# Diagnosing Bias and Variance

## Why this diagnosis matters

An initial machine learning model almost never works as well as desired. The important development skill is deciding what to change next. Across many applications, comparing training and cross-validation performance gives strong guidance by revealing whether the main problem is **high bias**, **high variance**, neither, or occasionally both.

With one input feature, underfitting and overfitting may be visible in a plot:

- A straight line fitted to curved data underfits and has **high bias**.
- A fourth-degree polynomial that bends through a small training set overfits and has **high variance**.
- A quadratic polynomial may provide a good intermediate fit.

When a model uses many features, plotting $f(\mathbf{x})$ is difficult. The errors $J_{\text{train}}$ and $J_{\text{cv}}$ provide a systematic alternative.

## Characteristic error patterns

| Situation | $J_{\text{train}}$ | $J_{\text{cv}}$ | Interpretation |
|---|---:|---:|---|
| High bias / underfitting | High | High, often close to training error | The model does not even fit data it has seen. |
| High variance / overfitting | Low | High and much larger than training error | The model fits seen data but generalizes poorly. |
| Good fit | Low | Low and not much larger than training error | Neither bias nor variance is a major problem. |
| High bias and high variance | High | Even higher, with a large CV–training gap | The model underfits some aspects while also generalizing much worse than it trains. |

The two central tests are therefore:

$$
\text{high bias indicator: } J_{\text{train}}\text{ is high},
$$

$$
\text{high variance indicator: } J_{\text{cv}}\gg J_{\text{train}}.
$$

For the polynomial example:

- $d=1$: both errors are high, indicating high bias.
- $d=4$: training error is low but CV error is high, indicating high variance.
- $d=2$: both errors are relatively low, indicating a suitable fit.

## Error as model complexity changes

Assume there is no regularization and increase the polynomial degree $d$:

### Training error

$J_{\text{train}}$ usually decreases as $d$ increases. A linear model has limited ability to fit the training points, while quadratic, cubic, and higher-degree polynomials have increasing flexibility and can fit them more closely.

### Cross-validation error

$J_{\text{cv}}$ typically follows a U-shaped pattern:

1. At low degree, the model underfits, so CV error is high.
2. At an intermediate degree, the model fits the underlying pattern better, so CV error is lower.
3. At high degree, the model overfits the training data, so CV error rises again.

Thus, the low-degree region corresponds to high bias, the high-degree region corresponds to high variance, and an intermediate degree can avoid both.

## When both bias and variance are high

High bias and high variance at the same time is uncommon for a one-dimensional linear-regression example, but can occur in some neural-network applications. Conceptually, a model might fit part of the input region with an overly complicated curve while failing even to fit the training examples in another region.

The numerical signature is:

- $J_{\text{train}}$ is high relative to the desired level, showing high bias; and
- $J_{\text{cv}}$ is much higher still, showing high variance.

Most applications are dominated by one problem rather than both. In practice, repeatedly checking these two errors is a powerful way to determine whether the current model is underfitting or overfitting and to guide the next experiment.
