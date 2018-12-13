require_relative 'helper'

class DoTheThing
  #FILENAME = "sample_input.txt"
  FILENAME = "input.txt"
  #MAX_DIST = 32
  MAX_DIST = 10000

  def initialize
    @points = Array.new
    @grid = nil
    @rows = 0
    @cols = 0
    read_file
  end

  def read_file
    fh = open FILENAME
    while (line = fh.gets)
      point = parse_input(line)
      # size the grid dynamically based on the largest coords
      @rows = point.x if point.x > @rows
      @cols = point.y if point.y > @cols
      @points.push(point)
    end
    fh.close
    @rows += 1
    @cols += 1
  end

  def find_owners_for_all_spaces
    @grid = Array.new(@rows){Array.new(@cols)}
    @grid.each_with_index do |row, x|
      row.each_with_index do |space, y|
        isEdge = false;
        isEdge = true if (x == 0 || x == @rows - 1)
        isEdge = true if (y == 0 || y == @cols - 1)
        space = GridSquare.new(x, y, isEdge)
        space.find_and_set_owner(@points)
      end
    end
  end

  def find_region_near_coords
    region = Array.new
    @grid = Array.new(@rows){Array.new(@cols)}
    @grid.each_with_index do |row, x|
      row.each_with_index do |space, y|
        # saves us an extra loop to initialize on the same pass as the calculation
        space = GridSquare.new(x, y, false)
        total_dist = space.count_dist_to_all_points(@points)
        if total_dist < MAX_DIST
          region.push(space)
        end
      end
    end
    return region
  end

  def find_largest_finite_area
    find_owners_for_all_spaces
    biggest_area = 0
    biggest = nil
    @points.each do |point|
      if !point.isInfinite? && point.area > biggest_area
        biggest = point
        biggest_area = point.area
      end
    end
    return biggest
  end
end
