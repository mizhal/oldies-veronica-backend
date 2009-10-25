from time import strftime
from datetime import datetime
import calendar

import xapian

from infosfera.index.xapian.adapters import rel_to_prefix

from ..utils.html_processing import decode_htmlentities, substitute_entity, replace_acute, strip_html_tags
from ..model.Article import Article
from .PostgresFeedLoader import PostgresFeedLoader

DEFAULT_SEARCH_FLAGS = (
        xapian.QueryParser.FLAG_BOOLEAN |
        xapian.QueryParser.FLAG_PHRASE |
        xapian.QueryParser.FLAG_LOVEHATE |
        xapian.QueryParser.FLAG_BOOLEAN_ANY_CASE |
        xapian.QueryParser.FLAG_WILDCARD |
        xapian.QueryParser.FLAG_SPELLING_CORRECTION |
        xapian.QueryParser.FLAG_PARTIAL
        )

class XapianArticleLoader:
	URL, TITLE, FEED_TITLE, FEED_ID, FETCH_TIMESTAMP, PUB_TIMESTAMP, ID = range(7)
	
	def __init__(self, db_dir, only_reader = False):
		self.db_dir = db_dir
		
		if not only_reader:
			self.wdb = xapian.WritableDatabase(db_dir, xapian.DB_CREATE_OR_OPEN)
		else:
			self.wdb = None

		## querys
		self.read_db = xapian.Database(db_dir)
		self.parser = xapian.QueryParser()
		self.parser.set_database(self.read_db) 
		
	def save(self, article):
		if self.wdb is None:
			raise "Xapian open as only reader"
		
		term_gen = xapian.TermGenerator()
		try:
			untag = replace_acute(decode_htmlentities(strip_html_tags(article.title + " " + article.content)))
			untitle = replace_acute(decode_htmlentities(strip_html_tags(article.title)))
		except UnicodeDecodeError, e:
			print e
			#errors.log("XapianArticleLoader", "save", str(e))
			return
		term_gen.index_text_without_positions(untag)
		
		doc = term_gen.get_document()
		
		title_gen = xapian.TermGenerator()
		title_gen.set_document(doc)
		title_gen.index_text_without_positions(untitle, 10)## tiene peso 10
		
		doc.add_value( XapianArticleLoader.TITLE, unicode(article.title).encode("utf-8") )
		doc.add_value( XapianArticleLoader.URL, article.link )
		doc.add_value( XapianArticleLoader.FEED_TITLE, unicode(article.feed.title).encode("utf-8") )
		doc.add_value( XapianArticleLoader.FEED_ID, str(article.feed.id) )
		doc.add_value( XapianArticleLoader.FETCH_TIMESTAMP, str(calendar.timegm(article.fetch_date.timetuple())) )
		doc.add_value( XapianArticleLoader.PUB_TIMESTAMP, str(calendar.timegm(article.pub_date.timetuple())) )
		doc.add_value( XapianArticleLoader.ID, str(article.id))
		
		doc.add_term( "D" + strftime("%Y-%m-%d",article.pub_date.timetuple()) )
		doc.add_term( "U" + article.link) ## @change cambiado para usar como indice la url, ya que para sustituir xapian usa un termino como indice, asi se sustituyen los que tengan el termino dado como primer parametro, no el identificador, por ello, es necesario anyadir ese termino de "unicidad"
		
		self.wdb.replace_document("U" + article.link, doc)
		
	def flush(self):
		self.wdb.flush()
		self.reopen_db()
		
	def reopen_db(self):
		try:
		    self.read_db.reopen()
		except IOError:
		    print "Unable to open database"
		
	def getFromQuery(self, query, offset = 0, count = 100):
		query = self.parser.parse_query(query.encode("utf8"))

		enquire = xapian.Enquire(self.read_db)
		enquire.set_query(query)
		try:
		    mset = enquire.get_mset(offset, count)
		except IOError, e:
		    if "DatabaseModifiedError" in str(e):
		        print "dbm error"
		        return
		except xapian.DatabaseModifiedError, e: 
		    self.reopen_db()
		    mset = enquire.get_mset(offset, count)
	
		results = []
		feed_loader = PostgresFeedLoader()
		for m in mset:
			a = Article()
			a.fitness = m[xapian.MSET_PERCENT]
			a.link = m[xapian.MSET_DOCUMENT].get_value(XapianArticleLoader.URL).decode("utf8")
			a.feed = feed_loader.getById(m[xapian.MSET_DOCUMENT].get_value(XapianArticleLoader.FEED_ID))
			a.title = m[xapian.MSET_DOCUMENT].get_value(XapianArticleLoader.TITLE).decode("utf8")
			a.fetch_date = datetime.fromtimestamp( int(m[xapian.MSET_DOCUMENT].get_value(XapianArticleLoader.FETCH_TIMESTAMP)) )
			try:
				a.pub_date = datetime.fromtimestamp( int(m[xapian.MSET_DOCUMENT].get_value(XapianArticleLoader.PUB_TIMESTAMP)) )
			except:
				a.pub_date = datetime.fromtimestamp( int(m[xapian.MSET_DOCUMENT].get_value(XapianArticleLoader.FETCH_TIMESTAMP)) )
			a.id = m[xapian.MSET_DOCUMENT].get_value(XapianArticleLoader.ID)
			
			results.append(a)
			
		return results
		