#UNFINISHED

require_relative 'graphsDS3.rb'
require 'matrix'



def floydWarshalAlg_IntOnly(g)
	n = g.vertexSet.size
	costs = []
	paths = []
	
	(n+1).times do |i|
		costs[i] = []
		paths[i] = []		
		(n+1).times do |j| 
			costs[i][j] = []
			paths[i][j] = []
		end
	end
	
	(n+1).times do |i|
		(n+1).times do |j|
			costs[0][i][j] = Float::INFINITY
			paths[0][i][j] = nil
			
			costs[0][i][j] = 0 if i == j
		end
	end
	
	g.edgeSet.each do |e|
		costs[0][e.s][e.d] = e.w
		paths[0][e.s][e.d] = e.s
	end
	
	(1..n).each do |k|
		(1..n).each do |i|
			(1..n).each do |j|
				old = costs[k-1][i][j]
				new = costs[k-1][i][k] + costs[k-1][k][j]
				if old <= new
					costs[k][i][j] = old
					paths[k][i][j] = paths[k-1][i][j]
				else
					costs[k][i][j] = new
					paths[k][i][j] = paths[k-1][k][j]
				end
			end
		end
	end
	
	puts "PRINTING ALL COSTS:"
	puts "**************************"
	puts
	
	(0..n).each do |k|
		puts "MATRIX: #{k} of #{n}"
		puts "====================="
		puts
		
		(1..n).each do |i|
			(1..n).each do |j|
				t = if costs[k][i][j] == Float::INFINITY then 'inf' else costs[k][i][j] end
				if t.class == Fixnum then print sprintf("%3d   ", t) else print("#{t}   ") end 
			end
			puts
		end
		puts
	end
	puts
	
	puts "PRINTING ALL PATHS:"
	puts "**************************"
	puts
	
	(0..n).each do |k|
		puts "MATRIX: #{k} of #{n}"
		puts "====================="
		puts
		
		(1..n).each do |i|
			(1..n).each do |j|
				t = if paths[k][i][j] == nil then "nil" else paths[k][i][j] end
				if t.class == Fixnum then print sprintf("%3d   ", t) else print("#{t}   ") end 
			end
			puts
		end
		puts
	end
	
end



g = Graph.new([1,2,3,4,5,6])
g.add_edge(Edge.new(4,1,-4))
g.add_edge(Edge.new(2,1,1))
g.add_edge(Edge.new(2,4,2))
g.add_edge(Edge.new(1,5,-1))
g.add_edge(Edge.new(5,2,7))
g.add_edge(Edge.new(3,2,2))
g.add_edge(Edge.new(6,2,5))
g.add_edge(Edge.new(6,3,10))
g.add_edge(Edge.new(3,6,-8))
g.add_edge(Edge.new(4,5,3))

floydWarshalAlg_IntOnly(g)