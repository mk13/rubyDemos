require_relative 'graphsDS3'

# g := original graph
# w := weight function
# r := starting vertex
def prim_mst(g, w, r)
	path = Hash.new(Float::INFINITY)
	path[r] = 0
	answer_graph = Graph.new
	answer_graph.add_edge_manual(nil, r, 0.0)
	
end