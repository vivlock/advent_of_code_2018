# input line format:
# X, Y
def parse_input(line)
  x,y = line.split(',')
  return Coord.new(x.strip.to_i, y.strip.to_i)
end

class Coord
  def initialize(x, y)
    @x = x
    @y = y
    @area = 0
    @infinite = false
  end
  def isInfinite
    @infinite = true
  end
  def isInfinite?
    return @infinite
  end
  def incrementArea
    @area += 1
  end
  def area
    return @area
  end
  def x
    return @x
  end
  def y
    return @y
  end
end

class GridSquare
  def initialize(x, y, isEdge)
    @x = x
    @y = y
    @isEdge = isEdge
    @owner = nil
  end

  def find_and_set_owner(points)
    closest = nil
    closest_dist = -1
    contested = false
    points.each do |point|
      if(point.x == @x && point.y == @y)
        closest = point
        contested = false
        break
      end
      dist = mdistance_to_point(point)
      if(closest_dist == -1 || dist < closest_dist)
        closest_dist = dist
        closest = point
        contested = false
      elsif(closest_dist == dist)
        contested = true
      end
    end
    if(!contested)
      @owner = closest
      @owner.isInfinite if @isEdge
      @owner.incrementArea
    end
  end

  def count_dist_to_all_points(points)
    total_dist = 0
    points.each do |point|
      total_dist += mdistance_to_point(point)
    end
    return total_dist
  end

  # for A=(x,y) and B=(z,q), the Manhattan distance is |x−z|+|y−q|
  def mdistance_to_point(point)
    x = @x - point.x
    y = @y - point.y
    return x.abs + y.abs
  end
end
