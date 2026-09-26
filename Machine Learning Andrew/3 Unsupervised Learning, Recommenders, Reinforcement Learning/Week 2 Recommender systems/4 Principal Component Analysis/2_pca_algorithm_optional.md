# PCA Algorithm (Optional)

Given $m$ feature vectors in $\mathbb{R}^n$, PCA finds a $k$-dimensional
subspace ($k<n$) that minimizes squared reconstruction error.

## Fit the projection

1. Compute the feature mean and subtract it from every example. Scale features
   first when their units differ.
2. Form the covariance matrix

   $$
   \Sigma=\frac{1}{m}X^TX.
   $$

3. Compute its singular value decomposition

   $$
   \Sigma=USV^T.
   $$

4. Keep the first $k$ columns of $U$, written $U_{reduce}$.

Project a centered example $x$ into the reduced space with

$$
z=U_{reduce}^T x.
$$

The approximate reconstruction is

$$
x_{approx}=U_{reduce}z.
$$

## Choose $k$

The diagonal values of $S$ measure variance along the ordered principal
components. The fraction retained by the first $k$ components is

$$
\frac{\sum_{j=1}^{k}S_{jj}}{\sum_{j=1}^{n}S_{jj}}.
$$

Choose a target such as 95% or 99%, then find the smallest $k$ that reaches it.
The right threshold depends on the cost of storage or computation versus the
loss of information. Always keep the fitted mean, scaling parameters, and
projection matrix so new examples use exactly the same transformation.
