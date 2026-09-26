# Anomaly Detection vs. Supervised Learning

Both methods can identify failures or fraud, but they need different training
data and make different assumptions.

| Situation | Usually a better starting point | Why |
| --- | --- | --- |
| Very few labeled anomalies; new failure types may appear | Anomaly detection | Learn normal behavior and flag examples that do not fit |
| Many labeled normal and anomalous examples | Supervised classification | Learn directly from examples of both classes |
| Known categories recur and labels are reliable | Supervised classification | The model can learn the specific known categories |
| Positive labels are extremely rare or incomplete | Anomaly detection | It does not need a representative list of every anomaly |

Anomaly detection is not automatically better whenever the classes are
imbalanced. If there are enough positive examples to cover the important
failure types, a classifier can learn the decision boundary directly. The
key question is whether the labeled positive set represents the events the
system must catch.

In an anomaly detector, the model estimates the distribution of normal
examples. In supervised learning, the model uses both labels to estimate
something like $P(y=1\mid x)$. These scores have different meanings and should
not be compared as if they were interchangeable probabilities.

It is common to use both: a classifier for known problems and an anomaly score
to surface new or poorly represented behavior for review.
