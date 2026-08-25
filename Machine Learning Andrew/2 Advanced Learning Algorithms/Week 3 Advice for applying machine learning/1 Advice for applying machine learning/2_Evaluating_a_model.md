# Evaluating a Model

## Why evaluation must be systematic

Consider a housing-price model that uses one input, house size $x$, and fits a fourth-degree polynomial:

$$
f_{\mathbf{w},b}(x)=w_1x+w_2x^2+w_3x^3+w_4x^4+b.
$$

With only five training examples, this model can fit the observed points extremely well while producing a very wiggly curve that is unlikely to generalize. With one input, a plot makes the problem visible. With several inputs—such as size, number of bedrooms, number of floors, and age of the house—$f$ is a function of $x_1,\ldots,x_4$ and is much harder to visualize. A numerical evaluation procedure is therefore needed.

## Split the available data

Rather than using every example to fit the parameters, divide the data into two subsets:

- **Training set:** commonly about 70–80% of the data; used to fit $\mathbf{w}$ and $b$.
- **Test set:** commonly about 20–30% of the data; kept out of training and used to evaluate the fitted model.

For the training set, use

$$
(\mathbf{x}^{(1)},y^{(1)}),\ldots,
(\mathbf{x}^{(m_{\text{train}})},y^{(m_{\text{train}})}),
$$

where $m_{\text{train}}$ is the number of training examples. For the test set, use

$$
(\mathbf{x}_{\text{test}}^{(1)},y_{\text{test}}^{(1)}),\ldots,
(\mathbf{x}_{\text{test}}^{(m_{\text{test}})},y_{\text{test}}^{(m_{\text{test}})}).
$$

In the ten-example illustration, seven examples form the training set and three form the test set.

## Regression evaluation

Fit regularized linear regression by minimizing

$$
J(\mathbf{w},b)
=
\frac{1}{2m_{\text{train}}}
\sum_{i=1}^{m_{\text{train}}}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)^2
+
\frac{\lambda}{2m_{\text{train}}}
\sum_{j=1}^{n}w_j^2.
$$

After fitting the parameters, compute the errors on the two subsets:

$$
J_{\text{train}}(\mathbf{w},b)
=
\frac{1}{2m_{\text{train}}}
\sum_{i=1}^{m_{\text{train}}}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)^2,
$$

$$
J_{\text{test}}(\mathbf{w},b)
=
\frac{1}{2m_{\text{test}}}
\sum_{i=1}^{m_{\text{test}}}
\left(f_{\mathbf{w},b}(\mathbf{x}_{\text{test}}^{(i)})-y_{\text{test}}^{(i)}\right)^2.
$$

Neither evaluation error includes the regularization term. Regularization belongs to the objective used to fit the parameters; the evaluation errors measure predictive performance on the relevant examples.

For the overfit fourth-degree model, $J_{\text{train}}$ may be zero or nearly zero, while $J_{\text{test}}$ is high. This gap reveals that fitting the training examples well does not imply good performance on new examples.

## Classification evaluation

For binary classification with logistic regression, first fit $\mathbf{w},b$ by minimizing the regularized logistic cost. The per-example logistic loss is

$$
L\!\left(f_{\mathbf{w},b}(\mathbf{x}),y\right)
=-y\log f_{\mathbf{w},b}(\mathbf{x})
-(1-y)\log\left(1-f_{\mathbf{w},b}(\mathbf{x})\right).
$$

The training and test errors can be computed as the average logistic loss on their respective subsets, again without adding the regularization term.

For classification, an even more common evaluation is the **fraction of examples misclassified**. Convert the model output into a class prediction:

$$
\hat y=
\begin{cases}
1, & f_{\mathbf{w},b}(\mathbf{x})\ge 0.5,\\
0, & f_{\mathbf{w},b}(\mathbf{x})<0.5.
\end{cases}
$$

Then

$$
J_{\text{test}}
=
\frac{\#\{\text{test examples with }\hat y\ne y\}}
{m_{\text{test}}},
\qquad
J_{\text{train}}
=
\frac{\#\{\text{training examples with }\hat y\ne y\}}
{m_{\text{train}}}.
$$

For handwritten digits labeled 0 or 1, these quantities count both zeros classified as ones and ones classified as zeros.

## Main conclusion

Splitting data into separate training and test sets provides a systematic way to measure:

- how well the model fits examples used for learning, through $J_{\text{train}}$; and
- how well it performs on unseen examples, through $J_{\text{test}}$.

This is sufficient for evaluating one fixed model. Choosing among several models requires one additional refinement so that the test set remains an unbiased final check.
