# Collaborative Filtering Algorithm

Collaborative filtering learns item and user representations from the rating
matrix itself instead of requiring hand-designed item features. For each item
$i$, learn a vector $x_i\in\mathbb{R}^d$. For each user $u$, learn a preference
vector $v_u\in\mathbb{R}^d$. Their predicted rating is the dot product

$$
\hat y_{ui}=v_u^T x_i.
$$

If a user's preferences align with an item's learned features, the dot product
is large. The coordinates do not need human-readable names; the training
process discovers dimensions that help predict observed ratings.

Train using only known user-item pairs. A regularized objective is

$$
J=\frac{1}{2}\sum_{(u,i)\in\mathcal{R}}
\bigl(v_u^Tx_i-y_{ui}\bigr)^2
+\frac{\lambda}{2}\left(\sum_u\|v_u\|^2+\sum_i\|x_i\|^2\right),
$$

where $\mathcal{R}$ is the set of observed ratings. The regularization term
discourages extremely large vectors, which can overfit a small number of
ratings.

The vectors are learned jointly: item vectors improve as they see ratings from
many users, and user vectors improve as they see ratings for many items. This
sharing is the “collaborative” part of the method.

## Cold-start limit

A brand-new user or item has no interaction history, so its vector is not yet
well learned. Content features, onboarding questions, or popularity-based
fallbacks can help until interactions accumulate.
