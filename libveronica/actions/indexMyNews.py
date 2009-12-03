from os import remove
from os.path import exists

import xapian

from ..config import credentials, xapian_news_base
from ..dao.PostgresFeedLoader import PostgresFeedLoader
from ..dao.PostgresDB import PostgresDB

def execute(how_many = None, show_details = False):
	PostgresDB.getInstance().connect(*credentials)
	sqldb = PostgresDB.getInstance()

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
	database_mapper = PostgresFeedLoader()
	for feed in feeds:
		feed.update(fts_index_mapper, database_mapper, show_details)
		loader.save(feed)
		
	PostgresDB.getInstance().commit()
