require_relative 'kruskalAlg'

#Graph construction
g = Graph.new(['a','b','c','d','e','f','g','h','i'])
g.add_undirected_edge_manual('a','b',4)
g.add_undirected_edge_manual('a','h',8)
g.add_undirected_edge_manual('b','c',8)
g.add_undirected_edge_manual('h','i',7)
g.add_undirected_edge_manual('i','c',2)
g.add_undirected_edge_manual('h','g',1)
g.add_undirected_edge_manual('i','g',6)
g.add_undirected_edge_manual('f','c',4)
g.add_undirected_edge_manual('g','f',2)
g.add_undirected_edge_manual('d','f',14)
g.add_undirected_edge_manual('d','e',9)
g.add_undirected_edge_manual('f','e',10)
g.add_undirected_edge_manual('c','d',7)


answer = kruskal_mst(g,g.weight_function)
p answer.edgeSet

require 'matrix'
m = Matrix.build(5) {0}
