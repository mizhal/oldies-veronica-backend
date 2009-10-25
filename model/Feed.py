'''
modelo de fuente de noticias
'''
from exceptions import Exception
from datetime import datetime
from time import time, strftime
import re

import feedparser

from .Article import Article
from ..dao.PostgresFeedLoader import PostgresFeedLoader 
from ..dao.PostgreSQLArticleLoader import PostgreSQLArticleLoader 
from ..dao.XapianArticleLoader import XapianArticleLoader

content_alias = ['summary','subtitle']

class Feed:
	id = None
	rss = None
	site = None
	title = ''
	response = 0
	freq = 1
	last_read = datetime.now()
	
	def __init__(self):
		self.last_read = datetime.now()
		
	def update(self, xapian_news_base, print_news = False):
		'''process feed and save news in Xapian index'''
		ptime = 0
		now = strftime("%Y-%m-%d %H:%M:%S",datetime.now().timetuple())
		try:
			st = time()
			data = feedparser.parse(self.rss)
			latency = time() - st
		except UnicodeDecodeError, e:
			print e
			#errors.log("veronica", "process_feed2", "RSS: %s::: %s"%(rss, str(e)))
			return
		except Exception, e:
			print e
			#errors.log("veronica", "process_feed2", "RSS: %s::: %s"%(rss, str(e)))
			return		
		
		self.title = ""
			
		try:
			if data.has_key("feed"):
				if data.feed.has_key("title"):
					self.title = data.feed.title
				elif data.feed.has_key("title_detail"):
					self.title = feed.title_detail.value
			elif data.has_key("channel"):
				self.title = data.channel.title
			
		except Exception, e:
			print "CANAL:", self.rss
			print e
			#errors.log("veronica", "process_feed2", "Canal: %s; %s"%(rss, str(e)))
			
		
		feed_loader = PostgresFeedLoader()
		feed_loader.setTitle(self, self.title)
			
		#extraccion de nuevas noticias

		new = {}
		for entry in data.entries:
			article = Article()
			article.feed = self
			article.link = entry.get('link', None)

			if not article.link:
				links = entry.get('links',[])
				if len(links) > 0:
					try:
						article.link = entry.links[0].href
					except:
						continue
				else:
					continue

			content = ""
			alias_i = 0
			while content == "" and alias_i < len( content_alias ):
				content = entry.get(content_alias[alias_i], "")
				alias_i += 1

			article.content = content
			article.title = entry.get('title',' ')
			if len(article.content):
				if article.content[-1] == '\\':
					article.content = ''.join([article.content," "])
			if len(article.title):
				if article.title[-1] == '\\':
					article.title = ''.join([article.title," "])


			pub_date = entry.get( 'updated_parsed', None )
			creation = entry.get( 'created_parsed', None )

			if pub_date:
				article.pub_date = datetime(*pub_date[:-2])

			if creation:
				article.create_date = datetime(*creation[:-2])

			article.fetch_date = datetime.now()

			new[article.link] = article
			
			
		#chequeo de duplicados
		#ENG-POINT: recuperamos de la base de datos tantas noticias como nuevas tenemos, ordenadas por fecha descendente.
		loaderDB = PostgreSQLArticleLoader()
		
		links = loaderDB.getNLastURIs(len(data.entries)*2, self.id)
			
		new2 = []
		
		for link, article in new.iteritems():
			if isinstance(link, unicode):
				llz = link.encode("utf-8")
				if not str(llz) in links:
					new2.append(article)
			else:	
				if not link in links:
					new2.append(article)
					
		feed_loader.updateFeedRatesAndTimes(self, len(new2), 0.33)
		feed_loader.setLatency(self,latency)

		#volcado a indice de xapian
		loader = XapianArticleLoader(xapian_news_base)
		if print_news:
			try:
				print "Actualizando ", self.title
			except UnicodeEncodeError, e:
				print e
				
		for a in new2:
			loaderDB.assignID(a)
			loaderDB.save(a)
			loader.save(a)
			if print_news:
				try:
					print "Descargado: ", a.title, "\n\tpublicado:", a.pub_date
				except UnicodeEncodeError, e:
					print e
		loader.flush()
		
		self.last_read = datetime.now()