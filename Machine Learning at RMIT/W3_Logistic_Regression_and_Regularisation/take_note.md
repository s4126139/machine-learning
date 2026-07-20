# Introduction to this week's topics
This week, we will begin our exploration of classification, one of the fundamental tasks in machine learning. A key approach to tackling classification problems is logistic regression, which builds upon the concepts of linear regression that we discussed in the previous week. Logistic regression is widely used in various real-world applications, such as spam detection, medical diagnosis, and customer segmentation.

In addition to logistic regression, we will also introduce the concept of regularization, a crucial technique in machine learning that helps prevent overfitting and improves model generalization. Regularization plays a significant role in enhancing the performance of predictive models, especially when dealing with complex datasets.

By the end of this week, you should have a strong foundational understanding of classification, be able to implement logistic regression, and appreciate the importance of regularization in machine learning models.

Links to the learning objectives
This module will contribute to:

understand the fundamental concepts and algorithms of machine learning and applications   
set up a machine learning configuration, including processing data and performing feature engineering, for a range of applications   
apply machine learning software and toolkits for diverse applications   
understand major application areas of machine learning  
 

Purpose
The material covered this week is designed to equip you with essential skills that will not only help you successfully complete Assignment 1 but also build a strong foundation for applying machine learning in a broader context.

By engaging with the concepts introduced, you will develop a deeper understanding of how machine learning models work, particularly in classification tasks. You will learn how to implement logistic regression, a fundamental technique in predictive modeling, and explore the role of regularization in improving model performance.

These skills are crucial for analyzing real-world datasets, making data-driven decisions, and optimizing machine learning models to achieve better accuracy and generalization. The knowledge gained will be valuable beyond this course, as it is widely applicable across various domains such as finance, healthcare, marketing, and artificial intelligence.

By the end of this learning module, you will be better prepared to approach Assignment 1 with confidence and have a practical understanding of how machine learning techniques are utilized in solving real-world problems.



# Slide 5-8: The order (degree) of polynomial regression

## Main idea

Polynomial regression extends a linear model by transforming the original inputs
into polynomial features. For one input variable and degree 2:

$$
h_\theta(x)=\theta_0+\theta_1x+\theta_2x^2
$$

Although the prediction is curved as a function of $x$, the model is still
**linear in its parameters** $\theta_0,\theta_1,\theta_2$. Therefore, it can be
trained using the same methods as ordinary linear regression, including gradient
descent.

The transformed dataset simply treats powers and products as new columns. For
example, $z_1=x$ and $z_2=x^2$ give:

$$
h_\theta(z)=\theta_0+\theta_1z_1+\theta_2z_2
$$

## What does the degree mean?

The degree of a term is the **sum of its exponents**. A model of degree $d$
contains polynomial terms whose total degree is at most $d$.

Examples:

- $x_1^2$ has degree 2.
- $x_1x_2$ has degree $1+1=2$.
- $x_1^2x_2$ has degree $2+1=3$.
- $x_1x_2^2$ has degree $1+2=3$.
- $x_1^2x_2^2$ has degree 4, so it is not included in a degree-3 model.

The degree is not simply the number of different variables in a product. For
example, $x_1^3$ contains only one distinct variable but has degree 3.

## Two variables with degree 2

For inputs $x_1$ and $x_2$, the complete degree-2 hypothesis is:

$$
h_\theta(x)=\theta_0+\theta_1x_1+\theta_2x_2+
\theta_3x_1^2+\theta_4x_1x_2+\theta_5x_2^2
$$

This model has five transformed input features and six parameters when the
intercept $\theta_0$ is counted.

For a single observation $(x_1,x_2)$, the transformed feature row is:

$$
\phi(x)=\begin{bmatrix}x_1 & x_2 & x_1^2 & x_2^2 & x_1x_2\end{bmatrix}
$$

Therefore, the transformed training dataset has these five input columns:

| Original/transformed feature | Meaning |
|---|---|
| $x_1$ | First original input |
| $x_2$ | Second original input |
| $x_1^2$ | Square of the first input |
| $x_2^2$ | Square of the second input |
| $x_1x_2$ | Interaction between the inputs |

The target $y$ remains unchanged. The fitted model returns six parameters:
$\theta_0,\theta_1,\ldots,\theta_5$. Here, $\theta_0$ is the intercept; it is not
another measured attribute. Some mathematical implementations represent it by
adding an all-ones column $x_0=1$ to the design matrix. Scikit-learn's
`LinearRegression` usually handles this intercept itself.

The interaction term $x_1x_2$ should normally be generated along with $x_1^2$
and $x_2^2$. It allows the effect of one variable to depend on the value of the
other. At the start of training, we generally do not know whether this term will
be useful; the model estimates its coefficient from the data.

## Two variables with degree 3

A complete degree-3 expansion adds all terms whose exponent sum is 3:

$$
x_1^3,\quad x_1^2x_2,\quad x_1x_2^2,\quad x_2^3
$$

Together with the degree-0, degree-1, and degree-2 terms, this gives ten
parameters including the intercept.

In general, for $n$ original features and maximum degree $d$, the number of
polynomial terms including the intercept is:

$$
\binom{n+d}{d}
$$

The number of transformed input columns excluding the intercept is therefore
$\binom{n+d}{d}-1$. The number grows quickly as either $n$ or $d$ increases.

## Answers to the key questions raised in class

### Should the model include $x_1x_2$?

Yes, in a standard complete degree-2 polynomial expansion. It is a valid
degree-2 interaction and cannot generally be reproduced by a linear combination
of $x_1$, $x_2$, $x_1^2$, and $x_2^2$.

However, including it does not guarantee better performance on unseen data. Its
usefulness should be evaluated using validation data, regularisation, and domain
knowledge.

### Can the coefficient of $x_1x_2$ be learned with derivatives?

Yes. Treat $x_1x_2$ as another feature column. Its gradient is calculated in the
same way as the gradient for every other coefficient, so gradient descent or
another linear-regression solver can estimate its coefficient.

### How should the maximum degree be chosen?

The maximum degree is a hyperparameter. Compare candidate degrees using a
validation set or cross-validation, then choose the degree that generalises best.
Do not select it using test-set performance, because the test set should remain
an unbiased final evaluation.

Higher degrees create a more flexible model but also introduce several risks:

- many more feature columns and coefficients;
- greater computation and memory usage;
- multicollinearity and numerical instability;
- a higher chance of overfitting;
- very different feature scales, such as $x$ versus $x^3$.

Feature scaling and regularisation (such as Ridge/L2) are often important when
using polynomial features.

## Scikit-learn workflow

Scikit-learn uses `PolynomialFeatures` to create the transformed columns, then a
linear estimator learns their coefficients. A pipeline prevents inconsistent
preprocessing between training and evaluation data:

```python
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import PolynomialFeatures

model = make_pipeline(
    PolynomialFeatures(degree=2, include_bias=False),
    LinearRegression(),
)

model.fit(X_train, y_train)
```

`PolynomialFeatures` generates powers and interaction terms; `LinearRegression`
then fits the associated coefficients. Thus, polynomial regression is linear
regression applied to a polynomially transformed feature matrix.

## Training process summarised

Polynomial regression does not require a separate optimisation algorithm. The
workflow is:

1. Choose a candidate maximum degree $d$.
2. Generate all required polynomial feature columns up to degree $d$.
3. Keep the original target values $y$.
4. Fit a linear-regression estimator to the transformed feature matrix.
5. Use gradient descent or another linear-regression solver to estimate all
   coefficients simultaneously.
6. Evaluate the full pipeline on validation data and compare it with other
   candidate degrees.

For two variables and degree 2, gradient descent learns the coefficients in:

$$
h_\theta(x)=\theta_0+\theta_1x_1+\theta_2x_2+
\theta_3x_1^2+\theta_4x_2^2+\theta_5x_1x_2
$$

The ordering of the coefficients may differ between implementations, but each
coefficient must correspond consistently to one transformed column.

## Increasing degree and model complexity -Slide 10

The lecture compares polynomial models with degrees such as 2, 4, 8, and 16.
Increasing the degree creates more polynomial and interaction features, which
makes the hypothesis more flexible and more complex.

- A degree that is too low may produce **underfitting** (high bias): the model is
  too simple to capture the pattern in the data.
- A suitable degree can capture the underlying pattern while still generalising
  to unseen observations.
- A degree that is too high may produce **overfitting** (high variance): the
  curve can follow training noise and isolated points rather than the true
  relationship.

Consequently, a lower training error at degree 8 or 16 does not automatically
mean a better model. Validation or cross-validation performance is the relevant
criterion when comparing degrees.

# Regularization 9-23

## Why regularisation becomes important

As the degree rises, the number of coefficients grows rapidly and high-order
terms can give the model excessive freedom. Regularisation controls this by
adding a penalty for large coefficient values to the training objective.

For Ridge/L2 regularisation, a common objective is:

$$
J(\theta)=\frac{1}{2m}\sum_{i=1}^{m}
\left(h_\theta(x^{(i)})-y^{(i)}\right)^2
+\frac{\lambda}{2m}\sum_{j=1}^{p}\theta_j^2
$$

where:

- $m$ is the number of training observations;
- $p$ is the number of transformed input features;
- $\lambda\geq 0$ controls the strength of regularisation;
- the intercept $\theta_0$ is normally excluded from the penalty.

Interpretation of $\lambda$:

- $\lambda=0$: no regularisation, so the model has maximum freedom;
- small $\lambda$: mild coefficient shrinkage;
- large $\lambda$: strong shrinkage, producing a simpler effective model but
  risking underfitting if the penalty is excessive.

Regularisation usually reduces coefficient magnitudes rather than removing the
polynomial columns themselves. Both the degree and $\lambda$ should be selected
using validation data or cross-validation.

Because values such as $x$, $x^2$, and $x^{16}$ can have dramatically different
scales, polynomial features should normally be standardised before applying a
regularised linear model. The transformation, scaling, and estimator should all
be placed in one pipeline to prevent data leakage.

## Detailed lecture intuition: underfitting, good fit, and overfitting

The lecture illustrates several fitted curves against an underlying “true”
curve:

- **Degree 2:** the learned curve is far from the true curve, so the model
  underfits.
- **Degree 4:** the learned and true curves are close, so this is presented as a
  good fit.
- **Degree 8 or 16:** the learned curve develops many bends and attempts to pass
  through nearly every training point, so it overfits.

The corresponding classification-style picture separates red and green points:

- a straight or overly simple boundary is likely to underfit;
- a moderately curved boundary may fit well;
- a highly irregular boundary that bends around individual observations is
  likely to overfit.

To move from underfitting toward a good fit, increase model capacity—for a
polynomial model, this can mean increasing its degree. However, a single training
dataset does not reveal in advance whether degree 2, 3, 4, or another degree will
generalise best. Candidate degrees must be compared using validation data or
cross-validation.

> **Slide follow-up:** Near the end of the class, a student noted that a graph
> labelled as degree 4 might actually depict degree 3. The lecturer said that the
> slide would be checked, so the label should not be treated as confirmed.

## How regularisation makes a high-capacity model behave more simply

The lecture compares these one-variable hypotheses:

$$
\begin{aligned}
h_2(x) &= \theta_0+\theta_1x+\theta_2x^2,\\
h_4(x) &= \theta_0+\theta_1x+\theta_2x^2+\theta_3x^3+\theta_4x^4.
\end{aligned}
$$

If $\theta_3$ and $\theta_4$ are close to zero, the contributions of $x^3$ and
$x^4$ are small. The degree-4 hypothesis then behaves approximately like the
degree-2 hypothesis. This motivates starting with a flexible feature set and
penalising coefficient magnitudes during training.

The regularised objective balances two goals:

1. reduce the difference between the ground-truth value $y^{(i)}$ and the
   prediction $h_\theta(x^{(i)})$;
2. reduce the magnitudes of the fitted coefficients.

For L2 regularisation:

$$
J(\theta)=
\underbrace{\frac{1}{2m}\sum_{i=1}^{m}
\left(h_\theta(x^{(i)})-y^{(i)}\right)^2}_{\text{data-fit term}}
+
\underbrace{\frac{\lambda}{2m}\sum_{j=1}^{p}\theta_j^2}_{\text{regularisation term}}.
$$

Squaring ensures that both positive and negative coefficients receive a
non-negative penalty. Minimising the full objective therefore trades off
prediction error against model complexity.

### Important technical clarification

Ordinary L1 or L2 regularisation penalises coefficients, not polynomial degrees
directly. It does not automatically penalise $x^4$ more strongly than $x$.
Feature scaling is essential because the numerical meaning of a coefficient
depends on its feature's scale. A high-degree model should still be compared
with lower-degree alternatives; regularisation does not eliminate the need to
tune the degree.

Also, training aims to minimise the objective, but its minimum does not normally
need to be exactly zero. Noise, irreducible error, and the regularisation penalty
can all keep the optimum above zero.

## Effect and selection of $\lambda$

$\lambda$ controls the trade-off between fitting the observations and shrinking
the coefficients:

| Value of $\lambda$ | Effect | Main risk |
|---|---|---|
| $\lambda=0$ or extremely small | Little or no penalty; the model keeps its flexibility | Overfitting |
| Moderate $\lambda$ | Shrinks coefficients while retaining useful signal | Often the desired balance |
| Extremely large $\lambda$ | Strongly shrinks coefficients toward zero | Underfitting |

If $\lambda$ is extremely large, the optimiser can reduce the penalty only by
making most penalised coefficients very small. If all $\theta_1,\ldots,\theta_p$
approach zero, the prediction becomes approximately the constant $\theta_0$,
which is an extreme underfit. The intercept is normally not penalised.

If $\lambda$ is close to zero, the regularisation term contributes very little,
so a high-capacity polynomial model may remain complex and overfit.

There is no universally best value of $\lambda$. The lecture suggests trying a
logarithmic range such as:

$$
10^{-5},10^{-4},10^{-3},10^{-2},10^{-1},1,10,10^2.
$$

This can be done manually or with an automated parameter search such as
`GridSearchCV`. The correct selection criterion is cross-validation or
validation performance—not the lowest training loss. After selecting the
hyperparameters, evaluate the final pipeline once on untouched test data.

Example:

```python
from sklearn.linear_model import Ridge
from sklearn.model_selection import GridSearchCV
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import PolynomialFeatures, StandardScaler

pipeline = make_pipeline(
    PolynomialFeatures(include_bias=False),
    StandardScaler(),
    Ridge(),
)

search = GridSearchCV(
    pipeline,
    param_grid={
        "polynomialfeatures__degree": [1, 2, 3, 4],
        "ridge__alpha": [1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1, 10, 100],
    },
    cv=5,
)
search.fit(X_train, y_train)
```

In scikit-learn, Ridge's `alpha` corresponds to the regularisation-strength
hyperparameter commonly written as $\lambda$.

## Ridge (L2) versus Lasso (L1)

The lecture introduces two regularisation penalties.

### Ridge/L2

$$
\Omega_{L2}(\theta)=\lambda\sum_{j=1}^{p}\theta_j^2
$$

Ridge typically shrinks coefficients toward zero while leaving most of them
non-zero. For example, a small coefficient $0.01$ contributes
$(0.01)^2=0.0001$ before multiplication by $\lambda$.

### Lasso/L1

$$
\Omega_{L1}(\theta)=\lambda\sum_{j=1}^{p}|\theta_j|
$$

The same coefficient $0.01$ contributes $|0.01|=0.01$. Lasso can drive some
coefficients exactly to zero. If the coefficient multiplying $x^3$ becomes zero,
that transformed feature no longer contributes to the prediction. This produces
a sparse model and performs embedded **feature selection**.

| Property | Ridge/L2 | Lasso/L1 |
|---|---|---|
| Penalty | Sum of squared coefficients | Sum of absolute coefficients |
| Typical coefficients | Small but mostly non-zero | Some can become exactly zero |
| Feature selection | Not usually | Yes, through zero coefficients |
| Behaviour with correlated features | Often shares weight | May select one and discard others |
| Differentiability at zero | Differentiable | Not differentiable at zero; solvers use subgradients or specialised optimisation |

The student's observation about $|\theta|$ not being differentiable at zero was
correct. This does not prevent Lasso from being trained; suitable optimisation
methods handle the non-smooth point.

Lasso helps identify selected features, but coefficient magnitude is not a
reliable importance comparison unless features have been placed on comparable
scales. With strongly correlated inputs, the selected feature can also be
unstable across samples.

## Models mentioned before logistic regression

By this point, the lecture has introduced:

- univariate linear regression;
- multiple linear regression;
- univariate polynomial regression;
- multivariable polynomial regression;
- Ridge/L2-regularised regression;
- Lasso/L1-regularised regression.

The lecturer connected these models to Assignment 1: develop at least two models
discussed in class and at least one model outside the class material. The exact
interpretation of what counts as a distinct model should follow the current
assignment specification and rubric.

# Logistic regression 24 - 43

## Regression versus classification

- **Regression** predicts a continuous numerical value.
- **Classification** predicts a discrete or categorical label.
- **Binary classification** has two labels, such as yes/no or 1/0.
- **Multiclass classification** has more than two labels, such as standing,
  walking, waiting, or moving.

Despite its name, logistic regression is primarily a classification model. It
models a class probability and then converts that probability into a predicted
class.

## House-price example

The lecture uses one input—the floor area—and a binary target:

$$
y=\begin{cases}
1,&\text{house price is over \$1 million},\\
0,&\text{house price is not over \$1 million}.
\end{cases}
$$

A larger floor-area observation might have label 1, while a smaller one might
have label 0. The objective is not to predict the exact house price. It is to
estimate the probability that the house belongs to the “over \$1 million” class.

For example, a prediction of $0.75$ means:

$$
P(y=1\mid x)=0.75,
$$

so the model assigns a 75% estimated probability to the house costing over
\$1 million. With a threshold of $0.5$, its predicted class is 1 (yes).

### Technical clarification

Logistic regression does not normally predict a continuous house price first and
then compare that predicted price with \$1 million. It directly learns the
probability of the binary label from the labelled examples.

## Linear score and sigmoid function

First calculate the linear score, also called the **logit**:

$$
z=\theta^Tx=\theta_0+\theta_1x_1+\cdots+\theta_px_p.
$$

This score can take any value from $-\infty$ to $+\infty$, so it cannot directly
represent a probability. Logistic regression passes it through the sigmoid
function:

$$
\sigma(z)=\frac{1}{1+e^{-z}}.
$$

The hypothesis is therefore:

$$
h_\theta(x)=\sigma(\theta^Tx)=P(y=1\mid x;\theta).
$$

Key sigmoid properties:

- $z\rightarrow+\infty$ implies $\sigma(z)\rightarrow1$;
- $z\rightarrow-\infty$ implies $\sigma(z)\rightarrow0$;
- $\sigma(0)=0.5$;
- for finite $z$, the output lies strictly between 0 and 1;
- it is continuous, smooth, and differentiable, making gradient-based
  optimisation possible.

The underlying score can contain linear, polynomial, interaction, or other
engineered features. Regularisation can also be applied to logistic regression.
Nevertheless, the estimator must use a classification loss—normally binary
cross-entropy/log loss—rather than treating the task as ordinary least-squares
regression.

## Class probabilities and complements

For binary logistic regression:

$$
P(y=1\mid x)=h_\theta(x)
$$

and

$$
P(y=0\mid x)=1-h_\theta(x).
$$

Therefore, if the probability of “price over \$1 million” is $0.75$, the
probability of “not over \$1 million” is:

$$
1-0.75=0.25.
$$

The probabilities of an event and its complement sum to 1, just like the
probabilities of rain and no rain.

## From probability to a class label

Using the conventional $0.5$ threshold:

$$
\hat y=\begin{cases}
1,&h_\theta(x)\geq0.5,\\
0,&h_\theta(x)<0.5.
\end{cases}
$$

Because the sigmoid is monotonic and $\sigma(0)=0.5$, this is equivalent to:

$$
\hat y=\begin{cases}
1,&\theta^Tx\geq0,\\
0,&\theta^Tx<0.
\end{cases}
$$

Thus, when only the final label is needed and the threshold is exactly $0.5$,
the implementation can test whether the logit $z$ is above or below zero without
explicitly calculating the sigmoid. The lecture's later phrase “greater than
one” is a transcription/speech error; the relevant logit boundary is **zero**.

This shortcut changes if a decision threshold other than $0.5$ is selected. For
a probability threshold $t$, the equivalent logit threshold is:

$$
z\geq\log\left(\frac{t}{1-t}\right).
$$

A predicted probability of $0.90$ expresses stronger model support for class 1
than $0.65$. However, it should be interpreted as a trustworthy 90% chance only
if the model's probabilities are well calibrated.

## Why logistic regression is not suitable for Assignment 1's continuous target

The Assignment 1 target was described in the lecture as a non-negative,
continuous capacity value. Direct capacity estimation is therefore a regression
task, not a binary-classification task. Logistic regression would only become
appropriate if the target were deliberately converted into categories—for
example, “capacity above a specified threshold” versus “not above it.”

The key issue is the target type, not merely that the sigmoid output lies between
zero and one.

## Multiclass logistic regression: open question for the following class

The binary formulation distinguishes only class 0 from class 1. The lecture
leaves the following question for the next week: how can logistic regression be
used when the possible labels are 0, 1, 2, and so on?

Preview of the standard solutions:

- **One-vs-Rest (OvR):** train one binary logistic model per class and choose the
  class with the strongest score/probability.
- **Multinomial logistic regression (softmax regression):** learn all classes
  jointly and use softmax to produce probabilities that sum to 1.

The original binary sigmoid model alone does not distinguish several classes,
but logistic-regression methods can be extended to solve multiclass problems.

# End-of-class summary and practical reminders

## Lecture summary

1. Polynomial regression expands the feature matrix using powers and
   interactions, then fits a model linear in its parameters.
2. Increasing polynomial degree increases capacity: too little capacity can
   underfit, while too much can overfit.
3. Regularisation encourages smaller coefficients and can reduce overfitting.
4. Ridge uses an L2 penalty; Lasso uses an L1 penalty and can perform feature
   selection.
5. Logistic regression applies the sigmoid to a linear score to estimate a
   binary-class probability and make a classification decision.
6. Multiclass logistic regression was posed as the question to continue in the
   next class.

## Assignment 1: preprocessing the test CSV

Every preprocessing operation required by the model must also be applied to the
test data. However, learned preprocessing parameters must come from the training
data only:

1. Fit imputers, encoders, scalers, polynomial transformations, feature
   selectors, and the model using the training data.
2. Apply those already-fitted transformations to validation and test inputs.
3. Never independently fit a scaler, encoder, imputer, or feature selector on
   the test CSV.
4. Preserve row order and the required output schema when producing assignment
   predictions.

A scikit-learn `Pipeline` is the safest way to ensure that the exact same fitted
preprocessing is used at training and prediction time without data leakage.

## Week 4 tutorial announcement recorded in the transcript

This announcement applied specifically to undergraduate students in Saigon;
Hanoi undergraduate and master's sessions were said to continue normally. The
speaker corrected the schedule several times. The final clarification in the
transcript was:

- the regular undergraduate tutorial was moved from **Thursday to Friday at
  2:30**, in the same room (room `1.3.6` was mentioned);
- an online Friday-morning option with the Hanoi class was mentioned for
  **10:30–12:00 via Microsoft Teams**;
- joining the master's tutorial on **Saturday morning** was also mentioned as an
  option.

One later sentence says “Saturday afternoon,” which conflicts with the earlier
and clearer “Saturday morning.” Because this is a time-sensitive announcement
with corrections inside the transcript, confirm the final schedule through the
official course channel rather than relying only on these notes.
