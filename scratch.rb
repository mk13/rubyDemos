module Hello
	d = 5
end

class Testing
	include Hello
	
	def initialize
		@a = 1
		@b = 2
		@c = 3
	end
	
	
	
	def report
		puts @a
		puts @b
		puts @c
		puts @d
	end
end

t1 = Testing.new

t1.report


a = [2]

p a.fetch(2, "NOPE")

20.times{|v| puts v}