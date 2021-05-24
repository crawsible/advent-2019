class IntcodeInterpreter
  def initialize(program, input=$stdin, output=$stdout)
    @program = program.dup
    @input = input
    @output = output
  end

  def execute
    pointer = 0
    until pointer >= program.length
      opcode = program[pointer]
      pointer += 1

      case opcode
      when 99
        break
      when 1
        input1, input2, destination = program[pointer...pointer+3]
        program[destination] = program[input1] + program[input2]
        pointer += 3
      when 2
        input1, input2, destination = program[pointer...pointer+3]
        program[destination] = program[input1] * program[input2]
        pointer += 3
      when 3
        destination = program[pointer]
        program[destination] = input.gets.chomp.to_i
        pointer += 1
      when 4
        source = program[pointer]
        output.puts(program[source])
        pointer += 1
      end
    end

    program
  end

  def update_value(position, value)
    program[position] = value
  end

  private
  attr_reader :program, :input, :output
end
