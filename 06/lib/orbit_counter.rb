class OrbitCounter
  def initialize(orbit_data)
    @satellite_orbits = {}
    process_orbits(orbit_data)
  end

  def count
    @satellite_orbits.keys.map do |satellite|
      get_all_orbits(satellite)
    end.flatten.count
  end

  def transfer_count(source, destination)
    source_orbits = get_all_orbits(source)
    destination_orbits = get_all_orbits(destination)

    source_stationaries = source_orbits.map(&:stationary)
    destination_stationaries = destination_orbits.map(&:stationary)
    shared_stationary = (source_stationaries & destination_stationaries).first

    source_distance = source_orbits.find do |orbit|
      orbit.stationary == shared_stationary
    end.distance
    destination_distance = destination_orbits.find do |orbit|
      orbit.stationary == shared_stationary
    end.distance

    source_distance + destination_distance - 2
  end

  private
  Orbit = Struct.new(:stationary, :satellite, :distance)

  def process_orbits(orbit_data)
    orbit_data.each do |raw_orbit|
      stationary, satellite = raw_orbit.match(/\A(.*)\)(.*)\z/).captures

      orbit = Orbit.new(stationary, satellite, 1)
      @satellite_orbits[satellite] = orbit
    end
  end

  def get_all_orbits(satellite)
    orbits = [@satellite_orbits[satellite]]
    orbits.each do |orbit|
      linked_orbit = @satellite_orbits[orbit.stationary]
      next if linked_orbit.nil?

      orbits << Orbit.new(linked_orbit.stationary, satellite, orbit.distance + 1)
    end
  end
end
