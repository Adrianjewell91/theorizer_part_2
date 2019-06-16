Currently, I generate a random mapping of 88 inputs to 2048 columns, assign random permanence values to each synapse, and then randomly select only 40 of those activated columns and then compare them. 

Randomness is introduced:
1. Segment generation and their synapses (synapses are mapped randomly).
2. Permanence values are estalished (randomly generated).
3. Inhibition step (40 out of all the activate columns are randomly chosen instead of using a method.)

Next steps: to finish implementing the spatial pooling and then implement the temporal pooling
And seeing if the machine can learn to predict the chord center after a few rounds or something like that. 

Will probably have to write some tests, for all of this stuff. 

See is this fricken thing works.  

When I start playing chord center it centers in on it and predicts it, when I move to the next chord center, it immediately perceives the next one. Is any of this going to work? 

Finish implementing HTM from the paper and do Andrew Ng's machine learning course. 