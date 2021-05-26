require 'orbit_counter'

RSpec.describe OrbitCounter do
  describe '#count' do
    context 'with only direct orbits' do
      it 'returns the orbit count' do
        two_counter = OrbitCounter.new(["COM)AAA", "COM)BBB"])
        three_counter = OrbitCounter.new(["COM)1", "COM)2", "COM)3"])

        expect(two_counter.count).to be(2)
        expect(three_counter.count).to be(3)
      end
    end

    context 'with direct and indirect orbits' do
      it 'returns the orbit count across both types' do
        counter = OrbitCounter.new(["COM)AAA", "AAA)BBB"])

        expect(counter.count).to be(3)
      end
    end
  end
end
