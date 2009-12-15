#############3
## Configuraciones

db_string = "host=127.0.0.1 user=vigilante password=Casablancas dbname=veronica"

credentials = ("127.0.0.1","veronica","vigilante","Casablancas")

xapian_news_base = "/var/mik6/Base/indexes/news"

logfile = "/tmp/veronica-error.log"

from os.path import dirname

stopwords_file = dirname(dirname(__file__))

sf = open(stopwords_file)
stopwords = {}
for i in sf.read():
    stopwords[i] = 1 

