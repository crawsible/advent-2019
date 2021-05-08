#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join("..", "lib"), __dir__))

require 'viable_password_counter'

input = File.read(File.expand_path(File.join("..", "data", "input.txt"), __dir__))
first, last = input.match(/(\d+)-(\d+)/).captures.map(&:to_i)
counter = ViablePasswordCounter.new((first..last))

puts counter.count
