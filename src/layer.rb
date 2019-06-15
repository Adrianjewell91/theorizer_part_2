class Layer 
    attr_accessor :columns, :segment_list

    def initialize(length)
        @columns = (0...length).to_a
        @segment_list = SegmentList.new(88)
    end

    # Return active columns given an input
    def activate(input = [])
        @segment_list.collect(input).reduce(Hash.new(0)) do |columns,segment| 
            segment.synapses.each do |synapse|
                columns[synapse.id] += 1 if synapse.permanence > synapse.threshold; 
            end
            columns
        end
        # Inhibition
        # and Learning? 
    end
end