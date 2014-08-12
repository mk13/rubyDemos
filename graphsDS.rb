#Standard linked-list node
#Serves as both a node and linked list
class AdjacencyNode
	attr_accessor :value, :nextNode
	
	def initialize(value, nextNode)
		@value = value
		@next = nextNode
	end
	
	#Neatly prints out the node
	#while following the pointers until
	#it reaches an end
	def to_s
		str = "#{@value} -> "
		if nextNode == nil
			str << "/"
			str << "\n"
		else
			str << @nextNode.to_s
		end
		str
	end
	
	#Calling each on it will return the value
	#of every node in the linked list,
	#starting with the current node as the head
	def each
		h = self
		while h != nil
			yield h.value
			h = h.nextNode
		end
	end
	
	#Call this on a node to follow
	#the linked list and reach the last node (not including nil),
	#for which the last node is returned
	def getLast
		h = self
		while h.nextNode != nil
			h = h.nextNode
		end
		h
	end
end

#Numerical vertices only
#Standard Adjacency-List representation of 
#	G=(V,E)
class AdjacencyList
	attr_reader :mainArray, :vertexList
	
	def initialize
		@mainArray = []
		@vertexList = [] #All valid vertices that are consistent
	end
	
	#Adding edge e=(u,v)
	#Where a
	def add_edge(u,v)
		checkAndAddConsistency(u)
		checkAndAddConsistency(v)
		if @mainArray[u] == nil
			@mainArray[u] = AdjacencyNode.new(v, nil)
		else
			tmp = @mainArray[u].getLast
			tmp.nextNode = AdjacencyNode.new(v,nil)
		end
	end
	
	#Adding a list of edges to u
	def add_edges(u, list)
		checkAndAddConsistency(u)
		if @mainArray[u] == nil
			@mainArray[u] = tmp = AdjacencyNode.new(list.shift, nil)
		else 
			tmp = @mainArray[u].getLast
		end
		
		list.each do |v|
			checkAndAddConsistency(v)
			tmp.nextNode = AdjacencyNode.new(v,nil)
			tmp = tmp.nextNode
		end
	end
	
	#Given a vertex #
	def [](v)
		@mainArray[v]
	end
	
	#Neatly prints out entire adjacency-list
	def to_s
		str = ""
		@vertexList.sort!
		
		@vertexList.each do |v|
			str << "[#{v}] -> "
			if @mainArray[v] == nil
				str << "/ \n"
			else
				str << @mainArray[v].to_s
			end
		end
		
		str
	end
	
	private
	
	#Given a vertex, checks to see if it exists within the vertex list;
	#if not found, adds to list
	#INEFFICIENT - MODIFY LATER
	def checkAndAddConsistency(v)
		if !@vertexList.include?(v)
			@vertexList << v
		end
	end
	
	#Given a vertex, checks to see if it exists within the vertex list;
	#simply returns true or false value
	def checkConsistency(v)
		@vertexList.include?(v)
	end
end

=begin
n = AdjacencyNode.new(10, nil)
n.nextNode = AdjacencyNode.new(20,nil)
n.nextNode.nextNode = AdjacencyNode.new(30,nil)
print n
n.each{|value| value = 99}
n2 = n.getLast
print n2
=end


=begin
list = AdjacencyList.new
list.add_edge(1,2)
list.add_edge(1,5)
list.add_edge(2,1)
list.add_edge(2,5)
list.add_edge(2,3)
list.add_edge(2,4)
list.add_edges(3, [2,4])
list.add_edges(4, [2,5,3])
list.add_edges(5, [4,1,2])
=end