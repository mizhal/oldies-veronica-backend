#############3
## Configuraciones

db_string = "host=127.0.0.1 user=vigilante password=Casablancas dbname=veronica"

credentials = ("127.0.0.1","veronica","vigilante","Casablancas")

xapian_news_base = "/var/mik6/Base/indexes/news"

logfile = "/tmp/veronica-error.log"

from os.path import join, dirname

stopwords_file = join(dirname(dirname(__file__)), "stopwords.txt")

sf = open(stopwords_file)
stopwords = {}
for i in sf.read():
    stopwords[i] = 1 

