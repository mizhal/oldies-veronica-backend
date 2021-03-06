from psycopg2 import connect
import random
import feedparser
import datetime
from time import time, strftime
import re
import calendar
from exceptions import Exception

import xapian

from config import logfile

def select(vero, tries = 6):
	#TODO: de momento no tiene en cuenta la afinidad del usuario, pero es necesario incorporarlo

	bag = []
	cur = vero.cursor()
	cur.execute("select id, title, rss from feeds order by (now() - last_read)*freq desc limit %s"%(2*tries,))
	bag.extend(cur.fetchall()) #fuentes muy productivas

	cur.execute("select id, title, rss from feeds order by last_read asc limit %s"%(2*tries,))
	bag.extend(cur.fetchall()) #fuentes poco atendidas

	selected = []
	for i in range(tries):
		try_ = int(random.uniform(0, len(bag)))
		s = bag.pop(try_)
		selected.append(s)

	return selected

content_alias = ['summary','subtitle']

from model.Feed import Feed
from dao.PostgresFeedLoader import PostgresFeedLoader 

from model.Article import Article

class ArticleLoader:
	def save(self):
		pass
		
class PostgreSQLArticleLoader(ArticleLoader):
	insert = "insert into articles(id, feed, link, title, content, published, fetch_date, created) values (%s, %s, '%s', '%s', '%s', '%s', '%s', '%s')"
	update = "update articles set title = '%s', content = '%s', published = '%s', fetch_date = '%s' where id = %s"
	
	def __init__(self, connection):
		self.con = connection
		
	def assignID(self, article):
		if article.id is None:
			cur = self.con.cursor()
			cur.execute("select id from articles where link = '%s' and feed = %s union select nextval('art_seq')"%(article.link, article.feed_id))
			all = cur.fetchall()
			if len(all) == 2:
				article.isnew = False
				article.id = all[0][0]
			elif len(all) == 1:
				article.isnew = True
				article.id = all[0][0]
			else:
				errors.log("PostgreSQLArticleLoader", "assignID", "error al obtener el identificador")
				raise "error al obtener el identificador"
		
	def getNLastURIs(self, n, feed_id):
		cur = self.con.cursor()
		cur.execute("select link from articles where feed = %s order by fetch_date desc limit %s"%(feed_id, n))
		return [unicode(i[0]) for i in cur.fetchall()]
		
	def save(self, a):
		cur = self.con.cursor()
		try:
			if a.isnew:
				cur.execute(PostgreSQLArticleLoader.insert % (a.id, a.feed_id, a.link, a.title, 
					a.content,
					strftime("%Y-%m-%d %H:%M:%S",a.pub_date.timetuple()),
					strftime("%Y-%m-%d %H:%M:%S",a.fetch_date.timetuple()),
					strftime("%Y-%m-%d %H:%M:%S",a.create_date.timetuple())) 
				)
			else:
				cur.execute(PostgreSQLArticleLoader.update % (a.title, 
					a.content,
					strftime("%Y-%m-%d %H:%M:%S",a.pub_date.timetuple()),
					strftime("%Y-%m-%d %H:%M:%S",a.fetch_date.timetuple()),
					a.id
					) 
				)
		except Exception, e:
			print "fallo link =", a.link," id=",a.id, " feed=",a.feed_id
			errors.log("PostgreSQLArticleLoader", "save", "fallo link ="+a.link+" id="+str(a.id)+" feed="+str(a.feed_id)+"\n"+str(e))
			print e
			
	def loadLastNArticles(self, n):
		## @todo completar esta funcion para implementar un servicio con web.py
		cur = self.con.cursor()
		cur.execute("select A.id, A.feed, A.link, A.title, A.content, A.published, A.fetch_date, A.created from articles as A order by A.published desc limit %s"%n)
		res = []
		for data in cur.fetchall():
			a = Article()
			a.define(*data)
			res.append(a)
		return res
		
	def loadLastNArticlesByFeed(self, n, feed_id):
		## @todo completar esta funcion para implementar un servicio con web.py
		cur = self.con.cursor()
		cur.execute("select A.id, A.feed, F.title, A.link, A.title, A.content, A.published, A.fetch_date, A.created from articles as A inner join feeds as F on A.feed = F.id where F.id = %s order by A.published desc limit %s"%(feed_id, n))
		res = []
		for data in cur.fetchall():
			a = Article()
			a.define(*data)
			res.append(a)
		return res

class ErrorLog:
	def __init__(self, fname):
		self.file = open(fname,"a")
		
	def __del__(self):
		self.file.close()

	def log(self, subsystem, module, txt):
		self.file.write("%s/%s: %s"%(subsystem, module, txt))
		self.file.flush()
	
errors = ErrorLog(logfile)

from htmlentitydefs import name2codepoint as n2cp

def substitute_entity(match):
    ent = match.group(2)
    if match.group(1) == "#":
        try:
          return unichr(int(ent))
        except ValueError, e:
          return unichr(eval("0"+ent))
    else:
        cp = n2cp.get(ent)

        if cp:
            return unichr(cp)
        else:
            return match.group()

def decode_htmlentities(string):
    entity_re = re.compile("&(#?)(\d{1,5}|\w{1,8});")
    return entity_re.subn(substitute_entity, string)[0]


def replace_acute(string):
  st = string.replace(u'\xe1',u'a') 
  st = st.replace(u'\xe9',u"e") 
  st = st.replace(u'\xed',u"i") 
  st = st.replace(u'\xf3',u"o") 
  st = st.replace(u'\xfa',u"u")
  st = st.replace(u'\xb4',u"")
  return st

def strip_html_tags(text):
	import html_stripper
	parser =  html_stripper.StrippingParser()
	parser.feed(text)
	parser.close()
	parser.cleanup()
	return parser.result

class XapianArticleLoader(ArticleLoader):
	URL, TITLE, FEED_TITLE, FEED_ID, FETCH_TIMESTAMP, PUB_TIMESTAMP, ID = range(7)
	
	def __init__(self, xapian_db):
		self.db = xapian_db
		
	def save(self, article):
		term_gen = xapian.TermGenerator()
		try:
			untag = replace_acute(decode_htmlentities(strip_html_tags(article.title + " " + article.content)))
			untitle = replace_acute(decode_htmlentities(strip_html_tags(article.title)))
		except UnicodeDecodeError, e:
			print e
			errors.log("XapianArticleLoader", "save", str(e))
			return
		term_gen.index_text_without_positions(untag)
		
		doc = term_gen.get_document()
		
		title_gen = xapian.TermGenerator()
		title_gen.set_document(doc)
		title_gen.index_text_without_positions(untitle, 10)## tiene peso 10
		
		doc.add_value( XapianArticleLoader.TITLE, unicode(article.title).encode("utf-8") )
		doc.add_value( XapianArticleLoader.URL, article.link )
		doc.add_value( XapianArticleLoader.FEED_TITLE, unicode(article.feed_title).encode("utf-8") )
		doc.add_value( XapianArticleLoader.FEED_ID, str(article.feed_id) )
		doc.add_value( XapianArticleLoader.FETCH_TIMESTAMP, str(calendar.timegm(article.fetch_date.timetuple())) )
		doc.add_value( XapianArticleLoader.PUB_TIMESTAMP, str(calendar.timegm(article.pub_date.timetuple())) )
		doc.add_value( XapianArticleLoader.ID, str(article.id))
		
		doc.add_term( "D" + strftime("%Y-%m-%d",article.pub_date.timetuple()) )
		doc.add_term( "U" + article.link) ## @change cambiado para usar como indice la url, ya que para sustituir xapian usa un termino como indice, asi se sustituyen los que tengan el termino dado como primer parametro, no el identificador, por ello, es necesario anyadir ese termino de "unicidad"
		
		self.db.replace_document("U" + article.link, doc)
			
def process_feed(id, title, rss, vero):
	'''Process feed and save news in database'''
	
	ptime = 0
	now = strftime("%Y-%m-%d %H:%M:%S",datetime.datetime.now().timetuple())
	try:
		data = feedparser.parse(rss)
	except UnicodeDecodeError, e:
		cur.execute("update feeds set errors = errors + 1, last_err = '%s', last_read = '%s' where id = %s"%(str(e).replace("'","\\'"),
			now, id))
	return
	#extraccion de nuevas noticias

	new = {}
	for entry in data.entries:
		article = Article()
		article.feed_id = id
		article.feed_title = title
		article.link = entry.get('link', None)

		if not article.link:
			links = entry.get('links',[])
			if len(links) > 0:
				article.link = entry.links[0].href
			else:
				continue

		content = ""
		alias_i = 0
		while content == "" and alias_i < len( content_alias ):
			content = entry.get(content_alias[alias_i], "")
			alias_i += 1

		article.content = re.sub("\\\\'|[']", "\\'", content)
		article.title = re.sub("\\\\'|[']", "\\'", entry.get('title',' '))
		if len(article.content):
			if article.content[-1] == '\\':
				article.content = ''.join([article.content," "])
		if len(article.title):
			if article.title[-1] == '\\':
				article.title = ''.join([article.title," "])


		pub_date = entry.get( 'updated_parsed', None )
		creation = entry.get( 'created_parsed', None )

		if pub_date:
			article.pub_date = datetime.datetime(*pub_date[:-2])

		if creation:
			article.create_date = datetime.datetime(*creation[:-2])

		new[article.link] = article
		#chequeo de duplicados
		#ENG-POINT: recuperamos de la base de datos tantas noticias como nuevas tenemos, ordenadas por fecha descendente.
		cur = vero.cursor()
		cur.execute("select link from articles where feed = %s order by fetch_date desc limit %s"%(id, len(new)))
		last_session = cur.fetchall()
		for link in last_session:
			if new.has_key(link):
				del new[link]

	#volcado a base de datos
	sql = "insert into articles(feed, link, title, content, published, fetch_date, created) values (%s, '%s', '%s', '%s', '%s', '%s', '%s')"
	for a in new.itervalues():
		cur.execute(sql % (id, a.link, a.title, 
			a.content,
			strftime("%Y-%m-%d %H:%M:%S",a.pub_date.timetuple()),
			strftime("%Y-%m-%d %H:%M:%S",a.fetch_date.timetuple()),
			strftime("%Y-%m-%d %H:%M:%S",a.create_date.timetuple())) 
		)
	cur.execute("update feeds set last_read = '%s', response = %s where id = %s"%(now, ptime, id))

def update_feeds(vero, select_ = 1, tries = 6):
	net_times = []

	feedbase = None
	if select_ == 1:
		feedbase = select(vero, tries)
	else:
		print "modo completo"
		cur = vero.cursor()
		cur.execute("select id, title, rss from feeds")
		feedbase = cur.fetchall()

	for id, title, rss in feedbase:
		process_feed(id, title, rss, vero)
	vero.commit()
	return tries, len(new), net_times


def process_feed2(id, title, rss, xapian_news_base, vero):
	'''process feed and save news in Xapian index'''
	
	ptime = 0
	now = strftime("%Y-%m-%d %H:%M:%S",datetime.datetime.now().timetuple())
	try:
		st = time()
		data = feedparser.parse(rss)
		latency = time() - st
	except UnicodeDecodeError, e:
		print e
		errors.log("veronica", "process_feed2", "RSS: %s::: %s"%(rss, str(e)))
		return
	except Exception, e:
		print e
		errors.log("veronica", "process_feed2", "RSS: %s::: %s"%(rss, str(e)))
		return		
	
	title = ""
		
	try:
		if data.has_key("feed"):
			if data.feed.has_key("title"):
				title = data.feed.title
			elif data.feed.has_key("title_detail"):
				title = feed.title_detail.value
		elif data.has_key("channel"):
			title = data.channel.title
		
	except Exception, e:
		print "CANAL:", rss
		print e
		errors.log("veronica", "process_feed2", "Canal: %s; %s"%(rss, str(e)))
		
	
	f = Feed()
	f.id = id
	feed_loader = PostgresFeedLoader(vero)
	feed_loader.setTitle(f, title)
		
	#extraccion de nuevas noticias

	new = {}
	for entry in data.entries:
		article = Article()
		article.feed_id = id
		article.feed_title = title
		article.link = entry.get('link', None)

		if not article.link:
			links = entry.get('links',[])
			if len(links) > 0:
				article.link = entry.links[0].href
			else:
				continue

		content = ""
		alias_i = 0
		while content == "" and alias_i < len( content_alias ):
			content = entry.get(content_alias[alias_i], "")
			alias_i += 1

		article.content = re.sub("\\\\'|[']", "\\'", content)
		article.title = re.sub("\\\\'|[']", "\\'", entry.get('title',' '))
		if len(article.content):
			if article.content[-1] == '\\':
				article.content = ''.join([article.content," "])
		if len(article.title):
			if article.title[-1] == '\\':
				article.title = ''.join([article.title," "])


		pub_date = entry.get( 'updated_parsed', None )
		creation = entry.get( 'created_parsed', None )

		if pub_date:
			article.pub_date = datetime.datetime(*pub_date[:-2])

		if creation:
			article.create_date = datetime.datetime(*creation[:-2])

		article.fetch_date = datetime.datetime.now()

		new[article.link] = article
		
		
	#chequeo de duplicados
	#ENG-POINT: recuperamos de la base de datos tantas noticias como nuevas tenemos, ordenadas por fecha descendente.
	loaderDB = PostgreSQLArticleLoader(vero)
	
	links = loaderDB.getNLastURIs(len(data.entries)*2, id)
		
	new2 = []
	
	for link, article in new.iteritems():
		if isinstance(link, unicode):
			llz = link.encode("utf-8")
			if not str(llz) in links:
				new2.append(article)
		else:	
			if not link in links:
				new2.append(article)
				
	f = Feed()
	f.id = id
	
	floader = PostgresFeedLoader(vero)
	floader.updateFeedRatesAndTimes(f, len(new2), 0.33)
	floader.setLatency(f,latency)

	#volcado a indice de xapian
	loader = XapianArticleLoader(xapian_news_base)
	for a in new2:
		loaderDB.assignID(a)
		loaderDB.save(a)
		loader.save(a)
	xapian_news_base.flush()
	vero.commit()
	
	
	
	