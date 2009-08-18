''' elementos de acceso y mantenimiento de la
base de articulos en Xapian

@todo decidir si es mejor usar esta clase como singleton y entonces especificar el nombre de la BD xapian a traves de las configuraciones

'''

############################
# DAO de articulos en Xapian
############################
URL, TITLE, FEED_TITLE, FEED_ID, FETCH_TIMESTAMP, PUB_TIMESTAMP = range(6)

class XapianArticleLoader(ArticleLoader):
	def __init__(self, xapian_db, dbfile):
		self.db = xapian_db
		self.dbfile = dbfile
		
		## para consultas
		self.read_db = None
		
		self.parser = xapian.QueryParser()
		self.parser.add_boolean_prefix("all", rel_to_prefix("all"))
		self.parser.add_boolean_prefix("tag", rel_to_prefix("rel"))
		self.parser.add_boolean_prefix("facet", rel_to_prefix("facet"))
		self.parser.add_boolean_prefix("state", rel_to_prefix("state"))
	
	def reopenDBReader(self):
		try:
		    self.read_db.reopen()
		except IOError:
		    print "Unable to open database"
		
	def save(self, article):
		term_gen = xapian.TermGenerator()
		try:
			untag = replace_acute(decode_htmlentities(strip_html_tags(article.title + " " + article.content)))
			untitle = replace_acute(decode_htmlentities(strip_html_tags(article.title)))
		except UnicodeDecodeError, e:
			print e
			errors.log("XapianArticleLoader", "save", str(e))
			return
		term_gen.index_text_without_positions(untag)
		
		doc = term_gen.get_document()
		
		title_gen = xapian.TermGenerator()
		title_gen.set_document(doc)
		title_gen.index_text_without_positions(untitle, 10)## tiene peso 10
		
		doc.add_value(TITLE, unicode(article.title).encode("utf-8") )
		doc.add_value(URL, article.link )
		doc.add_value(FEED_TITLE, unicode(article.feed_title).encode("utf-8") )
		doc.add_value(FEED_ID, str(article.feed_id) )
		doc.add_value(FETCH_TIMESTAMP, str(calendar.timegm(article.fetch_date.timetuple())) )
		doc.add_value(PUB_TIMESTAMP, str(calendar.timegm(article.pub_date.timetuple())) )
		
		doc.add_term( "D" + strftime("%Y-%m-%d",article.pub_date.timetuple()) )
		
		id_doc = article.id
		
		self.db.replace_document(str(id_doc), doc)
		
	def loadFromQuery(self, query, offset = 0, count = 100):
		#query = re.sub("-|\s+", " ", query)
		query = self.parser.parse_query(query.encode("utf8"))#, DEFAULT_SEARCH_FLAGS)
		if self.read_db is None:
			self.read_db = xapian.Database(self.dbfile)
			
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
		for m in mset:
			art = Article()
			art.title = m[xapian.MSET_DOCUMENT].get_value(TITLE)
			art.link = m[xapian.MSET_DOCUMENT].get_value(URL)
			art.fetch_date = m[xapian.MSET_DOCUMENT].get_value(FETCH_TIMESTAMP)
			art.pub_date = m[xapian.MSET_DOCUMENT].get_value(PUB_TIMESTAMP)
			art.feed_title = m[xapian.MSET_DOCUMENT].get_value(FEED_TITLE)
			art.feed_id = m[xapian.MSET_DOCUMENT].get_value(FEED_ID)
			
			results.append(
				{
					"percent": m[xapian.MSET_PERCENT],
					"article": art
				}
			)
		return {"count": mset.get_matches_upper_bound(), "results": results}