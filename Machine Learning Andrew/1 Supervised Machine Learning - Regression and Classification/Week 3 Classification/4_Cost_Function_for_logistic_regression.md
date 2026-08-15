# Cost Function for Logistic Regression

## 1. Purpose of the Cost Function

A cost function measures how well a particular set of parameters $\mathbf{w}$ and $b$ fits the training data. Training aims to find parameter values that minimize this cost.

For a binary-classification training set:

- $m$ is the number of training examples;
- each example $\mathbf{x}^{(i)}$ contains $n$ features;
- each label $y^{(i)}$ is either $0$ or $1$;
- the logistic regression prediction is

$$
f_{\mathbf{w},b}(\mathbf{x})
= \frac{1}{1 + e^{-(\mathbf{w} \cdot \mathbf{x} + b)}}
$$

The goal is to choose $\mathbf{w}$ and $b$ so that these predictions match the training labels well.

## 2. Why Not Use Squared Error?

For linear regression, the squared-error cost is:

$$
J(\mathbf{w},b)
= \frac{1}{m}\sum_{i=1}^{m}
\frac{1}{2}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)}) - y^{(i)}\right)^2
$$

When $f_{\mathbf{w},b}$ is a linear function, this cost is convex and has a bowl-shaped surface. Gradient descent can move toward its global minimum.

If the same squared-error cost is combined with the nonlinear sigmoid function, the resulting logistic-regression cost can become non-convex. It may contain multiple local minima, making gradient descent unreliable.

Logistic regression therefore uses a different loss function that produces a convex cost surface.

## 3. Loss Versus Cost

The **loss function** measures the model's error on one training example:

$$
L\left(f_{\mathbf{w},b}(\mathbf{x}), y\right)
$$

The **cost function** measures performance over the entire training set by averaging the individual losses:

$$
J(\mathbf{w},b)
= \frac{1}{m}\sum_{i=1}^{m}
L\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)}), y^{(i)}\right)
$$

## 4. Logistic Loss Function

For binary logistic regression, the loss for one example is:

$$
L(f,y) =
\begin{cases}
-\log(f), & y = 1 \\
-\log(1-f), & y = 0
\end{cases}
$$

where $f = f_{\mathbf{w},b}(\mathbf{x})$ is the model's predicted probability that $y = 1$.

### Case 1: The True Label Is $y = 1$

The loss becomes:

$$
L(f,1) = -\log(f)
$$

- If $f$ is close to $1$, the prediction is correct and the loss is close to $0$.
- As $f$ moves toward $0$, the prediction becomes increasingly wrong and the loss grows.
- As $f \to 0$, the loss approaches infinity.

For example, if a tumor is malignant but the model assigns only a very small probability to malignancy, the model receives a large penalty.

### Case 2: The True Label Is $y = 0$

The loss becomes:

$$
L(f,0) = -\log(1-f)
$$

- If $f$ is close to $0$, the prediction is correct and the loss is close to $0$.
- As $f$ moves toward $1$, the prediction becomes increasingly wrong and the loss grows.
- As $f \to 1$, the loss approaches infinity.

For example, if a tumor is benign but the model predicts a $99.9\%$ probability of malignancy, the model receives a very large penalty.

## 5. Why Logistic Loss Works

The logistic loss has two important behaviors:

- confident correct predictions receive a very small loss;
- confident incorrect predictions receive a very large loss.

When this loss is averaged across the training set, the resulting logistic-regression cost is convex. It has no misleading local minima, so gradient descent can find the global minimum when used with an appropriate learning rate and convergence procedure.

Minimizing

$$
J(\mathbf{w},b)
= \frac{1}{m}\sum_{i=1}^{m}
L\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)}), y^{(i)}\right)
$$

therefore provides suitable values for $\mathbf{w}$ and $b$.

## 6. Optional Lab and Next Step

- The optional lab compares the non-convex squared-error surface with the smooth, convex logistic-loss surface.
- The next lesson combines the two cases of the loss into one simpler expression and develops the full logistic-regression cost function for use with gradient descent.

## Key Takeaway

Squared error is not a good match for logistic regression because it can create a non-convex cost surface. Logistic loss instead penalizes incorrect probability estimates appropriately and produces a convex cost function that can be minimized reliably.
