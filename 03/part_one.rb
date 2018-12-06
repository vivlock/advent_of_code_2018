filename = "input.txt"

# algorithm
# init 2D array 1000 x 1000 to nils
# init counter to 0
# for each space of the rectangle x,y to x+z,y+q:
# * if the space is nil, set to 1
# * if the space is 1, increment space and increment counter
# * if the space is 2, next
# answer is counter

rows = 1000
cols = 1000
fabric = Array.new(rows){Array.new(cols)}

overlap_count = 0

def parse_line(line)
  coords = Hash.new

  # line: "#id @ x,y: zxq"
  pieces = line.split(" ").collect(&:strip)
  # pieces = ["#id", "@", "x,y:", "zxq"]

  x_y = pieces[2].split(",")
  z_q = pieces[3].split("x")

  coords[:x] = x_y[0].to_i
  coords[:y] = x_y[1].split(":")[0].to_i
  coords[:z] = z_q[0].to_i
  coords[:q] = z_q[1].to_i

  return coords
end

def put_coords(coords)
  #lol let's debug
  puts "coords: x = #{coords[:x]}, y = #{coords[:y]}, z = #{coords[:z]}, q = #{coords[:q]}"
end

#read in the file
fh = open filename
while (line = fh.gets)
  coords = parse_line(line)

  puts line
  put_coords coords

  for x in coords[:x]..(coords[:x] + coords[:z])
    if fabric[x].nil?
      fabric[x] = Array.new(cols)
    end

    for y in coords[:y]..(coords[:y] + coords[:q])
      if fabric[x][y].nil?
        fabric[x][y] = 1
      elsif fabric[x][y] == 1
        fabric[x][y] = 2
        overlap_count += 1
      end
    end
  end

end
fh.close

puts "Overlap count is #{overlap_count}"
