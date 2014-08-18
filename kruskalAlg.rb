=begin
Following is an implementation of Kruskal's minimum
spanning tree algorithm using
my Graph/Edge class from graphsDS3.rb. 
=end

require_relative 'graphsDS3'
require_relative 'disjointSetForests'
#g := starting graph
#w := weight function; call w.weight_function
def kruskal_mst(g,w)
	answer_graph = Graph.new(g.vertexSet)		
	sets = DisjointSetForest.new(*g.vertexSet)
	edges = g.edgeSet.sort{|u,v| w.call(u.s,u.d) <=> w.call(v.s, v.d)}
	
	edges.each do |e|
		if sets.find_set(e.s) != sets.find_set(e.d)
			answer_graph.add_edge(e)
			sets.union(e.s,e.d)
		end
	end
	answer_graph
end