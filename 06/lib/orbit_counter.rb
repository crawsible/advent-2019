class OrbitCounter
  def initialize(orbit_data)
    process_orbits(orbit_data)
  end

  def count
    orbits.count
  end

  private
  def process_orbits(orbit_data)
    @stationary_satellites = Hash.new([])

    orbit_data.each do |orbit|
      stationary, satellite = orbit.match(/\A(.*)\)(.*)\z/).captures
      @stationary_satellites[stationary] += [satellite]
    end
  end

  def orbits
    @stationary_satellites.keys.map do |stationary|
      find_satellites(stationary).map { |satellite| "#{stationary})#{satellite}" }
    end.flatten
  end

  def find_satellites(stationary)
    @stationary_satellites[stationary].map do |satellite|
      [satellite] + find_satellites(satellite)
    end.flatten
  end
end
