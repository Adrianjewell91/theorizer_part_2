Theorizer Part 2 begins my attempt to build a turing machine for musicians, for which the first step is to build a machine that learns to classify chord spaces given inputs. 

To Run:
create a folder /database
in terminal run: ``` ruby src/main.rb ```

This is generator all possible configurations of the a Major chord.
It will generate an sdr against a randomly generated set of synpases that connect the input to a collection 2048 columns.

It will then compute the overlap of each sdr with every other one. 

In the interest of time and space, I only compute a subset (10000) of SDRs from the 4 million plus chord configurations, and then only the overlap for ten of those. 

Open the index.html to see the overlap.

Remember to run a simple server.
