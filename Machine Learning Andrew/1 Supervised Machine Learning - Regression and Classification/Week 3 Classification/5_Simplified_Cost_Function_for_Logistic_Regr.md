# Simplified Cost Function for Logistic Regression

## 1. Review of the Logistic Loss

For binary classification, the target label can only be $y = 0$ or $y = 1$. The logistic loss for one training example was previously written as:

$$
L(f,y) =
\begin{cases}
-\log(f), & y = 1 \\
-\log(1-f), & y = 0
\end{cases}
$$

where:

$$
f = f_{\mathbf{w},b}(\mathbf{x})
$$

is the model's predicted probability that $y = 1$.

## 2. Simplifying the Loss Function

Because $y$ is binary, the two cases can be combined into one expression:

$$
L(f,y)
= -y\log(f) - (1-y)\log(1-f)
$$

### When $y = 1$

Substituting $y = 1$ gives:

$$
L(f,1)
= -(1)\log(f) - (1-1)\log(1-f)
= -\log(f)
$$

The second term disappears because $1-y=0$.

### When $y = 0$

Substituting $y = 0$ gives:

$$
L(f,0)
= -(0)\log(f) - (1-0)\log(1-f)
= -\log(1-f)
$$

The first term disappears because $y=0$.

Therefore, the single expression reproduces the correct loss for both possible labels without requiring separate cases.

## 3. Cost Over the Training Set

The cost function is the average loss across all $m$ training examples:

$$
J(\mathbf{w},b)
= \frac{1}{m}\sum_{i=1}^{m}
L\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)}), y^{(i)}\right)
$$

Substituting the simplified loss gives:

$$
J(\mathbf{w},b)
= -\frac{1}{m}\sum_{i=1}^{m}
\left[
y^{(i)}\log\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})\right)
+ \left(1-y^{(i)}\right)
\log\left(1-f_{\mathbf{w},b}(\mathbf{x}^{(i)})\right)
\right]
$$

This is the standard cost function used to train binary logistic regression.

## 4. Why This Cost Function?

The logistic-regression cost function is derived from the statistical principle of **maximum likelihood estimation**. Minimizing this mean negative log-likelihood is equivalent to selecting parameters that make the observed training labels as likely as possible under the model.

This cost function is also convex with respect to $\mathbf{w}$ and $b$. It has no misleading local minima, making it suitable for optimization with gradient descent.

The detailed derivation from maximum likelihood is beyond the scope of this lesson; the important point is that it provides a statistical justification for the chosen cost function.

## 5. Optional Lab and Next Step

- The optional lab shows how to implement the logistic cost function in code.
- It compares different parameter choices and demonstrates that a better-fitting decision boundary produces a lower cost.
- The next lesson applies gradient descent to minimize this cost and learn $\mathbf{w}$ and $b$.

## Key Takeaway

For binary labels, the two-case logistic loss can be written as one expression:

$$
L(f,y) = -y\log(f) - (1-y)\log(1-f)
$$

Averaging this loss across the training set produces the standard convex cost function used to train logistic regression.
