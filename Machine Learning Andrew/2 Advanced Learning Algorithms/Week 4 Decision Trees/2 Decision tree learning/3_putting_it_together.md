# Putting the Decision-Tree Algorithm Together

Information gain chooses a feature for one node. A full decision tree applies that same choice repeatedly to the root and then to progressively smaller subsets of the training data.

## Overall training algorithm

Start with all training examples at the root node.

1. Check whether a stopping criterion has been met.
2. If not, compute information gain for every candidate feature.
3. Select the feature with the highest information gain.
4. Split the examples into subsets according to that feature's value.
5. Create the corresponding child branches.
6. Repeat the procedure on each child subset.

Splitting can stop when one or more of these conditions holds:

- every example at the node belongs to one class, so its entropy is $0$;
- another split would make the tree exceed its maximum depth;
- the best available information gain is below a threshold;
- the number of examples at the node is below a threshold.

## Worked cat-classification tree

### Root node

All 10 examples begin at the root. The algorithm computes information gain for ear shape, face shape, and whiskers. Ear shape has the highest information gain, so the root splits the data into:

- five pointy-ear examples on the left;
- five floppy-ear examples on the right.

### Left subtree

Treat the five pointy-ear examples as a new, smaller training set.

1. They contain a mixture of cats and dogs, so training continues.
2. Recompute information gain using only these five examples.
3. Splitting again on ear shape has information gain $0$ because every example already has pointy ears.
4. Between face shape and whiskers, face shape has the highest information gain.
5. Split on face shape.
6. The resulting children are pure: one contains only cats and the other only non-cats. Convert both to leaves.

### Right subtree

Apply the same procedure to the five floppy-ear examples.

1. The examples are not all one class.
2. Compute information gain for the candidate features using only this subset.
3. Whiskers has the highest information gain.
4. Split on whiskers.
5. The resulting children meet the stopping criterion and become leaves predicting cat and not cat.

## The recursive structure

This is a **recursive algorithm**: building the full tree requires building smaller trees on its child subsets. In code, recursion means that a procedure calls itself. Here, the tree-building procedure is called again for each child branch until a stopping condition is satisfied.

Conceptually:

$$
\text{tree at a node}
=
\text{chosen root split}
+
\text{left subtree}
+
\text{right subtree}.
$$

Understanding recursion is useful when implementing a decision tree from scratch, but it is not required to use a decision-tree library.

## Maximum depth and model complexity

A larger maximum depth permits a larger, more complex tree. This resembles fitting a higher-degree polynomial or training a larger neural network:

- more depth lets the model represent a more complex function;
- more complexity also increases the risk of overfitting.

In theory, different maximum depths can be compared on a cross-validation set. In practice, open-source libraries provide useful defaults and may use better ways to choose this parameter.

The other stopping controls have the same broad purpose. A split with very small information gain gives little entropy reduction, and a node with very few examples may not be worth dividing further.

## Prediction after training

To classify a new example:

1. start at the root;
2. inspect the feature named by the current decision node;
3. follow the branch matching the example's feature value;
4. repeat until reaching a leaf;
5. output the leaf's prediction.

## Key takeaway

The same local rule—choose the feature with the highest information gain—is applied recursively throughout the tree. Stopping criteria control when a subset becomes a leaf and limit the complexity of the learned model.
