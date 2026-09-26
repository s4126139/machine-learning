# Mean Normalization

A new user has no ratings, so collaborative filtering has little evidence for
their preference vector. Mean normalization gives the model a sensible default
by removing each item's average rating before fitting user preferences.

For item $i$, let $\bar y_i$ be its average over users who rated it. For each
observed rating, train on the residual

$$
y'_{ui}=y_{ui}-\bar y_i.
$$

The model predicts the residual $\hat y'_{ui}=v_u^T x_i$, then restores the
item average:

$$
\hat y_{ui}=\bar y_i+v_u^T x_i.
$$

If a user has no history, their preference vector can default to zero, so the
recommendation falls back to the item's average rating. An item that is
generally well liked can therefore rank above one with a low average even for
a new user.

Mean normalization does not solve every cold-start problem. A new item with
no ratings has no reliable item average, and a new user still has no
personalized signal. Use content features or a neutral/popularity fallback
until more data arrives.
