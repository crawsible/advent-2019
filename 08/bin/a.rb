#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join("..", "lib"), __dir__))
require 'solver'

pixel_file = File.open(File.expand_path(File.join("..", "data", "input.txt"), __dir__))
Solver.solve(pixel_file, [25, 6], $stdout)
