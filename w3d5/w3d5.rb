class GraphNode
    attr_accessor :val, :neighbors

    def initialize(value)
        self.val = value
        self.neighbors = []
    end

    def add_neighbor(node)
        self.neighbors << node
    end

end

a = GraphNode.new('a')
b = GraphNode.new('b')
c = GraphNode.new('c')
d = GraphNode.new('d')
e = GraphNode.new('e')
f = GraphNode.new('f')
a.neighbors = [b, c, e]
c.neighbors = [b, d]
e.neighbors = [a]
f.neighbors = [e]

def get_matrix

end


def bfs(starting_node, target_value)
    queue = [starting_node]
    visited = []

    until queue.empty?
        node = queue.shift
    unless visited.include?(node)
      return node.val if node.val == target_value
      visited << node
      queue += node.neighbors
    end
  end
 return nil
end


p bfs(a, "f")
p bfs(a, "b")