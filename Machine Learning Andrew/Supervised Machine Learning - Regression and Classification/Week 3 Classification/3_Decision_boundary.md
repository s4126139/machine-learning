# Decision Boundary

## 1. From Probability to a Class Prediction

Recall that logistic regression computes:

$$
z = \mathbf{w} \cdot \mathbf{x} + b
$$

and then applies the sigmoid function:

$$
f_{\mathbf{w},b}(\mathbf{x}) = g(z)
= \frac{1}{1 + e^{-z}}
$$

The output is interpreted as the estimated probability that $y = 1$ given the input $\mathbf{x}$.

To convert this probability into a binary prediction $\hat{y}$, a common threshold is $0.5$:

$$
\hat{y} =
\begin{cases}
1, & f_{\mathbf{w},b}(\mathbf{x}) \geq 0.5 \\
0, & f_{\mathbf{w},b}(\mathbf{x}) < 0.5
\end{cases}
$$

Because the sigmoid satisfies $g(z) \geq 0.5$ when $z \geq 0$, the rule can also be written as:

$$
\hat{y} =
\begin{cases}
1, & \mathbf{w} \cdot \mathbf{x} + b \geq 0 \\
0, & \mathbf{w} \cdot \mathbf{x} + b < 0
\end{cases}
$$

## 2. Linear Decision Boundary

Consider a classification problem with two features, $x_1$ and $x_2$:

$$
z = w_1x_1 + w_2x_2 + b
$$

Suppose the parameters are:

$$
w_1 = 1, \qquad w_2 = 1, \qquad b = -3
$$

Then:

$$
z = x_1 + x_2 - 3
$$

To understand the model's predictions, consider the inputs for which the score is exactly zero. This set of inputs is called the **decision boundary**:

$$
\mathbf{w} \cdot \mathbf{x} + b = 0
$$

At the boundary, $z = 0$ and the model output is $g(0) = 0.5$. For this example, the boundary is:

$$
x_1 + x_2 - 3 = 0
$$

or equivalently:

$$
x_1 + x_2 = 3
$$

This equation defines a straight line:

- when $x_1 + x_2 \geq 3$, predict $\hat{y} = 1$;
- when $x_1 + x_2 < 3$, predict $\hat{y} = 0$.

Changing $w_1$, $w_2$, or $b$ changes the position or orientation of the line.

In general, the boundary separates the input space into two prediction regions:

- $\mathbf{w} \cdot \mathbf{x} + b \geq 0$: predict $\hat{y} = 1$;
- $\mathbf{w} \cdot \mathbf{x} + b < 0$: predict $\hat{y} = 0$.

The parameters $\mathbf{w}$ and $b$ determine the specific decision boundary.

## 3. Nonlinear Decision Boundary

Logistic regression can create nonlinear boundaries when the input includes polynomial features. Consider:

$$
z = w_1x_1^2 + w_2x_2^2 + b
$$

with:

$$
w_1 = 1, \qquad w_2 = 1, \qquad b = -1
$$

Then:

$$
z = x_1^2 + x_2^2 - 1
$$

Setting $z = 0$ gives the decision boundary:

$$
x_1^2 + x_2^2 = 1
$$

This is a circle of radius $1$ centered at the origin:

- outside or on the circle, $x_1^2 + x_2^2 \geq 1$, so predict $\hat{y} = 1$;
- inside the circle, $x_1^2 + x_2^2 < 1$, so predict $\hat{y} = 0$.

## 4. More Complex Boundaries

Adding higher-order and interaction features allows logistic regression to represent more complex boundaries. For example:

$$
z = w_1x_1 + w_2x_2 + w_3x_1^2
+ w_4x_1x_2 + w_5x_2^2 + b
$$

This quadratic feature set can produce conic boundaries such as an ellipse. Adding still higher-degree polynomial features allows the model to form more irregular curves.

In the video's illustrated complex-boundary example, the model predicts $\hat{y} = 1$ inside the shape and predicts $\hat{y} = 0$ outside it. The predicted side ultimately depends on the sign of $z$ in each region.

- With only the original features, logistic regression produces a **linear decision boundary**.
- With polynomial features, it can produce **nonlinear decision boundaries** and fit more complex datasets.

## 5. Optional Lab and Next Step

- The optional lab visualizes a decision boundary for a two-feature logistic regression model.
- The next lessons explain how to train logistic regression using a suitable cost function and gradient descent.

## Key Takeaway

A decision boundary is defined by the inputs for which the logistic regression score satisfies $\mathbf{w} \cdot \mathbf{x} + b = 0$. The selected features determine the kinds of boundary shapes the model can learn, while $\mathbf{w}$ and $b$ determine the specific boundary.
