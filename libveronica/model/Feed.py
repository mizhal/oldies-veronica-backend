'''
modelo de fuente de noticias
'''
from exceptions import Exception
from datetime import datetime
from time import time, strftime
import re

import feedparser

from .Article import Article
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
	latency = 0
	last_read = datetime.now()
	last_news = 0
	created = datetime.now()
	errors = 0
	
	def __init__(self):
		self.last_read = datetime.now()
		
	def update(self, fts_index_mapper, database_mapper, print_news = False):
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
			else:
				article.pub_date = datetime.now()

			if creation:
				article.create_date = datetime(*creation[:-2])
			else:
				article.create_date = datetime.now()

			article.fetch_date = datetime.now()

			new[article.link] = article
			
			
		#chequeo de duplicados
		#ENG-POINT: recuperamos de la base de datos tantas noticias como nuevas tenemos, ordenadas por fecha descendente.
		links = database_mapper.getNLastURIs(len(data.entries)*2, self.id)
			
		new2 = []
		
		for link, article in new.iteritems():
			if isinstance(link, unicode):
				llz = link.encode("utf-8")
				if not llz in links:
					new2.append(article)
			else:	
				if not link in links:
					new2.append(article)
					
		## recalculo de frecuencia
					
		## alfa es la decadencia por dia
		alpha = 0.33
		produced_news = len(new2)
		## delta son segundos
		delta = (feed.last_read - datetime.now()).seconds or 1
		
		## las frecuencias son post por dia
		## un dia tiene 86400 segundos
		new_freq = produced_news * 86400.0 / delta

		self.freq = alpha * new_freq + (1 - alpha) * self.freq

		self.last_news = produced_news
		self.last_read = datetime.now()
		self.latency = latency

		#volcado a indice FTS

		if print_news:
			try:
				print "Actualizando ", self.title
			except UnicodeEncodeError, e:
				print e
				
		for a in new2:
			database_mapper.assignID(a)
			database_mapper.save(a)
			fts_index_mapper.save(a)
			if print_news:
				try:
					print "Descargado: ", a.title, "\n\tpublicado:", a.pub_date
				except UnicodeEncodeError, e:
					print e
		fts_index_mapper.flush()
		
		self.last_read = datetime.now()