from os import remove
from os.path import exists

import xapian

from ..config import xapian_news_base
from ..dao.PostgresFeedLoader import PostgresFeedLoader
from ..dao.PostgreSQLArticleLoader import PostgreSQLArticleLoader

from ..dao.XapianArticleLoader import XapianArticleLoader

def execute(how_many = None, show_details = False):
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
	for feed in feeds:
		feed.update(fts_index_mapper, database_mapper, show_details)
		loader.save(feed)
