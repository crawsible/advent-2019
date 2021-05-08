class Segment
  attr_reader :fromX, :fromY, :toX, :toY, :distance_offset

  def initialize(fromX:, fromY:, toX:, toY:, distance_offset: 0)
    @fromX, @fromY, @toX, @toY, @distance_offset = fromX, fromY, toX, toY, distance_offset
  end

  def intersection(other)
    return nil if self.orientation == other.orientation

    horizontal, vertical = (self.orientation == :horizontal ? [self, other] : [other, self])

    return nil unless horizontal.x_range.cover?(vertical.x_range.first)
    return nil unless vertical.y_range.cover?(horizontal.y_range.first)

    [vertical.x_range.first, horizontal.y_range.first]
  end

  def distance_from_origin(coords)
    case orientation
    when :horizontal
      (coords.first - fromX).abs + distance_offset
    when :vertical
      (coords.last - fromY).abs + distance_offset
    end
  end

  def ==(other)
    self.class == other.class && self.state.hash == other.state.hash
  end

  protected
  def state
    self.instance_variables.map { |iv| self.instance_variable_get(iv) }
  end

  def orientation
    x_range.one? ? :vertical : :horizontal
  end

  def x_range
    fromX < toX ? (fromX..toX) : (toX..fromX)
  end

  def y_range
    fromY < toY ? (fromY..toY) : (toY..fromY)
  end
end
