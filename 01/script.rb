filename = "input.txt"
puts "Going to open '#{filename}'"

changes = Array.new
seenFrequencies = Hash.new
done = false
frequency = 0

#lets read the file in first
fh = open filename
while (line = fh.gets)
   change = { operator: line[0], operand: line[1..-1].to_i }
   changes.push(change)
end
fh.close

def calc_next_frequency(cur_frequency, change)
  if (change[:operator] == "+")
    return cur_frequency + change[:operand]
  elsif(change[:operator] == "-")
    return cur_frequency - change[:operand]
  end
end

while(not done)
  changes.each do |change|
    frequency = calc_next_frequency(frequency, change)
    puts frequency
    if seenFrequencies.has_key?(frequency)
      puts "found it!!"
      done = true
      puts frequency
      break
    else
      seenFrequencies[frequency] = 1
    end
  end
end

fh.close
