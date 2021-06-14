require 'solver'
require 'tempfile'

RSpec.describe Solver do
  context "with a pixel file, image dimensions, and an output" do
    let(:pixel_file) { Tempfile.new('pixel-file') }
    let(:image_size) { [2, 2] }
    let(:output) { spy("io") }

    before(:each) do
      pixel_file.write("10002021")
      pixel_file.rewind
    end

    it "writes to output the solution to the AOC problem" do
      # solution is "2":
      # - layer with fewest zeros is [2, 0, 2, 1]
      # - num 1s * num 2s is 2: 1 * 2 = 2
      Solver.solve(pixel_file, image_size, output)

      expect(output).to have_received(:puts).with(2)
    end
  end
end
