# Using Per-Item Features

Start with a model that learns a separate linear predictor for each user. Let
$x_i$ describe item $i$ using known attributes, such as genre, price, or
runtime. User $u$ has parameters $w_u$ and $b_u$, and the predicted preference
score is

$$
\hat y_{ui}=w_u^T x_i+b_u.
$$

The weights say which item features matter to that user. One user may prefer
short comedies while another prefers long documentaries. Fit each user's
parameters from that user's observed ratings, then use the model to score other
items.

This representation explains recommendations through known features and can
score a new item as soon as its attributes are available. Its limitation is
that it needs useful item features, and learning a separate model for every
user can be inefficient.

## Learning from known ratings

Use only pairs with a recorded rating. If $R(u,i)=1$ means user $u$ rated item
$i$, a squared-error objective can be written as

$$
J=\frac{1}{2}\sum_{u,i:R(u,i)=1}
\bigl(w_u^T x_i+b_u-y_{ui}\bigr)^2.
$$

Regularization can be added when a user has only a few ratings. Do not treat
unobserved pairs as rated examples with a score of zero; that would teach a
false preference.
