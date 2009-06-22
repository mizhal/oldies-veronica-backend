import xapian

## @ref http://www.thesamet.com/blog/2007/02/04/pumping-up-your-applications-with-xapian-full-text-search/

DEFAULT_SEARCH_FLAGS = (
        xapian.QueryParser.FLAG_BOOLEAN |
        xapian.QueryParser.FLAG_PHRASE |
        xapian.QueryParser.FLAG_LOVEHATE |
        xapian.QueryParser.FLAG_BOOLEAN_ANY_CASE |
        xapian.QueryParser.FLAG_WILDCARD |
        xapian.QueryParser.FLAG_SPELLING_CORRECTION |
        xapian.QueryParser.FLAG_PARTIAL
        )

URL, TITLE, FEED_TITLE, FEED_ID, FETCH_TIMESTAMP, PUB_TIMESTAMP = range(6)

from infosfera.index.xapian.adapters import rel_to_prefix

import re
import sys

class Search:
	def __init__(self, dbfile):
		self.db = xapian.Database(dbfile)
		self.parser = xapian.QueryParser()
		self.parser.add_boolean_prefix("all", rel_to_prefix("all"))
		self.parser.add_boolean_prefix("tag", rel_to_prefix("rel"))
		self.parser.add_boolean_prefix("facet", rel_to_prefix("facet"))
		self.parser.add_boolean_prefix("state", rel_to_prefix("state"))
		
	def reopen_db(self):
		try:
		    self.db.reopen()
		except IOError:
		    print "Unable to open database"
		

	def doQuery(self, query, offset = 0, count = 100):
		#query = re.sub("-|\s+", " ", query)
		query = self.parser.parse_query(query.encode("utf8"))#, DEFAULT_SEARCH_FLAGS)

		enquire = xapian.Enquire(self.db)
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
			results.append(
				{"percent": m[xapian.MSET_PERCENT],
				"url": m[xapian.MSET_DOCUMENT].get_value(URL),
				"channel":m[xapian.MSET_DOCUMENT].get_value(FEED_TITLE),
				"title":m[xapian.MSET_DOCUMENT].get_value(TITLE),
				"time":m[xapian.MSET_DOCUMENT].get_value(FETCH_TIMESTAMP),
				}
			)
		return {"count": mset.get_matches_upper_bound(), "results": results}

if __name__ == "__main__":
	se = Search(ur"C:\LibroNegro\Base\indexes\news")
	res = se.doQuery(sys.argv[2],0,100)

	x = [(i["percent"], i) for i in res["results"]]
	x.sort()
	x.reverse()
	
	limit = int(sys.argv[1])
	for p, i in x[:limit]:
		print p,i["channel"],":", i["title"]
	print "----------------"
	print res["count"]
	