# Measuring Purity with Entropy

Decision-tree learning needs a numerical way to describe how pure or impure a set of labeled examples is. A set containing only one class is pure; a set containing a mixture of classes is impure.

## Class proportions

For the cat-classification example, define:

- $p_1$: fraction of examples with label $1$—the cats;
- $p_0$: fraction of examples with label $0$—the non-cats.

Because the task has two classes,

$$
p_0 = 1-p_1.
$$

For a sample containing three cats and three dogs,

$$
p_1=\frac{3}{6}=0.5.
$$

## Entropy

The entropy of the sample is

$$
H(p_1)
=-p_1\log_2(p_1)-p_0\log_2(p_0)
=-p_1\log_2(p_1)-(1-p_1)\log_2(1-p_1).
$$

Base-2 logarithms are used so that the maximum entropy is the convenient value $1$. Using natural logarithms would vertically rescale the curve without changing its overall shape.

When $p_1=0$ or $p_0=0$, the equation contains a term of the form $0\log(0)$. For entropy calculations, use the convention

$$
0\log(0)=0.
$$

This gives entropy $0$ for a sample that contains only one class.

## Interpreting the entropy value

| Sample of 6 animals | $p_1$ | $H(p_1)$ | Interpretation |
|---|---:|---:|---|
| 3 cats, 3 dogs | $3/6=0.50$ | $1.00$ | maximum impurity |
| 5 cats, 1 dog | $5/6\approx0.83$ | $\approx0.65$ | mixed, but relatively pure |
| 6 cats, 0 dogs | $6/6=1$ | $0$ | completely pure |
| 2 cats, 4 dogs | $2/6\approx0.33$ | $\approx0.92$ | highly impure |
| 0 cats, 6 dogs | $0/6=0$ | $0$ | completely pure |

The entropy curve is symmetric:

- $H(0)=0$: all examples are non-cats;
- $H(0.5)=1$: the sample is split evenly between cats and non-cats;
- $H(1)=0$: all examples are cats.

Moving from a 50–50 mixture toward either pure endpoint lowers entropy and increases purity.

## Entropy in decision trees

Entropy is the impurity measure used in these lessons to compare possible splits. Another criterion available in open-source packages is the Gini criterion, which has a similar shape and can also work well. The course focuses on entropy because it is sufficient for most applications discussed here.

Although the entropy equation resembles the logistic-loss equation, the mathematical reason for that similarity is outside the scope of this lesson.

## Key takeaway

Entropy converts the class balance at a node into an impurity score between $0$ and $1$: pure nodes have entropy $0$, while an evenly mixed binary node has entropy $1$.
