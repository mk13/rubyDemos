#Standard linked-list node
class AdjacencyNode
	attr_accessor :value, :nextNode
	def initialize(value, nextNode)
		@value = value
		@next = nextNode
	end
	
	def to_s
		str = "#{@value} -> "
		if nextNode == nil
			str << "/"
		else
			str << @nextNode.to_s
		end
		str
	end
end

#Numerical vertices only
#Standard Adjacency-List representation of 
#	G=(V,E)
class AdjacencyList
	attr_reader :mainArray
	def initialize
		@mainArray = []
	end
end
		
node1 = AdjacencyNode.new(10, nil)
node2 = AdjacencyNode.new(20, nil)

node1.nextNode=node2

print node1