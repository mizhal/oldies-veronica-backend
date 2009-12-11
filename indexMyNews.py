from __future__ import absolute_import

from sys import argv
from os import remove
from os.path import exists

### timeout al leer feeds

import socket
timeout = 10
socket.setdefaulttimeout(timeout)

##############################

from libveronica.facade import Veronica

if __name__ == "__main__":
	veronica = Veronica()
	user = 'cron'
	session_token = veronica.login(user, "ToAruMajutsuNoIndex")
	if len(argv) == 2:
		veronica.gatherNews(user, session_token, int(argv[1]))
	elif len(argv) >= 3:
		veronica.gatherNews(user, session_token, int(argv[1]), argv[2] != 0)
	else:
		veronica.gatherNews(user, session_token)
	