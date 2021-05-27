def dfs(visited, graph, node):
    """Depth-first search (DFS), is an algorithm for tree traversal
    on graph or tree data structures. It can be implemented easily
    using recursion and data structures like dictionaries and sets."""
    if node not in visited:
        print(node)
        visited.add(node)
        for neighbour in graph[node]:
            dfs(visited, graph, neighbour)


def bfs(visited, graph, node):
    """Breath-first search (BFS) is an algorithm used for tree traversal
     on graphs or tree data structures. BFS can be easily implemented using
     recursion and data structures like dictionaries and lists."""
    queue = []
    visited.append(node)
    queue.append(node)
    while queue:  # while the queue contains elements
        s = queue.pop(0)  # taking out nodes from the queue
        print(s, end=" ")

        for neighbour in graph[s]:
            # appends the neighbors of that node to the queue if they are unvisited
            if neighbour not in visited:
                visited.append(neighbour)
                queue.append(neighbour)
    # continues until the queue is empty.
