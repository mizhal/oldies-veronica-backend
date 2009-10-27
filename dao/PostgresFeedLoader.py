import random
from time import strftime
from datetime import datetime

from .PostgresDB import PostgresDB
from ..utils.CacheDict import LRUCache
		
class PostgresFeedLoader:
	cache = LRUCache(40)
	
	def updateFeedRatesAndTimes(self, feed, produced_news, alpha):
		''' alfa es la decadencia por dia '''
		cur = PostgresDB.getInstance().cursor()
		delta = (feed.last_read - datetime.now()).seconds or 1
		freq = alpha*produced_news*(3600*24)/delta
		if (feed.last_read - datetime.now()).seconds >= 1:
			cur.execute("update feeds set freq = %s + (1 - %s) * freq , last_news = %s, last_read = now() where id = %s" % (freq, alpha, produced_news, feed.id))
		else:
			cur.execute("update feeds set freq = %s*%s*(3600*24) + (1 - %s) * freq , last_news = %s, last_read = now() where id = %s" % (alpha, produced_news, alpha, produced_news, feed.id))
		
	def setLatency(self, feed, latency):
		cur = PostgresDB.getInstance().cursor()
		cur.execute("update feeds set response = %s where id = %s"%(latency, feed.id))
		
	def setTitle(self, feed, title):
		cur = PostgresDB.getInstance().cursor()
		cur.execute("update feeds set title = '%s' where id = %s"%(title.replace("'","''"), feed.id))
		
	def save(self, feed):
		## @todo
		if feed.id:
			pass
		else:
			pass
		
	def loadSingle(self, sql):
		cur = PostgresDB.getInstance().cursor()
		cur.execute(sql)
		row = cur.fetchone()
		
		from veronica.model.Feed import Feed
		
		f = Feed()
		f.id = row[0]
		f.rss = row[1]
		f.site = row[2]
		f.title = (not row[3] is None) and row[3].decode("utf8") or ""
		f.response = row[4]
		f.freq = row[5]
		f.last_read = row[6]
		
		return f
		
	def loadMany(self, sql):
		cur = PostgresDB.getInstance().cursor()
		cur.execute(sql)
		results = []
		
		from veronica.model.Feed import Feed

		for row in cur.fetchall():		
			f = Feed()
			f.id = row[0]
			f.rss = row[1]
			f.site = row[2]
			f.title = (not row[3] is None) and row[3].decode("utf8") or ""
			f.response = row[4]
			f.freq = row[5]
			f.last_read = row[6]
			results.append(f)
		
		return results	
		
	def getAll(self):
		return self.loadMany("select id, rss, site, title, response, freq, last_read from feeds")
		
	def getById(self, id):
		q = PostgresFeedLoader.cache.get(id, False)
		if q:
			return q
		else:
			q = self.loadSingle("select id, rss, site, title, response, freq, last_read from feeds where id = %s"%(id,))
			PostgresFeedLoader.cache[id] = q
			return q
			
	def randomSelect(self, tries = 6):
		#TODO: de momento no tiene en cuenta la afinidad del usuario, pero es necesario incorporarlo
		bag = []
	
		quick = self.loadMany("select id, rss, site, title, response, freq, last_read from feeds order by (now() - last_read)*freq desc limit %s"%(2*tries,))

		old = self.loadMany("select id, rss, site, title, response, freq, last_read from feeds order by last_read asc limit %s"%(2*tries,))

		bag.extend(quick)
		bag.extend(old)

		selected = []
		for i in range(tries):
			try_ = int(random.uniform(0, len(bag)))
			s = bag.pop(try_)
			selected.append(s)

		return selected