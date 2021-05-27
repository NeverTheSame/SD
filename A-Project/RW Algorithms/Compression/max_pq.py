heap_size = 0
tree_array_size = 20
INF = 100000


# function to get right child of a node of a tree_array_size
def get_right_child(A, index):
    if (((2 * index) + 1) < len(A)) and (index >= 1):
        return (2 * index) + 1
    return -1


def get_left_child(A, index):
    if (((2 * index) + 1) < len(A)) and (index >= 1):
        return 2 * index
    return -1


# function to get the parent of a node of a tree_array_size
def get_parent(A, index):
    if index > 1 and index < len(A):
        return index // 2
    return -1


def increase_key(A, index, key):
    A[index] = key
    while (index > 1) and (A[get_parent(A, index)] < A[index]):
        A[index], A[get_parent(A, index)] = A[get_parent(A, index)], A[index]


def insert(A, key):
    global heap_size
    heap_size += 1
    increase_key(A, heap_size, key)


def maximum(A):
    return A[1]


def max_heapify(A, index):
    left_child_index = get_left_child(A, index)
    right_child_index = get_right_child(A, index)

    # finding largest among index, left child and right child
    largest = index
    if left_child_index <= heap_size and left_child_index > 0:
        if A[left_child_index] > A[largest]:
            largest = left_child_index

    if right_child_index <= heap_size and right_child_index > 0:
        if A[right_child_index] > A[largest]:
            largest = right_child_index

    if largest != index:
        A[index], A[largest] = A[largest], A[index]
        max_heapify(A, largest)


def extract_max(A):
    global heap_size
    max_value = maximum(A)
    A[1] = A[heap_size]
    heap_size -= 1
    max_heapify(A, 1)
    return max_value
