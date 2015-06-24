'''
Created on 01/01/2010

@author: mizhal

@todo Ampliar esta clase y considerar si es necesario o mejor crear un pequeño webcrawler
'''
from urllib2 import urlopen
from lxml.html import fromstring

class EnhancedRetriever(object):
    ''' Algunas fuentes necesitan postproceso
        para recuperar el verdadero texto de
        la noticia (agregadores o sitios sociales),
        esta clase proporciona ayuda para realizarlo
        '''
    retrieve = False # si vale True, debe descargarse la pagina indicada en 'Article.link'
    relevant_classes = [] #clases CSS de los elementos cuyo contenido se indexa, vacio equivale a indexar todo
    forward_retrieve_class = None #clase CSS del enlace que debe seguirse para llegar a la verdadera noticia. Solo se sigue el primero
    follow_links = False #si vale True
        
    def __init__(self):
        pass
    
    def getHtml(self, link):
        page = urlopen(link)
        text = page.read()
        return fromstring(text)
    
    def process(self, article):
        ''' retorna el articulo con su contenido
            enriquecido '''
        
        infobag = []
            
        if self.retrieve:
            html = self.getHtml(article.link)
            infobag.append(self.captureRelevantInfo(html))
            
            if not self.forward_retrieve_class is None:
                link = html.xpath("//*[@class='%s']/@href"%self.forward_retrieve_class)[0]
                html2 = self.getHtml(link)
                infobag.append(self.captureRelevantInfo(html2))
                
        if self.follow_links:
            html3 = fromstring("<html><body>%s</body></html>"%article.content)
            links = html3.xpath("//a/@href")
            for link in links:
                html4 = self.getHtml(link)
                infobag.append(self.captureRelevantInfo(html4))
                    
        article.content = '\n'.join(article.content, *infobag)
            
    def captureRelevantInfo(self, html):
        classes = []
        for c in self.relevant_classes:
            classes.append("@class='%s'"%c)
            
        info = html.xpath("//*[%s]//text()"%(" or ".join(classes),))
        return ''.join(info)
            
            
            
