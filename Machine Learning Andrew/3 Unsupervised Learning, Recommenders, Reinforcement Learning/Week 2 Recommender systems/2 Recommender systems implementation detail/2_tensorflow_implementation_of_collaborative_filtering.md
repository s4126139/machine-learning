# TensorFlow Implementation of Collaborative Filtering

The model needs one trainable vector for every user and every item. TensorFlow
can store these as embedding matrices: row $u$ is user vector $v_u$, and row
$i$ is item vector $x_i$. For a batch of observed pairs, gather the two rows
and compute their dot products.

For batch index arrays `user_ids` and `item_ids`, the core calculation is
conceptually:

```python
user_vectors = user_embeddings(user_ids)
item_vectors = item_embeddings(item_ids)
scores = tf.reduce_sum(user_vectors * item_vectors, axis=1)
```

Train the scores against only observed ratings. Use regularization on the
embedding values so users or items with little data do not acquire extreme
vectors. An optimizer such as Adam updates both embedding tables from the same
loss.

## Shape checks

If a batch has $B$ pairs and the embedding dimension is $d$, both gathered
arrays have shape $(B,d)$ and the per-example score has shape $(B,)$. Shape
errors often arise from mixing a scalar ID, a one-element batch, and a full
vector of IDs.

Before training, verify that IDs are zero-based and inside their embedding
table, that the target and score arrays have matching batch shape, and that
the loss uses the intended ratings. Separate train and validation pairs so
that held-out ratings are not used for gradient updates.
