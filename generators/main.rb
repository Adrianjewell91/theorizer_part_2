require_relative "generate_chords"
require_relative "generate_sdrs"

# Write the chord configurations
p "Generating Chord Configurations"
writeChords()

p "Computing active columns for each chord"
# Generate active columns
writeActiveColumns()

p "Computing overlaps of each chord with every other chord"
# Generate overlaps 
writeOverlaps()