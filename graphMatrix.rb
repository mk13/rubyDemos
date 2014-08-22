class GraphMatrix
	def initialize(vlist=nil, elist=nil, extra={}, &weightFunction=nil)
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
		@m[u].fetch(v,Float::INFINITY)
	end
	
	private
end