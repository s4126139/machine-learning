# Regularization and Bias–Variance

## How $\lambda$ changes a model

Consider a regularized fourth-degree polynomial. Its objective balances fitting the training data against keeping the weights small:

$$
J(\mathbf{w},b)
=J_{\text{train}}(\mathbf{w},b)
+\frac{\lambda}{2m}\sum_{j=1}^{n}w_j^2.
$$

The regularization parameter $\lambda$ controls that balance.

| Choice of $\lambda$ | Effect on parameters and fit | Diagnostic |
|---|---|---|
| Very large, e.g. $10{,}000$ | Strongly drives the $w_j$ values toward zero, leaving $f(x)\approx b$, nearly a constant | High $J_{\text{train}}$; high bias and underfitting |
| Zero or very small | Gives little or no penalty to a complex fourth-degree curve | Low $J_{\text{train}}$ but high $J_{\text{cv}}$; high variance and overfitting |
| Intermediate | Allows enough flexibility to fit the data without an excessively wiggly curve | Low training and CV errors; a better fit |

Thus, the same model class can move from high variance to a good fit and then to high bias as $\lambda$ increases.

## Choose $\lambda$ with cross-validation

Use a procedure analogous to choosing polynomial degree:

1. Select a range of candidate regularization values. The example begins with
   $$
   \lambda\in\{0,\ 0.01,\ 0.02,\ldots\},
   $$
   repeatedly doubling until reaching a value of roughly $10$.
2. For each candidate $\lambda_k$, minimize the regularized training objective to obtain parameters $(\mathbf{w}^{\langle k\rangle},b^{\langle k\rangle})$.
3. Evaluate each fitted model using
   $$
   J_{\text{cv}}\!\left(\mathbf{w}^{\langle k\rangle},b^{\langle k\rangle}\right).
   $$
4. Choose the $\lambda_k$ with the smallest cross-validation error. In the lesson's illustration, the fifth candidate gives the minimum.
5. After making that choice, report the test error of the selected parameters as the estimate of generalization:
   $$
   J_{\text{test}}\!\left(\mathbf{w}^{\langle 5\rangle},b^{\langle 5\rangle}\right).
   $$

Trying a broad range is important because both extremes can perform poorly for different reasons.

## Error curves as a function of $\lambda$

### Training error

As $\lambda$ increases, the algorithm puts more weight on keeping the weights small and correspondingly less emphasis on minimizing the training error. Therefore,

$$
J_{\text{train}}\ \text{tends to increase as}\ \lambda\ \text{increases}.
$$

At $\lambda=0$, the flexible fourth-degree model can fit the training set extremely well. At a very large $\lambda$, the nearly constant model fits it poorly.

### Cross-validation error

$J_{\text{cv}}$ is high at both ends:

- With very small $\lambda$, the model overfits and has high variance.
- With very large $\lambda$, the model underfits and has high bias.
- An intermediate $\lambda$ gives the lowest cross-validation error.

The cross-validation curve is therefore U-shaped as $\lambda$ increases.

## Relation to polynomial degree

The degree and regularization plots look qualitatively like mirror images:

- Increasing polynomial degree moves from high bias toward high variance.
- Increasing $\lambda$ moves from high variance toward high bias.

This resemblance is intuitive rather than a formal mathematical equivalence. In both settings, evaluating candidates on the cross-validation set provides a practical way to choose the setting with the best overall performance.
