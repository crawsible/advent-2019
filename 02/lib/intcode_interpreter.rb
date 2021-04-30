class IntcodeInterpreter
  def initialize(program)
    @program = program
  end

  def execute
    offset = 0
    until offset >= program.length
      opcode, input1, input2, output = program[offset...offset+4]

      case opcode
      when 99
        break
      when 1
        program[output] = program[input1] + program[input2]
      when 2
        program[output] = program[input1] * program[input2]
      end

      offset += 4
    end

    program
  end

  def update_value(position, value)
    program[position] = value
  end

  private
  attr_reader :program
end
