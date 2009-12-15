''' prueba de la funcionalidad de terminos mas relevantes '''

from libveronica.dao.XapianArticleLoader import XapianArticleLoader
from libveronica.dao.PostgreSQLArticleLoader import PostgreSQLArticleLoader
from libveronica.Veronica import xapian_news_base
from libveronica.config import stopwords

artloader = PostgreSQLArticleLoader()

while 1:
    print "prueba un articulo"
    id = input()
    art = artloader.loadAllArticles(400,1)[0]
    
    print "Contenido del articulo"
    print "-----------------------------"
    print art.content
    
    print "es este archivo correcto?"
    res = input()
    if res == 'S' or res == 's':
        break

search_engine = XapianArticleLoader(xapian_news_base)
search_engine.setStopWords(stopwords)

print "Terminos mas relevantes"
print "-----------------------------"
print search_engine.mostRelevantTerms(art, 10)
