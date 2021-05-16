#=
This is a Heap data structure made specificaly for Dijkstra's Algorithm
Hence only the functions needed were implemented
=#

mutable struct heap
    cost
    vertice
    last_node
end

struct node
    val
    key
end

function newHeap(source, n)
    i = Inf * ones(n,1)
    i[1] = 0
    k = collect(1:n)
    k[1] = source
    k[source] = 1
    return heap(i,k,n)
end

#=
function insert(h::heap)

end
=#

function decressKey(h::heap, pos, newCost, verbose = false)
    h.cost[pos] = newCost
    verbose && println("Pre upHeap =>  ", h)
    h = upHeap(h, pos, verbose)
    return h
end

function upHeap(h::heap, child, verbose = false)
    parent = div(child, 2)
    if h.cost[child] < h.cost[parent]
        h = swap(h, child, parent)
        verbose && println("swaped parent with child =>  ", h)
        h = upHeap(h, parent, verbose)
    end
    verbose && println(" Done =>  ", h)
    return h
end

function extractMin(h::heap, verbose = false)
    # remove min from heap replace with last node
    minCost = h.cost[1]
    minVert = h.vertice[1]
    min = node(minCost, minVert)
    if empty(h) == false
        h = swap(h, 1, h.last_node)
        h.last_node -= 1
        verbose && println("Pre downHeap =>  ", h)
        # call ReHeap
        downHeap(h, 1, verbose)
        # return the min
    end
    return h, min
end

function downHeap(h::heap, root, verbose = false)
    # check if there are two childeren nodes
    if (2*root) + 1 <= h.last_node
        (h.cost[2*root] <= h.cost[(2*root) + 1]) ? minCostArg = 2*root : minCostArg = (2*root) + 1
        if h.cost[root] > h.cost[minCostArg]
            h = swap(h, root, minCostArg)
            verbose && println(root, " if =>  ", h)
            downHeap(h, minCostArg, verbose)
        end
    # if there is one it is a left child
    elseif 2*root <= h.last_node
        minCostArg = 2*root
        if h.cost[root] > h.cost[minCostArg]
            h = swap(h, root, minCostArg)
            verbose && println(root, " elseif =>  ", h)
            downHeap(h, minCostArg, verbose)
        end
    # no childeren then on a leaf end the recursion
    else
        verbose && println(root, " Done =>  ", h)
        return h
    end
end

function swap(h::heap, n1, n2)
    # swap n1 with n2
    tempCost = h.cost[n1]
    tempVertice = h.vertice[n1]
    h.cost[n1] = h.cost[n2]
    h.vertice[n1] = h.vertice[n2]
    h.cost[n2] = tempCost
    h.vertice[n2] = tempVertice
    return h
end

function empty(h::heap)
    isempty = false
    if h.last_node == 1
        isempty = true
    end
    return isempty
end
