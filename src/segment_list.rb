class SegmentList   
    attr_accessor :segments

    def initialize(length = 88)
        @segments = Array.new(length) { Segment.generate } #introducting some serious randomness here.
    end

    # return active segments
    def collect(input = [])
        input.map { |idx| @segments[idx] }
    end
end 