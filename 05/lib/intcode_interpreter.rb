class IntcodeInterpreter
  def initialize(program, input=$stdin, output=$stdout)
    @program = program.dup
    @input = input
    @output = output
  end

  def execute
    pointer = 0
    until pointer >= program.length
      opcode, param_modes = decompose_operation(pointer)
      pointer += 1

      case opcode
      when 99
        break
      when 1
        pointer = add(pointer, param_modes)
      when 2
        pointer = multiply(pointer, param_modes)
      when 3
        pointer = input_to_destination(pointer)
      when 4
        pointer = source_to_output(pointer, param_modes)
      end
    end

    program
  end

  def update_value(position, value)
    program[position] = value
  end

  private
  attr_reader :program, :input, :output

  def decompose_operation(pointer)
    opcode = program[pointer] % 100
    param_modes = [
      program[pointer] % 1_000 / 100,
      program[pointer] % 10_000 / 1_000,
      program[pointer] % 100_000 / 10_000,
    ]

    [opcode, param_modes]
  end

  def add(pointer, param_modes)
    input1, input2 = program[pointer..pointer+1].map.with_index do |param, i|
      param_modes[i] == 0 ? program[param] : param
    end
    destination = program[pointer+2]

    program[destination] = input1 + input2
    pointer + 3
  end

  def multiply(pointer, param_modes)
    input1, input2 = program[pointer..pointer+1].map.with_index do |param, i|
      param_modes[i] == 0 ? program[param] : param
    end
    destination = program[pointer+2]

    program[destination] = input1 * input2
    pointer += 3
  end

  def input_to_destination(pointer)
    destination = program[pointer]
    program[destination] = input.gets.chomp.to_i
    pointer += 1
  end

  def source_to_output(pointer, param_modes)
    source_param = program[pointer]
    source = param_modes.first == 0 ? program[source_param] : source_param

    output.puts(source)
    pointer += 1
  end
end
