require 'amplification_series'

RSpec.describe AmplificationSeries do
  context 'given 5 amplifiers' do
    let(:amplifiers) { 5.times.map { instance_double("Amplifier") } }

    describe '#amplify' do
      it 'returns the result of chaining amplifier inputs and outputs' do
        series = AmplificationSeries.new(amplifiers)

        expect(amplifiers[0]).to receive(:amplify).with(0, 0).and_return(10)
        expect(amplifiers[1]).to receive(:amplify).with(0, 10).and_return(20)
        expect(amplifiers[2]).to receive(:amplify).with(0, 20).and_return(30)
        expect(amplifiers[3]).to receive(:amplify).with(0, 30).and_return(40)
        expect(amplifiers[4]).to receive(:amplify).with(0, 40).and_return(50)

        expect(series.amplify([0, 0, 0, 0, 0])).to eq(50)
      end

      it 'uses the provided phases in series' do
        series = AmplificationSeries.new(amplifiers)

        expect(amplifiers[0]).to receive(:amplify).with(5, 0).and_return(0)
        expect(amplifiers[1]).to receive(:amplify).with(4, 0).and_return(0)
        expect(amplifiers[2]).to receive(:amplify).with(3, 0).and_return(0)
        expect(amplifiers[3]).to receive(:amplify).with(2, 0).and_return(0)
        expect(amplifiers[4]).to receive(:amplify).with(1, 0).and_return(0)

        series.amplify([5, 4, 3, 2, 1])
      end
    end
  end
end
