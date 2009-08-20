import mozStorage

def sync_ff_feeds(dbcon):
  sql = "insert into feeds(rss, site) values('%s','%s')"
  previous = "select rss from feeds"
  cur = dbcon.cursor()
  cur.execute(previous)
  prev = [i[0] for i in cur.fetchall()]

  new = [(rss, site) for rss, site in mozStorage.list_feeds() if rss not in prev]
    
  #elimina duplicados de FF
  dups = {}
  for rss, site in new:
    if not dups.has_key(rss):
      cur.execute(sql % (rss, site))
      dups[rss] = 1
  dbcon.commit()

import sys
if __name__ == '__main__':
  from psycopg2 import connect
  
  print "usuario de la base de datos"
  user = sys.stdin.readline()
  print "clave"
  passw = sys.stdin.readline()
  
  vero = connect("host=192.168.1.7 user=%s password=%s dbname=veronica"%(user, passw))
  sync_ff_feeds(vero)
  vero.commit()
