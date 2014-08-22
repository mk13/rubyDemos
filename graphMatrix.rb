class GraphMatrix
	attr_reader :m
	
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
			@m[@h[u]].fetch(@h[v],Float::INFINITY)
		else
			nil
		end
	end
	
	def add_edge(u,v,w)
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
	
	def print_matrix
		@vnum.each do |i|
			@vnum.each do |j|
				t = if @m[i][j] == nil then 'inf' else @m[i][j] end
				if t.class == Fixnum || Integer || Float then print sprintf("%3d   ", t) else print("#{t}   ") end 
			end
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
			
			@vnum.each do |i|
				@vnum.each do |j|
					@vnum.each do |k|
						t = @m[i][k] + o.m[i][k]
						copy.m[i][j] = t if copy.m[i][j] > t
						#Add path change here
					end
				end
			end
		end
		copy
	end
	
	#Does same thing as above, but changes self's matrix
	#	DOES NOT CHECK FOR VERTEX CONSISTENCY; only size
	def extend=(o)
		if o.class != GraphMatrix || o.vertex_count != @vnum
			return nil
		else
			self = extend(o)
			self
		end
	end
	
	protected
	attr_accessor :m
end