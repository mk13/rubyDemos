require_relative 'DFS2'

g = Graph.new

g.add_edges_from_vertex('q', ['s','w','t'])
g.add_edges_from_vertex('r', ['u','y'])
g.add_edges_from_vertex('s', ['v'])
g.add_edges_from_vertex('t', ['x','y'])
g.add_edges_from_vertex('u', ['y'])
g.add_edges_from_vertex('v', ['w'])
g.add_edges_from_vertex('w', ['s'])
g.add_edges_from_vertex('x', ['z'])
g.add_edges_from_vertex('y', ['q'])
g.add_edges_from_vertex('z', ['x'])


puts 

p "PRINTING VERTEX SET OF ORIGINAL GRAPH:"
p "======================================"
p g.vertexSet
puts 

p "PRINTING ALL EDGES OF ORIGINAL GRAPH:"
p "====================================="
g.edgeSet.each {|e| puts e}

puts
puts
puts "FINISHED CALCULATING DFS GRAPH"
puts 

#answer graph
ag = dfs(g)

puts "PRINTING TREE EDGES:"
puts "===================="
p ag.edgeSet

puts

puts "PRINTING BACK EDGES:"
puts "===================="
p ag.extra['backEdges']
puts

puts "PRINTING FORWARD EDGES:"
puts "======================="
p ag.extra['forwardEdges']
puts

puts "PRINTING CROSS EDGES:"
puts "======================="
p ag.extra['crossEdges']
puts

