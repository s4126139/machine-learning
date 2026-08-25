# Trading Off Precision and Recall

## The ideal and the trade-off

For rare-disease diagnosis:

- **High precision** means that when the model diagnoses the disease, the diagnosis is probably correct.
- **High recall** means that when a patient truly has the disease, the model will probably detect it.

Ideally both are high, but changing the classification threshold usually improves one at the expense of the other.

Recall the definitions:

$$
P=\text{Precision}=\frac{\text{TP}}{\text{TP}+\text{FP}},
\qquad
R=\text{Recall}=\frac{\text{TP}}{\text{TP}+\text{FN}}.
$$

## Thresholding logistic-regression output

Logistic regression outputs a value $f(\mathbf{x})$ between 0 and 1. With threshold $t$:

$$
\hat y=
\begin{cases}
1, & f(\mathbf{x})\ge t,\\
0, & f(\mathbf{x})<t.
\end{cases}
$$

The same threshold must appear in both cases so that every output is assigned to exactly one class.

## Raise the threshold: higher precision, lower recall

The usual choice is $t=0.5$. Suppose a positive prediction leads to an invasive and expensive treatment, while leaving the disease untreated is not as serious. The system may predict positive only when highly confident:

$$
t=0.7 \quad\text{or even}\quad t=0.9.
$$

Raising $t$ produces fewer positive predictions:

- the remaining positive predictions are more likely to be correct, so precision rises;
- more truly positive patients are missed, so recall falls.

## Lower the threshold: lower precision, higher recall

Suppose treatment is not very invasive, painful, or expensive, while failing to treat the disease has severe consequences. A safer policy may be “when in doubt, predict positive,” using a threshold such as

$$
t=0.3.
$$

Lowering $t$ produces more positive predictions:

- some additional predictions are wrong, so precision falls;
- more truly positive patients are found, so recall rises.

The application must balance the consequences of false positives and false negatives.

## Precision–recall curve

Both precision and recall range from 0 to 1. Evaluating many thresholds produces a trade-off curve:

- near $t=0.99$: very high precision and low recall;
- as $t$ decreases: recall increases while precision decreases;
- near $t=0.01$: relatively high recall and low precision.

Plotting the pairs $(P,R)$ allows the team to select a point that reflects the application's desired balance. The best operating point is not determined by cross-validation alone; the application owner must specify which trade-off is appropriate. For many applications, the threshold is chosen manually.

## Why one combined metric can help

When comparing several algorithms, one model may have higher precision while another has higher recall. The lesson's example is:

| Algorithm | Precision $P$ | Recall $R$ | Arithmetic average |
|---|---:|---:|---:|
| 1 | 0.50 | 0.40 | 0.45 |
| 2 | 0.70 | 0.10 | 0.40 |
| 3 | 0.02 | 0.98 | 0.50 |

The ordinary average is misleading. Algorithm 3 receives the highest average even though its precision is extremely low. It may behave like a model that predicts nearly every patient as having the disease, yielding excellent recall but little diagnostic value.

## $F_1$ score

The $F_1$ score combines precision and recall while emphasizing the smaller value. It averages their reciprocals and then takes the reciprocal:

$$
F_1
=
\frac{1}
{\frac{1}{2}\left(\frac{1}{P}+\frac{1}{R}\right)}
=
\frac{2PR}{P+R}.
$$

This is also called the harmonic mean of precision and recall. If either $P$ or $R$ is very small, $F_1$ remains small rather than being dominated by the larger metric.

For the three algorithms:

| Algorithm | $F_1$ |
|---|---:|
| 1 | 0.444 |
| 2 | 0.175 |
| 3 | 0.0392 |

The combined score favors Algorithm 1 because it maintains a better balance between precision and recall.

## Main conclusions

- Increasing the classification threshold raises precision and lowers recall.
- Decreasing the threshold lowers precision and raises recall.
- Manual threshold choice should reflect the relative costs of false positives and false negatives.
- When a single comparison number is needed, $F_1$ is preferable to the arithmetic average because it strongly penalizes very low precision or very low recall.
