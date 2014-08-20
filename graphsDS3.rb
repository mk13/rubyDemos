=begin
GOAL OF THIS FILE: 
	Create a generic Graphs data structure that follows the
	G=(V,E) model. Needs to allow for flexibility in what type of
	values a vertex can be: integer, string, object, etc. 
	
	Use various features of Ruby to gain understanding and practice.
	Basic functionalities needed: 
		* Graph must be able to hold a weight function or hash
		* Vertex set and Edge Set
		* Adj[u] => returns a list/set of all vertices it can connect with
		* Define structure of an edge; store two vertices and weight
			* Uphold consistency with vertex list; a vertex that exists in
			  any edge of Edge List must also exist in Vertex List
		* Need a way to hold any additional number of attributes for a Vertex
			* Need a way to access those attributes of a given Vertex
		* Work with object_id for easiest vertex accesibility
		
	Extra features to consider:
		* Consider a hash cache in Graphs to store adjacency lists of
		  recently searched vertices to reduce computational time.
		
=end

require 'set'

class Edge
	attr_reader :s, :d, :w, :extra
	def initialize(source, destination, weight=nil, *args)
		@s = source
		@d = destination
		@w = weight
		@extra = args
	end
	
	def to_s
		"(#{@s.to_s}, #{@d.to_s})"
	end
	
	def change_s(s)
		@s = s
	end
	
	def change_d(d)
		@d = d
	end
	
	def weight
		if @w == nil then 0.0 else @w end
	end
	
	def match?(u,v)
		if e.s == u && e.d == v
			e
		else
			nil
		end
	end
	
	#Useful for mirroring an edge in a
	#undirected graph
	def mirror
		Edge.new(@d, @s, @w, *@extra)
	end
	
end

class Graph
	attr_reader :vertexSet, :edgeSet, :extra, :weightFunction
	
	def initialize(vlist=nil, elist=nil, extra = {}, &weightFunction)
		@vertexSet = Set.new
		@edgeSet = Set.new
		@weightFunction = weightFunction
		@extra = extra
		
		if vlist != nil
			vlist.each {|v| @vertexSet << v}
		end
		
		if elist != nil
			elist.each {|e| @edgeSet << e if e.class == Edge}
		end
	end

	def add_vertex(v)
		@vertexSet << v
	end
	
	def add_edge(e)
		if e.class == Edge
			@edgeSet << e
			@vertexSet << e.s if !@vertexSet.include?(e.s) && e.s != nil
			@vertexSet << e.d if !@vertexSet.include?(e.d) && e.d != nil
			true
		else
			false
		end
	end
	
	def add_edge_manual(s,d,w=nil,*extra)
		e = Edge.new(s,d,w,*extra)
		add_edge(e)
	end
	
	def add_undirected_edge_manual(s,d,w=nil, *extra)
		e = Edge.new(s,d,w,*extra)
		add_edge(e)
		e = e.mirror
		add_edge(e)
	end
	
	def add_edges(elist)
		elist.each {|e| add_edge(e) if e.class == Edge}
	end
	
	def add_edges_from_vertex(u, vlist)
		vlist.each{|v| add_edge_manual(u,v)}
	end
	
	def vertexSize
		@vertexSet.size
	end
	
	def edgeSize
		@edgeSet.size
	end
	
	#Returns a LIST of vertices adjacent to vertex u
	def adj(u)
		l = Array.new
		@edgeSet.each do |e|
			if e.s == u
				l << e.d
			end
		end
		l
	end
	
	#Returns a list of the original edge objects
	#with vertex u as the starting
	#Better to use this if you want to preserve
	#reference pointers to original edges
	#rather than creating whole new edges
	def adjEdges(u)
		l = Array.new
		@edgeSet.each do |e|
			if e.s == u
				l << e
			end
		end
		l
	end
	
	def sum_weight
		sum = 0.0
		@edgeSet.each do |e|
			sum += e.weight
		end
		sum
	end
	
	def vertex_sum_weight(v)
		sum = 0.0
		@edgeSet.each do |e|
			sum += e.weight if e.s == v
		end
		sum
	end
	
	#Returns the weightfunction proc-object if it has been defined;
	#Other wise, returns a closure function that simply looks for edge
	#in hash and returns weight.
	def weight_function
		if @weightFunction != nil
			@weightFunction
		else
			lambda do |u,v|
				@edgeSet.each{|f| return f.weight if (f.s==u && f.d == v)}
				return nil
			end
		end
	end
end

=begin
g = Graph.new
g.add_edge_manual('a','b', 5.0)
g.add_edge_manual('a','c', 6.0)
g.add_edge_manual('b','c', 7.0)
g.add_undirected_edge_manual('y','z',10.0)

w = g.weight_function

x =  w.call('a','b')
p x
p w.call('d','e')
p g.edgeSet
=end


=begin
g = Graph.new([1,2,3,4,5])
p g.vertexSet
g.add_edge_manual(1,2,5)
g.add_edge_manual(2,3,30)
g.add_edge_manual(1,4,5)
g.add_edge_manual(1,3,5)
g.add_edge_manual(1,5,5)
g.add_edge_manual(20,30)

p g.vertexSet
p g.adj(1)
p g.adj(2)
p g.adj(5)
p g.adj(20)


r = 2.8
puts r.class

n = nil
puts n.class

p g.sum_weight
p g.vertex_weight(1)
=end

