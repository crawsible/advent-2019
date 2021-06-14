require 'image'
require 'tempfile'

RSpec.describe Image do
  describe '#read_from_file' do
    context 'with a pixel file and dimensions' do
      let(:image) { Image.new([2, 3]) }
      let(:pixel_file) { Tempfile.new("pixel-file") }

      it "separates the pixels into layer matrices of the image's dimensions" do
        pixel_file.write("100200300400")
        pixel_file.rewind

        image.read_from_file(pixel_file)

        expect(image.layers).to eq([
          [
            [1, 0, 0],
            [2, 0, 0],
          ],
          [
            [3, 0, 0],
            [4, 0, 0]
          ],
        ])
      end

      it "ignores non-digit characters" do
        pixel_file.write("10a020\n0")
        pixel_file.rewind

        image.read_from_file(pixel_file)

        expect(image.layers).to eq([[
          [1, 0, 0],
          [2, 0, 0],
        ]])
      end
    end
  end
end
