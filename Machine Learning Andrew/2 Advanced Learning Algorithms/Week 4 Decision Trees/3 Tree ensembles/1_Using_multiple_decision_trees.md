# Using Multiple Decision Trees

A single decision tree can be highly sensitive to small changes in its training data. A **tree ensemble** reduces that sensitivity by combining the predictions of many decision trees.

## Instability of a single tree

In the cat-classification example, ear shape initially has the highest information gain at the root. Now change just one training example:

- before: pointy ears, round face, whiskers absent, cat;
- after: floppy ears, round face, whiskers present, cat.

After this one change, whiskers—not ear shape—has the highest information gain at the root. A different root split creates different child subsets, and the recursive learning procedure can then produce entirely different subtrees.

This illustrates the weakness: one small data change can alter the entire learned tree.

## Tree ensembles

A tree ensemble is a collection of multiple, plausible decision trees trained for the same task. Instead of trusting any single tree, run the test example through every tree and combine their outputs.

For classification, the trees vote.

### Voting example

Consider a test animal with:

- pointy ears;
- a not-round face;
- whiskers present.

Three trees predict:

| Tree | Prediction |
|---|---|
| Tree 1 | cat |
| Tree 2 | not cat |
| Tree 3 | cat |

The majority vote is **cat**, so that becomes the ensemble's final prediction.

$$
\text{ensemble prediction}
=\operatorname{majority\ vote}
\left(
\text{tree}_1,\text{tree}_2,\ldots
\right).
$$

## Why voting helps

Each tree contributes only one vote. An unusual or inaccurate decision by one tree therefore has less influence on the final output when many other trees also vote. Combining trees makes the overall algorithm:

- less sensitive to the behavior of any one tree;
- more robust to small changes in the training data;
- often more accurate than a single decision tree.

The remaining problem is how to create many useful but different trees. Sampling with replacement provides the key mechanism for generating their different training sets.
