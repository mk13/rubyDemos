=begin
Code is one giant mess; origin of mess started
with a badly defined node/vertex.
Need a Data Structure for vertex that is more
universal.

DO NOT RUN CODE - unless you want it to crash several times
=end
require_relative 'graphsDS2'

$count = 0

class DFSnode
	attr_accessor :value, :color, :source, 
				  :discover, :finish
	def initialize(value, color = :WHITE, 
				   source = nil, discover = nil, finish = nil)
		@value = value
		@color = color
		@source = source
		@discover = discover
		@finish = finish
	end
end


def DFS(g)
	gpi = Graph.new
	g.edges.each_pair do |v, l|
		l.each {|w| gpi.addEdge(DFSnode.new(v), DFSnode.new(w))}
	end
	$count = 0
	
	gpi.vertexList.each{|u| DFS_VISIT(g, gpi, u) if u.color == :WHITE}
	
	gpi
end

def DFS_VISIT(g, u)
	$count++
	u.d = $count
	u.color = :GRAY
	
	g.adj(u).each do |v|
		if v.color == :WHITE
			v.source = u
			g.defineEdge([u,v], :TREEEDGE)
			DFS_VISIT(g, v)
		elsif v.color == :GRAY
			g.defineEdge([u,v], :BACKEDGE)
		else
			if u.distance > v.distance
				g.defineEdge([u,v], :FORWARDEDGE)
			else
				g.defineEdge([u,v], :CROSSEDGE)
			end
		end
	end
	
	u.color = :BLACK
	$count++
	u.finish = $count
end

