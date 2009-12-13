from sys import argv
from psycopg2 import connect
import feedparser as rss

from dao.XapianArticleLoader import XapianArticleLoader as FTSArticleLoader
from dao.PostgreSQLArticleLoader import PostgreSQLArticleLoader as DBArticleLoader
from dao.PostgresFeedLoader import PostgresFeedLoader as DBFeedLoader
from dao.PostgresDB import PostgresDBReader as DBReader
from config import credentials, xapian_news_base

from model.Feed import Feed

class Veronica:
	def __init__(self):
		self.feed_loader = DBFeedLoader()
		
	def select(self, tries = 6):
		return self.feed_loader.randomSelect(tries) 
		
	def login(self, user, password):
		return DBReader.getInstance().openSession(user, password)
		
	def getFeed(self, id):
		feed_loader = DBFeedLoader()
		return feed_loader.getById(id)
		
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
		
	def deleteFeed(self, user, session_token, feed):
		pass
		
	def classifyFeed(self, user, session_token, feed, sgcat):
		pass
		
	def vetoFeed(self, user, session_token, feed, delete_news = False):
		feed.veto = True
		feed_loader = DBFeedLoader()
		feed_loader.setCredentials(user, session_token)
		
		feed_loader.save(feed)
		
		if delete_news:
			artloader = DBArticleLoader()
			fts_artloader = FTSArticleLoader(xapian_news_base)
			fts_artloader.deleteArticlesFromFeed(feed, artloader)
			artloader.setCredentials(user, session_token)
			artloader.deleteArticlesFromFeed(feed)
		
	def rebuildFTSIndex(self, user, session_token):
		fts_index_mapper = FTSArticleLoader(xapian_news_base)
		database_mapper = DBArticleLoader()
		
		fts_index_mapper.cleanAll()
		
		page = 0
		articles = database_mapper.loadAllArticles(page, 50)
		while len(articles):
			for a in articles:
				fts_index_mapper.save(a)
			fts_index.flush()
			articles = database_mapper.loadAllArticles(page, 50)
			page +=1
		
	def gatherNews(self, user, session_token, how_many = None, show_details = False):
		loader = DBFeedLoader()

		#seleccion de los feeds a consultar
		feeds = None

		if how_many:
			if how_many != 0:
				feeds = loader.randomSelect(how_many)
			else:
				feeds = loader.getAll()
		else:
			feeds = loader.randomSelect()

		fts_index_mapper = FTSArticleLoader(xapian_news_base)
		database_mapper = DBArticleLoader()
		database_mapper.setCredentials(user, session_token)
		for feed in feeds:
			feed.update(fts_index_mapper, database_mapper, show_details)
		