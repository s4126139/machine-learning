# Classification: Motivation

## 1. From Regression to Classification

- **Linear regression** predicts a number from a continuous range of possible values.
- **Classification** predicts one of a small number of possible categories.
- Linear regression is generally not suitable for classification, so a different algorithm, **logistic regression**, is needed.

## 2. Examples of Classification Problems

- Is an email **spam** or **not spam**?
- Is an online financial transaction **fraudulent** or **legitimate**?
- Is a tumor **malignant** or **benign**?

Each example has only two possible outputs.

## 3. Binary Classification

- A classification problem with two possible classes or categories is called **binary classification**.
- The terms *class* and *category* are often used interchangeably.
- The two classes can be represented as:
  - no or yes;
  - false or true; or
  - $0$ or $1$.
- Machine-learning algorithms commonly use $0$ and $1$ as the values of the target variable $y$:
  - $y = 0$: false or no;
  - $y = 1$: true or yes.

## 4. Negative and Positive Classes

- The class represented by $0$ is commonly called the **negative class**.
- The class represented by $1$ is commonly called the **positive class**.

For spam detection:

- not spam: negative example ($y = 0$);
- spam: positive example ($y = 1$).

Here, *negative* and *positive* do not mean bad and good. They usually indicate the **absence** or **presence** of the property being detected.

The choice of which class is $0$ and which is $1$ can be somewhat arbitrary. Different engineers may encode the same problem differently, provided the meaning of each label is defined and used consistently.

## 5. Why Linear Regression Is Not Suitable

Consider a dataset that uses tumor size to predict whether a tumor is:

- benign: $y = 0$;
- malignant: $y = 1$.

### Initial Attempt

1. Fit a straight line to the training examples using linear regression.
2. Choose a threshold such as $0.5$.
3. Convert the numerical prediction into a class:
   - if $f(x) < 0.5$, predict $y = 0$;
   - if $f(x) \geq 0.5$, predict $y = 1$.

For a particular dataset, this may appear to produce a reasonable dividing point between benign and malignant tumors.

### The Problem

- Linear regression can predict values below $0$, above $1$, or anywhere in between, even though the required outputs are only $0$ and $1$.
- Adding one new example with a very large tumor can shift the best-fit line substantially.
- The point where the line crosses the $0.5$ threshold then moves to the right.
- As a result, tumors that were previously classified correctly as malignant may now be classified as benign.
- The new example should reinforce that large tumors are malignant, but linear regression can instead produce a worse classifier.

The input value where the predicted class changes is called the **decision boundary**. In this one-feature example, it is shown as a vertical line. With linear regression, this boundary can move in undesirable ways when new training examples are added.

## 6. Motivation for Logistic Regression

- **Logistic regression** is designed for binary classification problems where $y$ is either $0$ or $1$.
- Its output is always between $0$ and $1$.
- It avoids the classification problems caused by fitting and thresholding a linear-regression model.
- Despite its historical name, logistic regression is a **classification** algorithm, not a regression algorithm.

## 7. Optional Lab and Next Step

- The optional lab demonstrates interactively that linear regression may sometimes appear to classify data correctly but often performs poorly.
- The next video introduces logistic regression for classification and examines its decision boundary.

## Key Takeaway

Linear regression may occasionally appear to work for classification, but it is unreliable. Logistic regression is the appropriate algorithm for binary classification.
