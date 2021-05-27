require 'amplification_series'

RSpec.describe AmplificationSeries do
  context 'given 3 amplifiers' do
    let(:amplifiers) do
      3.times.map do
        instance_double("Amplifier", {
          input: instance_double("Queue"),
          output: instance_double("Queue"),
        })
      end
    end

    describe '.new' do
      it 'sets up the amplifier inputs and outputs in a loop' do
        expect(amplifiers[1]).to receive(:input=).with(amplifiers[0].output)
        expect(amplifiers[2]).to receive(:input=).with(amplifiers[1].output)
        expect(amplifiers[0]).to receive(:input=).with(amplifiers[2].output)

        series = AmplificationSeries.new(amplifiers)
      end
    end

    describe '#amplify' do
      before(:example) do
        amplifiers.each do |amplifier|
          allow(amplifier).to receive(:input=)
          allow(amplifier.input).to receive(:enq)
          allow(amplifier).to receive(:execute)
        end

        allow(amplifiers[2].output).to receive(:deq)
      end

      it "seeds each amplifier's inputs with the corresponding phase" do
        series = AmplificationSeries.new(amplifiers)

        expect(amplifiers[0].input).to receive(:enq).with(5)
        expect(amplifiers[1].input).to receive(:enq).with(9)
        expect(amplifiers[2].input).to receive(:enq).with(6)

        series.amplify([5, 9, 6])
      end

      it "seeds the first amplifier's input with zero after its phase" do
        series = AmplificationSeries.new(amplifiers)

        expect(amplifiers[0].input).to receive(:enq).with(5).ordered
        expect(amplifiers[0].input).to receive(:enq).with(0).ordered

        series.amplify([5, 9, 6])
      end

      it 'calls execute on each of the amplifiers' do
        series = AmplificationSeries.new(amplifiers)

        expect(amplifiers[0]).to receive(:execute)
        expect(amplifiers[1]).to receive(:execute)
        expect(amplifiers[2]).to receive(:execute)

        series.amplify([5, 9, 6])
      end

      it 'runs the amplifiers concurrently' do
        series = AmplificationSeries.new(amplifiers)

        amp0wait = Queue.new
        inAmp0 = false
        allow(amplifiers[0]).to receive(:execute) do
          inAmp0 = true
          amp0wait.deq
          inAmp0 = false
        end

        amp0WasActive = nil
        allow(amplifiers[2]).to receive(:execute) do
          amp0WasActive = inAmp0
          amp0wait.enq(nil)
        end

        series.amplify([5, 9, 6])

        expect(amp0WasActive).to be(true)
      end

      it "returns the value from the last amplifier's output" do
        series = AmplificationSeries.new(amplifiers)
        allow(amplifiers[2].output).to receive(:deq).and_return(999)

        expect(series.amplify([5, 9, 6])).to eq(999)
      end
    end
  end
end
