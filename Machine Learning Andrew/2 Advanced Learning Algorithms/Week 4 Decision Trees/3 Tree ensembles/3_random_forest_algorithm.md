# The Random Forest Algorithm

Sampling with replacement makes it possible to train many trees on slightly different versions of the original dataset. A random forest adds another source of variation by also randomizing which features each node may consider.

## Bagged decision trees

Given a training set of size $m$, build an ensemble of $B$ trees:

1. For $b=1,2,\ldots,B$:
   1. sample $m$ training examples **with replacement** from the original dataset;
   2. train one decision tree on that sampled dataset.
2. For a new classification example, ask all $B$ trees to vote and use the majority prediction.

Each sampled dataset has size $m$, but it may repeat some examples and omit others. The different datasets therefore produce somewhat different trees.

This procedure is called **bagging**, and its trees are called **bagged decision trees**. The “bag” refers to the virtual bag used in the sampling-with-replacement explanation.

## Choosing the number of trees

A typical value of $B$ is around $100$; values such as $64$ or $128$ are also used. Increasing $B$ does not hurt predictive performance, but after a certain point the gains diminish. Building, for example, $1000$ trees can substantially slow computation without meaningfully improving the ensemble over roughly $100$ trees.

## Why bagged trees may still be too similar

Even after resampling the data, many sampled datasets may select the same feature at the root and at nodes near the root. This can make the trained trees too similar to one another.

The random forest introduces an additional modification to diversify them.

## Random feature selection at each node

Suppose $n$ input features are available at a node.

1. Randomly choose a subset of $k$ features, where $k<n$.
2. Compute information gain only for those $k$ features.
3. Split on the feature with the highest information gain within that subset.

When $n$ is large, a typical choice is

$$
k=\sqrt{n}.
$$

This feature-subsampling step is most useful for problems with dozens or hundreds of features rather than the running example's three features.

## Why the random forest is robust

Two mechanisms create varied trees:

- sampling with replacement changes the training examples seen by each tree;
- random feature subsets change the split candidates seen at each node.

The ensemble averages, through voting, over many small changes to the data and feature choices. A further small change to the training set is therefore less likely to cause a large change in the overall prediction than it would for one decision tree.

## Bagging versus random forest

| Method | Randomized training examples | Randomized candidate features |
|---|---|---|
| Bagged decision trees | yes | no |
| Random forest | yes | yes, independently at each node |

The random forest is typically more accurate and much more robust than a single decision tree. Boosted decision trees provide another ensemble approach, developed next through XGBoost.
