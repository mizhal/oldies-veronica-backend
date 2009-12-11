from sys import argv
from psycopg2 import connect
import feedparser as rss

from dao.XapianArticleLoader import XapianArticleLoader
from dao.PostgresFeedLoader import PostgresFeedLoader
from dao.PostgresDB import PostgresDBReader
from config import credentials, xapian_news_base

from model.Feed import Feed

class Veronica:
	def __init__(self):
		self.feed_loader = PostgresFeedLoader()
		
	def select(self, tries = 6):
		return self.feed_loader.randomSelect(tries) 
		
	def login(self, user, password):
		return PostgresDBReader.getInstance().openSession(user, password)
		
	def addFeed(self, user, session_token, url, title = None, site = None):
		''' anyadir un feed 
		'''
		new = Feed()
		new.rss = url
		
		data = rss.parse(url)
		if site is None:
			try:
				new.site = data.feed.link
			except:
				new.site = ""
			
		if title is None:
			try:
				new.title = data.feed.title
			except:
				new.title = ""
			
		feed_loader = PostgresFeedLoader()
		feed_loader.setCredentials(user, session_token)
		
		feed_loader.save(new)
		
	def deleteFeed(self, url):
		pass
		
	def classifyFeed(self, feed, sgcat):
		pass
		
	def rebuildFTSIndex(self):
		pass
		
	def gatherNews(self, user, session_token, how_many = None, show_details = False):
		loader = PostgresFeedLoader()

		#seleccion de los feeds a consultar
		feeds = None

		if how_many:
			if how_many != 0:
				feeds = loader.randomSelect(how_many)
			else:
				feeds = loader.getAll()
		else:
			feeds = loader.randomSelect()

		fts_index_mapper = XapianArticleLoader(xapian_news_base)
		database_mapper = PostgreSQLArticleLoader()
		database_mapper.setCredentials(user, session_token)
		for feed in feeds:
			feed.update(fts_index_mapper, database_mapper, show_details)
		