#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join("..", "lib"), __dir__))

require 'amplification_series'
require 'intcode_interpreter'
require 'signal_maximizer'

input = File.read(File.expand_path(File.join("../data/input.txt"), __dir__))
program = input.split(',').map(&:to_i)

amplifiers = 5.times.map { IntcodeInterpreter.new(program) }
series = AmplificationSeries.new(amplifiers)
maximizer = SignalMaximizer.new(series, [5, 6, 7, 8, 9])

puts maximizer.get_maximum
