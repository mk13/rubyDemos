require_relative 'graphsDS3'

$time = 0

def dfs_visit(originalGraph, answerGraph, u)
	$time+=1
	
	answerGraph.extra['discoverHash'][u] = $time
	answerGraph.extra['colorHash'][u] = :gray
	
	originalGraph.adj(u).each do |v|
		if answerGraph.extra['colorHash'][v] == :white
			answerGraph.add_edge_manual(u, v)
			dfs_visit(originalGraph, answerGraph, v)
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
		{'colorHash' => colorHash, 'discoverHash' => discoverHash, 'finishHash' => finishHash})
	
	g.vertexSet.sort.each do |u|
		if answer_graph.extra['colorHash'][u] == :white
			answer_graph.add_edge_manual(nil, u)
			dfs_visit(g, answer_graph, u)
		end
	end
	
	answer_graph
end

