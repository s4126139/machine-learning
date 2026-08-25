# Deciding What to Try Next: Revisited

## Diagnose before choosing an intervention

Training and cross-validation errors—or, when useful, a learning curve—show whether the current algorithm is mainly suffering from high bias or high variance. That diagnosis turns a broad list of possible changes into a focused set of experiments.

For the regularized housing-price model with unacceptably large prediction errors, the six candidate actions divide into two groups:

| Action | Helps address | Why |
|---|---|---|
| Get more training examples | High variance | More examples reduce overfitting to a small training set. |
| Use a smaller feature set | High variance | Fewer features reduce the model's flexibility to fit an overly complicated function. |
| Increase $\lambda$ | High variance | Stronger regularization encourages a smoother, less complex fit. |
| Add new input features | High bias | More relevant information can let the model fit even the training set better. |
| Add polynomial features | High bias | Terms such as $x^2,x^3,x^4,\ldots$ let the model represent a more complex relationship. |
| Decrease $\lambda$ | High bias | Weaker regularization allows the training objective to place more emphasis on fitting the data. |

## Actions for high variance

High variance means that the model does much better on the training set than on the cross-validation set:

$$
J_{\text{cv}}\gg J_{\text{train}}.
$$

Two broad remedies are available.

### 1. Get more training data

An overfit model trained on a very small dataset can improve substantially when given more examples. This is different from the high-bias case, where data alone usually does not solve the problem.

### 2. Simplify the model

One way is to reduce the feature set. If the inputs include many irrelevant, redundant, or unnecessary features, the model has more freedom to fit a complex pattern that does not generalize. Removing some features is analogous to dropping higher polynomial terms from

$$
x,\ x^2,\ x^3,\ x^4,\ x^5,\ldots
$$

Another way is to increase $\lambda$. Stronger regularization discourages large weights and leads to a smoother, less wiggly function.

## Actions for high bias

High bias means that the model performs poorly even on the training set. The broad remedy is to make it more powerful or flexible.

### Add relevant features

Predicting house price from size alone may be inadequate if price also depends on number of bedrooms, number of floors, and age of the house. Until the algorithm is given that information, it may be unable to fit the training data well.

### Add polynomial features

If a straight line cannot represent the observed relationship, polynomial terms can give the model enough flexibility to improve its training fit.

### Decrease $\lambda$

Reducing regularization places less emphasis on keeping weights small and more emphasis on fitting the training examples, which can reduce bias.

## What not to do

Do not try to fix high bias by discarding training examples. A smaller dataset may be easier to fit and thus show lower training error, but its cross-validation error and overall performance will usually become worse.

## Working summary

$$
\boxed{
\begin{aligned}
\text{High variance} &\Rightarrow \text{more data or a simpler model},\\
\text{High bias} &\Rightarrow \text{a more powerful, more flexible model}.
\end{aligned}}
$$

Bias and variance are simple to state but take repeated practice to use well. During model development, repeatedly measuring which problem is dominant makes the choice of the next experiment much more systematic.
