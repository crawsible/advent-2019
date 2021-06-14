class ImageVerifier
  def initialize(image)
    @image = image
  end

  def verification_code
    fewest_0_flat_layer = image.layers.map(&:flatten).min_by { |flat_layer| flat_layer.count(0) }
    fewest_0_flat_layer.count(1) * fewest_0_flat_layer.count(2)
  end

  private
  attr_reader :image
end
