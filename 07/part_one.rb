require_relative 'step_map'

class DoTheThing
  FILENAME = "sample_input.txt"
  #FILENAME = ""

  def initialize
    @step_map = StepMap.new
  end

  def read_file
    fh = open FILENAME
    while (line = fh.gets)

    end
    fh.close
  end

  # Step A must be finished before step B can begin.
  def parse_input(line)
    pieces = line.split(' ')
    a = pieces[1]
    b = pieces[7]
    @step_map.add_node(a, b)
  end
end
