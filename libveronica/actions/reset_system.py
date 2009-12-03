from os import rmdir, remove, walk
from os.path import join, exists, isdir
from config import *

from psycopg2 import connect

from exceptions import Exception

if __name__ == "__main__":
	
	if exists(xapian_news_base):
		for root, dirs, files in walk(xapian_news_base):
			for f in files:
				remove(join(root, f))
				
		for root, dirs, files in walk(xapian_news_base):
			for d in dirs:
				rmdir(join(root, d))
				
		rmdir(xapian_news_base)
		
	if exists(logfile):
		remove(logfile)
		
	db = connect("host=localhost user=mizhal password=Alvidran dbname=postgres")
	db.set_isolation_level(0)
	cur = db.cursor()
	
	try:
		cur.execute("drop database veronica")
		db.commit()
	except Exception ,e:
		print e
		exit(-1)
		
	cur.execute("""CREATE DATABASE veronica
				WITH OWNER = mizhal
				ENCODING = 'UTF8';""")
	db.commit()
	db.close()

	db = connect("host=localhost user=mizhal password=Alvidran dbname=veronica")
	creation = open("./veronica.sql")
	cur = db.cursor()
	cur.execute(creation.read())
	db.commit()
	
	