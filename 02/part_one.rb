filename = "input.txt"
puts "Going to open '#{filename}'"

ids = Array.new
twos = Array.new
threes = Array.new

#read in the file
fh = open filename
while (id = fh.gets)
  char_counts = Hash.new
  in_twos = false
  in_threes = false

  id.each_char do |char|
    #use the hash to only count each char once
    if (char_counts.has_key?(char))
      next
    end
    char_counts[char] = id.count(char)
    if (!in_twos && char_counts[char] == 2)
      twos.push(id)
      in_twos = true
    elsif (!in_threes && char_counts[char] == 3)
      threes.push(id)
      in_threes = true
    end
  end
end

#compute checksum
puts twos.length * threes.length

fh.close
