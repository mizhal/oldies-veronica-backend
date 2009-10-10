class Article:
	''' articulo obtenido mediante rss '''
	def __init__(self):
		self.content = ''
		self.title = ''
		self.create_date = datetime.datetime(1,1,1) #ENG-POINT: valores que indican desconocido, 1 de enero del ano 1
		self.pub_date = datetime.datetime(1,1,1)
		self.fetch_date = datetime.datetime.now()
		self.feed = None
		self.link = ''
		self.id = None
	
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
		
	def extractIndexEntry(self):
		''' obtiene un objeto de entrada
		en el indice FTS para este
		articulo '''
		pass
		
class ArticleIndexEntry:
	''' elementos de un articulo que
	 se indexan en un indice FTS 
	 '''
	terms = []
	title_terms = []
	relevant_terms = []
	domain_terms = []
	tags = []
	feed_id = None
	fetch_date = None
	db_id = None
	url = None
	 
	def __init__(self):
		pass
		
		
class UserReview:
	article = None
	tags = []