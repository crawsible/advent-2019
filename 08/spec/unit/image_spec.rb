require 'image'
require 'tempfile'

RSpec.describe Image do
  describe '#read_from_file' do
    context 'with a pixel file and dimensions' do
      let(:image) { Image.new([2, 3]) }
      let(:pixel_file) { Tempfile.new("pixel-file") }

      it "separates the pixels into layer matrices of the image's dimensions" do
        pixel_file.write("100200200100")
        pixel_file.rewind

        image.read_from_file(pixel_file)

        expect(image.layers).to eq([
          [
            [1, 0, 0],
            [2, 0, 0],
          ],
          [
            [2, 0, 0],
            [1, 0, 0]
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

  describe '#render' do
    let(:image) { Image.new([2, 3]) }

    context 'with multiple layers' do
      before(:each) do
        image.layers << [[0, 0, 2], [2, 2, 1]]
        image.layers << [[1, 1, 2], [1, 2, 0]]
        image.layers << [[1, 1, 1], [1, 1, 0]]
      end

      it 'returns a first-to-last composite with 2 representing transparency' do
        expect(image.render).to eq("  █\n███")
      end
    end
  end
end
