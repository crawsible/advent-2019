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

  describe '#transfer_count' do
    # COM - A - B - C
    #        \
    #         D - E - F
    let(:counter) { OrbitCounter.new(["COM)A", "A)B", "B)C", "A)D", "D)E", "E)F"]) }

    context 'with two satellites directly orbiting the same station' do
      it 'returns zero' do
        transfer_count = counter.transfer_count("B", "D")
        expect(transfer_count).to be(0)
      end
    end

    context 'with satellites orbiting separate stationaries' do
      it 'returns the shortest number of transfers between the two stationaries' do
        transfer_count = counter.transfer_count("C", "F")
        expect(transfer_count).to be(3)
      end
    end
  end
end
