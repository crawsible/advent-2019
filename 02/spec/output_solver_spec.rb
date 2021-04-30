require 'output_solver'

RSpec.describe OutputSolver do
  describe '#solve_for' do
    context 'given some program' do
      let(:solver) { OutputSolver.new([2, 0, 0, 0, 99, 3, 9]) }

      it 'finds values for position 1 and 2 that result in the desired output' do
        result = solver.solve_for(27)

        expect(result.length).to be(2)
        expect(result).to include(5, 6)
      end
    end
  end
end
