require 'set';
require_relative 'chord_generator';
require_relative 'synapse';
require_relative 'segment';
require_relative 'segment_list';
require_relative 'layer';
require_relative 'writer';

LAYER = Layer.new(2048)

Writer.write(nil, "database/chords.txt") { |_, writer| 
    pitches = ChordGenerator.generate()
    (3..pitches.length).each do |size|
        pitches.combination(size) { |combo| writer.write("#{combo}"[1...-1] + "\n") }
    end
}


Writer.write("database/chords.txt", 'database/sdrs.txt') { |reader, writer|
    count = 0
    reader.each_line do |line|
        count += 1
        p count if count % 1000 == 0
        writer.write("#{LAYER.activate(Writer.to_array(line))}" + "\n")
        break if count == 10000
    end
}


Writer.write('database/sdrs.txt', "database/overlaps.txt") { |reader, writer| 
    sdrs = []
    reader.each_line do |line|
        input = Writer.to_array(line)
        sdrs << input.to_set
    end 

    p "Comparing each SDR with every other and computing overlap"
    count = 0
    writer.write("#{(0...sdrs.length).to_a}"[1...-1] + "\n")

    sdrs.shuffle.each do |sdr|
        p count 
        count += 1
        writer.write("#{(0...sdrs.length).to_a.reduce([]) { |acc, idx2| acc << (sdr & sdrs[idx2]).length / 40.0 * 100; acc }}"[1...-1] + "\n")
        break if count == 30
    end

    p 'Finished'
}


Writer.write(nil, "database/b_chords.txt") { |_, writer| 
    pitches = ChordGenerator.generate([2,6,9])
    (3..pitches.length).each do |size|
        pitches.combination(size) { |combo| writer.write("#{combo}"[1...-1] + "\n") }
    end
}

Writer.write("database/b_chords.txt", 'database/b_sdrs.txt') { |reader, writer|
    count = 0
    reader.each_line do |line|
        count += 1
        p count if count % 1000 == 0
        writer.write("#{LAYER.activate(Writer.to_array(line))}" + "\n")
        break if count == 10000
    end
}

# Load b sdr and a sdr, and compute some overlap of a_sdrs with b_sdrs

# Load a sdrs
# Load b sdrs
# Go through a sample of a sdrs
    # Compute the overlap with the b sdrs and store in overlaps file. 
Writer.write('database/b_sdrs.txt', "database/b_overlaps.txt") { |b_reader, writer| 
    a_reader = File.open('database/sdrs.txt')
    a_sdrs = []
    a_reader.each_line do |line|
        input = Writer.to_array(line)
        a_sdrs << input.to_set
    end    


    b_sdrs = []
    b_reader.each_line do |line|
        input = Writer.to_array(line)
        b_sdrs << input.to_set
    end 

    p "Comparing each SDR with every other and computing overlap"
    count = 0
    writer.write("#{(0...b_sdrs.length).to_a}"[1...-1] + "\n")

    b_sdrs.shuffle.each do |sdr|
        p count 
        count += 1
        writer.write("#{(0...a_sdrs.length).to_a.reduce([]) { |acc, idx2| acc << (sdr & a_sdrs[idx2]).length / 40.0 * 100; acc }}"[1...-1] + "\n")
        # writer.write("#{(0...a_sdrs.length).to_a.reduce([]) { |acc, idx2| acc << (sdr & a_sdrs[idx2]).length; acc }}"[1...-1] + "\n")
        break if count == 30
    end

    p 'Finished'
}