# TensorFlow Implementation of Content-Based Filtering

Implement two neural networks: one maps user features to a user vector, and
the other maps item features to an item vector. Their output dimension $d$
must match. For a batch of user-item pairs, the prediction is the row-wise dot
product:

$$
\hat y_{ui}=\sum_{k=1}^{d}v_{u,k}x_{i,k}.
$$

TensorFlow's `tf.reduce_sum(user_vectors * item_vectors, axis=1)` expresses
this for a batch. Train the towers jointly so that the predicted scores match
the observed targets. Include regularization where needed and use a validation
split to detect overfitting.

## Implementation checks

1. Normalize numeric input features using statistics fitted on the training
   set; apply the same transformation to validation and future data.
2. Verify that the user and item networks return shapes `(batch_size, d)`.
3. Check that each training row pairs the correct user, item, and label.
4. Compare training and validation loss and inspect sample predictions.
5. Keep feature transformations and model weights together for inference.

The final system can precompute item vectors and compare them with a user's
vector. Large catalogues usually add a retrieval index and a ranking stage;
the training notebook demonstrates the scoring model, not the entire serving
system.
