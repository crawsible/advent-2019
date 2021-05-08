class PathTraverser
  attr_reader :segments

  def initialize(steps)
    @steps = steps.split(',')
    @segments = []
  end

  def traverse
    fromX, fromY = 0, 0
    distance_offset = 0

    until steps.empty? do
      direction, distance = next_step

      case direction
      when :R
        toX, toY = fromX + distance, fromY
      when :D
        toX, toY = fromX, fromY - distance
      when :L
        toX, toY = fromX - distance, fromY
      when :U
        toX, toY = fromX, fromY + distance
      end

      segments << Segment.new(
        fromX: fromX,
        fromY: fromY,
        toX: toX,
        toY: toY,
        distance_offset: distance_offset
      )

      fromX, fromY = toX, toY
      distance_offset += distance
    end
  end

  private
  attr_reader :steps

  def next_step
    direction, distance = steps.shift.match(/(R|D|L|U)(\d+)/).captures
    [direction.to_sym, distance.to_i]
  end
end
