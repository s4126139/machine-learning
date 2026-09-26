# Developing and Evaluating an Anomaly Detection System

An anomaly detector is trained mostly on normal examples, but it still needs
an evaluation set that includes both normal and anomalous cases. The labeled
examples let us choose a useful threshold and estimate how the system behaves
in practice.

## Split the data by purpose

- **Training set:** fit the Gaussian parameters using normal examples.
- **Validation set:** include normal and anomalous examples; choose the
  threshold $\epsilon$ and compare feature choices.
- **Test set:** include both classes and use it once for an unbiased final
  estimate.

The split is different from a standard balanced classification problem because
the positive class is rare. Put known anomalies into validation and test data
even if they are excluded from training.

## Choose a threshold with classification metrics

For each candidate $\epsilon$, convert scores to predictions and count true
positives, false positives, and false negatives. Then compute

$$
\text{precision}=\frac{TP}{TP+FP},\qquad
\text{recall}=\frac{TP}{TP+FN},
$$

and use the F1 score to balance precision and recall:

$$
F_1=2\frac{\text{precision}\cdot\text{recall}}
{\text{precision}+\text{recall}}.
$$

Pick the threshold using validation data, not the test set. The business cost
of missed failures versus unnecessary inspections may favor a different
precision-recall balance, so metrics should support the actual decision.

Do not judge performance by accuracy alone. If only one example in a thousand
is anomalous, predicting “normal” every time gives 99.9% accuracy while finding
no failures.
