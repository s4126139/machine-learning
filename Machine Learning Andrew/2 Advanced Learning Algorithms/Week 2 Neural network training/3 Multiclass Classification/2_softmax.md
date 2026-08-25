# Softmax Regression

Softmax regression generalizes logistic regression from two output classes to more than two.

## Reframing logistic regression

For binary classification, logistic regression computes

$$
z=w\cdot x+b,
\qquad
a_1=g(z)=\frac{1}{1+e^{-z}},
$$

where

$$
a_1=P(y=1\mid x).
$$

Because the probabilities must add to one,

$$
a_2=1-a_1=P(y=0\mid x),
\qquad
a_1+a_2=1.
$$

For example, if $P(y=1\mid x)=0.71$, then $P(y=0\mid x)=0.29$.

This two-probability view prepares the generalization to softmax.

## Four-class softmax

Suppose $y\in\{1,2,3,4\}$. Softmax regression has parameters

$$
w_1,w_2,w_3,w_4
\qquad\text{and}\qquad
b_1,b_2,b_3,b_4.
$$

First compute one score for each class:

$$
z_j=w_j\cdot x+b_j,
\qquad j=1,2,3,4.
$$

Then convert the four scores into probabilities:

$$
a_j=
\frac{e^{z_j}}
{e^{z_1}+e^{z_2}+e^{z_3}+e^{z_4}},
\qquad j=1,2,3,4.
$$

Each activation has a probability interpretation:

$$
a_j=P(y=j\mid x).
$$

All four probabilities share the same denominator and therefore satisfy

$$
a_1+a_2+a_3+a_4=1.
$$

For example, if

$$
a_1=0.30,\qquad a_2=0.20,\qquad a_3=0.15,
$$

then

$$
a_4=1-0.30-0.20-0.15=0.35.
$$

## General softmax formula

If the target has $n$ possible labels,

$$
y\in\{1,2,\ldots,n\},
$$

softmax computes

$$
z_j=w_j\cdot x+b_j
$$

and

$$
a_j=
\frac{e^{z_j}}
{\displaystyle\sum_{k=1}^{n}e^{z_k}},
\qquad j=1,\ldots,n.
$$

Here:

- $j$ identifies the specific class whose probability is being calculated;
- $k$ is the index used in the denominator's summation;
- $a_j$ estimates $P(y=j\mid x)$;
- by construction, $\sum_{j=1}^{n}a_j=1$.

When $n=2$, softmax reduces to essentially the same model as logistic regression, although the parameterization is slightly different. This is why it is considered a generalization of logistic regression.

## Loss function

### Logistic-regression form

Using $a_1=P(y=1\mid x)$ and $a_2=P(y=0\mid x)$, the binary loss can be rewritten as

$$
L=-y\log a_1-(1-y)\log a_2.
$$

Therefore:

- if $y=1$, then $L=-\log a_1$;
- if $y=0$, then $L=-\log a_2$.

### Softmax form

For softmax, if the correct class is $y=j$, define

$$
L(a_1,\ldots,a_n,y)=-\log a_j.
$$

Equivalently,

$$
L=
\begin{cases}
-\log a_1, & y=1,\\
-\log a_2, & y=2,\\
\vdots\\
-\log a_n, & y=n.
\end{cases}
$$

Only the probability assigned to the actual class contributes to the loss for that training example. If $y=2$, for instance, the loss is $-\log a_2$, not a sum of all the negative-log terms.

The behavior of $-\log a_j$ gives the intended incentive:

- when the model assigns the correct class a probability close to 1, the loss is small;
- as that probability becomes smaller, the loss becomes larger.

The cost over a training set of $m$ examples is the average loss:

$$
J(W,B)=\frac{1}{m}\sum_{i=1}^{m}L^{(i)}.
$$

Training chooses the parameters $w_1,\ldots,w_n,b_1,\ldots,b_n$ so that the model assigns high probability to the correct class across the training set.

