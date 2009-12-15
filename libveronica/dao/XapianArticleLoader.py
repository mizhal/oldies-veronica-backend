import re
from time import strftime
from datetime import datetime
import calendar

import lxml.html
from lxml.html.clean import clean_html
from lxml.etree import ParserError

from shutil import rmtree

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

BLANK_RE = re.compile("^\s*$")

class XapianArticleLoader:
    URL, TITLE, FEED_TITLE, FEED_ID, FETCH_TIMESTAMP, PUB_TIMESTAMP, ID = range(7)
    stopwords = None
    
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
        
    def _cleanArticleText(self, article):
        if BLANK_RE.match(article.title):
           untitle = ''
        else:
            try:
                title = clean_html(article.title)
                untitle = lxml.html.fromstring(title).text_content()
            except:
                untitle = ''
                            
        if BLANK_RE.match(article.content):
            uncontent = ''
        else:
            try:
                content = clean_html(article.content)
                uncontent = lxml.html.fromstring(content).text_content()
            except:
                uncontent = ''
            
        uncontent = untitle + uncontent
        
        if BLANK_RE.match(uncontent):
            return None, None
        else:
            return untitle, uncontent

    def save(self, article):
        if self.wdb is None:
            raise "Xapian open as only reader"
        
        term_gen = xapian.TermGenerator()

        untitle, uncontent = self._cleanArticleText(article)
        if untitle is None and uncontent is None:
            return
        
        ## @todo FILTROS DE STOPWORDS, NUMEROS Y DEMAS
        
        term_gen.index_text_without_positions(uncontent)
        
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
        
        #identificacion del feed
        doc.add_term( "XFEED" + str(article.feed.id))
        doc.add_term( "D" + strftime("%Y-%m-%d",article.pub_date.timetuple()) )
        
        unique_key = "U" + article.link
        while len(unique_key.encode("utf8")) > 245:
            unique_key = unique_key[:-1]

        doc.add_term(unique_key)
        
        self.wdb.replace_document(unique_key, doc)
        
    def flush(self):
        self.wdb.flush()
        self.reopen_db()
        
    def reopen_db(self):
        try:
            self.read_db.reopen()
        except IOError:
            print "Unable to open database"
              
    def cleanAll(self):
        '''delete whole index'''
        ## @fixme Este metodo es inseguro, mejorarlo
        rmtree(self.db_dir)
        self.wdb = xapian.WritableDatabase(self.db_dir, xapian.DB_CREATE_OR_OPEN)
        self.read_db = xapian.Database(self.db_dir)
        self.reopen_db()

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
            try:
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
            except xapian.DatabaseModifiedError, e:
                self.reopen_db()
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
        
    def deleteArticlesFromFeed(self, feed, database_article_mapper):
        page = 0
        articles = database_article_mapper.loadArticlesByFeed(feed.id, page, 50)
        while len(articles) > 0:
            for art in articles:
                self.wdb.delete_document("U"+art.link)
            page += 1
            articles = database_article_mapper.loadArticlesByFeed(feed.id, page, 50)
            
        self.flush()
        
    def setStopWords(self, stopwords_dict):
        self.stopwords = stopwords_dict
                
    def mostRelevantTerms(self, article, Nterms):
        ''' extrae los N terminos mas relevantes 
        del articulo '''
            
        ## extraccion de terminos
        untitle, uncontent = self._cleanArticleText(article)
        
        termbag = []
        for i in re.split("\s+", uncontent):
            if not self.stopwords.has_key(i):
                if re.match("^[0-9]+(?:[.,][0-9]+)*$", i) is None:
                    termbag.append(i)
        
        
        enquire = xapian.Enquire(self.read_db)
        
        query = xapian.Query((" AND ".join(termbag).encode("utf8")))
        enquire.set_query(query)

        # Now, instead of showing the results of the query, we ask Xapian what are the
        # terms in the index that are most relevant to this search.
        # Normally, you would use the results to suggest the user possible ways for
        # refining the search.  I instead abuse this feature to see what are the tags
        # that are most related to the search results.

        # Use an adaptive cutoff to avoid to pick bad results as references
        matches = enquire.get_mset(0, 1)
        topWeight = matches[0].weight
        enquire.set_cutoff(0, topWeight * 0.7)

        # Select the first 10 documents as the key ones to use to compute relevant
        # terms
        rset = xapian.RSet()
        for m in enquire.get_mset(0, 30):
                rset.add_document(m[xapian.MSET_DID])
                
        # This is the "Expansion set" for the search: the 10 most relevant terms that
        # match the filter
        eset = enquire.get_eset(10, rset, None)

        # Print out the results
        for res in eset:
          print "%.2f %s" % (res.weight, res.term[2:])
        