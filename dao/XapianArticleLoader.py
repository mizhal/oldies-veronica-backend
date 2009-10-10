'''
Created on 08/10/2009

@author: mizhal
'''

class XapianArticleLoader(object):
    '''
    DAO para serializacion de articulos
    entre la memoria y el indice FTS.
    
    Se serializa solamente indices de
    articulo, no el objeto de negocio
    Article que tiene parte de su
    informacion en la base de datos.
    '''
    URL, TITLE, FEED_TITLE, FEED_ID, FETCH_TIMESTAMP, PUB_TIMESTAMP, ID = range(7)
    
    def __init__(self, xapian_db):
        self.db = xapian_db
        
    def save(self, article):
        term_gen = xapian.TermGenerator()
        try:
            untag = replace_acute(decode_htmlentities(strip_html_tags(article.title + " " + article.content)))
            untitle = replace_acute(decode_htmlentities(strip_html_tags(article.title)))
        except UnicodeDecodeError, e:
            print e
            errors.log("XapianArticleLoader", "save", str(e))
            return
        term_gen.index_text_without_positions(untag)
        
        doc = term_gen.get_document()
        
        title_gen = xapian.TermGenerator()
        title_gen.set_document(doc)
        title_gen.index_text_without_positions(untitle, 10)## tiene peso 10
        
        doc.add_value( XapianArticleLoader.TITLE, unicode(article.title).encode("utf-8") )
        doc.add_value( XapianArticleLoader.URL, article.link )
        doc.add_value( XapianArticleLoader.FEED_TITLE, unicode(article.feed_title).encode("utf-8") )
        doc.add_value( XapianArticleLoader.FEED_ID, str(article.feed_id) )
        doc.add_value( XapianArticleLoader.FETCH_TIMESTAMP, str(calendar.timegm(article.fetch_date.timetuple())) )
        doc.add_value( XapianArticleLoader.PUB_TIMESTAMP, str(calendar.timegm(article.pub_date.timetuple())) )
        doc.add_value( XapianArticleLoader.ID, str(article.id))
        
        doc.add_term( "D" + strftime("%Y-%m-%d",article.pub_date.timetuple()) )
        doc.add_term( "U" + article.link) ## @change cambiado para usar como indice la url, ya que para sustituir xapian usa un termino como indice, asi se sustituyen los que tengan el termino dado como primer parametro, no el identificador, por ello, es necesario anyadir ese termino de "unicidad"
        
        self.db.replace_document("U" + article.link, doc)