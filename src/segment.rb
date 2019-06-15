class Segment 
    attr_accessor :synapses 
    
    #Generate a segment according to something actual here.
    def self.generate(columns = (0...2048).to_a.sample(100))
        self.new(columns.map{ |column| Synapse.new(column, rand) })
    end

    def initialize(synapses)
        @synapses = synapses
    end
end 

