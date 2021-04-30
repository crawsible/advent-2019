#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join("..", "lib"), __dir__))

require 'intcode_interpreter'

input = File.read(File.expand_path(File.join("../data/input.txt"), __dir__))
program = input.split(",").map(&:to_i)

interpreter = IntcodeInterpreter.new(program)
interpreter.update_value(1, 12)
interpreter.update_value(2, 2)

puts interpreter.execute[0]
