require 'image'
require 'image_verifier'

class Solver
  def self.solve(pixel_file, image_size, output)
    image = Image.new(image_size)
    image.read_from_file(pixel_file)

    verifier = ImageVerifier.new(image)
    output.puts(verifier.verification_code)
  end
end
