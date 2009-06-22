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

if __name__ == '__main__':
  from psycopg2 import connect
  
  vero = connect("host=localhost user=mizhal password=Galatz dbname=veronica")
  sync_ff_feeds(vero)
  vero.commit()
