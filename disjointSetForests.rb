#Implemented from page 571
#of 'Introduction to Algorithms, 3rd edition" by
#Cormen, Leiserson, Rivest, Stein

#WARNING: WILL crash if all vertices/nodes are not
#properly added before applying other set functions

class DisjointSetForest
	
	def initialize(*args)
		@path = Hash.new
		@rank = Hash.new(0)
		
		args.each{|v| @path[v] = v}
	end
	
	def link(x,y)
		if @rank[x] > @rank[y]
			@path[y] = x
		else
			@path[x] = y
			@rank[y]+=1 if @rank[x] == @rank[y]
		end
	end
	
	def find_set(x)
		@path[x] = find_set(@path[x]) if x != @path[x]
		@path[x]
	end
	
	def union(x,y)
		link(find_set(x), find_set(y))
	end
	
	def make_set(x)
		@path[x] = x
	end
end