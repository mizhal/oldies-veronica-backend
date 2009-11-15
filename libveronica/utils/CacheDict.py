from collections import deque
from weakref import WeakValueDictionary
from time import time

class Node:
	time = 0
	data = None
	name = None
	
	def __init__(self, time, name):
		self.time = time
		self.name = name
	
	def __cmp__(self, other):
		return cmp(self.time, other.time)

class LRUCache:
	def __init__(self, max_size):
		self.LRU = [Node(time(), "none%s"%i) for i in range(max_size)]
		self.search = WeakValueDictionary()
		for i in self.LRU:
			self.search[i.name] = i
		
	def __setitem__(self, name, value):
		q = self.search.get(name, None)
		if q:
			q.data = value
			q.time = time()
		else:
			lru = self.LRU[0]
			self.search.pop(lru.name)
			lru.data = value
			lru.time = time()
			lru.name = name
			self.search[lru.name] = lru
		self.LRU.sort()
		
	def get(self, name, default=None):
		pos = None
		try:
			pos = self.search.__getitem__(name)
			pos.time = time()
			return pos.data
		except KeyError:
			if default is not None:
				return default
			else:
				raise

