def read_file(filename)
  points = Array.new
  fh = open FILENAME
  while (line = fh.gets)
    points.push(parse_input(line))
  end
  fh.close
  return points
end

# position=< 9,  1> velocity=< 0,  2>
# spacing varies, don't split on whitespace
def parse_input(line)
  pieces = line.split(/<|>|,/).map { |x| x.strip.to_i }
  return Point.new(pieces[1], pieces[2], pieces[4], pieces[5])
end

def output_2d_arr(arr)
  arr.each do |row|
    output = ""
    row.each do |item|
      output += " #{item}"
    end
    puts output
  end
end

class Point
  def initialize(posx, posy, velx, vely)
    @pos = { x: posx, y: posy }
    @vel = { x: velx, y: vely }
  end
  def to_s
    return "(#{@pos[:x]}, #{@pos[:y]}) V: #{@vel[:x]}, #{@vel[:y]}"
  end
  def tick
    @pos[:x] = @pos[:x] + @vel[:x]
    @pos[:y] = @pos[:y] + @vel[:y]
  end
  def x
    return @pos[:x]
  end
  def y
    return @pos[:y]
  end
end

class Grid
  def initialize(points)
    @points = points
    @elapsed = 0
    resize_grid
  end
  def resize_grid
    @min_x, @max_x, @min_y, @max_y = 0,0,0,0
    @points.each do |point|
      @min_x = point.x if point.x < @min_x
      @max_x = point.x if point.x > @max_x
      @min_y = point.y if point.y < @min_y
      @max_y = point.y if point.y > @max_y
    end
  end
  def tick
    @points.each do |point|
      point.tick
    end
    @elapsed += 1
  end
  def output
    rows = @max_y - @min_y
    cols = @max_x - @min_x
    grid = Array.new(cols){Array.new(rows, ".")}
    @points.each do |point|
      # indices are offset by min_x, min_y
      if grid[point.y + @min_y].nil? || grid[point.y + @min_y][point.x + @min_x].nil?
        resize_grid
      end
      grid[point.y + @min_y][point.x + @min_x] = "#"
    end
    return grid
  end
  def elapsed
    return @elapsed
  end
end
