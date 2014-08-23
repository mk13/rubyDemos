#Add a paths matrix?
#Use inheritance? Move extend functions to the child
require_relative 'graphsDS3'

class GraphMatrix
	attr_accessor :m
	
	def initialize(vlist=nil, elist=nil, extra={}, &weightFunction)
		@vnum = 0
		@h = Hash.new
		@m = []
		@weightFunction = weightFunction
		@extra = extra
	
		vlist.each do |v|
			add_vertex(v)
		end if vlist != nil
		
		elist.each do |e|
			add_vertex(e.s)
			add_vertex(e.d)
			@m[@h[e.s]][@h[e.d]] = e.w
		end if elist != nil
			
	end	
	
	def add_vertex(v)
		if !@h.has_key?v
			@h[v] = @vnum
			@m[@vnum] = []
			@m[@vnum][@vnum] = 0
			@vnum += 1
		end
	end
	
	def weight(u,v)
		if @h[u] < @vnum && @h[v] < @vnum
			if @m[@h[u]][@h[v]] == nil then Float::INFINITY else @m[@h[u]][@h[v]] end
		else
			nil
		end
	end
	
	def add_edge_manual(u,v,w)
		if w.class == Integer || Float
			add_vertex(u)
			add_vertex(v)
			@m[@h[u]][@h[v]] = w
		end
	end
	
	def weight_function
		if @weightFunction != nil
			@weightFunction
		else
			lambda do |u,v|
				weight(u,v)
			end
		end
	end
	
	def print_hash_key
		@h.each_pair{ |k,v| puts "#{k.to_s}  =>  #{v+1}"}
	end
	
	def print_matrix
		@vnum.times do |i|
			@vnum.times do |j|
				t = if @m[i][j] == nil then '  inf' else @m[i][j] end
				if t.class == String then print ("#{t}   ") else print sprintf("%5.2f   ", t) end
			end
			puts
		end
	end
	
	def vertex_count
		@vnum
	end
	
	#Extends self matrix with another graphMatrix;
	#Does not change self's attributes; instead
	#makes a new copy
	#	DOES NOT CHECK FOR VERTEX CONSISTENCY; only size
	def extend(o)
		if o.class != GraphMatrix || o.vertex_count != @vnum
			return nil
		else
			copy = self.clone
			copy.m = pextend(o)
			copy
		end
	end
	
	#Does same thing as above, but changes self's matrix
	#	DOES NOT CHECK FOR VERTEX CONSISTENCY; only size
	def extend=(o)
		if o.class != GraphMatrix || o.vertex_count != @vnum
			return nil
		else
			@m = pextend(o)
			self
		end
	end
	

	private
	def pextend(o)
		c = []
		@vnum.times do |z|
			c[z] = []
		end
		@vnum.times do |i|
			@vnum.times do |j|
				c[i][j] = Float::INFINITY
				@vnum.times do |k|
					a = if @m[i][k] == nil then Float::INFINITY else @m[i][k] end
					b = if o.m[k][j] == nil then Float::INFINITY else o.m[k][j] end
					c[i][j] = if (a+b) < c[i][j] then (a+b) else c[i][j] end
				end
			end
		end
		c
	end
end