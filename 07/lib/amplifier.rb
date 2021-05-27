class Amplifier

  def initialize(interpreter)
    @interpreter = interpreter
  end

  def amplify(phase, input_signal)
    interpreter.input.puts(phase)
    interpreter.input.puts(input_signal)
    interpreter.input.rewind

    interpreter.execute
    signal = interpreter.output.string.chomp.to_i

    reset_io
    signal
  end

  private
  attr_reader :interpreter

  def reset_io
    interpreter.input.truncate(0)
    interpreter.input.rewind

    interpreter.output.truncate(0)
    interpreter.output.rewind
  end

end
