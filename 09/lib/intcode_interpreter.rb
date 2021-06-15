require 'stringio'

class IntcodeInterpreter
  attr_accessor :input, :output

  def initialize(program, input=Queue.new, output=Queue.new)
    @initial_program = program.dup

    @input = input
    @output = output

    @relative_base = 0
  end

  def execute
    self.program = initial_program.dup

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
        pointer = input_to_destination(pointer, param_modes)
      when 4
        pointer = source_to_output(pointer, param_modes)
      when 5
        pointer = jump_if_true(pointer, param_modes)
      when 6
        pointer = jump_if_false(pointer, param_modes)
      when 7
        pointer = less_than(pointer, param_modes)
      when 8
        pointer = equals(pointer, param_modes)
      when 9
        pointer = adjust_relative_base(pointer, param_modes)
      end
    end

    program
  end

  private
  attr_accessor :program, :relative_base
  attr_reader :initial_program

  def decompose_operation(pointer)
    opcode = program[pointer] % 100
    param_modes = [
      program[pointer] % 1_000 / 100,
      program[pointer] % 10_000 / 1_000,
      program[pointer] % 100_000 / 10_000,
    ]

    [opcode, param_modes]
  end

  def resolve_parameters(num_requested, pointer, param_modes)
    program[pointer, num_requested].map.with_index do |value, i|
      case param_modes[i]
      when 0
        program[value]
      when 1
        value
      when 2
        program[relative_base + value]
      else
        raise("incorrect param mode for parameter")
      end
    end
  end

  def resolve_destination(pointer, param_mode)
    case param_mode
    when 0
      program[pointer]
    when 2
      relative_base + program[pointer]
    else
      puts param_mode
      raise("incorrect param mode for destination")
    end
  end

  def add(pointer, param_modes)
    input1, input2 = resolve_parameters(2, pointer, param_modes)
    destination = resolve_destination(pointer + 2, param_modes[2])

    program[destination] = input1 + input2
    pointer + 3
  end

  def multiply(pointer, param_modes)
    input1, input2 = resolve_parameters(2, pointer, param_modes)
    destination = resolve_destination(pointer + 2, param_modes[2])

    program[destination] = input1 * input2
    pointer + 3
  end

  def input_to_destination(pointer, param_modes)
    destination = resolve_destination(pointer, param_modes.first)
    program[destination] = input.deq

    pointer + 1
  end

  def source_to_output(pointer, param_modes)
    source = resolve_parameters(1, pointer, param_modes).first

    output.enq(source)
    pointer + 1
  end

  def jump_if_true(pointer, param_modes)
    conditional, location = resolve_parameters(2, pointer, param_modes)

    !conditional.zero? ? location : pointer + 2
  end

  def jump_if_false(pointer, param_modes)
    conditional, location = resolve_parameters(2, pointer, param_modes)

    conditional.zero? ? location : pointer + 2
  end

  def less_than(pointer, param_modes)
    value1, value2 = resolve_parameters(2, pointer, param_modes)
    destination = resolve_destination(pointer + 2, param_modes[2])

    is_less_than = value1 < value2 ? 1 : 0
    program[destination] = is_less_than

    pointer + 3
  end

  def equals(pointer, param_modes)
    value1, value2 = resolve_parameters(2, pointer, param_modes)
    destination = resolve_destination(pointer + 2, param_modes[2])

    is_less_than = value1 == value2 ? 1 : 0
    program[destination] = is_less_than

    pointer + 3
  end

  def adjust_relative_base(pointer, param_modes)
    base_adjustment = resolve_parameters(1, pointer, param_modes).first
    self.relative_base += base_adjustment

    pointer + 1
  end
end
