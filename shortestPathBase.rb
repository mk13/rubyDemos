require_relative 'graphsDS3'

module SP #Shortest Paths
	#Given original graph g,
	#Returns a predecessor graph
	def SP.initialize_single_source(g,s)
		pgraph = Graph.new([s])
		pgraph.extra['root'] = s
		pgraph.extra['upperBound'] = Hash.new(Float::INFINITY)
		pgraph.extra['predecessor'] = Hash.new(nil)
		pgraph.extra['upperBound'][s] = 0
		pgraph
	end
	
	#Given edge=(u,v), relaxes the edge
	def SP.relax(pgraph,e,w)
		t = pgraph.extra['upperBound'][e.s] + w.call(e.s,e.d)
		if pgraph.extra['upperBound'][e.d] > t
			pgraph.extra['upperBound'][e.d] = t
			pgraph.extra['predecessor'][e.d] = e
		end
	end
end