class Synapse
    attr_accessor :destination, :permanence, :threshold

    def initialize(destination, permanence)
        @destination, @permanence = destination, permanence
        @threshold = 0.5
    end
end