'''
Created on 08/10/2009

@author: mizhal
'''

class WordExtractor(object):
    '''
    Extrae terminos desde un articulo
    '''


    def __init__(selfparams):
        '''
        Constructor
        '''
        
    def extractPlainText(self, content):
        pass
    
    def extractFromHTML(self, content):
        pass
        
class XapianWordExtractor(WordExtractor):
    def extractPlainText(self, content):
        pass
    
    def extractFromHTML(self, content):
        term_gen = xapian.TermGenerator()
        try:
            untag = replace_acute(decode_htmlentities(strip_html_tags(content)))
        except UnicodeDecodeError, e:
            print e
            errors.log("XapianArticleLoader", "save", str(e))
            return