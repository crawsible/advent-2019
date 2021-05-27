class AmplificationSeries
  def initialize(amplifiers)
    @amplifiers = amplifiers
  end

  def amplify(phases)
    amplifiers.each.with_index.reduce(0) do |signal, (amplifier, i)|
      amplifier.amplify(phases[i], signal)
    end
  end

  private
  attr_reader :amplifiers
end
