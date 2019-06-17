require 'byebug'

class Layer 
    attr_accessor :columns, :segment_list

    def initialize(length)
        @segment_list = SegmentList.generate(88, length, 100)
    end

    def activate(input = [])
        @segment_list.collect(input).reduce(Hash.new(0)) do |columns,segment| 
            segment.synapses.each do |synapse|
                columns[synapse.destination] += 1 if synapse.permanence > synapse.threshold; 
            end
            columns
        end.keys.shuffle[0...40].compact
        # Inhibition
        # and Learning the new situation.
    end
end