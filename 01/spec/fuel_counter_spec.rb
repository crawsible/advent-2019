require 'fuel_counter'

RSpec.describe FuelCounter do
  describe "#required_fuel_for_modules" do
    context "with one module weight" do
      it "returns its required fuel amount without factoring fuel weight" do
        expect(FuelCounter.new([9]).required_fuel_for_modules).to eq(1)
        expect(FuelCounter.new([33]).required_fuel_for_modules).to eq(9)
        expect(FuelCounter.new([105]).required_fuel_for_modules).to eq(33)
      end
    end

    context "with multiple module weights" do
      it "returns the sum of the required fuel amounts without factoring fuel weight" do
        expect(FuelCounter.new([9, 33, 105]).required_fuel_for_modules).to eq(43)
      end
    end
  end

  describe "#required_fuel" do
    context "with one module weight" do
      it "returns its required fuel amount" do
        expect(FuelCounter.new([9]).required_fuel).to eq(1)
        expect(FuelCounter.new([33]).required_fuel).to eq(10)
        expect(FuelCounter.new([105]).required_fuel).to eq(43)
      end
    end

    context "with multiple module weights" do
      it "returns the sum of the required fuel amounts" do
        expect(FuelCounter.new([9, 33, 105]).required_fuel).to eq(54)
      end
    end
  end
end
