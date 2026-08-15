# The Problem of Overfitting

## 1. Two Common Modeling Problems

Linear regression and logistic regression work well for many tasks, but a model can still fail in two nearly opposite ways:

- **underfitting**: the model is too simple to capture the pattern in the training data;
- **overfitting**: the model fits the training data extremely well but performs poorly on new examples.

The following examples illustrate both problems and motivate **regularization**, a technique introduced in the next lessons to reduce overfitting.

## 2. Underfitting in Linear Regression

Consider predicting a house's price $y$ from its size $x$. A simple linear model is:

$$
f_{\mathbf{w},b}(x) = w_1x + b
$$

The straight line may fit the training data poorly because the data suggests that prices flatten as house size increases.

This is **underfitting**, also called **high bias**:

- the model cannot capture a clear pattern in the training set;
- it has a strong simplifying assumption that price is completely linear in size;
- even its performance on the training data is poor.

Here, *bias* has a specific technical meaning: failure to fit the training data adequately. This is distinct from harmful societal bias involving characteristics such as gender or ethnicity, which is also critically important to evaluate in machine-learning systems.

## 3. A Model That Is Just Right

Adding a quadratic feature gives a more flexible model:

$$
f_{\mathbf{w},b}(x) = w_1x + w_2x^2 + b
$$

This curve does not necessarily pass through every training example, but it captures the overall pattern well and is likely to make reasonable predictions for houses outside the training set.

The ability to make good predictions on examples the model has never seen is called **generalization**. A useful model should fit the training data reasonably well and generalize well to new data. This quadratic model is described as **just right** because it appears to do both.

## 4. Overfitting in Linear Regression

At the other extreme, consider a fourth-order polynomial:

$$
f_{\mathbf{w},b}(x)
= w_1x + w_2x^2 + w_3x^3 + w_4x^4 + b
$$

With five training examples, the parameters can be chosen so that the curve passes through every point exactly. Its training error, and therefore its training cost, can be zero.

Despite this perfect training fit, the curve is highly irregular. It can make implausible predictions, such as predicting that a larger house costs less than smaller houses. This is **overfitting**, also called **high variance**:

- the model fits the training data almost too well;
- it captures noise or accidental details instead of only the broader pattern;
- it is unlikely to generalize well to new examples.

The term *high variance* reflects the model's sensitivity to the training data. If one house's price changed slightly, the fitted fourth-order curve could change substantially. Training the same flexible model on slightly different datasets could therefore produce very different predictions.

## 5. The Bias-Variance Comparison

The three housing-price models illustrate a spectrum:

- **Too few features:** the linear model underfits and has high bias.
- **Appropriate flexibility:** the quadratic model is just right and should generalize well.
- **Too many features:** the fourth-order model overfits and has high variance.

This resembles the Goldilocks story: one choice is too simple, another is too complex, and the middle choice is just right. The goal is to find a model with neither high bias nor high variance.

## 6. Underfitting and Overfitting in Classification

The same ideas apply to classification. Suppose logistic regression uses:

- $x_1$: tumor size;
- $x_2$: patient age;
- $y$: whether the tumor is malignant or benign.

### Linear Boundary: Underfitting

A simple logistic regression model has:

$$
f_{\mathbf{w},b}(\mathbf{x}) = g(z),
\qquad
z = w_1x_1 + w_2x_2 + b
$$

Its decision boundary, defined by $z=0$, is a straight line. The line may separate some positive and negative examples but still fail to capture the data's pattern well. This is underfitting, or high bias.

### Quadratic Boundary: Just Right

Adding quadratic and interaction features gives:

$$
z = w_1x_1 + w_2x_2 + w_3x_1^2
+ w_4x_1x_2 + w_5x_2^2 + b
$$

The boundary $z=0$ can now resemble an ellipse. It may misclassify a few training examples, yet still capture the overall pattern and generalize well to new patients. This is the just-right case.

### High-Order Boundary: Overfitting

Adding many high-order polynomial features allows the model to create an extremely complex boundary that twists around individual training examples. It may classify the training set perfectly while making unreliable predictions for new patients.

This is overfitting, or high variance: excellent training-set performance does not guarantee good generalization.

## 7. Next Step

The next video explains ways to address overfitting and briefly discusses ideas relevant to underfitting. The lessons then develop regularization as a practical method for producing models that generalize better.

## Key Takeaway

Underfitting means a model is too simple to fit even the training data and is associated with high bias. Overfitting means a model fits the training data too closely but fails to generalize and is associated with high variance. A successful model balances the two.
