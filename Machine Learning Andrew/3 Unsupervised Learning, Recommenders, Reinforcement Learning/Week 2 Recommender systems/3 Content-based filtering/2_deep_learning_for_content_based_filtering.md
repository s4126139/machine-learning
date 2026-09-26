# Deep Learning for Content-Based Filtering

Content-based filtering can represent both a user and an item with feature
vectors. A neural network maps each side into the same latent space:

$$
v_u=f_{\theta}(x_u),\qquad x_i=g_{\phi}(x_i^{\text{features}}).
$$

The model scores the pair using a dot product,

$$
s(u,i)=v_u^T x_i.
$$

Here $x_u$ may contain user attributes or preference history, and
$x_i^{\text{features}}$ may contain an item's known metadata. The two networks
can use different input shapes, but their outputs must have the same number
of coordinates so that the dot product is defined.

Training examples are user-item pairs with observed ratings or interactions.
The loss teaches matching users and items to receive higher scores. At
inference time, compute a user vector once and score many item vectors.

## Why use two networks?

Each network can learn a useful representation from its own feature types.
The shared output space makes the representations comparable. This approach
can generalize to a new item if its features are present, unlike a model that
relies only on an item ID.

The features and labels still determine what is learned. Poorly chosen inputs,
leakage from future behavior, or biased interaction data cannot be repaired by
adding more layers.
