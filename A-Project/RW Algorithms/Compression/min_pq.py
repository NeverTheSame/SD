heap_size = 0
tree_array_size = 20
INF = 100000


# function to get right child of a node of a tree
def get_right_child(A, index):
  if((((2*index)+1) < len(A)) and (index >= 1)):
    return (2*index)+1
  return -1


# function to get left child of a node of a tree
def get_left_child(A, index):
    if(((2*index) < len(A)) and (index >= 1)):
        return 2*index
    return -1

# function to get the parent of a node of a tree
def get_parent(A, index):
  if ((index > 1) and (index < len(A))):
    return index//2
  return -1


def min_heapify(A, index):
  left_child_index = get_left_child(A, index)
  right_child_index = get_right_child(A, index)

  # finding smallest among index, left child and right child
  smallest = index

  if ((left_child_index <= heap_size) and (left_child_index>0)):
    if (A[left_child_index] < A[smallest]):
      smallest = left_child_index

  if ((right_child_index <= heap_size and (right_child_index>0))):
    if (A[right_child_index] < A[smallest]):
      smallest = right_child_index

  # smallest is not the node, node is not a heap
  if (smallest != index):
    A[index], A[smallest] = A[smallest], A[index]
    min_heapify(A, smallest)


def build_min_heap(A):
  for i in range(heap_size//2, 0, -1):
    min_heapify(A, i)


def minimum(A):
  return A[1]


def extract_min(A):
  global heap_size
  minm = A[1]
  A[1] = A[heap_size]
  heap_size = heap_size-1
  min_heapify(A, 1)
  return minm


def decrease_key(A, index, key):
  A[index] = key
  while((index>1) and (A[get_parent(A, index)] > A[index])):
    A[index], A[get_parent(A, index)] = A[get_parent(A, index)], A[index]
    index = get_parent(A, index)


def increase_key(A, index, key):
  A[index] = key
  min_heapify(A, index)


def insert(A , key):
  global heap_size
  heap_size = heap_size+1
  A[heap_size] = INF
  decrease_key(A, heap_size, key)
