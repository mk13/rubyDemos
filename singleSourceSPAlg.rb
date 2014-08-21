require_relative 'shortestPathBase'
	#SP.initialize_single_source(g,s)
	#SP.relax(pgraph,u,v,w)

def bellmanFordAlg(g, w, s)
	#Predecessor graph that keeps track 
	#of progress; at end, it is the single-source
	#shortest path tree
	pgraph = SP.initialize_single_source(g,s)					#O(1)
	
	#Main algorithm: ===================================		O(VE)
	(1..(g.vertexSet.size-1)).each do |i|
		g.edgeSet.each do |e|
			SP.relax(pgraph, e, w)
		end
	end
	
	#Checks for negative valued cycles; if found, returns nil		O(E)
	g.edgeSet.each{|e|
		return nil if pgraph.extra['upperBound'][e.d] > pgraph.extra['upperBound'][e.s] + w.call(e.s,e.d)
	}
	#Main algorithms ENDS ==============================
	
	#Add all reachable graphs from s to pgraph's vertexSet;
	#if a vertex cannot be reached, it will not be added
	#to the vertex set, but to an extra storage space				O(V)
	pgraph.extra['unreachable'] = Set.new
	pgraph.extra['upperBound'].each_pair{|k,v|
		if v != Float::INFINITY then pgraph.vertexSet << k else pgraph.extra['unreachable'] << k end
	}

	#Add edges to each vertex that leads to that vertex				O(V)
	pgraph.vertexSet.each{|v|
		pgraph.add_edge(pgraph.extra['predecessor'][v])
	}
	
	#Hash to create a list of path for each vertex					O(V * V-1) = O(V^2) ??
	pgraph.extra['path'] = Hash.new()
	pgraph.vertexSet.each do |v|
		a = []
		current = v
		loop do
			a.unshift current
			break if current == s
			current = pgraph.extra['predecessor'][current].s
		end
		pgraph.extra['path'][v] = a
	end
	
	#Optional function to neatly printout the
	#order of all reachable vertices' paths
	#	Simply: pgraph.extra['printPaths'].call						O(V)
	pgraph.extra['printPaths'] = lambda do
		puts
		puts "Paths with root: #{pgraph.extra['root'].to_s}"
		puts "===================="
		pgraph.vertexSet.each{|v| puts "#{v.to_s} => #{pgraph.extra['path'][v]} ; #{pgraph.extra['upperBound'][v]}"}
	end
	
	pgraph
end
#O(max{VE, V^2)) ??