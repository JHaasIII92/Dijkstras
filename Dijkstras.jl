include("NonnegativeCostGraph.jl")
include("heap.jl")
using SparseArrays
using DataFrames

function dijkstras(g, source, verbose = false)
    h = newHeap(source,g.n)
    d = Inf * ones(g.n,1)
    p = Inf * zeros(g.n,1)
	p[1] = 0
	d[1] = 0
	lookUpTable = g.LookUpTable(g.arcs, g.n)
    while empty(h) == false
        h, min = extractMin(h)  # min.val, min.key type node from "heap.jl"
		verbose && println("=======================")
		verbose && println("min.val: $(min.val)\nmin.key: $(min.key)")
        for i in 1:h.last_node
			verbose && println("i => $(i)")
			# check for connection
			isconn = false
			pos = (min.key - 1)*g.n + 1
			while lookUpTable[pos] != 0
				if lookUpTable[pos] == h.vertice[i]
					isconn = true
					verbose && println("connection found: ($(min.key), $(lookUpTable[pos]))")
					break
				end
				pos += 1
			end
			# if there is a connection
			# check if cost is reducible
			if isconn
				arc_ij = (min.key, lookUpTable[pos])
				verbose && println(arc_ij)
				c_ij = g.costs[arc_ij]
				if isconn && h.cost[i] > min.val + c_ij
					verbose && println("Found Min: $(min.val) + $(c_ij)")
					d[lookUpTable[pos]] = min.val + c_ij
					p[lookUpTable[pos]] = min.key
					verbose && println("Heap pre decress: ",h)
					h = decressKey(h, i, d[lookUpTable[pos]])
					verbose && println("Heap post decress: ",h)
				end
			end
		end
    end
	df = DataFrame(path=p[:,1],cost =d[:,1])
	return df
end
