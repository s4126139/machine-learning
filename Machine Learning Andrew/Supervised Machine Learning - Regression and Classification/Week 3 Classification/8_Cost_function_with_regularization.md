# Cost Function with Regularization

## 1. Motivation: Make an Overfit Model Simpler

Suppose a high-order polynomial model is:

$$
f_{\mathbf{w},b}(x)
= w_1x + w_2x^2 + w_3x^3 + w_4x^4 + b
$$

This model may overfit the training data because the cubic and fourth-order terms allow a very wiggly curve.

If $w_3$ and $w_4$ are made very small, the effects of $x^3$ and $x^4$ nearly disappear. The model then behaves more like a simpler quadratic function, which may generalize better.

One way to encourage small values is to add large penalties to the cost:

$$
J(\mathbf{w},b) + 1000w_3^2 + 1000w_4^2
$$

Minimizing this modified objective strongly encourages $w_3$ and $w_4$ to remain close to zero.

## 2. Penalizing All Weights

With many features, it may not be clear in advance which parameters should be small. Regularization therefore usually penalizes every weight $w_j$ rather than selecting a few manually.

For linear regression, the regularized cost function is:

$$
J(\mathbf{w},b)
= \frac{1}{2m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)^2
+ \frac{\lambda}{2m}\sum_{j=1}^{n}w_j^2
$$

The two parts are:

1. **Data-fitting term**

   $$
   \frac{1}{2m}\sum_{i=1}^{m}
   \left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)^2
   $$

   This encourages accurate predictions on the training data.

2. **Regularization term**

   $$
   \frac{\lambda}{2m}\sum_{j=1}^{n}w_j^2
   $$

   This encourages the weights to remain small, producing a smoother and simpler model that is less prone to overfitting.

## 3. The Regularization Parameter $\lambda$

The Greek letter $\lambda$ (lambda) is the **regularization parameter**. It controls the trade-off between:

- fitting the training data well; and
- keeping the model weights small.

Like the learning rate $\alpha$, $\lambda$ is a value that must be chosen.

The factor $1/(2m)$ scales the regularization term in the same way as the squared-error term. This convention makes useful values of $\lambda$ less sensitive to changes in the training-set size $m$.

## 4. Why the Bias Is Usually Not Regularized

By convention, the penalty includes $w_1,\ldots,w_n$ but not the bias $b$:

$$
\frac{\lambda}{2m}\sum_{j=1}^{n}w_j^2
$$

Some implementations also penalize $b$, but doing so usually makes little practical difference. This course follows the more common convention of regularizing only $\mathbf{w}$.

## 5. Effect of Different $\lambda$ Values

### If $\lambda = 0$

- The regularization term disappears.
- A high-order polynomial can use large weights and fit an overly complex curve.
- The model may **overfit**.

### If $\lambda$ Is Extremely Large

- The cost heavily penalizes every $w_j$.
- The learned weights become nearly zero.
- The model becomes approximately $f_{\mathbf{w},b}(x)=b$, a horizontal line.
- The model may **underfit**.

### If $\lambda$ Is Chosen Well

- The model can retain all available features while keeping their effects under control.
- It balances training accuracy with model simplicity.
- The resulting function is more likely to generalize well.

## 6. Next Step

Later lessons discuss systematic ways to select $\lambda$. The next two videos show how regularization changes the gradient-descent updates for linear regression and logistic regression.

## Key Takeaway

Regularization adds a penalty for large weights to the original cost function. The parameter $\lambda$ controls the balance: too little regularization can lead to overfitting, while too much can lead to underfitting.
