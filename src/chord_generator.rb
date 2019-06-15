class ChordGenerator
    #Generates all possible piano notes in a given major chord.
    def self.generate(chord = [0,4,7])
        chord.reduce([]) do |acc, val|
            pitch = val
            while pitch < 87
                acc << pitch 
                pitch += 12
            end
            acc
        end
    end

    # Convert a chord to all twelve key centers.
    def self.to_twelve(chord=[0,4,7])
        [chord].reduce([]) do |acc, chord|
            12.times do |i|
                acc << [chord[0] + i, chord[1] + i, chord[2] + i]
            end
            acc
        end
    end
end