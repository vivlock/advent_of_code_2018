def read_file(filename)
  fh = open FILENAME
  initial_state = parse_initial_state(fh.gets)
  rules = Hash.new
  # throw out empty line
  fh.gets
  while (line = fh.gets)
    parse_rule(line, rules)
  end
  fh.close
  return PlantState.new(initial_state, rules)
end

def parse_initial_state(input)
  pieces = input.split(":")
  return pieces[1].strip
end

def parse_rule(line, rules)
  pieces = line.split("=>").map{ |x| x.strip }
  rules[pieces[0]] = pieces[1]
end

class PlantState
  def initialize(initial_state, rules)
    @state = initial_state
    @rules = rules
    @index_0 = 0
    @generation = 0
  end
  def gen
    return @generation
  end

  def get_total
    total = 0
    index = 0
    while(index < @state.length)
      next_plant = @state.index('#', index)
      if(next_plant != nil)
        total += next_plant - @index_0
        index = next_plant + 1
      else
        break
      end
    end
    return total
  end

  def tick
    @state = "...." + @state + "...."
    @index_0 += 4
    @generation += 1

    new_state = @state.dup
    length = @state.length
    loop_to = length - 5

    for i in 0..loop_to
      key = @state[i..(i + 4)]
      #puts "Key: #{key}; HasKey: #{@rules.has_key?(key)}; Val: #{@rules[key]}"
      if @rules.has_key?(key)
        new_state[i + 2] = @rules[key]
      else
        # this handles the sample input, which only includes => #
        # the real input contains all combinations
        new_state[i + 2] = '.'
      end
    end

    @state = new_state
    return @state
  end

  def output_state
    puts "Generation #{@generation}"
    puts (" " * @index_0) + "0"
    puts @state
  end

  def output_rules
    puts @rules
  end
end
