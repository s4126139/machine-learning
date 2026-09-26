# Finding Related Items

After collaborative filtering learns item vectors, similar items can be found
by comparing those vectors. Items that receive similar patterns of ratings
often end up near each other in the learned representation, even if they do
not share an obvious hand-coded category.

For item vectors $x_i$ and $x_j$, cosine similarity is

$$
\operatorname{sim}(i,j)=
\frac{x_i^T x_j}{\|x_i\|\,\|x_j\|}.
$$

It is near 1 when the vectors point in similar directions, near 0 when they
are nearly perpendicular, and negative when they point in opposing directions.
Rank candidate items by similarity and exclude the query item itself.

Euclidean distance can also be used, but it is affected by vector magnitude.
Cosine similarity focuses on direction. Choose the measure that matches how
the embeddings are used and validate that the retrieved neighbors make sense.

This is different from finding items with identical metadata. A learned
embedding reflects behavior in the training data, so two films from different
genres can still be related if users tend to rate them similarly. Sparse data,
popularity effects, or feedback loops can also make neighbors misleading.
