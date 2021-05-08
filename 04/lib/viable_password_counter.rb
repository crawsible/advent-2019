class ViablePasswordCounter
  def initialize(range)
    @range = range
  end

  def count
    range.count do |number|
      same_adjacent_digits?(number) && no_descending_digits?(number)
    end
  end

  def a_count
    range.count do |number|
      a_same_adjacent_digits?(number) && no_descending_digits?(number)
    end
  end

  private
  attr_reader :range

  def same_adjacent_digits?(number)
    number = number.to_s
    5.times do |i|
      return true if number.match(/(#{number[i]}+)/).captures.first.length == 2
    end

    false
  end

  def a_same_adjacent_digits?(number)
    number = number.to_s
    5.times do |i|
      return true if number[i] == number[i+1]
    end

    false
  end

  def no_descending_digits?(number)
    number = number.to_s
    5.times do |i|
      return false if number[i].to_i > number[i+1].to_i
    end

    true
  end
end
