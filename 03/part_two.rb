filename = "input.txt"
#filename = "small_input.txt"

rows = 1000
cols = 1000
fabric = Array.new(rows){Array.new(cols)}
claims = Array.new

overlap_count = 0
intact = nil

def parse_line(line)
  coords = Hash.new

  # line: "#id @ x,y: zxq"
  pieces = line.split(" ").collect(&:strip)
  # pieces = ["#id", "@", "x,y:", "zxq"]

  x_y = pieces[2].split(",")
  z_q = pieces[3].split("x")

  coords[:id] = pieces[0]
  coords[:x] = x_y[0].to_i
  coords[:y] = x_y[1].split(":")[0].to_i
  coords[:z] = z_q[0].to_i
  coords[:q] = z_q[1].to_i

  return coords
end

# read in the file
fh = open filename
while (line = fh.gets)
  coords = parse_line(line)
  claims.push(coords)

  for x in coords[:x]..(coords[:x] + coords[:z] - 1)
    if fabric[x].nil?
      fabric[x] = Array.new(cols)
    end

    for y in coords[:y]..(coords[:y] + coords[:q] - 1)
      if fabric[x][y].nil?
        fabric[x][y] = coords[:id]
      elsif fabric[x][y] != "X"
        fabric[x][y] = "X"
        overlap_count += 1
      end
    end
  end

end
fh.close

# we've marked all the rectangles in the array
# X signifies an overlap
# there's probably a nicer way to do this, but let's just go over the claims again
# and see if any of the spaces == X
claims.each do |coords|
  overlapped = false
  for x in coords[:x]..(coords[:x] + coords[:z] - 1)
    for y in coords[:y]..(coords[:y] + coords[:q] - 1)
      if fabric[x][y] == "X"
        overlapped = true
        break
      end
    end #for y
    break if overlapped
  end #for x
  if not overlapped
    intact = coords[:id]
    break
  end
end


# keeping overlap count as a sanity check
# small_input = 4, input = 111326
puts "Overlap count is #{overlap_count}"
puts "Intact rectangle is #{intact}"
