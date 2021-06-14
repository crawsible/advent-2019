require 'solver'
require 'tempfile'

RSpec.describe Solver do
  describe '.solve_a' do
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
        Solver.solve_a(pixel_file, image_size, output)

        expect(output).to have_received(:puts).with(2)
      end
    end
  end

  describe '.solve_b' do
    context "with a pixel file, image dimensions, and an output" do
      let(:pixel_file) { Tempfile.new('pixel-file') }
      let(:image_size) { [2, 2] }
      let(:output) { spy("io") }

      before(:each) do
        pixel_file.write("0222112222120000")
        pixel_file.rewind
      end

      it "writes to output the solution to the AOC problem" do
        Solver.solve_b(pixel_file, image_size, output)

        expect(output).to have_received(:puts).with(" █\n█ ")
      end
    end
  end
end
