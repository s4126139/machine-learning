# PCA in Code (Optional)

In NumPy, `numpy.linalg.svd` computes the SVD of the covariance matrix. If
`U, S, Vt = np.linalg.svd(covariance)`, the columns of `U` are ordered
principal directions. Keep `U[:, :k]` and project centered examples with a
matrix multiplication.

```python
mean = X_train.mean(axis=0)
X_centered = X_train - mean
covariance = X_centered.T @ X_centered / len(X_centered)
U, singular_values, Vt = np.linalg.svd(covariance)
U_reduce = U[:, :k]
Z_train = X_centered @ U_reduce
```

For data with very different feature scales, divide centered features by
training-set standard deviations before computing the covariance. Store those
scales and reuse them on validation, test, and future examples.

## Common mistakes

- Projecting uncentered data shifts the coordinates and changes the result.
- Choosing $k$ from validation or test variance leaks information into the
  transformation; fit the projection on training data.
- Forgetting the mean or scaling at inference time produces incompatible
  coordinates.
- Reducing to fewer dimensions is lossy. Check reconstruction or downstream
  performance before deciding that the reduction is useful.

The optional lab demonstrates the reduced coordinates on a dataset with many
features. PCA is useful for a two-dimensional plot, but overlapping clusters
in that projection may still be separated in dimensions that were discarded.
