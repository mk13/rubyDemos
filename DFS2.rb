require_relative 'graphsDS3'


$time = 0

def dfs_visit(originalGraph, answerGraph, u)
	$time+=1
	
	answerGraph.extra['discoverHash'][u] = $time
	answerGraph.extra['colorHash'][u] = :gray
	
	#Following does NOT preserve original edge objects
	#from the original graph; therefore harder to 
	#preserve extra information and weights
	
	#originalGraph.adj(u).each do |v|
	#	if answerGraph.extra['colorHash'][v] == :white
	#		answerGraph.add_edge_manual(u, v)
	#		dfs_visit(originalGraph, answerGraph, v)
	#	end
	#end
	
	#Following is a better usage; preserves
	#original edge objects and all necessary information
	originalGraph.adjEdges(u).each do |e|
		#e.s = u ; e.d = v
		if answerGraph.extra['colorHash'][e.d] == :white
			answerGraph.add_edge(e)	#add tree edge
			dfs_visit(originalGraph, answerGraph, e.d)
		elsif answerGraph.extra['colorHash'][e.d] == :gray
			answerGraph.extra['backEdges'] << e
		else
			if answerGraph.extra['discoverHash'][e.s] < answerGraph.extra['discoverHash'][e.d]
				answerGraph.extra['forwardEdges'] << e
			else
				answerGraph.extra['crossEdges'] << e
			end
		end
	end
	
	answerGraph.extra['colorHash'][u] = :black
	$time++
	answerGraph.extra['finishHash'][u] = $time
end

def dfs(g)
	colorHash = Hash.new(:white)
	discoverHash = Hash.new(0)
	finishHash = Hash.new(0)
	
	answer_graph = Graph.new(g.vertexSet, nil, 
		{'colorHash' => colorHash, 'discoverHash' => discoverHash, 'finishHash' => finishHash,
		 'backEdges' => Set.new, 'forwardEdges' => Set.new, 'crossEdges' => Set.new})
	
	g.vertexSet.sort.each do |u|
		if answer_graph.extra['colorHash'][u] == :white
			answer_graph.add_edge_manual(nil, u)
			dfs_visit(g, answer_graph, u)
		end
	end
	
	answer_graph
end

