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
        amplifier = Amplifier.new(interpreter, 3)
        amplifier.amplify(7)

        expect(input.string).to eq("3\n7\n")
      end

      it "executes the interpreter" do
        amplifier = Amplifier.new(interpreter, 3)

        expect(interpreter).to receive(:execute)
        amplifier.amplify(7)
      end

      it "reads from the interpreter's output and and returns the value" do
        output.puts "42"
        amplifier = Amplifier.new(interpreter, 0)
        expect(amplifier.amplify(0)).to be(42)
      end
    end

    describe '#reset' do
      it "truncates and rewinds the interpreter's input and output" do
        amplifier = Amplifier.new(interpreter, 0)

        expect(input).to receive(:truncate).with(0)
        expect(input).to receive(:rewind)

        expect(output).to receive(:truncate).with(0)
        expect(output).to receive(:rewind)

        amplifier.reset
      end
    end
  end
end
