#=

NonnegativeCostGraph.jl
This julia file incluedes
* Constructor that returns a graph data type

TODO: Add ploting features

=#

using Plots
using GraphRecipes
using SparseArrays

struct graph
    nodes::Vector
    arcs::Vector
    costs::Dict
    n::Int
	AdjMatrix::Function
	LookUpTable::Function
end

function newGraph(V::Vector{Int},A::Vector{Tuple{Int64, Int64}},c::Dict)
    if sum(values(c) .< 0) > 0   #verify there are no negative costs
        error("Use only nonnegative costs!")
    elseif c.count != size(A,1)
        error("Assign cost to each edge!")
    else
        n = size(V,1)
        return graph(V,A,c,n,getAdjMatrix,getLookUpTable)
    end
end


function getAdjMatrix(arcs, costs)
	"""
	g.arcs, g.costs
	"""
	AdjMatrix = spzeros(Int, size(V,1),size(V,1))
	# fill matrix with Arcs (i,j)
	for arc in arcs
		AdjMatrix[arc[1],arc[2]] = costs[arc]
		AdjMatrix[arc[2],arc[1]] = costs[arc]
	end
	return AdjMatrix
end


function getLookUpTable(arcs, n)
	"""
	g.arcs, g.n
	"""
	lookUpTable = spzeros(Int,((n)*(n)),1)
	for (i,e) in enumerate(arcs)
        pos = (e[1] - 1)*n + 1
        while lookUpTable[pos] != 0
            pos += 1
        end
        lookUpTable[pos] = e[2]
    end
    return lookUpTable
end
