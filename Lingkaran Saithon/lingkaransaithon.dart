class Node<T> {
  T value;
  Node<T>? next;

  Node(this.value);
}

typedef AdjList = Map<String, Node<MapEntry<String, int>>>;

class Graph {
  final AdjList adjacencyList = {};

  void addEdge(String vertex1, String vertex2, int weight) {
    adjacencyList[vertex1] =
        _addToList(adjacencyList[vertex1], MapEntry(vertex2, weight));
    adjacencyList[vertex2] = _addToList(adjacencyList[vertex2],
        MapEntry(vertex1, weight)); // For undirected graph
  }

  Node<MapEntry<String, int>> _addToList(
      Node<MapEntry<String, int>>? node, MapEntry<String, int> entry) {
    return Node(entry)..next = node;
  }

  int getDistance(String from, String to) {
    Node<MapEntry<String, int>>? node = adjacencyList[from];
    while (node != null) {
      if (node.value.key == to) {
        return node.value.value;
      }
      node = node.next;
    }
    return -1;
  }

  void findShortestPath(String start) {
    List<String> visited = [start];
    String currentVertex = start;
    int totalWeight = 0;

    print('All possible routes:');

    while (visited.length < adjacencyList.length) {
      String? nearestVertex;
      int nearestDistance = double.maxFinite.toInt();

      Node<MapEntry<String, int>>? neighbors = adjacencyList[currentVertex];
      while (neighbors != null) {
        String neighbor = neighbors.value.key;
        int distance = neighbors.value.value;
        if (!visited.contains(neighbor) && distance < nearestDistance) {
          nearestVertex = neighbor;
          nearestDistance = distance;
        }
        neighbors = neighbors.next;
      }

      if (nearestVertex != null) {
        visited.add(nearestVertex);
        totalWeight += nearestDistance;
        currentVertex = nearestVertex;
      } else {
        print('No valid route found!');
        return;
      }
    }

    // Tambahkan bobot untuk kembali ke titik awal
    int returnDistance = getDistance(currentVertex, start);
    if (returnDistance != -1) {
      totalWeight += returnDistance;
    }

    print('${visited.join(' -> ')} -> $start | Total weight = $totalWeight');

    print('\nTHE MOST EFFECTIVE ROUTE');
    print('  Most effective route: ${visited.join(' -> ')} -> $start');
    print('  Total: $totalWeight');
  }
}

void main() {
  Graph graph = Graph();

  graph.addEdge('A', 'B', 8);
  graph.addEdge('A', 'C', 3);
  graph.addEdge('A', 'D', 4);
  graph.addEdge('A', 'E', 10);
  graph.addEdge('B', 'C', 5);
  graph.addEdge('B', 'D', 2);
  graph.addEdge('B', 'E', 7);
  graph.addEdge('C', 'D', 1);
  graph.addEdge('C', 'E', 6);
  graph.addEdge('D', 'E', 3);

  graph.findShortestPath('A');
}
