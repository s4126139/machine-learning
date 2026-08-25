# Learning Curves

## Definition

A **learning curve** shows how a learning algorithm performs as the amount of experience available to it changes. Here, experience means the training-set size $m_{\text{train}}$.

The plot uses:

- horizontal axis: $m_{\text{train}}$;
- vertical axis: error;
- one curve for $J_{\text{train}}(\mathbf{w},b)$; and
- one curve for $J_{\text{cv}}(\mathbf{w},b)$.

The model in the initial example is a quadratic, or second-degree polynomial.

## General shape of the curves

### Cross-validation error

As the training set becomes larger, the model usually improves, so

$$
J_{\text{cv}}\ \text{tends to decrease as}\ m_{\text{train}}\ \text{increases}.
$$

### Training error

Training error generally moves in the opposite direction:

$$
J_{\text{train}}\ \text{tends to increase as}\ m_{\text{train}}\ \text{increases}.
$$

With one training example, a quadratic can fit the point exactly. With two examples, a line can fit both. With three examples, a quadratic can still achieve zero or nearly zero training error. As a fourth, fifth, and further examples are added, it becomes harder for one quadratic to fit every point perfectly, so average training error rises.

Because the parameters were chosen to fit the training set, the model usually performs better on that set than on unseen cross-validation data:

$$
J_{\text{cv}}\ge J_{\text{train}}
$$

in the typical learning-curve picture, with the gap sometimes especially large when the training set is small.

## Learning curve for high bias

Consider fitting a straight line to data whose pattern is more complex.

- $J_{\text{train}}$ rises as examples are added and eventually reaches a plateau.
- $J_{\text{cv}}$ falls but also reaches a plateau above $J_{\text{train}}$.
- Both plateau because a simple linear model changes little after enough examples have been observed.
- A baseline such as human-level performance lies substantially below the training error.

The large gap between the baseline and $J_{\text{train}}$ indicates high bias. Extending the curves to a much larger training set would not make them drop to the baseline; they would remain roughly flat because the model itself is too simple.

**Consequence:** if an algorithm has high bias, obtaining more training data alone is unlikely to help much. Before investing heavily in data collection, check for high bias and consider a change other than merely adding examples.

## Learning curve for high variance

Consider an unregularized fourth-degree polynomial that fits a small training set extremely well but generalizes poorly.

- $J_{\text{train}}$ is low and rises as the training set grows.
- $J_{\text{cv}}$ is much higher, producing a large gap between the curves.
- An overfit model can even achieve unrealistically low training error, possibly lower than human-level performance, because it has fitted the particular training examples so closely.

The defining signal remains

$$
J_{\text{cv}}\gg J_{\text{train}}.
$$

If the curves are extrapolated to larger $m_{\text{train}}$, training error continues to rise while CV error can fall toward it. With more examples, the same fourth-degree polynomial can be fitted more reliably and become less wiggly.

**Consequence:** if an algorithm has high variance, increasing the training-set size is likely to help and can move cross-validation performance closer to the baseline.

## High-bias and high-variance comparison

| Property | High bias | High variance |
|---|---|---|
| Main visible gap | Baseline to $J_{\text{train}}$ | $J_{\text{train}}$ to $J_{\text{cv}}$ |
| Behavior after many examples | Both errors plateau at an undesirably high level | CV error may keep falling toward training error |
| Will more data alone help? | Usually not much | Often yes |
| Example | Straight-line underfit | Fourth-degree overfit |

## How to construct a learning curve

Suppose 1,000 training examples are available:

1. Train a model on a subset of 100 examples and compute its training and CV errors.
2. Train a new model on 200 examples, temporarily leaving the other 800 unused, and compute both errors again.
3. Repeat with increasingly large subsets.
4. Plot the two errors against the subset size.

The shape helps determine whether the current behavior resembles high bias or high variance.

## Practical limitation

Plotting a learning curve requires training many separate models on different-sized subsets, which can be computationally expensive. It is therefore not always done in practice. Even when the full plot is not produced, the mental picture of these curve shapes is useful for reasoning about what the algorithm is doing and whether additional data is likely to help.
