# Regression Trees

A decision tree can predict a number, not only a class. In the running example, use the categorical animal features $X$ to predict the animal's weight $Y$. Weight is now the target rather than an input, so this is a regression problem.

## Prediction at a leaf

The internal structure works as before: a test example follows feature decisions from the root until it reaches a leaf. The difference is the leaf output.

A regression-tree leaf predicts the average target value of the training examples that reached that leaf:

$$
\hat{y}_{\text{leaf}}
=\frac{1}{m_{\text{leaf}}}
\sum_{i\in\text{leaf}}y^{(i)}.
$$

For the tree in the lesson:

- pointy ears and round face lead to a leaf whose average weight is $8.35$;
- pointy ears and a not-round face lead to a leaf whose only training weight is $9.2$, so the prediction is $9.2$;
- the remaining leaves predict $17.70$ and $9.90$.

It is valid for different branches to split on the same feature. For example, both the left and right subtrees may choose face shape.

## Choosing a split: reduce variance

Classification trees choose splits that reduce entropy. Regression trees instead choose splits that reduce the **variance** of the target values $Y$.

Variance describes how widely a set of numerical targets varies. In the lesson's example:

- one child has variance $1.47$, indicating relatively little spread;
- another has variance $21.87$, indicating much greater spread.

For a candidate binary split, define:

- $V_{\text{root}}$: variance of all targets at the current node;
- $V_{\text{left}}$ and $V_{\text{right}}$: variances in the child nodes;
- $w^{\text{left}}$ and $w^{\text{right}}$: fractions of examples sent to each child.

The weighted variance after splitting is

$$
w^{\text{left}}V_{\text{left}}
+w^{\text{right}}V_{\text{right}}.
$$

The reduction in variance is

$$
\Delta V
=V_{\text{root}}
-\left(
w^{\text{left}}V_{\text{left}}
+w^{\text{right}}V_{\text{right}}
\right).
$$

Choose the feature with the **largest variance reduction**.

## Comparing root features

All 10 examples at the root have variance

$$
V_{\text{root}}=20.51.
$$

### Ear-shape split

Five examples go left and five go right, so

$$
w^{\text{left}}=w^{\text{right}}=\frac{5}{10}.
$$

With child variances $1.47$ and $21.87$, the reduction is

$$
\Delta V_{\text{ears}}
=20.51
-\left(
\frac{5}{10}\cdot1.47
+\frac{5}{10}\cdot21.87
\right)
=8.84.
$$

### Other candidate features

Repeating the calculation gives:

| Candidate feature | Reduction in variance |
|---|---:|
| Ear shape | $8.84$ |
| Face shape | $0.64$ |
| Whiskers | $6.22$ |

Ear shape produces the largest reduction, so it is selected at the root.

## Recursive training

After the ear-shape split, each branch contains five examples. Build each subtree by repeating the same procedure on its subset:

1. evaluate the candidate features;
2. compute each candidate's variance reduction;
3. choose the largest reduction;
4. split the subset;
5. continue until a stopping criterion is met.

## Classification tree versus regression tree

| Component | Classification tree | Regression tree |
|---|---|---|
| Target | discrete class | numerical value |
| Leaf output | predicted class | average target value at the leaf |
| Split objective | largest entropy reduction | largest variance reduction |
| Tree construction | recursive splitting | recursive splitting |

Training many trees together produces a tree ensemble, which can perform better than a single tree.
