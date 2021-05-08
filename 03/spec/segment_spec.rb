require 'segment'

RSpec.describe Segment do
  describe '#==' do
    it 'returns true when all from and to coords are the same' do
      segment = Segment.new(fromX: 0, fromY: 0, toX: 1, toY: 0)
      matching_segment = Segment.new(fromX: 0, fromY: 0, toX: 1, toY: 0)

      expect(segment == matching_segment).to be(true)
    end

    it 'returns false in any other scenario' do
      segment = Segment.new(fromX: 0, fromY: 0, toX: 1, toY: 0)
      nonmatching_segment = Segment.new(fromX: 0, fromY: 0, toX: 1, toY: 1)

      expect(segment == nonmatching_segment).to be(false)
    end
  end

  describe '#intersection' do
    let(:segment) { Segment.new(fromX: 0, fromY: 0, toX: 2, toY: 0) }

    context 'with a non-intersecting segment' do
      it 'returns nil' do
        nonintersecting_segment = Segment.new(fromX: 1, fromY: 1, toX: 1, toY: 3)
        expect(segment.intersection(nonintersecting_segment)).to be_nil
      end
    end

    context 'with an intersecting segment' do
      it 'returns the coordinates of the intersection point' do
        intersecting_segment = Segment.new(fromX: 1, fromY: 1, toX: 1, toY: -1)
        expect(segment.intersection(intersecting_segment)).to eq([1, 0])
      end

      it 'assumes (incorrectly) parallel segments must not intersect' do
        intersecting_segment = Segment.new(fromX: 1, fromY: 0, toX: 3, toY: 0)
        expect(segment.intersection(intersecting_segment)).to be_nil
      end
    end
  end

  describe '#distance_from_origin' do
    context 'with no offset' do
      it 'returns the distance from the "from" coordinates' do
        segment = Segment.new(fromX: 0, fromY: 0, toX: 5, toY: 0)
        expect(segment.distance_from_origin([2, 0])).to eq(2)
      end

      it 'returns an absolute value' do
        segment = Segment.new(fromX: 0, fromY: 0, toX: -5, toY: 0)
        expect(segment.distance_from_origin([-2, 0])).to eq(2)
      end
    end

    context 'with an offset' do
      it 'returns the distance plus the offset' do
        segment = Segment.new(fromX: 0, fromY: 0, toX: -5, toY: 0, distance_offset: 5)
        expect(segment.distance_from_origin([-2, 0])).to eq(7)
      end
    end
  end
end
