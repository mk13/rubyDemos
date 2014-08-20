require_relative 'shortestPathBase'
	#SP.initialize_single_source(g,s)
	#SP.relax(pgraph,u,v,w)

def bellmanFordAlg(g, w, s)
	pgraph = SP.initialize_single_source(g,s)
	
	(1..(g.vertexSet.size-1)).each do |i|
		g.edgeSet.each do |e|
			SP.relax(pgraph, e, w)
		end
	end
	
	#Checks for negative valued cycles; if found, returns nil
	g.edgeSet.each{|e|
		return nil if pgraph.extra['upperBound'][e.d] > pgraph.extra['upperBound'][e.s] + w.call(e.s,e.d)
	}
	
	#If no negative valued cycles exist, constructs shortest-paths graph
	pgraph.extra['upperBound'].each_pair{|k,v|
		pgraph.vertexSet << k if v != Float::INFINITY
	}

	pgraph.vertexSet.each{|v|
		pgraph.add_edge(pgraph.extra['predecessor'][v])
	}
	
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
	
	pgraph.extra['printPaths'] = lambda do
		puts
		puts "Paths with root: #{pgraph.extra['root'].to_s}"
		puts "===================="
		pgraph.vertexSet.each{|v| puts "#{v.to_s} => #{pgraph.extra['path'][v]} ; #{pgraph.extra['upperBound'][v]}"}
	end
	
	pgraph
end