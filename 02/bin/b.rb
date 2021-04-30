#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join("..", "lib"), __dir__))

require 'output_solver'

input = File.read(File.expand_path(File.join("../data/input.txt"), __dir__))
program = input.split(",").map(&:to_i)

solver = OutputSolver.new(program)
result = solver.solve_for(19690720)

puts 100 * result.first + result.last
