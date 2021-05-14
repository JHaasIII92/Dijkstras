#=




=#

struct heap
    i
    k
    last_node
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

function extractMin()
    # remove min from heap replace with last node
    # call Heapify
    # return the min
end


function empty()


end
