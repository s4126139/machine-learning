# Finding Unusual Events

Anomaly detection looks for examples that are very different from the usual
ones. Typical applications include identifying a machine that may fail soon,
spotting an unusual financial transaction, or flagging a network event that
does not resemble normal traffic.

The main difficulty is that unusual events are rare and varied. We may have
many examples of normal operation but only a few known failures. A model trained
only to recognize yesterday's failures can miss a new kind of failure. Anomaly
detection instead models what normal data looks like and asks whether a new
example fits that model.

For a feature vector $x$, the model produces a score such as $p(x)$. A low
score means the example is unlikely under the learned normal-data distribution.
Choose a threshold $\epsilon$ and flag the example when

$$
p(x)<\epsilon.
$$

The score is evidence of unusualness, not a diagnosis. A low probability may
come from a sensor glitch, a valid rare event, or a real failure. Domain review
and suitable follow-up actions are still required.

## A useful training setup

Fit the model using examples believed to be normal. Keep labeled anomalous
examples for threshold selection and evaluation when possible. If the training
set contains a few anomalies, they may have little influence when the set is
large, but severe contamination can distort the model.
