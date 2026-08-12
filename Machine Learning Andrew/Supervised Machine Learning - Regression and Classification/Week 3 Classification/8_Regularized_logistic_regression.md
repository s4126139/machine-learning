# Regularized Logistic Regression

## 1. Why Logistic Regression Needs Regularization

Logistic regression can overfit when it uses many features. For example, a high-order polynomial passed through the sigmoid function may create an unnecessarily complex decision boundary that follows the training examples too closely.

Regularization is applied almost exactly as it is in linear regression: the cost receives the same penalty, and the gradient equations have the same form. The key difference is that logistic regression computes $f_{\mathbf{w},b}$ with the sigmoid function rather than a linear function.

The model is:

$$
f_{\mathbf{w},b}(\mathbf{x})
= g(z)
= \frac{1}{1+e^{-z}},
\qquad
z=\mathbf{w}\cdot\mathbf{x}+b
$$

Here, the components of $\mathbf{x}$ may include polynomial or other engineered features. Regularization allows the model to retain these features while discouraging the large weights that often produce overly complex boundaries.

## 2. Regularized Logistic Cost

The unregularized logistic-regression cost is augmented with the same penalty used for linear regression:

$$
J(\mathbf{w},b)
= -\frac{1}{m}\sum_{i=1}^{m}
\left[
y^{(i)}\log\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})\right)
+\left(1-y^{(i)}\right)
\log\left(1-f_{\mathbf{w},b}(\mathbf{x}^{(i)})\right)
\right]
+\frac{\lambda}{2m}\sum_{j=1}^{n}w_j^2
$$

Minimizing this cost penalizes large values of $w_1,\ldots,w_n$. Even with many polynomial features, keeping the weights smaller can produce a simpler, more reasonable decision boundary that generalizes better to new examples.

The parameter $b$ is not regularized.

## 3. Gradient Descent Updates

As before, gradient descent performs simultaneous updates. For $j=1,\ldots,n$:

$$
w_j := w_j-\alpha\frac{\partial J(\mathbf{w},b)}{\partial w_j}
$$

and:

$$
b := b-\alpha\frac{\partial J(\mathbf{w},b)}{\partial b}
$$

For regularized logistic regression, the gradients are:

$$
\frac{\partial J(\mathbf{w},b)}{\partial w_j}
=\frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)x_j^{(i)}
+\frac{\lambda}{m}w_j
$$

$$
\frac{\partial J(\mathbf{w},b)}{\partial b}
=\frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)
$$

Therefore, the complete updates are:

$$
w_j := w_j-\alpha
\left[
\frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)x_j^{(i)}
+\frac{\lambda}{m}w_j
\right]
$$

$$
b := b-\alpha\frac{1}{m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)
$$

Regularization changes only the $w_j$ updates. The bias update remains unchanged because the cost does not penalize $b$.

## 4. Comparison with Regularized Linear Regression

The gradient equations have the same form as those for regularized linear regression. The algorithms are still different because they use different prediction functions:

### Linear Regression

$$
f_{\mathbf{w},b}(\mathbf{x})
=\mathbf{w}\cdot\mathbf{x}+b
$$

### Logistic Regression

$$
f_{\mathbf{w},b}(\mathbf{x})
=g\left(\mathbf{w}\cdot\mathbf{x}+b\right)
$$

Thus, the error term $f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}$ is calculated from sigmoid probabilities in logistic regression.

## 5. Final Optional Lab

- The final optional lab revisits the regression and classification overfitting examples.
- Its interactive plot allows regularization to be enabled by selecting a value for $\lambda$.
- The lab shows regularized gradient descent for both linear and logistic regression.
- The regularized logistic-regression code is especially important because the week's practice lab asks you to implement it.

## 6. Course 1 Completion and Next Step

Linear regression and logistic regression are already sufficient to build many valuable machine-learning applications. Knowing how to recognize and reduce overfitting is as important in practice as knowing the algorithms themselves.

This lesson completes Week 3 and Course 1. The remaining practice labs and quizzes provide an opportunity to consolidate the implementation skills from the course.

Course 2 introduces neural networks, also called deep learning algorithms. Neural networks build directly on ideas already developed here, including cost functions, gradient descent, and sigmoid functions, and they support applications such as speech recognition, image recognition, and self-driving systems.

## Key Takeaway

Regularized logistic regression adds $\frac{\lambda}{m}w_j$ to every weight gradient while leaving the bias gradient unchanged. This discourages overly large weights and helps complex classification models produce simpler decision boundaries that generalize better.
