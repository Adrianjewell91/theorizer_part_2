require 'set';
require_relative 'chord_generator';
require_relative 'synapse';
require_relative 'segment';
require_relative 'segment_list';
require_relative 'layer';
require_relative 'writer';

# Writer.write(nil, "database/chords.txt") { |_, writer| 
#     pitches = ChordGenerator.generate()
#     (3..pitches.length).each do |size|
#         pitches.combination(size) { |combo| writer.write("#{combo}"[1...-1] + "\n") }
#     end
# }

Writer.write("database/chords.txt", 'database/sdrs.txt') { |reader, writer|
    layer = Layer.new(2048)
    count = 0
    reader.each_line do |line|
        count += 1
        p count if count % 1000 == 0
        writer.write("#{layer.activate(line.chomp.split(", ").map(&:to_i)).keys.shuffle[0...40].compact}" + "\n")
        break if count == 10000
    end
}

Writer.write('database/sdrs.txt', "database/overlaps.txt") { |reader, writer| 
    sdrs = []
    reader.each_line do |line|
        input = line.chomp.split(", ").map(&:to_i)
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

