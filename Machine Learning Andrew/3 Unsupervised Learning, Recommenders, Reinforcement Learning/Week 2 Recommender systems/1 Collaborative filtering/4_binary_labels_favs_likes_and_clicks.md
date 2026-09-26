# Binary Labels: Favourites, Likes, and Clicks

Many systems observe implicit behavior instead of star ratings. A click,
purchase, or favourite can be represented as a positive label $y=1$. The
absence of an interaction is less certain: the person may not have seen the
item, so it is not automatically a reliable dislike.

A simple training dataset uses positive interactions and sampled unobserved
pairs as negative examples $y=0$. A logistic model can turn a user-item score
$s_{ui}$ into a probability-like value:

$$
\hat y_{ui}=\sigma(s_{ui})=\frac{1}{1+e^{-s_{ui}}}.
$$

Train it with binary cross-entropy on the selected positive and negative
examples. This learns to rank observed positive behavior above sampled
unobserved pairs, but the result depends on how the negatives were chosen.

## Keep the meaning of a label clear

“No click” may mean the item was never displayed. “Watched for most of its
duration” is stronger evidence of interest than “opened once.” Define the
interaction event carefully, and consider how exposure, ranking position, and
user activity influence it.

When negatives are sampled, keep the sampling strategy consistent between
training and evaluation. The model's output should be interpreted as a score
under that data construction, not automatically as the user's true probability
of liking an item.
