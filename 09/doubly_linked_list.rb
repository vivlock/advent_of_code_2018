# this will be a doubly linked list linked in a circle
# maintain the current node, updating based on our rotations
class DoublyLinkedList
  def initialize(value)
    @current = Node.new(value)
  end
  def left
    return @current.left
  end
  def right
    return @current.right
  end
  def value
    return @current.value
  end
  def add_right_node(value)
    if @current.has_right?
      temp = @current.right
      @current.set_right(Node.new(value))
      # maintain links
      @current.right.set_left(@current)
      @current.right.set_right(temp)
      @current.right.right.set_left(@current.right)
    else
      @current.set_right(Node.new(value))
      @current.right.set_left(@current)
    end
  end
  def add_left_node(value)
    if @current.has_left?
      temp = @current.left
      @current.set_left(Node.new(value))
      # maintain links
      @current.left.set_right(@current)
      @current.left.set_left(temp)
      @current.left.left.set_right(@current.left)
    else
      @current.set_left(Node.new(value))
      @current.left.set_right(@current)
    end
  end
  def get_leftmost
    left_node = @current
    while left_node.has_left?
      left_node = left_node.left
    end
    return left_node
  end
  def get_rightmost
    right_node = @current
    while right_node.has_right?
      right_node = right_node.right
    end
    return right_node
  end

  def rotate_ccw(spaces)
    while spaces > 0
      if @current.has_left?
        @current = @current.left
      else
        # wrap
        @current = get_rightmost
      end
      spaces -= 1
    end
  end
  def rotate_cw(spaces)
    while spaces > 0
      if @current.has_right?
        @current = @current.right
      else
        # wrap
        @current = get_leftmost
      end
      spaces -= 1
    end
  end

  # current's right node becomes new current
  def delete_current
    left_node = @current.left
    right_node = @current.right
    removed_value = @current.value
    if !left_node.nil?
      left_node.set_right right_node
    end
    if !right_node.nil?
      right_node.set_left left_node
      @current = right_node
    else
      # wrap
      @current = get_leftmost
    end
    return removed_value
  end

  def string
    node = get_leftmost
    string = ""
    current = @current.value
    while !node.nil?
      if node.value == current
        string += " (#{node.value.to_s})"
      else
        string += " #{node.value.to_s}"
      end
      node = node.right
    end
    return string
  end
end

class Node
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
  def set_value(value)
    @value = value
  end
  def value
    return @value
  end
  def set_left(left)
    @left = left
  end
  def left
    return @left
  end
  def set_right(right)
    @right = right
  end
  def right
    return @right
  end
  def has_left?
    return !@left.nil?
  end
  def has_right?
    return !@right.nil?
  end
end
