#FILENAME = "sample_input.txt"
FILENAME = "input.txt"

characters = Array.new
("a".."z").each { |letter| characters.push({value: letter}) }

def read_file
  polymer = Array.new
  polymer_string = File.read(FILENAME).strip
  for i in 0..(polymer_string.length - 1)
    polymer.push(polymer_string[i])
  end
  return polymer
end

def strip_pairs(polymer)
  i = 0
  while(i < polymer.length - 1)
    this_char = polymer[i]
    next_char = polymer[i + 1]
    if toggle_case(this_char) == next_char
      polymer.delete_at(i + 1)
      polymer.delete_at(i)
    else
      i += 1
    end
  end
  return polymer
end

def strip_character(polymer, character)
  polymer_copy = polymer.dup
  polymer_copy.delete(character)
  polymer_copy.delete(character.upcase)
  return polymer_copy
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

def calculate_polymer_length_for_character(polymer, character)
  polymer = strip_character(polymer, character)
  last_polymer_length = 0
  while(polymer.length != last_polymer_length)
    last_polymer_length = polymer.length
    polymer = strip_pairs(polymer)
  end
  return polymer.length
end

polymer = read_file
characters.each do |char|
  char[:length] = calculate_polymer_length_for_character(polymer, char[:value])
end

lowest = characters[0]
characters.each do |char|
  if char[:length] < lowest[:length]
    lowest = char
  end
end

puts "The best character to remove is #{lowest[:value]} with length #{lowest[:length]}"
