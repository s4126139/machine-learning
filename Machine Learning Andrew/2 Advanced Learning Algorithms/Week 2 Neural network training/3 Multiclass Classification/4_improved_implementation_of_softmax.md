# A Numerically Improved Softmax Implementation

The direct softmax implementation is mathematically correct, but TensorFlow can compute the loss more accurately if it receives the unnormalized scores, or **logits**, and combines the activation with the loss internally.

## Why equivalent formulas can behave differently on a computer

Consider two ways to calculate the same number.

### Direct form

$$
x=\frac{2}{10{,}000}.
$$

### Difference of two nearby values

$$
x=
\left(1+\frac{1}{10{,}000}\right)
-
\left(1-\frac{1}{10{,}000}\right).
$$

Algebraically, both expressions equal $2/10{,}000$. On a computer, however, numbers are stored with finite precision as floating-point values. The second computation can show more round-off error because it first forms two nearby numbers and then subtracts them.

The same issue can arise when an activation is explicitly computed as an intermediate value before the loss.

## Logistic-regression illustration

Ordinary logistic regression first computes

$$
a=g(z)=\frac{1}{1+e^{-z}}
$$

and then evaluates binary cross-entropy:

$$
L(a,y)
=
-y\log a-(1-y)\log(1-a).
$$

This usually works reasonably well. But $a$ can be substituted directly into the loss:

$$
L(z,y)
=
-y\log\left(\frac{1}{1+e^{-z}}\right)
-(1-y)\log\left(1-\frac{1}{1+e^{-z}}\right).
$$

If TensorFlow is given the loss as a function of $z$, it has flexibility to rearrange the computation instead of being forced to materialize $a$ first. That can reduce numerical round-off error.

The TensorFlow pattern is:

- use a **linear activation** in the output layer, so that the network outputs $z$;
- configure binary cross-entropy with **from_logits=True**, so the sigmoid and loss are combined within the loss calculation.

A **logit** is the value $z$ before sigmoid.

## Applying the same idea to softmax

The direct softmax computation is

$$
a_j=
\frac{e^{z_j}}
{\displaystyle\sum_{k=1}^{n}e^{z_k}}
$$

followed, for the correct class $y=j$, by

$$
L=-\log a_j.
$$

Substituting the softmax expression into the loss gives

$$
L
=
-\log\left(
\frac{e^{z_j}}
{\displaystyle\sum_{k=1}^{n}e^{z_k}}
\right).
$$

Giving TensorFlow the logits $z_1,\ldots,z_n$ and the combined loss lets it rearrange this expression for more accurate numerical computation.

This matters because:

- a very negative $z_j$ makes $e^{z_j}$ extremely small;
- a very positive $z_j$ makes $e^{z_j}$ extremely large;
- avoiding unnecessary extremely small or large intermediate values reduces numerical error.

## Recommended TensorFlow structure

Use:

- a **linear** output layer that produces $z_1,\ldots,z_n$;
- **SparseCategoricalCrossentropy** with **from_logits=True**.

Conceptually, this is equivalent to a softmax output followed by sparse categorical cross-entropy. The improved form is slightly harder to read, but it is the recommended, more numerically accurate implementation.

The same recommendation applies to the logistic-regression form with binary cross-entropy, although its round-off errors are usually less severe than softmax's.

## Getting probabilities after changing the output layer

With the improved implementation, the network's final layer no longer returns probabilities $a_1,\ldots,a_n$; it returns logits $z_1,\ldots,z_n$.

To obtain class probabilities for softmax, apply

$$
a_j=
\frac{e^{z_j}}
{\sum_{k=1}^{n}e^{z_k}}.
$$

Likewise, when a binary model outputs a logit $z$, map it through the sigmoid function to obtain its probability:

$$
a=\frac{1}{1+e^{-z}}.
$$

