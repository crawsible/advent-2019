require 'intcode_interpreter'
require 'stringio'

RSpec.describe IntcodeInterpreter do
  describe '.new' do
    it 'copies the provided program' do
      program = [99]
      interpreter = IntcodeInterpreter.new(program)

      interpreter_program = interpreter.send(:program)
      expect(interpreter_program.object_id).not_to eq(program.object_id)
    end
  end

  describe '#execute' do
    context 'opcodes' do
      context 'with opcode 99 (exit)' do
        it 'returns the program unchanged' do
          interpreter = IntcodeInterpreter.new([99, 0, 1, 2])
          expect(interpreter.execute).to    eq([99, 0, 1, 2])
        end
      end

      context 'with opcode 1 (add)' do
        it 'adds the referenced values and stores them at the referenced index' do
          interpreter = IntcodeInterpreter.new([1, 0, 0, 1])
          expect(interpreter.execute).to    eq([1, 2, 0, 1])
        end
      end

      context 'with opcode 2 (multiply)' do
        it 'multiplies the referenced values and stores them at the referenced index' do
          interpreter = IntcodeInterpreter.new([2, 0, 0, 1])
          expect(interpreter.execute).to    eq([2, 4, 0, 1])
        end
      end

      context 'with opcode 3 (input to destination)' do
        it 'reads from a provided input and writes it to the referenced index' do
          input = StringIO.new("777\n")
          interpreter = IntcodeInterpreter.new([3, 0], input)

          expect(interpreter.execute).to    eq([777, 0])
        end
      end

      context 'with opcode 4 (source to output)' do
        it 'reads from a refenced index and writes it to output' do
          output = StringIO.new
          interpreter = IntcodeInterpreter.new([4, 0], nil, output)
          interpreter.execute

          expect(output.string).to eq("4\n")
        end
      end

      context 'with opcode 5 (jump if true)' do
        context 'when the first parameter is zero' do
          it 'does nothing' do
            interpreter = IntcodeInterpreter.new([5, 7, 5, 99, 1, 4, 4, 0])
            expect(interpreter.execute).to    eq([5, 7, 5, 99, 1, 4, 4, 0])
          end
        end

        context 'when the first parameter is nonzero' do
          it 'moves the pointer to the value of the second parameter' do
            interpreter = IntcodeInterpreter.new([5, 6, 5, 99, 1, 4, 4, 0])
            expect(interpreter.execute).to    eq([2, 6, 5, 99, 1, 4, 4, 0])
          end
        end
      end

      context 'with opcode 6 (jump if false)' do
        context 'when the first parameter is zero' do
          it 'moves the pointer to the value of the second parameter' do
            interpreter = IntcodeInterpreter.new([6, 7, 5, 99, 1, 4, 4, 0])
            expect(interpreter.execute).to    eq([2, 7, 5, 99, 1, 4, 4, 0])
          end
        end

        context 'when the first parameter is nonzero' do
          it 'does nothing' do
            interpreter = IntcodeInterpreter.new([6, 6, 5, 99, 1, 4, 4, 0])
            expect(interpreter.execute).to    eq([6, 6, 5, 99, 1, 4, 4, 0])
          end
        end
      end

      context 'with opcode 7 (less than)' do
        context 'when the first parameter is less than the second parameter' do
          it 'writes 1 to the destination specified by the third parameter' do
            interpreter = IntcodeInterpreter.new([7, 5, 4, 0, 99, 98])
            expect(interpreter.execute).to    eq([1, 5, 4, 0, 99, 98])
          end
        end

        context 'when the first parameter is not less than the second parameter' do
          it 'writes 0 to the destination specified by the third parameter' do
            interpreter = IntcodeInterpreter.new([7, 5, 4, 0, 99, 99])
            expect(interpreter.execute).to    eq([0, 5, 4, 0, 99, 99])
          end
        end
      end

      context 'with opcode 8 (equal)' do
        context 'when the first parameter is equal to the second parameter' do
          it 'writes 1 to the destination specified by the third parameter' do
            interpreter = IntcodeInterpreter.new([8, 5, 4, 0, 99, 99])
            expect(interpreter.execute).to    eq([1, 5, 4, 0, 99, 99])
          end
        end

        context 'when the first parameter is not less than the second parameter' do
          it 'writes 0 to the destination specified by the third parameter' do
            interpreter = IntcodeInterpreter.new([8, 5, 4, 0, 99, 100])
            expect(interpreter.execute).to    eq([0, 5, 4, 0, 99, 100])
          end
        end
      end
    end

    context 'with nonzero parameter modes' do
      it 'treats the corresponding parameter as a value and not an address for opcode 1 (add)' do
        interpreter = IntcodeInterpreter.new([1101, 0, 0, 0])
        expect(interpreter.execute).to    eq([0,    0, 0, 0])
      end

      it 'treats the corresponding parameter as a value and not an address for opcode 2 (multiply)' do
        interpreter = IntcodeInterpreter.new([1102, 0, 0, 0])
        expect(interpreter.execute).to    eq([0,    0, 0, 0])
      end

      it 'treats the corresponding parameter as a value and not an address for opcode 4 (source to output)' do
        output = StringIO.new
        interpreter = IntcodeInterpreter.new([104, 3, 99, 777], nil, output)
        interpreter.execute

        expect(output.string).to eq("3\n")
      end

      it 'treats the corresponding parameter as a value and not an address for opcode 5 (jump if true)' do
        interpreter = IntcodeInterpreter.new([105, 7, 5, 99, 1, 4, 4, 0])
        expect(interpreter.execute).to    eq([2,   7, 5, 99, 1, 4, 4, 0])
      end

      it 'treats the corresponding parameter as a value and not an address for opcode 6 (jump if false)' do
        interpreter = IntcodeInterpreter.new([106, 0, 5, 99, 1, 4, 4, 0])
        expect(interpreter.execute).to    eq([2,   0, 5, 99, 1, 4, 4, 0])
      end

      it 'treats the corresponding parameter as a value and not an address for opcode 7 (less than)' do
        interpreter = IntcodeInterpreter.new([1107, 5, 4, 0, 99, 98])
        expect(interpreter.execute).to    eq([0,    5, 4, 0, 99, 98])
      end

      it 'treats the corresponding parameter as a value and not an address for opcode 8 (equals)' do
        interpreter = IntcodeInterpreter.new([1108, 5, 4, 0, 99, 99])
        expect(interpreter.execute).to    eq([0,    5, 4, 0, 99, 99])
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
