# Error Metrics for Skewed Datasets

## Why accuracy can be misleading

A dataset is **skewed** when the proportions of positive and negative examples are very far from 50–50.

Consider a binary classifier for a rare disease:

$$
y=
\begin{cases}
1, & \text{disease is present},\\
0, & \text{disease is absent}.
\end{cases}
$$

Suppose a trained model has 1% test error, or 99% accuracy. That sounds strong until the class distribution is considered. If only 0.5% of patients have the disease, a program that always predicts

$$
\hat y=0
$$

has 99.5% accuracy and 0.5% error. It numerically outperforms the learned classifier while never detecting a single patient who has the disease.

When comparing models with errors such as 0.5%, 1.0%, and 1.2%, the smallest classification error may therefore belong to the least useful predictor. On skewed data, accuracy alone does not reveal whether a model is making valuable positive predictions.

## Confusion matrix

Let the rare class $y=1$ be the positive class. Count predictions on a cross-validation or test set in a $2\times2$ table:

| Predicted class | Actual $y=1$ | Actual $y=0$ |
|---|---:|---:|
| $\hat y=1$ | True positive (TP) | False positive (FP) |
| $\hat y=0$ | False negative (FN) | True negative (TN) |

The names mean:

- **True positive:** predicted positive, and the example really is positive.
- **False positive:** predicted positive, but the example is actually negative.
- **False negative:** predicted negative, but the example is actually positive.
- **True negative:** predicted negative, and the example really is negative.

The lesson's 100-example illustration is:

| Predicted class | Actual $y=1$ | Actual $y=0$ |
|---|---:|---:|
| $\hat y=1$ | 15 | 5 |
| $\hat y=0$ | 10 | 70 |

There are 25 actual positive examples and 75 actual negative examples.

## Precision

Precision asks:

> Of all examples predicted as positive, what fraction actually are positive?

$$
\text{Precision}
=
\frac{\text{TP}}{\text{number predicted positive}}
=
\frac{\text{TP}}{\text{TP}+\text{FP}}.
$$

For the example:

$$
\text{Precision}
=\frac{15}{15+5}
=\frac{15}{20}
=0.75.
$$

Thus, when the algorithm predicts that a patient has the disease, it is correct 75% of the time.

## Recall

Recall asks:

> Of all examples that actually are positive, what fraction did the model correctly identify?

$$
\text{Recall}
=
\frac{\text{TP}}{\text{number actually positive}}
=
\frac{\text{TP}}{\text{TP}+\text{FN}}.
$$

For the example:

$$
\text{Recall}
=\frac{15}{15+10}
=\frac{15}{25}
=0.60.
$$

The algorithm therefore finds 60% of the patients who actually have the disease.

## Detecting an all-negative predictor

If a model always predicts $\hat y=0$, it has no true positives:

$$
\text{TP}=0
\quad\Longrightarrow\quad
\text{Recall}=0.
$$

Precision would formally be $0/0$ because the model makes no positive predictions. In practice, the lesson treats precision as 0 in this situation as well.

A model with zero precision or zero recall is not useful. Requiring both precision and recall to be reasonably high helps verify two important properties:

- positive diagnoses are often correct; and
- a meaningful fraction of truly positive patients is detected.

For rare-class problems, precision and recall therefore provide substantially more insight than overall classification accuracy.
