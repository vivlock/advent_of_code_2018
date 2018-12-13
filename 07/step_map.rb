require 'set'

class Node
  def initialize(v)
    @letter = v
    @prereqs = Array.new
  end
end

class StepMap
  def initialize
    @letters = Hash.new
    @available = SortedSet.new
    (A..Z).each do |letter|
      @letters.push(Node.new(letter))
    end
  end

  def pop_next_available
    a = @available[0]
    @available.delete(a)
    return a
  end

  def add_node(prereq, after)
    if !@letters.has_key?(prereq)
      @letters[prereq] = Node.new(prereq)
      @available.push(prereq)
    end
    if !@letters.has_key?(after)
      @letter[after] = Node.new(after)
      if @available === after
        @available.delete(after)
      end
    end
    @letter[after].prereq(prereq)
  end
end
