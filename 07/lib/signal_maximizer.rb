class SignalMaximizer
  def initialize(series, phases)
    @series, @phases = series, phases
  end

  def get_maximum
    phases.permutation.map do |phase_order|
      series.amplify(phase_order)
    end.max
  end

  private
  attr_reader :series, :phases
end
