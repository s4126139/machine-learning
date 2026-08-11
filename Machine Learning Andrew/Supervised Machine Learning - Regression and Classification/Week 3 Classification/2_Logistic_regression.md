# Logistic Regression

## 1. Logistic Regression for Classification

Logistic regression is one of the most widely used classification algorithms.

Consider the tumor-classification example:

- malignant tumor: positive class, $y = 1$;
- benign tumor: negative class, $y = 0$;
- input feature $x$: tumor size.

Because this is a classification problem, the true label $y$ can only be $0$ or $1$. Linear regression is not appropriate for this task. Logistic regression instead fits an S-shaped curve and produces an output between $0$ and $1$.

For example, the model might output $0.7$ for a patient. This is not a possible value of the true label; it represents the model's estimate of how likely the tumor is to be malignant.

## 2. The Sigmoid Function

Logistic regression uses the **sigmoid function**, also called the **logistic function**:

$$
g(z) = \frac{1}{1 + e^{-z}}
$$

where:

- $z$ can be any positive or negative number;
- $e$ is the mathematical constant approximately equal to $2.718$;
- $g(z)$ always produces a value strictly between $0$ and $1$.

Here, the sigmoid graph's horizontal axis represents $z$, not the tumor-size feature $x$ from the earlier plot.

### Behavior of the Sigmoid Function

- When $z$ is a large positive number, $e^{-z}$ is very small, so $g(z)$ approaches $1$.
- When $z$ is a large negative number, $e^{-z}$ is very large, so $g(z)$ approaches $0$.
- When $z = 0$:

$$
g(0) = \frac{1}{1 + e^0} = \frac{1}{2} = 0.5
$$

These properties give the sigmoid function its characteristic S-shaped curve.

## 3. Building the Logistic Regression Model

The logistic regression model is constructed in two steps.

### Step 1: Compute a Linear Function

First, calculate:

$$
z = \mathbf{w} \cdot \mathbf{x} + b
$$

where $\mathbf{x}$ contains the input features, $\mathbf{w}$ contains the model weights, and $b$ is the bias.

### Step 2: Apply the Sigmoid Function

Pass $z$ through the sigmoid function:

$$
f_{\mathbf{w},b}(\mathbf{x}) = g(\mathbf{w} \cdot \mathbf{x} + b)
$$

Equivalently:

$$
f_{\mathbf{w},b}(\mathbf{x})
= \frac{1}{1 + e^{-(\mathbf{w} \cdot \mathbf{x} + b)}}
$$

The model accepts one or more input features and always outputs a number strictly between $0$ and $1$.

## 4. Interpreting the Model Output

The logistic regression output is interpreted as the estimated probability that the label is $1$ for a given input $\mathbf{x}$:

$$
f_{\mathbf{w},b}(\mathbf{x})
= P(y = 1 \mid \mathbf{x}; \mathbf{w}, b)
$$

In the tumor example, if:

$$
f_{\mathbf{w},b}(\mathbf{x}) = 0.7
$$

then the model estimates:

- a $70\%$ probability that $y = 1$, meaning the tumor is malignant;
- a $30\%$ probability that $y = 0$, meaning the tumor is benign.

The two probabilities must add up to $1$:

$$
P(y = 0 \mid \mathbf{x}; \mathbf{w}, b)
+ P(y = 1 \mid \mathbf{x}; \mathbf{w}, b) = 1
$$

Therefore:

$$
P(y = 0 \mid \mathbf{x}; \mathbf{w}, b)
= 1 - f_{\mathbf{w},b}(\mathbf{x})
$$

The vertical bar in the probability notation means "given," while the semicolon separates the input from the model parameters $\mathbf{w}$ and $b$.

## 5. Practical Context and Next Step

- The optional lab demonstrates how to implement and plot the sigmoid function in code.
- Historically, variations of logistic regression drove much of online advertising.
- The next lesson visualizes logistic regression and introduces the **decision boundary**, which converts outputs such as $0.3$, $0.65$, or $0.7$ into a predicted class of $0$ or $1$.

## Key Takeaway

Logistic regression applies the sigmoid function to a linear combination of the input features. Its output lies between $0$ and $1$ and can be interpreted as the estimated probability that $y = 1$.
