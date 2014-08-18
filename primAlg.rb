=begin
Following is an implementation of Prim's minimum
spanning tree algorithm using
my Graph/Edge class from graphsDS3.rb. 
The algorithm capitalizes on the fact that my graph
object is capable of freely storing extra data
in the form of a hash under instance variable, 'extra'.

Algorithm also utilizes my own HeapPQ data structure
in 'heapPQ.rb'. The balancing occurs by passing a closure
of the Graph's extra attribute to HeapPQ, which makes comparisons
using the block.

The algorithm returns another Graph, holding the same vertices
and edges from the original Graph that comprise the MST.
Call: <evaluatedGraph>.extra['weight'] to find the
weight of the yielded MST.

If MST for given original graph is not unique, algorithm
does not discern and simply returns the first MST
it evaluates. 

'q.include?(e.d)' is NOT constant time. 

Shallow tested; not rigorously tested.
Check: primTest.rb 
=end

require_relative 'graphsDS3'
require_relative 'heapPQ'
# g := original graph
# w := weight function
# r := starting vertex
def prim_mst(g, w, r)
	key = Hash.new
	path = Hash.new
	g.vertexSet.each do |v| 		#O(V)
		key[v] = Float::INFINITY
		path[v] = nil
	end
	
	key[r] = 0
	
	answer_graph = Graph.new(g.vertexSet)	#O(V)
	answer_graph.add_edge_manual(nil, r, 0.0)
	q = HeapPQ.new {|a,b| key[a] <= key[b]}
	
	g.vertexSet.each{|v| q.enqueue(v)}		#O(V)
	
	while !q.empty?							#Occurs at most, V times
		u = q.dequeue						#O(lg V)
		g.adjEdges(u).each do |e|			#At most occurs O(2E)->O(E) times
			if q.include?(e.d) && w.call(e.s,e.d) < key[e.d]	#Total: O(EV); **Change V run time to lg V for better results
				path[e.d] = e									
				key[e.d] = e.w
				q.changeValue(e.d,e.d)							#O(lg V) --> Total: O(E lg V)
			end
		end
	end										#Entire 'while' block therefore is: O(EV + E lg V) (not tight)
											# EV > E lg V, therefore O(EV)
	
	
	sumWeight = 0.0
	path.each_pair do |k,value|				#At most (V-1) edges; V if including arbitrary edge (nil, r); O(V)
		if value != nil						
			sumWeight += w.call(value.s,value.d)		#If w is a hash-lookup function, O(1); else runtime of w
			answer_graph.add_edge(value)
			answer_graph.add_edge(value.mirror)
		end
	end										#O(V*w) -> where w is a function run time; if hash, then O(v)
	
	answer_graph.extra['weight'] = sumWeight
	answer_graph
end
#Rough runtime analysis: O(V) + O(EV + E lg V) + O(V * w) = max{(EV), (V*w)}
#Best to consider as: O(EV); therefore not ideal O(E lg V) unless MinHeap can
#search in constant time. 


#Using space-time complexity; we can add hash to store all vertices in 
#minHeap with value of 0 or 1 to make 'q.contains' constant time. 
