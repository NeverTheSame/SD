import max_pq
from max_pq import insert, maximum, extract_max

if __name__ == '__main__':
    A = [None] * max_pq.tree_array_size
    insert(A, 20)
    insert(A, 15)
    insert(A, 8)
    insert(A, 10)
    insert(A, 5)
    insert(A, 7)
    insert(A, 6)
    insert(A, 2)
    insert(A, 9)
    insert(A, 1)
    print(A[1:max_pq.heap_size + 1])

    max_pq.increase_key(A, 5, 22)
    print(A[1:max_pq.heap_size + 1])

    print(maximum(A))
    print(extract_max(A))
    print(A[1:max_pq.heap_size + 1])

    print(extract_max(A), A[1:max_pq.heap_size + 1])
    print(extract_max(A), A[1:max_pq.heap_size + 1])
    print(extract_max(A), A[1:max_pq.heap_size + 1])
    print(extract_max(A), A[1:max_pq.heap_size + 1])
    print(extract_max(A), A[1:max_pq.heap_size + 1])
    print(extract_max(A), A[1:max_pq.heap_size + 1])
    print(extract_max(A), A[1:max_pq.heap_size + 1])
    print(extract_max(A), A[1:max_pq.heap_size + 1])
    print(extract_max(A), A[1:max_pq.heap_size + 1])


