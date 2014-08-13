=begin
Note: Implementation of code seen here are used
for personal educational purposes and do not demonstrate
any fully practical or optimal solution.

Evaluation: badly designed datastructure; does not
accommade for future changes or different search structures. 
Need a data structure base that is more versatile with
a strong foundation that is universal.
=end


#Simpler, more practical G=(V,E) version
#of graphsDS.rb; utilizes Sets and Hashes
#to basically make everything dumb easy.


# TO ADD: Removal of edges and vertices
require 'set'

class Graph
	attr_reader :vertices, :edges, :edgesSpecial
	#vertices      :: SET of all vertices
	#edges         :: HASH where key is vertex from
	#				  vertexList and value is a set of other vertices
	def initialize
		@vertices = Set.new
		@edges    = Hash.new() #Using @edges = Hash.new(Set.new) not working
		@edgesSpecial = Hash.new() #Used for defining values to edges
								   #Keys = 2 index arrays [u,v]
								   #Values = type
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
		@edges[u] = Set.new if !@edges.key?(u)
		@edges[u].add(v)
	end
	
	#Same as above, but can pass list or any
	#enumerable
	def addEdges(u, enum)
		@vertices.add(u)
		@edges[u] = Set.new if !@edges.key?(u)
		enum.each do |v|
			@vertices.add(v)
			@edges[u].add(v)
		end
	end
	
	#Returns a vertex LIST
	def vertexList
		return @vertices.to_a
	end
	
	def defineEdge(e, type)
		@edgesSpecial[e] = type
	end
	
	#Returns list of all adjacent vertices
	#to a given vertex u.
	#If vertex u does not exist or u exists
	#but does not have any adjacent, returns
	#empty list
	def adj(u)
		@edges[u].to_a
	end
end

=begin
g = Graph.new
g.addEdges(5,[1,2,3,4])
g.addEdge(1,2)

p g.adj(5)
p g.adj(1)
p g.adj(2)
p g.vertexList
=end