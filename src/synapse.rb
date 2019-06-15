class Synapse
    attr_accessor :id, :permanence, :threshold

    def initialize(id, permanence)
        @id, @permanence = id, permanence
        @threshold = 0.5
    end
end