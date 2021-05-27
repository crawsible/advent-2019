require 'signal_maximizer'

RSpec.describe SignalMaximizer do
  describe '#get_maximum' do
    context 'given an amplification series' do
      let(:series) { instance_double("AmplificationSeries") }

      it 'gets the signal from every permutation of its phases' do
        maximizer = SignalMaximizer.new(series, [0, 1, 2])

        expect(series).to receive(:amplify).with([0, 1, 2])
        expect(series).to receive(:amplify).with([1, 0, 2])
        expect(series).to receive(:amplify).with([2, 1, 0])
        expect(series).to receive(:amplify).with([0, 2, 1])
        expect(series).to receive(:amplify).with([1, 2, 0])
        expect(series).to receive(:amplify).with([2, 0, 1])

        maximizer.get_maximum
      end

      it 'returns the maximum signal from all permutations' do
        maximizer = SignalMaximizer.new(series, [0, 1, 2])

        allow(series).to receive(:amplify).and_return(10)
        allow(series).to receive(:amplify).with([0, 2, 1]).and_return(100)

        expect(maximizer.get_maximum).to eq(100)
      end
    end
  end
end
