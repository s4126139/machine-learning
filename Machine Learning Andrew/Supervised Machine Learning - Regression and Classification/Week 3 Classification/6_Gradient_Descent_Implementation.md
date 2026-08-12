# Gradient Descent Implementation for Logistic Regression

## 1. Training Objective

Training logistic regression means finding parameters $\mathbf{w}$ and $b$ that minimize the cost function:

$$
\min_{\mathbf{w},b} J(\mathbf{w},b)
$$

The model prediction for training example $i$ is:

$$
f_{\mathbf{w},b}(\mathbf{x}^{(i)})
= g\left(\mathbf{w} \cdot \mathbf{x}^{(i)} + b\right)
$$

where $g$ is the sigmoid function. Once trained, the model can estimate the probability that $y=1$ for a new input.

## 2. Gradient Descent Updates

Gradient descent repeatedly updates each parameter in the direction that reduces the cost. For every feature $j=1,\ldots,n$:

$$
w_j := w_j - \alpha\frac{\partial J(\mathbf{w},b)}{\partial w_j}
$$

The bias is updated as:

$$
b := b - \alpha\frac{\partial J(\mathbf{w},b)}{\partial b}
$$

Here, $\alpha$ is the learning rate.

## 3. Gradients for Logistic Regression

For $m$ training examples, the derivative with respect to $w_j$ is:

$$
\frac{\partial J(\mathbf{w},b)}{\partial w_j}
= \frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)x_j^{(i)}
$$

where $x_j^{(i)}$ is feature $j$ of training example $i$.

The derivative with respect to $b$ is:

$$
\frac{\partial J(\mathbf{w},b)}{\partial b}
= \frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)
$$

## 4. Use Simultaneous Updates

All gradients must be calculated using the current values of $\mathbf{w}$ and $b$ before any parameter is overwritten.

For each iteration:

1. Compute every $\frac{\partial J}{\partial w_j}$ and $\frac{\partial J}{\partial b}$.
2. Store the resulting gradients or new parameter values temporarily.
3. Update all components of $\mathbf{w}$ and $b$ simultaneously.

Updating parameters one at a time with partially updated values would implement a different algorithm.

Substituting the derivatives into the simultaneous update rules gives:

$$
w_j := w_j - \alpha\frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)x_j^{(i)}
$$

for $j=1,\ldots,n$, and:

$$
b := b - \alpha\frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)
$$

These updates are repeated until the cost converges.

## 5. Comparison with Linear Regression

The gradient formulas look identical to those used for linear regression, but the two algorithms use different prediction functions:

### Linear Regression

$$
f_{\mathbf{w},b}(\mathbf{x})
= \mathbf{w} \cdot \mathbf{x} + b
$$

### Logistic Regression

$$
f_{\mathbf{w},b}(\mathbf{x})
= g\left(\mathbf{w} \cdot \mathbf{x} + b\right)
$$

Therefore, the error term $f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}$ is computed differently, so the resulting algorithms are not the same.

## 6. Improving and Monitoring Training

### Convergence Monitoring

The same methods used for linear regression can monitor logistic regression. In particular, track $J(\mathbf{w},b)$ across iterations to confirm that it decreases and eventually levels off.

### Vectorization

A vectorized implementation can calculate predictions and gradients for many examples and parameters at once, making training faster than explicit parameter-by-parameter loops.

### Feature Scaling

Scaling features to similar ranges, such as approximately $-1$ to $1$, can help gradient descent converge faster. This is useful when features have very different numerical scales.

## 7. Optional Labs

- One lab implements the logistic-regression gradients and visualizes gradient descent using the sigmoid curve, cost contours, a three-dimensional cost surface, and a learning curve.
- Another lab demonstrates how to train a logistic regression classifier using the widely used scikit-learn library.
- The same gradient calculations will also be implemented in the week's practice lab.

## Key Takeaway

Logistic regression is trained by repeatedly computing the average prediction errors, using them to calculate the gradients of $\mathbf{w}$ and $b$, and updating all parameters simultaneously. Although its gradient formulas resemble those of linear regression, logistic regression uses sigmoid predictions and is therefore a different learning algorithm.

Together, these steps provide everything needed to implement and train an unregularized logistic regression model.
