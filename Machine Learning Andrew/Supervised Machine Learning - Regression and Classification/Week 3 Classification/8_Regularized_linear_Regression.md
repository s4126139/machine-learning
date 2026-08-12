# Regularized Linear Regression

## 1. Regularized Training Objective

Regularized linear regression chooses parameters $\mathbf{w}$ and $b$ that minimize:

$$
J(\mathbf{w},b)
= \frac{1}{2m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)^2
+ \frac{\lambda}{2m}\sum_{j=1}^{n}w_j^2
$$

where the linear prediction is:

$$
f_{\mathbf{w},b}(\mathbf{x})
= \mathbf{w}\cdot\mathbf{x}+b
$$

The first term is the usual squared-error cost. The second term penalizes large weights, and $\lambda$ controls the strength of that penalty. As before, the bias $b$ is not regularized.

## 2. Gradient Descent with Regularization

The general gradient descent rules are unchanged. For $j=1,\ldots,n$:

$$
w_j := w_j-\alpha\frac{\partial J(\mathbf{w},b)}{\partial w_j}
$$

and:

$$
b := b-\alpha\frac{\partial J(\mathbf{w},b)}{\partial b}
$$

For the regularized cost, the gradients are:

$$
\frac{\partial J(\mathbf{w},b)}{\partial w_j}
= \frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)x_j^{(i)}
+ \frac{\lambda}{m}w_j
$$

$$
\frac{\partial J(\mathbf{w},b)}{\partial b}
= \frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)
$$

Only the $w_j$ gradient gains an additional term. The $b$ gradient stays the same because $b$ is not included in the regularization term.

## 3. Complete Parameter Updates

Substituting the gradients gives the update for each weight:

$$
w_j := w_j-\alpha
\left[
\frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)x_j^{(i)}
+ \frac{\lambda}{m}w_j
\right]
$$

for $j=1,\ldots,n$, while the bias update is:

$$
b := b-\alpha\frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)
$$

All weights and the bias must be updated simultaneously using gradients computed from the current parameter values.

These equations are all that is required to implement regularized linear regression. The remaining sections give optional mathematical intuition.

## 4. Optional Intuition: Regularization Shrinks the Weights

The weight update can be rearranged as:

$$
w_j :=
\left(1-\frac{\alpha\lambda}{m}\right)w_j
-\alpha\frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)x_j^{(i)}
$$

The second part is the usual unregularized linear-regression update. Regularization adds the factor:

$$
1-\frac{\alpha\lambda}{m}
$$

For typical positive values of $\alpha$ and $\lambda$, this factor is slightly less than $1$. For example, if:

$$
\alpha=0.01, \qquad \lambda=1, \qquad m=50
$$

then:

$$
1-\frac{\alpha\lambda}{m}
=1-\frac{0.01\times1}{50}
=0.9998
$$

Thus, the regularization component scales the previous $w_j$ by a number slightly below $1$ before the usual data-gradient contribution is applied. This adds a tendency toward smaller weights relative to the unregularized update, which is also known as **weight decay**. The complete update can still increase $|w_j|$ when the data-gradient contribution points strongly in that direction.

## 5. Optional Derivative Derivation

Starting from the regularized cost, the derivative with respect to $w_j$ is:

$$
\frac{\partial J}{\partial w_j}
= \frac{1}{2m}\sum_{i=1}^{m}
2\left(\mathbf{w}\cdot\mathbf{x}^{(i)}+b-y^{(i)}\right)x_j^{(i)}
+ \frac{\lambda}{2m}(2w_j)
$$

After cancelling the factors of $2$ and using
$f_{\mathbf{w},b}(\mathbf{x})=\mathbf{w}\cdot\mathbf{x}+b$, this becomes:

$$
\frac{\partial J}{\partial w_j}
= \frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)x_j^{(i)}
+ \frac{\lambda}{m}w_j
$$

The derivative of $\sum_{k=1}^{n}w_k^2$ with respect to one particular $w_j$ is $2w_j$; therefore, the summation over the weight index does not remain in the final derivative.

## 6. Result and Next Step

Regularized linear regression can reduce overfitting when the model has many features relative to the number of training examples. It does so by balancing fit to the training data against keeping the weights small.

The next lesson applies the same regularization idea to logistic regression.

## Key Takeaway

Regularized linear regression adds $\frac{\lambda}{m}w_j$ to each weight gradient but leaves the bias gradient unchanged. This gives gradient descent a consistent tendency toward smaller weights while it continues fitting the data.
