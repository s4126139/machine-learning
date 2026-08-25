# Sampling with Replacement

Sampling with replacement creates new datasets that resemble the original dataset but are not identical to it. This is a key building block for tree ensembles.

## Meaning of “with replacement”

Imagine a bag containing four colored tokens:

- red;
- yellow;
- green;
- blue.

To draw a sample of four **with replacement**:

1. randomly draw one token;
2. record its color;
3. put the token back into the bag;
4. mix the bag and draw again;
5. repeat until four colors have been recorded.

One sample might be:

$$
(\text{green},\text{yellow},\text{blue},\text{blue}).
$$

Blue appears twice and red does not appear. Repeating the procedure could instead produce sequences such as:

$$
(\text{red},\text{yellow},\text{red},\text{green})
$$

or

$$
(\text{green},\text{green},\text{blue},\text{red}).
$$

Replacement is essential. Without it, drawing four times from four tokens would always return each token exactly once, merely changing their order.

## Applying it to a training set

Suppose the original cat dataset contains 10 training examples. Treat those 10 examples as items in a virtual bag.

To generate a new training set:

1. randomly select one of the 10 examples;
2. add it to the new training set;
3. return it to the virtual bag;
4. repeat until the new training set also contains 10 entries.

Because every selected example is returned before the next draw:

- some original examples can occur more than once;
- some original examples may not occur at all;
- the new dataset has the same size as the original;
- the new dataset is similar to, but different from, the original.

## Role in tree ensembles

Repeating this procedure generates multiple random training sets. Training a separate decision tree on each one produces a collection of different trees whose predictions can later be combined.

## Key takeaway

Sampling with replacement preserves the requested sample size while allowing duplicates and omissions. Those controlled variations in the training data help create the diverse trees needed by an ensemble.
