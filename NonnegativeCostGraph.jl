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
    AdjMatrix::Matrix
    costs::Dict
    n::Int
end

function newGraph(V::Vector{Int},A::Vector{Tuple{Int64, Int64}},c::Vector)
    if sum(c .< 0) > 0   #verify there are no negative costs
        error("Use only nonnegative costs!")
    elseif size(c,1) != size(A,1)
        error("Assign cost to each edge!")
    else
        AdjMatrix = spzeros(Int, size(V,1),size(V,1))
        # fill matrix with Arcs (i,j)
        for (i,e) in enumerate(A)
            AdjMatrix[e[1],e[2]] = c[i]
            AdjMatrix[e[2],e[1]] = c[i]
        end
        n = size(V,1)
        return graph(V,A,AdjMatrix,c,n)
    end
end
