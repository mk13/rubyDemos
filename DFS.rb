class DFSnode
	attr_accessor :value, :color, :source, 
				  :discover, :finish
	def initialize(value, color = :WHITE, 
				   source = nil, discover = nil, finish = nil)
		@value = value
		@color = color
		@source = source
		@discover = discover
		@finish = finish
	end
end

class DFStree
	#root
	#children = {hash}
end

class DFSforest
	#multiple starting, disjoint
end

