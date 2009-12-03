##@todo

import calendar

class ControlSearch:
	def __init__(self, search_engine, decay, window = 1000):
		self.main_term #termino que se trata de afinar
		self.query = None #conjunto de terminos que expanden el termino principal antes de usar tesauro
		self.results = []
		self.search_engine = search_engine
		self.window = window
		
	def reloadResults(self):
		res = self.search_engine.doQuery(replace_acute(control_query), 0, window)
		
		self.results = [(i["percent"], i) for i in res["results"]]
			
	def timeSort(self, decay = None):
		if decay is None:
			decay = lambda time: 1 + (now - time)**1.1 + ((now - time)/3600)**6
		else:
			decay = decay
			
		now = calendar.timegm(datetime.now().timetuple())
	
		self.results = [(percent/self.decay(int(i["time"])), i) for percent, i in self.results] 