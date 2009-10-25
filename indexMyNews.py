from sys import argv
from os import remove
from os.path import exists

from veronica.actions.indexMyNews import execute

if __name__ == "__main__":
	if len(argv) == 2:
		execute(int(argv[1]))
	elif len(argv) >= 3:
		execute(int(argv[1]), argv[2] != 0)
	else:
		execute()