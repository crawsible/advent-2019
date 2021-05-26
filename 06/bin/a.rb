#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join("..", "lib"), __dir__))

require 'orbit_counter'

input = File.read(File.expand_path(File.join("../data/input.txt"), __dir__))
orbit_data = input.split("\n")

counter = OrbitCounter.new(orbit_data)
puts counter.count
