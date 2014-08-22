class Foo
	def initialize(a)
		@a = a
	end
	
	def report
		puts @a
	end
	
	def set(o)
		copy = self.clone
		copy.a = @a + o.a
		return copy
	end
	
	protected
	
	attr_accessor :a
end


c1 = Foo.new(1)
c2 = Foo.new(20)
c3 = c1.set(c2)

c1.report
c2.report
c3.report

puts c1.a