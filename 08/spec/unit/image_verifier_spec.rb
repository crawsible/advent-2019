require 'image_verifier'

RSpec.describe ImageVerifier do
  describe '#verification_code' do
    context 'given some object with layers' do
      let(:image) { instance_double("Image", layers: [[[1, 2], [1, 2]], [[0, 0], [0, 0]]]) }

      it 'returns the product of the 1 count and 2 count, for the layer with the fewest number of zeros' do
        verifier = ImageVerifier.new(image)

        result = verifier.verification_code

        expect(result).to eq(4)
      end
    end

  end
end
