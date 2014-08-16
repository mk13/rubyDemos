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


p g.vertexSet
p g.edgeSet.each {|e| puts e}

ag = dfs(g)


p ag.edgeSet.each {|e| puts e}

#Yay it works