require('byebug')

# Generate array of segments, each of which contain synapses, and a permanace value.
def generate_segments(length = 88 - 1, columns = 2048, synapse_multiplier = 100)
    (0...columns).reduce([]) {
            |acc, num| synapse_multiplier.times{|_| acc << num }; acc 
        }.shuffle.each_slice((columns*synapse_multiplier) / length).map {
            |slice| slice.map{|column| [column,rand]}
        }
end

# Generates an SDR
# @input: array of active inputs
# @threshold: values between 0 and 1, denoting permanance threshold.
# @segments: array of segments, each of which contain an array of synapses
def get_sdr(input = [0,1,2], 
            threshold = 0.5, 
            segments = generate_segments(), 
            output_size = 2048,
            desired_active = 40)

    input.map { |idx| segments[idx] }
         .reduce(Array.new(output_size,0)) do |columns, synapses| 
                synapses.each do |(column, permanence)|
                    columns[column] += 1 if permanence > threshold 
                end
                columns
            end
        .map.with_index { |val, idx| [val,idx] } 
        .each_slice(output_size/desired_active).inject([]) do |active_columns, slice| 
                active_columns << slice.sort{|a,b| a[0]<=>b[0]}[-1][1]
                active_columns
            end
end

# Create active columns for each chord config using above script.
def writeActiveColumns(readPath = "database/a_major_combinations.txt",
                       writePath = "database/a_major_sdr_representations.txt")
    
    read = File.open(readPath)
    write = File.open(writePath, "w")
    segments = generate_segments()
    perm_threshold = 0.5

    p "writing"
    count = 0
    read.each_line do |line|
        p count if count % 1000 == 0
        count += 1
        input = line.chomp.split(", ").map(&:to_i)
        write.write("#{get_sdr(input, perm_threshold, segments)}\n")
        
        #IMPORTANT:
        # Right now, only write the first 10000 configurations.
        break if count == 10000
    end

    p "Finished"

    write.close
end

# Take each configuration and determine its overlap with every other chord.
def writeOverlaps(readPath = "database/a_major_sdr_representations.txt", 
                writePath =  "database/sdr_overlaps.txt")

    p "Loading SDR representations"
    write = File.open(writePath, "w")
    read = File.open(readPath, "r")
    array = []

    p "Putting into an array"
    read.each_line do |line|
        input = line.chomp.split(", ").map(&:to_i)
        array << input 
    end 

    p "Comparing each SDR with every other and computing overlap"
    count = 0
    write.write("#{array.map.with_index{|el,idx| idx}}"[1...-1] + "\n")

    array.each_with_index do |active_columns, idx|
        p count 
        count += 1 
        overlaps = [] 
        (0...array.length).each do |idx2|
            counter = {}
            n = 0
            active_columns.each {|col| counter[col] = true }
            array[idx2].each { |col| n += 1 if counter[col] }
            overlaps << [((n/40.0) * 100).to_i, 100].min
        end
        write.write("#{overlaps}"[1...-1] + "\n")
        break if count == 10
    end

    p 'Finished'
    write.close
end

