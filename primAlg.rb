#NOT YET TESTED

require_relative 'graphsDS3'
require_relative 'heapPQ'
# g := original graph
# w := weight function
# r := starting vertex
def prim_mst(g, w, r)
	key = Hash.new
	path = Hash.new
	g.vertexSet.each do |v| 
		key[v] = Float::INFINITY
		path[v] = nil
	end
	
	key[r] = 0
	
	answer_graph = Graph.new(g.vertexSet)
	answer_graph.add_edge_manual(nil, r, 0.0)
	q = HeapPQ.new {|a,b| key[a] <= key[b]}
	
	g.vertexSet.each{|v| q.enqueue(v)}
	
	while !q.empty?
		u = q.dequeue
		g.adjEdges(u).each do |e|
			if q.include?(e.d) && w.call(e.s,e.d) < key[e.d]
				path[e.d] = e
				key[e.d] = e.w
				q.changeValue(e.d,e.d)
			end
		end
	end
	
	sumWeight = 0.0
	p path
	path.each_pair do |k,value|
		if value != nil
			sumWeight += w.call(value.s,value.d)
			answer_graph.add_edge(value)
			answer_graph.add_edge(value.mirror)
		end
	end
	answer_graph.extra['weight'] = sumWeight
	answer_graph
end