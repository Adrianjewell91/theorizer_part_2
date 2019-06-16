class Segment 
    attr_accessor :synapses 
    def self.generate(columns)
        self.new(columns.map{ |column| Synapse.new(column, rand) })
    end

    def initialize(synapses)
        @synapses = synapses
    end
end 

