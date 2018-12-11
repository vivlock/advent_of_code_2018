#FILENAME = "sample_input.txt"
FILENAME = "input.txt"

polymer = Array.new
polymer_string = File.read(FILENAME).strip
for i in 0..(polymer_string.length - 1)
  polymer.push(polymer_string[i])
end

def strip_pairs(polymer)
  i = 0
  while(i < polymer.length - 2)
    this_char = polymer[i]
    next_char = polymer[i + 1]
    if toggle_case(this_char) == next_char
      #cut out these two characters
      polymer.delete_at(i + 1)
      polymer.delete_at(i)
    else
      i += 1
    end
  end
  return polymer
end

def is_upper?(char)
  /[[:upper:]]/.match(char)
end

def toggle_case(char)
  if is_upper?(char)
    return char.downcase
  else
    return char.upcase
  end
end

last_polymer_length = 0
#somewhat inelegantly, loop until the strip_pairs function makes no change
while(polymer.length != last_polymer_length)
  last_polymer_length = polymer.length
  polymer = strip_pairs(polymer)
end

puts "Length: #{polymer.length}"
