def compute_prefix_function(p)
	m = p.length
	a = []
	a[0] = -1
	k = -1
	(1...m).each do |q|
		while k > -1 && p[k+1] != p[q]
			k = a[k]
		end
		k = k + 1 if p[k+1] == p[q]
		a[q] = k
	end
	a
end

def kmp_matcher(t,p)
	n = t.length
	m = p.length
	a = compute_prefix_function(p)
	q = -1
	answer = []
	n.times do |i|
		while q > -1 && p[q+1] != t[i]
			q = a[q]
		end
		q = q + 1 if p[q+1] == t[i]
		if q == m-1
			answer << i-m+1
			puts "Pattern occurs beginning with shift/index #{i-m+1}"
			q = a[q]
		end
	end
	answer
end

t ="aaabababacaaababaca"
p = "ababaca"
p compute_prefix_function("ababaca")
answer = kmp_matcher(t,p)

answer.each{|v| p t.slice(v, p.length)}
