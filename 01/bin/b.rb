#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join("..", "lib"), __dir__))

require 'fuel_counter'

input = File.read(File.expand_path(File.join("../data/input.txt"), __dir__))
module_weights = input.split("\n").map(&:to_i)
puts FuelCounter.new(module_weights).required_fuel
