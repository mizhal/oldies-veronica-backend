from os.path import join, split
from time import strftime
from datetime import datetime
from exceptions import Exception

from md5 import md5

from psycopg2 import connect

from ..utils.readini import IniFile

local_dir, filename = split(__file__)[0]

config = IniFile(join(local_dir, "dbconfig.ini"))

SESSION_TIMEOUT = int(config.get("session.timeout"))

class PostgresDBReader:
	singleton = None
	
	@staticmethod
	def getInstance():
		if PostgresDBReader.singleton is None:
			PostgresDBReader.singleton = PostgresDBReader()
		return PostgresDBReader.singleton
	
	def __init__(self):
		user = config.get("reader.user")
		host = config.get("reader.host")
		password = config.get("reader.password")
		dbname = config.get("reader.dbname")
		self.con = connect("host=%s dbname=%s user=%s password=%s"%(host, dbname, user, password))
		
	def connect(self, host, dbname, user, passwd):
		pass
		
	def convertTimestamp(self, atime):
		return strftime("%Y-%m-%d %H:%M:%S",atime.timetuple())
		
	def cursor(self):
		return self.con.cursor()
		
	def commit(self):
		self.con.commit()
		
	def close(self):
		self.con.close()
		
	def __del__(self):
		self.con.close()
		
	SESSION_TOKENS = {}
		
	def _genSessionToken(self):
		letters = []
		for i in range(128):
			letters.append(random.randint(ord("A"), ord("Z")))
		return "".join(letters)
		
	def openSession(self, user, password):
		cur = self.cursor()
		cur.execute("select * from users where user=? and password=?", user, password)
		if len(cur.fetchall()) > 0:
			token = self._genSessionToken()
			while PostgresDBReader.SESSION_TOKENS.has_key(token):
				token = self._genSessionToken()
			
			PostgresDBReader.SESSION_TOKENS[token] = (user, datetime.now())
				
			return token
		else:
			return False
			
	def validateUser(self, user, session_token):
		q = PostgresDBReader.SESSION_TOKENS.get(session_token, None)
		if q:
			if q[0] == user and (datetime.now() - q[2]).seconds < SESSION_TIMEOUT:
				PostgresDBReader.SESSION_TOKENS[token] = (user, datetime.now())
				return True
			else:
				return False
		
			
class NotEnoughPrivileges(Exception):
	pass

class PostgresDBPrivileged(PostgresDBReader):
	singleton = None
	
	@staticmethod
	def getInstance(user, session_token):
		if PostgresDBPrivileged.singleton is None:
			PostgresDBPrivileged.singleton = PostgresDBPrivileged()
		if self.validateUser(user, session_token):
			return PostgresDBPrivileged.singleton
		else:
			raise NotEnoughPrivileges()
	
	def __init__(self):
		user = config.get("privileged.user")
		host = config.get("privileged.host")
		password = config.get("privileged.password")
		dbname = config.get("privileged.dbname")
		self.con = connect("host=%s dbname=%s user=%s password=%s"%(host, dbname, user, password))