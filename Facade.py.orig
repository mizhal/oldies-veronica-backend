from sys import argv
from psycopg2 import connect
import feedparser as rss

class Veronica:
	def __init__(self):
		self.vero = connect("host=localhost user=mizhal password=Alvidran dbname=veronica")
		
	def select(self, tries = 6):
		''' Seleccion aleatoria de "tries" feeds para vigilar '''
		#TODO: de momento no tiene en cuenta la afinidad del usuario, pero es necesario incorporarlo
		vero = self.vero

		bag = []
		cur = vero.cursor()
		cur.execute("select id, title, rss from feeds order by (now() - last_read)*freq desc limit %s"%(2*tries,))
		bag.extend(cur.fetchall()) #fuentes muy productivas

		cur.execute("select id, title, rss from feeds order by last_read asc limit %s"%(2*tries,))
		bag.extend(cur.fetchall()) #fuentes poco atendidas

		selected = []
		for i in range(tries):
			try_ = int(random.uniform(0, len(bag)))
			s = bag.pop(try_)
			selected.append(s)

		return selected
		
	def addFeed(self, url):
		''' anyadir un feed '''
		data = rss.parse(url)
		try:
			site = data.feed.link
		except:
			site = ""
			
		try:
			title = data.feed.title
		except:
			title = ""

		vero = self.vero
		
		sql = "insert into feeds(rss, site, title) values('%s','%s','%s')"
		previous = "select rss from feeds"
		cur = vero.cursor()
		cur.execute(previous)
		prev = [i[0] for i in cur.fetchall()]

		if url not in prev:
			cur.execute(sql % (url, site, title))
		else:
			raise "la fuente ya existe"
		
		vero.commit()
		
	def deleteFeed(self, url):
		pass
		
	def classifyFeed(self, feed, sgcat):
		pass
		