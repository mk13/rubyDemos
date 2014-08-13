=begin
Note: Implementation of code seen here are used
for personal educational purposes and do not demonstrate
any fully practical or optimal solution.
=end


#Simpler, more practical G=(V,E) version
#of graphsDS.rb; utilizes Sets and Hashes
#to basically make everything dumb easy.

require 'set'

class Graph
	attr_accessor :vertices, :edges
	#vertices      :: SET of all vertices
	#edges         :: HASH where key is vertex from
	#				  vertexList and value is a set of other vertices
	def initialize
		@vertices = Set.new
		@edges    = Hash.new(Set.new)
	end
	
	#Add single vertex to @vertices
	def addVertex(v)
		@vertices.add(v)
	end
	
	#Add single edge
	#Also adds u and v to vertices
	#if not already in it
	def addEdge(u, v)
		@vertices.add(u)
		@vertices.add(v)
		@edges[u].add(v)
	end
	
	#Same as above, but can pass list or any
	#enumerable
	def addEdges(u, enum)
		@vertices.add(u)
		enum.each do |v|
			@vertices.add(v)
			@edges[u].add(v)
		end
	end
	
	#Returns set of all adjacent vertices
	#to a given vertex u.
	#If vertex u does not exist or u exists
	#but does not have any adjacent, returns
	#empty set
	def adj(u)
		@edges[u]
	end
end
