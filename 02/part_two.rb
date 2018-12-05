filename = "input.txt"
puts "Going to open '#{filename}'"

ids = Array.new
done = false

#read in the file
fh = open filename
while (id = fh.gets)
  ids.push(id)
end
fh.close

ids.each do |id|
  matches = Array.new
  id.each_char.with_index do |char, i|
    match = id.dup
    match[i] = "."
    rgx = Regexp.new(match)
    results = ids.grep(rgx)
    if (results.length > 1)
      puts "SUCCESS"
      results.each do |result|
        puts result
      end
      done = true
    end
    if done then break end
  end
  if done then break end
end
