from sys import argv
from psycopg2 import connect
import feedparser as rss

from dao.PostgresFeedLoader import PostgresFeedLoader
from dao.PostgresDB import PostgresDB
from config import credentials

class Veronica:
	def __init__(self):
		self.feed_loader = PostgresFeedLoader()
		
	def select(self, tries = 6):
		return self.feed_loader.randomSelect(tries) 
		
	def addFeed(self, url):
		''' anyadir un feed '''
		data = rss.parse(url)
		try:
			site = data.feed.link
		except:
			site = ""
			
		try:
			title = data.feed.title
		except:
			title = ""

		vero = PostgresDB.getInstance()
		
		sql = "insert into feeds(rss, site, title) values('%s','%s','%s')"
		previous = "select rss from feeds"
		cur = vero.cursor()
		cur.execute(previous)
		prev = [i[0] for i in cur.fetchall()]

		if url not in prev:
			cur.execute(sql % (url, site, title))
		else:
			raise "la fuente ya existe"
		
		vero.commit()
		
	def deleteFeed(self, url):
		pass
		
	def classifyFeed(self, feed, sgcat):
		pass
		
	def rebuildFTSIndex(self):
		pass
		