def read_file(filename)
  fh = open FILENAME
  initial_state = parse_initial_state(fh.gets)
  # throw out empty line
  fh.gets
  while (line = fh.gets)
    rule = parse_rule(line)
  end
  fh.close
end

def parse_initial_state(input)

end

def parse_rule(line)
  pieces = line.split("=>").map{ |x| x.strip }
  rule = Regexp.new(Regexp.escape(pieces[0]))
end

# use gsub to replace all "pattern" with "string"

class PlantState
  def initialize(initial_state, rules)
    @state = initial_state
    @rules = rules
  end
end
