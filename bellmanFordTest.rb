require_relative 'singleSourceSPAlg'

#Graph construction
g = Graph.new(['s','t','x','y','z'])
g.add_edge_manual('s','y',7)
g.add_edge_manual('s','t',6)
g.add_edge_manual('t','y',8)
g.add_edge_manual('t','x',5)
g.add_edge_manual('x','t',-2)
g.add_edge_manual('y','x',-3)
g.add_edge_manual('t','z',-4)
g.add_edge_manual('z','x',7)
g.add_edge_manual('y','z',9)
g.add_edge_manual('z','s',2)

#Running bellmanford alg
pgraph = bellmanFordAlg(g, g.weight_function, 's')
pgraph.extra['printPaths'].call