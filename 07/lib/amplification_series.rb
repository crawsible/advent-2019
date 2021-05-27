class AmplificationSeries
  def initialize(amplifiers)
    @amplifiers = amplifiers
  end

  def amplify
    amplifiers.reduce(0) do |signal, amplifier|
      amplifier.amplify(signal)
    end
  end

  private
  attr_reader :amplifiers
end
