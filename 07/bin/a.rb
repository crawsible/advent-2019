#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join("..", "lib"), __dir__))

require 'amplification_series'
require 'amplifier'
require 'intcode_interpreter'
require 'signal_maximizer'

input = File.read(File.expand_path(File.join("../data/input.txt"), __dir__))
program = input.split(',').map(&:to_i)

amplifiers = 5.times.map do
  interpreter = IntcodeInterpreter.new(program)
  Amplifier.new(interpreter)
end

series = AmplificationSeries.new(amplifiers)
maximizer = SignalMaximizer.new(series, [0, 1, 2, 3, 4])

puts maximizer.get_maximum
