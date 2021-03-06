import random
from time import strftime
from datetime import datetime

from ..utils.CacheDict import LRUCache
from ..model.Feed import Feed

from .PostgresDB import PostgresDBReader, PostgresDBPrivileged
		
class PostgresFeedLoader:
	cache = LRUCache(40)
	user = None
	session_token = None
	
	def _assignID(self, feed):
		if feed.id is None:
			cur = PostgresDBReader.getInstance().cursor()
			try:
				cur.execute(u"select id from feeds where rss = '%s' union select nextval('feed_seq')"%(feed.rss, feed.id))
			except:
				self.con.commit()
				raise "error al obtener el identificador del feed"
				
			all = cur.fetchall()
			if len(all) == 2:
				feed.id = all[0][0]
				return "exists"
			elif len(all) == 1:
				article.id = all[0][0]
				return "new"
			else:
				errors.log("PostgresFeedLoader", "assignID", "error al obtener el identificador")
				raise "error al obtener el identificador"
	
				
	def setCredentials(self, user, session_token):
		self.user = user
		self.session_token =  session_token
		
	def save(self, feed):
		db = PostgresDBPrivileged.getInstance(self.user, self.session_token)
		cur = db.cursor()
		if not feed.id:
			kind = self._assignID(feed)
			if kind == 'new':
				## caso de feed nuevo
				cur.execute("insert into feeds("
						    "title, "
						    "response, "
						    "freq, "
						    "rss, "
						    "site, "
						    "last_read, " 
						    "created, "
						    "errors, "
						    "last_err, "
						    "last_news, "
						    "veto ) "
						    "values("
						    "'%s', "
						    "%s, "
						    "%s, "
						    "'%s', "
						    "'%s', "
						    "'%s', " 
						    "'%s', "
						    "%s, "
						    "'%s', "
						    "%s, %s)" % (feed.title.replace("'","''"),
									   feed.latency,
									   feed.freq,
									   feed.rss.replace("'","''"),
									   feed.site.replace("'","''"),
									   strftime("%Y-%m-%d %H:%M:%S",feed.last_read.timetuple()),
									   strftime("%Y-%m-%d %H:%M:%S",feed.created.timetuple()),
									   feed.errors,
									   feed.last_error != None and feed.last_error.replace("'","''") or '',
									   feed.last_news,
									   feed.veto
									   )
						    )
				return
			
		## caso de que ya existiera
		cur.execute("update feeds set "
				    "title = '%s', "
				    "response = %s, "
				    "freq = %s, "
				    "rss = '%s', "
				    "site = '%s', "
				    "last_read = '%s', " 
				    "created = '%s', "
				    "errors = %s, "
				    "last_err = '%s', "
				    "last_news = %s, "
				    "veto = %s "
				    "where id = %s" % (feed.title.replace("'","''"),
									   feed.latency,
									   feed.freq,
									   feed.rss.replace("'","''"),
									   feed.site.replace("'","''"),
									   strftime("%Y-%m-%d %H:%M:%S",feed.last_read.timetuple()),
									   strftime("%Y-%m-%d %H:%M:%S",feed.created.timetuple()),
									   feed.errors,
									   feed.last_error != None and feed.last_error.replace("'","''") or '',
									   feed.last_news,
									   feed.veto,
									   feed.id
									   )
				    )
		db.commit()

	def _loadSingle(self, sql):
		cur = PostgresDBReader.getInstance().cursor()
		cur.execute(sql)
		row = cur.fetchone()
		
		f = Feed()
		f.id = row[0]
		f.rss = row[1]
		f.site = row[2]
		f.title = (not row[3] is None) and row[3].decode("utf8") or ""
		f.latency = row[4]
		f.freq = row[5]
		f.last_read = row[6]
		f.last_news = row[7]
		f.created = row[8]
		f.errors = row[9]
		f.last_error = row[10]
		f.veto = row[11]
		
		return f
		
	def _loadMany(self, sql):
		cur = PostgresDBReader.getInstance().cursor()
		cur.execute(sql)
		results = []

		for row in cur.fetchall():		
			f = Feed()
			f.id = row[0]
			f.rss = row[1]
			f.site = row[2]
			f.title = (not row[3] is None) and row[3].decode("utf8") or ""
			f.latency = row[4]
			f.freq = row[5]
			f.last_read = row[6]
			f.last_news = row[7]
			f.created = row[8]
			f.errors = row[9]
			f.last_error = row[10]
			f.veto = row[11]
			results.append(f)
		
		return results	
		
	COLUMNS = "id, rss, site, title, response, freq, last_read, last_news, created, errors, last_err, veto"
		
	def getAll(self):
		return self._loadMany("select %s from feeds" % PostgresFeedLoader.COLUMNS)
		
	def getById(self, id):
		q = PostgresFeedLoader.cache.get(id, False)
		if q:
			return q
		else:
			q = self._loadSingle("select %s from feeds "
							    "where id = %s"%(
												PostgresFeedLoader.COLUMNS,
												id)
							    )
			PostgresFeedLoader.cache[id] = q
			return q
			
	def randomSelect(self, tries = 6):
		#TODO: de momento no tiene en cuenta la afinidad del usuario, pero es necesario incorporarlo
		bag = []
	
		quick = self._loadMany("select %s from feeds where veto = false "
							  "order by (now() - last_read)*freq desc "
							  "limit %s"%(PostgresFeedLoader.COLUMNS, 
											2*tries
									      )
							  )

		old = self._loadMany("select %s "
						    "from feeds where veto = false "
						    "order by last_read asc "
						    "limit %s"%(PostgresFeedLoader.COLUMNS, 
									    2*tries)
						    )

		bag.extend(quick)
		bag.extend(old)

		selected = []
		for i in range(tries):
			try_ = int(random.uniform(0, len(bag)))
			s = bag.pop(try_)
			selected.append(s)

		return selected