import re
from htmlentitydefs import name2codepoint as n2cp

def substitute_entity(match):
    ent = match.group(2)
    if match.group(1) == "#":
        try:
          return unichr(int(ent))
        except ValueError, e:
          return unichr(eval("0"+ent))
    else:
        cp = n2cp.get(ent)

        if cp:
            return unichr(cp)
        else:
            return match.group()

def decode_htmlentities(string):
    entity_re = re.compile("&(#?)(\d{1,5}|\w{1,8});")
    return entity_re.subn(substitute_entity, string)[0]


def replace_acute(string):
  st = string.replace(u'\xe1',u'a') 
  st = st.replace(u'\xe9',u"e") 
  st = st.replace(u'\xed',u"i") 
  st = st.replace(u'\xf3',u"o") 
  st = st.replace(u'\xfa',u"u")
  st = st.replace(u'\xb4',u"")
  return st

def strip_html_tags(text):
	import html_stripper
	parser =  html_stripper.StrippingParser()
	parser.feed(text)
	parser.close()
	parser.cleanup()
	return parser.result