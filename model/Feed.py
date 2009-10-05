'''
modelo de fuente de noticias
'''

from datetime import datetime

class Feed:
	id = None
	rss = None
	site = None
	title = ''
	response = 0
	freq = 1
	last_read = datetime.now()
	
	def __init__(self):
		self.last_read = datetime.now()