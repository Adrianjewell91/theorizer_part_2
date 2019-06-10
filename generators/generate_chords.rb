#Generates all possible piano notes in a given major chord.
def generate(chord = [0,4,7])
    chord.reduce([]) do |acc, val|
        pitch = val
        while pitch < 87
            acc << pitch 
            pitch += 12
        end
        acc
    end
end

# Write all possible configurations on a given array of pitches.
def writeChords(pitches = generate(), path="database/a_major_combinations.txt")
    f = File.open(path, "w")
    (3..pitches.length).each do |size|
        pitches.combination(size) { |combo| f.write("#{combo}"[1...-1] + "\n") }
    end
    return f.close
end

# Convert a chord to all twelve key centers.
def to_twelve(chord=[0,4,7])
    [chord].reduce([]) do |acc, chord|
        12.times do |i|
            acc << [chord[0] + i, chord[1] + i, chord[2] + i]
        end
        acc
    end
end