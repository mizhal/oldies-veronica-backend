from datetime import datetime
import calendar

class Article:
	''' articulo bajado de rss '''
	def __init__(self):
		self.content = ''
		self.title = ''
		self.create_date = datetime(1901,1,1) #ENG-POINT: valores que indican desconocido, 1 de enero del ano 1
		self.pub_date = datetime(1901,1,1)
		self.fetch_date = datetime.now()
		self.feed = None
		self.link = ''
		self.id = None
		self.fitness = 0
	
	def define (self, id, feed, feed_title, link, title, content, published, fetch_date, created):
		'''id, feed, F.title link, title, content, published, fetch_date, created'''
		self.content = content.decode("utf8")
		self.title = title.decode("utf8")
		self.create_date = created
		self.pub_date = published
		self.fetch_date = fetch_date
		self.feed = feed
		self.link = link.decode("utf8")
		self.id = id
		
	def loadFeed(self, feed_id, database_mapper):
		self.feed = database_mapper.getById(feed_id) 
		
	def getFetchUnixTime(self):
		return calendar.timegm(self.fetch_date.timetuple())
		
	def getPubUnixTime(self):
		return calendar.timegm(self.pub_date.timetuple())
	
	def getCreateUnixTime(self):
		return calendar.timegm(self.create_date.timetuple())
	