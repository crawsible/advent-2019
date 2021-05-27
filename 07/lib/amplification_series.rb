class AmplificationSeries
  def initialize(amplifiers)
    @amplifiers = amplifiers
    chain_amplifiers
  end

  def amplify(phases)
    amplifiers.each.with_index do |amplifier, i|
      amplifier.input.enq(phases[i])
    end

    amplifiers[0].input.enq(0)

    threads = amplifiers.map do |amplifier|
      Thread.new { amplifier.execute }
    end

    threads.each(&:join)
    amplifiers.last.output.deq
  end

  private
  attr_reader :amplifiers

  def chain_amplifiers
    amplifiers.each.with_index do |amplifier, i|
      next_amplifier = amplifiers[(i + 1) % amplifiers.length]
      next_amplifier.input = amplifier.output
    end
  end
end
