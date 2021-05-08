require 'viable_password_counter'

RSpec.describe ViablePasswordCounter do
  describe '#count' do
    it 'counts the number of viable passwords within a given range' do
      counter = ViablePasswordCounter.new((112222..112223))
      expect(counter.count).to eq(2)
    end

    it 'only counts numbers that have at least one group of exactly two same adjacent numbers' do
      counter = ViablePasswordCounter.new((123444..123445))
      expect(counter.count).to eq(1)
    end

    it 'does not count numbers that have any descending digits' do
      counter = ViablePasswordCounter.new((112349..112354))
      expect(counter.count).to eq(1)
    end
  end

  describe '#a_count' do
    it 'counts the number of viable passwords within a given range' do
      counter = ViablePasswordCounter.new((111111..111112))
      expect(counter.a_count).to eq(2)
    end

    it 'does not count numbers that do not have at least two same numbers adjacent' do
      counter = ViablePasswordCounter.new((123455..123459))
      expect(counter.a_count).to eq(1)
    end

    it 'does not count numbers that have any descending digits' do
      counter = ViablePasswordCounter.new((112349..112354))
      expect(counter.a_count).to eq(1)
    end
  end
end
