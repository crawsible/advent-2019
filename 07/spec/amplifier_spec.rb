require 'amplifier'

RSpec.describe Amplifier do
  context 'given an interpreter loaded with amplifier controller software' do
    let(:input) { StringIO.new }
    let(:output) { StringIO.new }

    let(:interpreter) { instance_double("IntcodeInterpreter", {input: input, output: output}) }

    before(:example) do
      allow(interpreter).to receive(:execute)
    end

    describe '#amplify' do
      it "writes phase and input signal to its input" do
        amplifier = Amplifier.new(interpreter)
        expect(input).to receive(:puts).with(3).ordered
        expect(input).to receive(:puts).with(7).ordered

        amplifier.amplify(3, 7)
      end

      it "executes the interpreter" do
        amplifier = Amplifier.new(interpreter)

        expect(interpreter).to receive(:execute)
        amplifier.amplify(3, 7)
      end

      it "reads from the interpreter's output and and returns the value" do
        output.puts "42"
        amplifier = Amplifier.new(interpreter)
        expect(amplifier.amplify(0, 0)).to be(42)
      end

      it "truncates and rewinds the interpreter's input and output" do
        amplifier = Amplifier.new(interpreter)
        amplifier.amplify(0, 0)

        expect(input.string).to be_empty
        expect(output.string).to be_empty
        expect(input.pos).to be(0)
        expect(output.pos).to be(0)
      end
    end
  end
end
