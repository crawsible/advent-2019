#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join("..", "lib"), __dir__))
require 'solver'

pixel_file = File.open(File.expand_path(File.join("..", "data", "input.txt"), __dir__))
Solver.solve_b(pixel_file, [6, 25], $stdout)
