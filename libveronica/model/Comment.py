'''
Created on 27/12/2009

@author: mizhal
'''
from datetime import datetime

class Comment(object):
    '''
    classdocs
    '''
    id = None
    version = 0
    article = None
    user = None
    title = u''
    text = u''
    created = datetime.now()
    modified = datetime.now()


    def __init__(selfparams):
        '''
        Constructor
        '''
        