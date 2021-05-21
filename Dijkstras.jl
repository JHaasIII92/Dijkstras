include("NonnegativeCostGraph.jl")
include("heap.jl")


function dijkstras(g, source)
    h = newHeap(source,g.n)
    d = Inf * ones(g.n, 1)
    p = zeros(g.n, 1)

    while empty(h) != 1
        h, min = extractMin(h)  # min.val, min.key type node from "heap.jl"
        for (i,e) in enumerate(g.arcs)
            if e[1] == min.key & cost[e[2]] > min.val + g.costs[i]
                h.vertice

            
    end
end
