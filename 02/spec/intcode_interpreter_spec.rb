require 'intcode_interpreter'

RSpec.describe IntcodeInterpreter do
  describe '#execute' do
    context 'with a 99 opcode' do
      it 'returns the program unchanged' do
        interpreter = IntcodeInterpreter.new([99, 0, 1, 2])
        expect(interpreter.execute).to    eq([99, 0, 1, 2])
      end
    end

    context 'with a 1 opcode' do
      it 'adds the referenced values and stores them at the referenced index' do
        interpreter = IntcodeInterpreter.new([1, 0, 0, 1])
        expect(interpreter.execute).to    eq([1, 2, 0, 1])
      end
    end

    context 'with a 2 opcode' do
      it 'multiplies the referenced values and stores them at the referenced index' do
        interpreter = IntcodeInterpreter.new([2, 0, 0, 1])
        expect(interpreter.execute).to    eq([2, 4, 0, 1])
      end
    end

    context 'with a multi-opcode program' do
      it 'executes them in sequence' do
        interpreter = IntcodeInterpreter.new([1, 0, 0, 1, 2, 4, 5, 5])
        expect(interpreter.execute).to    eq([1, 2, 0, 1, 2, 8, 5, 5])
      end

      it 'halts upon encountering a 99 opcode' do
        interpreter = IntcodeInterpreter.new([99, 0, 0, 1, 2, 4, 5, 5])
        expect(interpreter.execute).to    eq([99, 0, 0, 1, 2, 4, 5, 5])
      end
    end
  end

  describe '#update_value' do
    it 'changes a given position in the program to a given value' do
      interpreter = IntcodeInterpreter.new([99, 0, 0, 1])
      interpreter.update_value(1, 3)
      expect(interpreter.send(:program)).to eq([99, 3, 0, 1])
    end
  end
end
