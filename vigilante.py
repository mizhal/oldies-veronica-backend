from sys import argv
from multiprocessing import Process, Queue
from veronica import connect, process_feed, select, sync_ff_feeds

db_string = "host=127.0.0.1 user=vigilante password=Casablancas dbname=veronica"

def worker(queue):
  vero = connect(db_string)
  id, rss = queue.get()
  while rss != '':
    process_feed(id, rss, vero)
    id, rss = queue.get()
  vero.commit()
  
POOL = 12
if __name__ == '__main__':

  vero = connect(db_string)
  
  #multiproceso
  
  queue = Queue()
  
  workers = [0]*POOL
  for i in range(POOL):
    workers[i] = Process(target = worker, args = (queue,))
    workers[i].start()
  
  #seleccion de los feeds a consultar
  feeds = None

  if len(argv) > 1:
    if argv[1] != '0':
      feeds = select(vero, int(argv[1]))
    else:
      cur = vero.cursor()
      cur.execute("select id, rss from feeds")
      feeds = cur.fetchall()
  else:
    feeds = select(vero)
    
  for id, rss in feeds:
    queue.put((id,rss))
    
  for i in range(POOL):
    queue.put(("",""))
    
  for i in range(POOL):
    workers[i].join()
