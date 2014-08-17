#NOT YET TESTED

require_relative 'graphsDS3'
require_relative 'heapPQ'
# g := original graph
# w := weight function
# r := starting vertex
def prim_mst(g, w, r)
	key = Hash.new(Float::INFINITY)
	key[r] = 0
	answer_graph = Graph.new(g.vertexSet)
	answer_graph.add_edge_manual(nil, r, 0.0)
	
	active_vertices = []
	g.vertexSex.each{|v| active_vertices << v}
	q = HeapPQ.new {|a,b| key[a] <= key[b]}
	
	active_vertices.each{|v| q.enqueue(v)}
	
	while !q.empty?
		u = q.dequeue
		active_vertices.delete(u)
		g.adjEdges(u).each do |e|
			if q.contains?(e.d) && e.w < key[e.d]
				answer_graph.add_edge(e)
				key[e.d] = e.w
			end
		end
		
		q.clear
		active_vertices.each{|v| q.enqueue(v)}
	end
	
	answer_graph
end

