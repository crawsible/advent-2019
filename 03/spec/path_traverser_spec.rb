require 'path_traverser'

RSpec.describe PathTraverser do
  describe '#traverse' do
    context 'with a right-step path' do
      it 'creates a segment beginning at the origin' do
        traverser = PathTraverser.new('R5')
        traverser.traverse
        expect(traverser.segments).to eq([Segment.new(fromX: 0, fromY: 0, toX: 5, toY: 0)])
      end
    end
    context 'with a down-step path' do
      it 'creates a segment beginning at the origin' do
        traverser = PathTraverser.new('D4')
        traverser.traverse
        expect(traverser.segments).to eq([Segment.new(fromX: 0, fromY: 0, toX: 0, toY: -4)])
      end
    end
    context 'with a left-step path' do
      it 'creates a segment beginning at the origin' do
        traverser = PathTraverser.new('L3')
        traverser.traverse
        expect(traverser.segments).to eq([Segment.new(fromX: 0, fromY: 0, toX: -3, toY: 0)])
      end
    end
    context 'with a up-step path' do
      it 'creates a segment beginning at the origin' do
        traverser = PathTraverser.new('U2')
        traverser.traverse
        expect(traverser.segments).to eq([Segment.new(fromX: 0, fromY: 0, toX: 0, toY: 2)])
      end
    end

    context 'with a multistep path' do
      it 'creates segments beginning at the origin' do
        traverser = PathTraverser.new('R5,D4,L3,U2')
        traverser.traverse
        expect(traverser.segments).to eq([
          Segment.new(fromX: 0, fromY:  0, toX: 5, toY:  0),
          Segment.new(fromX: 5, fromY:  0, toX: 5, toY: -4),
          Segment.new(fromX: 5, fromY: -4, toX: 2, toY: -4),
          Segment.new(fromX: 2, fromY: -4, toX: 2, toY: -2),
        ])
      end
    end
  end
end
