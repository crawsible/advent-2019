class FuelCounter
  def initialize(module_weights)
    @module_weights = module_weights
  end

  def required_fuel_for_modules
    module_weights.reduce(0) do |memo, weight|
      memo + (weight / 3 - 2)
    end
  end

  def required_fuel
    module_weights.reduce(0) do |memo, weight|
      total_fuel = 0
      added_fuel = weight / 3 - 2

      until added_fuel <= 0
        total_fuel += added_fuel
        added_fuel = added_fuel / 3 - 2
      end

      memo + total_fuel
    end
  end

  private
  attr_reader :module_weights
end
