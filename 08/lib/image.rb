class Image
  attr_reader :layers

  def initialize(dimensions)
    @m, @n = dimensions
    @layers = []
    @pixel_count = 0
  end

  DIGIT_REGEX = /[[:digit:]]/
  def read_from_file(file)
    file.each_char do |char|
      next unless DIGIT_REGEX.match(char)
      add_pixel(char.to_i)
    end
  end

  private
  attr_accessor :pixel_count
  attr_reader :m, :n

  def add_pixel(pixel)
    layer_i = pixel_count / (m * n)
    row_i = pixel_count / n % m
    col_i = pixel_count % n

    until layer_i < layers.length
      layers << Array.new(m) { Array.new(n) }
    end

    layers[layer_i][row_i][col_i] = pixel
    self.pixel_count += 1
  end
end
