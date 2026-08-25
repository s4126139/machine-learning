# Model Selection and Training, Cross-Validation, and Test Sets

## Why training error is insufficient

Once $\mathbf{w}$ and $b$ have been fitted to the training set, the training error can be much lower than the true **generalization error**, the average error on new examples that were not in the training set. An overfit polynomial may have nearly zero training error while generalizing poorly.

For one fixed model, performance on a separate test set is a better estimate of generalization. However, the procedure must change when the data is also being used to choose the model itself.

## The flawed two-set selection procedure

Suppose the candidate regression models are polynomials of degrees $d=1,2,\ldots,10$. Training each degree produces parameters

$$
(\mathbf{w}^{\langle 1\rangle},b^{\langle 1\rangle}),
\ldots,
(\mathbf{w}^{\langle 10\rangle},b^{\langle 10\rangle}).
$$

A tempting procedure is to compute the test error for every candidate, choose the degree with the lowest test error, and then report that same error. For example, if degree five has the lowest value, one might choose $d=5$ and report

$$
J_{\text{test}}\!\left(\mathbf{w}^{\langle 5\rangle},b^{\langle 5\rangle}\right).
$$

This estimate is overly optimistic. Although $\mathbf{w}$ and $b$ were fitted on the training data, the degree $d$ was effectively fitted using the test set. The test set therefore influenced the model and is no longer a fair, untouched estimate of generalization.

## Use three subsets

Split the data into:

| Subset | Typical share in the example | Purpose |
|---|---:|---|
| Training set | 60% | Fit model parameters such as $\mathbf{w}$ and $b$. |
| Cross-validation set | 20% | Compare candidates and choose the model. |
| Test set | 20% | Estimate generalization only after all choices are complete. |

The cross-validation set is also called the **validation set**, **development set**, or **dev set**. Its examples are denoted

$$
(\mathbf{x}_{\text{cv}}^{(1)},y_{\text{cv}}^{(1)}),\ldots,
(\mathbf{x}_{\text{cv}}^{(m_{\text{cv}})},y_{\text{cv}}^{(m_{\text{cv}})}).
$$

For squared-error regression, compute

$$
J_{\text{cv}}(\mathbf{w},b)
=
\frac{1}{2m_{\text{cv}}}
\sum_{i=1}^{m_{\text{cv}}}
\left(f_{\mathbf{w},b}(\mathbf{x}_{\text{cv}}^{(i)})-y_{\text{cv}}^{(i)}\right)^2.
$$

$J_{\text{train}}$, $J_{\text{cv}}$, and $J_{\text{test}}$ are each computed on their corresponding subset and do not include the regularization term used in the training objective.

## Correct model-selection procedure

The data flow is:

**training set → fit every candidate → cross-validation set → choose the lowest-CV-error model → test set → report final generalization estimate**

For polynomial selection:

1. Fit each degree $d=1,\ldots,10$ using only the training set.
2. Compute
   $$
   J_{\text{cv}}\!\left(\mathbf{w}^{\langle d\rangle},b^{\langle d\rangle}\right)
   $$
   for every candidate.
3. Choose the degree with the lowest cross-validation error. If degree four is lowest, select $d=4$.
4. Only after selecting the final model, report
   $$
   J_{\text{test}}\!\left(\mathbf{w}^{\langle 4\rangle},b^{\langle 4\rangle}\right)
   $$
   as the estimate of generalization error.

Neither the numerical parameters nor the model degree were selected using the test set, so the final test error remains a fair estimate rather than an optimistically biased one.

## Selecting a neural-network architecture

The same method applies when the candidates are different neural networks—for example, a small network, a somewhat larger network, and an even larger network:

1. Train each architecture on the training set, producing a separate set of parameters for each model.
2. Evaluate each on the cross-validation set. For classification, a common $J_{\text{cv}}$ is the fraction of CV examples misclassified.
3. Select the architecture with the lowest cross-validation error.
4. Evaluate that one selected network on the test set to estimate its generalization error.

## Best-practice separation of roles

While developing a learning algorithm, make decisions about parameter values, polynomial degree, neural-network architecture, and other model choices using only the training and cross-validation sets. Do not inspect the test-set results to guide development. Use the test set only after one final model has been chosen.

This separation supports both automatic model selection and a credible final estimate of performance on new data.
