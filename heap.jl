#=




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

function insert(h::heap)


end

function decressKey()


end

function extractMin(h::heap)
    # remove min from heap replace with last node
    minCost = h.cost[1]
    minVert = h.vertice[1]
    min = node(minCost, minVert)
    if empty(h) == false
        h.cost[1] = h.cost[h.last_node]
        h.vertice[1] = h.vertice[h.last_node]
        h.cost[h.last_node] = minCost
        h.vertice[h.last_node] = minVert
        h.last_node -= 1
        println("Pre ReHeap =>  ", h)
        # call ReHeap
        ReHeap(h,1)
        # return the min
    end
    return h, min
end

function ReHeap(h::heap, root)
    # root is an index of its location in the arrays
    tempCost = h.cost[root]
    tempVertice = h.vertice[root]
    # check if there are two childeren nodes
    if (2*root) + 1 <= h.last_node
        (h.cost[2*root] <= h.cost[(2*root) + 1]) ? minCostArg = 2*root : minCostArg = (2*root) + 1
        if h.cost[root] > h.cost[minCostArg]
            h.cost[root] = h.cost[minCostArg]
            h.vertice[root] = h.vertice[minCostArg]
            h.cost[minCostArg] = tempCost
            h.vertice[minCostArg] = tempVertice
            println(root, " if =>  ", h)
            ReHeap(h, minCostArg)
        end
    # if there is one it is a left child
    elseif 2*root <= h.last_node
        minCostArg = 2*root
        if h.cost[root] > h.cost[minCostArg]
            h.cost[root] = h.cost[minCostArg]
            h.vertice[root] = h.vertice[minCostArg]
            h.cost[minCostArg] = tempCost
            h.vertice[minCostArg] = tempVertice
            println(root, " elseif =>  ", h)
            ReHeap(h, minCostArg)
        end
    # no childeren then on a leaf end the recursion
    else
        println(root, " else =>  ", h)
        return h
    end
end

function empty(h::heap)
    isempty = false
    if h.last_node == 1
        isempty = true
    end
    return isempty
end
