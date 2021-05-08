#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join("..", "lib"), __dir__))

require 'path_traverser'
require 'segment'

input = File.read(File.expand_path(File.join("..", "data", "input.txt"), __dir__))
path_steps = input.split("\n")

traverser1 = PathTraverser.new(path_steps[0])
traverser2 = PathTraverser.new(path_steps[1])

traverser1.traverse
traverser2.traverse

closest_distance = nil

traverser1.segments.each do |t1_segment|
  traverser2.segments.each do |t2_segment|
    intersection = t1_segment.intersection(t2_segment)
    next if intersection.nil? || intersection == [0, 0]

    distance = t1_segment.distance_from_origin(intersection) +
      t2_segment.distance_from_origin(intersection)
    if closest_distance.nil? || distance < closest_distance
      closest_distance = distance
    end
  end
end

puts closest_distance
