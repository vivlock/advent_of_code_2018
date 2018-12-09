require 'date'

def read_file(filename)
  updates = Array.new
  fh = open filename
  while (line = fh.gets)
    updates.push(parse_input(line))
  end
  fh.close

  updates = updates.sort_by{ |v| v[:time] }
  return updates
end

def parse_input(line)
  update = Hash.new
  # input format:
  # [YYYY-MM-DD HH:MM] action
  _, timestamp, action = line.split /\[|\]\s/

  #store the raw values for debugging
  update[:timestamp] = timestamp
  update[:action] = action

  update[:time] = DateTime.strptime(timestamp, "%Y-%m-%d %H:%M")
  # action:
  # "Guard #num begins shift", "wakes up", or "falls asleep"
  update[:wakes] = false
  update[:sleeps] = false
  update[:new_shift_id] = 0

  if action.include?("wakes up")
    update[:wakes] = true
  elsif action.include?("falls asleep")
    update[:sleeps] = true
  else
    update[:new_shift_id] = action.split(' ')[1].sub('#', '').to_i
  end
  return update
end
