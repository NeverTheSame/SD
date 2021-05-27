from tree_traversal import dfs, bfs


def main() -> None:
    # Using a Python dictionary to act as an adjacency list
    graph = {
        'A': ['B', 'C'],
        'B': ['D', 'E'],
        'C': ['F'],
        'D': [],
        'E': ['F'],
        'F': []
    }
    # visited_dfs = set()  # keeps track of visited nodes
    # dfs(visited_dfs, graph, 'A')

    visited_bfs = []  # List to keep track of visited nodes.
    bfs(visited_bfs, graph, 'A')


if __name__ == '__main__':
    try:
        main()
    except Exception as ex:
        raise ex
