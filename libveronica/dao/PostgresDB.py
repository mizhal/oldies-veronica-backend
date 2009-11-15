from psycopg2 import connect
from time import strftime

class PostgresDB:
	singleton = None
	
	@staticmethod
	def getInstance():
		if PostgresDB.singleton is None:
			PostgresDB.singleton = PostgresDB()
		return PostgresDB.singleton
	
	def __init__(self):
		from ..config import credentials
		self.con = connect("host=%s dbname=%s user=%s password=%s"%credentials)
		
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