class Amplifier
  attr_accessor :phase

  def initialize(interpreter, phase)
    @interpreter, @phase = interpreter, phase
  end

  def amplify(input_signal)
    interpreter.input.puts(phase)
    interpreter.input.puts(input_signal)
    interpreter.input.rewind

    interpreter.execute
    interpreter.output.string.chomp.to_i
  end

  def reset
    interpreter.input.truncate(0)
    interpreter.input.rewind
    interpreter.output.truncate(0)
    interpreter.output.rewind
  end

  private
  attr_reader :interpreter
end
