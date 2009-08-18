from sys import argv
from config import db_string, xapian_news_base

from veronica import connect, process_feed2, select
import xapian

from os import remove
from os.path import exists

if __name__ == '__main__':
	vero = connect(db_string)

	db = xapian.WritableDatabase(xapian_news_base, xapian.DB_CREATE_OR_OPEN)

	#seleccion de los feeds a consultar
	feeds = None

	if len(argv) > 1:
		if argv[1] != '0':
			feeds = select(vero, int(argv[1]))
		else:
			cur = vero.cursor()
			cur.execute("select id, title, rss from feeds")
			feeds = cur.fetchall()
	else:
		feeds = select(vero)

	for id, title, rss in feeds:
		process_feed2(id, title, rss , db, vero)
		
	db.flush()
