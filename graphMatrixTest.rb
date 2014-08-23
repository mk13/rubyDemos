require_relative 'graphMatrix'

g1 = GraphMatrix.new(['a','b','c','d','e'])
g1.add_edge_manual('a','b',3)
g1.add_edge_manual('a','c',8)
g1.add_edge_manual('b','e',7)
g1.add_edge_manual('b','d',1)
g1.add_edge_manual('c','b',4)
g1.add_edge_manual('d','c',-5)
g1.add_edge_manual('d','a',2)
g1.add_edge_manual('e','d',6)
g1.add_edge_manual('a','e',-4)

g2 = GraphMatrix.new(['a','b','c','d','e'])
g2.add_edge_manual('a','b',3)
g2.add_edge_manual('a','c',8)
g2.add_edge_manual('b','e',7)
g2.add_edge_manual('b','d',1)
g2.add_edge_manual('c','b',4)
g2.add_edge_manual('d','c',-5)
g2.add_edge_manual('d','a',2)
g2.add_edge_manual('e','d',6)
g2.add_edge_manual('a','e',-4)

g1.print_hash_key


g3 = g1.extend(g1)

puts
g1.print_matrix
puts
g3.print_matrix