class SegmentList   
    attr_accessor :segments
    def self.generate(input_length, columns, multiplier)
        # c = Array.new(multiplier * columns) { rand(columns) }
        self.new(
            Array.new(multiplier * columns) { 
               rand(columns) 
            }.each_slice((columns * multiplier)/input_length).map { |slice| 
               Segment.generate(slice) 
            }
        )
    end

    def initialize(segments)
        @segments = segments
    end

    # return active segments
    def collect(input = [])
        input.map { |idx| @segments[idx] }
    end
end 