#=



=#

using Plots
using GraphRecipes
using SparseArrays

struct graph
    nodes
    arcs
    AdjMatrix
    costs
end

function newGraph(V::Vector{Int},A::Vector{Tuple{Int64, Int64}},c::Vector{Number})
    if sum(c .< 0) > 0   #verify there are no negative costs
        error("Use only nonnegative costs!")
    else
        AdjMatrix = spzeros(Int, size(A,1), size(V,1))
        # fill matrix with Arcs (i,j)
        for i in 1:size(A,1)
            AdjMatrix[A[i][1], i] = 1
            AdjMatrix[A[i][2], i] = -1
        end
        return graph(V,A,AdjMatrix,c)
    end
end
