require 'intcode_interpreter'

class OutputSolver
  def initialize(program)
    @program = program
  end

  def solve_for(target)
    100.times do |noun|
      100.times do |verb|
        interpreter = IntcodeInterpreter.new(program)

        interpreter.update_value(1, noun)
        interpreter.update_value(2, verb)

        return [noun, verb] if interpreter.execute.first == target
      end
    end
  end

  private
  attr_reader :program
end
