# Input format:
# A header, which is always exactly two numbers:
#   The quantity of child nodes.
#   The quantity of metadata entries.
# Zero or more child nodes (as specified in the header).
# One or more metadata entries (as specified in the header).

# the most straightforward way to handle this data will be to read it in and split it
# into an array of numbers. We can then parse the nodes recursively.

def read_file(filename)
  return File.read(filename).strip.split(' ')
end

def parse_node(input)
  node = Node.new
  quantity_children = input.shift.to_i
  quantity_metadata = input.shift.to_i
  for i in 0..(quantity_children - 1)
    node.add_child(parse_node(input))
  end
  for i in 0..(quantity_metadata - 1)
    node.add_metadata(input.shift.to_i)
  end
  return node
end

class Node
  def initialize
    @children = Array.new
    @metadata = Array.new
  end
  def children
    return @children
  end
  def metadata
    return @metadata
  end
  def add_child(child)
    @children.push(child)
  end
  def add_metadata(metadata)
    @metadata.push(metadata)
  end
end

def sum_metadata(node)
  total = 0
  total += node.metadata.reduce(:+)
  for i in 0..(node.children.length - 1)
    total += sum_metadata node.children[i]
  end
  return total
end
