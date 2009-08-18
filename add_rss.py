#!/bin/python

def add_feed(dbcon, rss, site, title):
	sql = "insert into feeds(rss, site, title) values('%s','%s','%s')"
	previous = "select rss from feeds"
	cur = dbcon.cursor()
	cur.execute(previous)
	prev = [i[0] for i in cur.fetchall()]

	if rss not in prev:
		cur.execute(sql % (rss, site, title))
	else:
		print "la fuente ya existe"

if __name__ == '__main__':

	from sys import argv
	from psycopg2 import connect
	import feedparser as rss
	
	data = rss.parse(argv[1])
	try:
		site = data.feed.link
	except:
		site = ""
		
	try:
		title = data.feed.title
	except:
		title = ""

	vero = connect("host=localhost user=mizhal password=Alvidran dbname=veronica")
	add_feed(vero, argv[1], site, title)
	vero.commit()
