module Heaps
	def Heaps.minHeap
		HeapPQ.new{|a,b| a <= b}
	end
	
	def Heaps.maxHeap
		HeapPQ.new{|a,b| a >= b}
	end
end

class HeapPQ
	def initialize(&block)
		@arr = []
		@last = 0
		@f = block	#f = |a,b|{} true if 'a' should be higher priority than 'b'
	end
	
	def enqueue(v)
		@arr[@last] = v
		@last+=1
		heapifyUp(@last-1)
	end
	
	def dequeue
		if @last == 0
			nil
		else
			ans = @arr[0]
			@last-=1
			@arr[0] = @arr[@last]
			heapifyDown(0)
			ans
		end
	end
	
	#WARNING: REMOVES ELEMENTS FROM PQ
	def each
		yield dequeue while @last != 0
	end
	
	#def each_preserve
	#	copy = self.clone
	#	yield copy.dequeue while copy.length > 0
	#end
	
	#WARNING: REMOVES ALL ELEMENTS FROM PQ
	def	collect
		a = []
		self.each{|v| a << v}
		a
	end
	
	#This version does NOT remove all elements from PQ
	def collect_preserve
		a = []
		copy = self.clone
		copy.each {|v| a << v}
		a
	end
	
	def size
		@last
	end
	
	def length
		@last
	end
	
	def clear
		@last = 0
	end
	
	def empty?
		@last == 0
	end
	
	def contains?(e)
		@arr.each do |v|
				return true if v == e
		end
		false
	end
	
	private
	def left(i)
		2*i + 1
	end
	
	def right(i)
		2*i + 2
	end
	
	def parent(i)
		if i == 0 then nil else ((i-1)/2).to_i end
	end
	
	def hasLeft(i)
		left(i) < @last
	end
	
	def hasRight(i)
		right(i) < @last
	end
	
	def isLeaf(i)
		!hasLeft(i) && !hasRight(i)
	end
	
	def heapifyUp(i)
		if i != 0 && @f.call(@arr[i], @arr[parent(i)])
			swap(i,parent(i))
			heapifyUp(parent(i))
		end
	end
	
	def heapifyDown(i)
		if !isLeaf(i)
			dir = nil
			#Check left
			if hasLeft(i)
				dir = if @f.call(@arr[left(i)], @arr[i]) then left(i) else nil end
			end
			
			#If left is not valid or doesn't exist and there is a right
			if dir == nil && hasRight(i)
				dir = if @f.call(@arr[right(i)],@arr[i]) then right(i) else nil end
			elsif dir != nil && hasRight(i) && @f.call(@arr[right(i)], @arr[i])
				dir = if @f.call(@arr[left(i)], @arr[right(i)]) then left(i) else right(i) end
			end
			
			if dir != nil
				swap(i, dir)
				heapifyDown(dir)
			end
		end
	end
	
	def swap(a,b)
		temp = @arr[a]
		@arr[a] = @arr[b]
		@arr[b] = temp
	end
end


#Test cases
=begin
r = Random.new
f = lambda{r.rand(1..100)}
a = []
200.times{a << f.call}
pq = HeapPQ.new{|a,b| a <= b}

a.each do |v| 
	pq.enqueue(v)
end

answer = pq.collect
a = a.sort
check = lambda do 200.times do |i|
	if a[i] != answer[i]
		puts "ANSWER IS WRONG!"
		puts "INDEX: #{i}"
		puts "#{answer[i]} != #{a[i]}"
	end
end
end

check.call

puts

p a
p answer

p answer.length

=end


