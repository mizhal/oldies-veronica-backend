from time import strftime
import re

from PostgresDB import PostgresDBReader, PostgresDBPrivileged
from ..model.Article import Article

from PostgresFeedLoader import PostgresFeedLoader

class PostgreSQLArticleLoader:
	insert = "insert into articles(id, feed, link, title, content, published, fetch_date, created) values (%s, %s, '%s', '%s', '%s', '%s', '%s', '%s')"
	update = "update articles set title = '%s', content = '%s', published = '%s', fetch_date = '%s' where id = %s"
	user = None
	session_token = None	
	
	
	feed_mapper = PostgresFeedLoader()
		
	def assignID(self, article):
		if article.id is None:
			cur = PostgresDBReader.getInstance().cursor()
			try:
				cur.execute(u"select id from articles where link = '%s' and feed = %s union select nextval('art_seq')"%(article.link, article.feed.id))
			except:
				self.con.commit()
				raise "error al obtener el identificador"
				
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
		cur = PostgresDBReader.getInstance().cursor()
		cur.execute("select link from articles where feed = %s order by fetch_date desc limit %s"%(feed_id, n))
		return [i[0].decode("utf8") for i in cur.fetchall()]
			
	def setCredentials(self, user, session_token):
		self.user = user
		self.session_token =  session_token
		
	def save(self, a):
		mapper = PostgresDBPrivileged.getInstance(self.user, self.session_token)
		cur = mapper.cursor()
		try:
			if a.isnew:
				cur.execute(PostgreSQLArticleLoader.insert % (a.id, a.feed.id, a.link, 
					re.sub("\\\\'|[']", "''", a.title), 
					re.sub("\\\\'|[']", "''", a.content),
					strftime("%Y-%m-%d %H:%M:%S",a.pub_date.timetuple()),
					strftime("%Y-%m-%d %H:%M:%S",a.fetch_date.timetuple()),
					strftime("%Y-%m-%d %H:%M:%S",a.create_date.timetuple())) 
				)
			else:
				cur.execute(PostgreSQLArticleLoader.update % (
					re.sub("\\\\'|[']", "''", a.title), 
					re.sub("\\\\'|[']", "''", a.content),
					strftime("%Y-%m-%d %H:%M:%S",a.pub_date.timetuple()),
					strftime("%Y-%m-%d %H:%M:%S",a.fetch_date.timetuple()),
					a.id
					) 
				)
		except Exception, e:
			print "fallo ", str(e), " - link =", a.link," id=",a.id, " feed=",a.feed.id
			#errors.log("PostgreSQLArticleLoader", "save", "fallo link ="+a.link+" id="+str(a.id)+" feed="+str(a.feed_id)+"\n"+str(e))
		
		mapper.commit()
		
	def deleteArticlesFromFeed(self, feed):
		mapper = PostgresDBPrivileged.getInstance(self.user, self.session_token)
		cur = mapper.cursor()
		cur.execute("delete from articles where feed = %s", feed.id)
		mapper.commit()

	def loadLastNArticles(self, n):
		cur = PostgresDBReader.getInstance().cursor()
		cur.execute("select A.id, A.feed, A.link, A.title, A.content, A.published, A.fetch_date, A.created from articles as A order by A.published desc limit %s"%n)
		res = []
		
		for id, feed_id , link, title, content, published, fetch_date, created in cur.fetchall():
			a = Article()
			a.content = content.decode("utf8")
			a.title = title.decode("utf8")
			a.create_date = created
			a.pub_date = published
			a.fetch_date = fetch_date
			a.loadFeed(feed_id, PostgreSQLArticleLoader.feed_mapper)
			a.link = link.decode("utf8")
			a.id = id
			res.append(a)
		return res
		
	def loadLastNArticlesFetched(self, n):
		cur = PostgresDBReader.getInstance().cursor()
		cur.execute("select A.id, A.feed, A.link, A.title, A.content, A.published, A.fetch_date, A.created from articles as A order by A.fetch_date desc limit %s"%n)
		res = []
		for id, feed_id , link, title, content, published, fetch_date, created in cur.fetchall():
			a = Article()
			a.content = content.decode("utf8")
			a.title = title.decode("utf8")
			a.create_date = created
			a.pub_date = published
			a.fetch_date = fetch_date
			a.loadFeed(feed_id, PostgreSQLArticleLoader.feed_mapper)
			a.link = link.decode("utf8")
			a.id = id
			res.append(a)
		return res	
		
	def loadLastNArticlesByFeed(self, n, feed_id):
		cur = PostgresDBReader.getInstance().cursor()
		cur.execute("select id, feed, link, title, content, published, fetch_date, created from articles where feed = %s order by published desc limit %s"%(feed_id, n))
		res = []
		for id, feed_id , link, title, content, published, fetch_date, created in cur.fetchall():
			a = Article()
			a.content = content.decode("utf8")
			a.title = title.decode("utf8")
			a.create_date = created
			a.pub_date = published
			a.fetch_date = fetch_date
			a.loadFeed(feed_id, PostgreSQLArticleLoader.feed_mapper)
			a.link = link.decode("utf8")
			a.id = id
			res.append(a)
		return res
		
	def loadArticlesByFeed(self, n, feed_id, offset, limit):
		cur = PostgresDBReader.getInstance().cursor()
		cur.execute("select id, feed, link, title, content, published, fetch_date, created from articles where feed = %s order by published desc offset %s limit %s"%(feed_id, offset*limit, limit))
		res = []
		for id, feed_id , link, title, content, published, fetch_date, created in cur.fetchall():
			a = Article()
			a.content = content.decode("utf8")
			a.title = title.decode("utf8")
			a.create_date = created
			a.pub_date = published
			a.fetch_date = fetch_date
			a.loadFeed(feed_id, PostgreSQLArticleLoader.feed_mapper)
			a.link = link.decode("utf8")
			a.id = id
			res.append(a)
		return res