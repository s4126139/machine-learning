# Matrix Multiplication Code for Vectorized Forward Propagation

## Transpose and matrix multiplication in NumPy

Given a NumPy matrix $A$, its transpose can be written explicitly as another array, but NumPy provides a direct transpose operation:

```python
AT = A.T
```

The matrix product

$$
Z=A^TW
$$

is computed with:

```python
Z = np.matmul(AT, W)
```

Python also supports the equivalent `@` operator:

```python
Z = AT @ W
```

Both expressions perform the same multiplication. The course uses `np.matmul` because it states the operation more explicitly.

## Vectorizing one neural-network layer

For the coffee-roasting example, one input is stored as a $1\times2$ row matrix:

$$
A_{\mathrm{in}}
=
\begin{bmatrix}
200 & 17
\end{bmatrix}.
$$

The three neuron weight vectors are stacked as columns of a $2\times3$ matrix:

$$
W=
\begin{bmatrix}
1 & -3 & 5\\
-2 & 4 & -6
\end{bmatrix}.
$$

The three biases form a $1\times3$ row matrix:

$$
B=
\begin{bmatrix}
-1 & 1 & 2
\end{bmatrix}.
$$

The pre-activation matrix is:

$$
Z=A_{\mathrm{in}}W+B.
$$

Each element still corresponds to the familiar computation for one neuron:

$$
\begin{aligned}
z_1^{[1]}&=(200)(1)+(17)(-2)-1=165,\\
z_2^{[1]}&=(200)(-3)+(17)(4)+1=-531,\\
z_3^{[1]}&=(200)(5)+(17)(-6)+2=900.
\end{aligned}
$$

Therefore,

$$
Z=
\begin{bmatrix}
165 & -531 & 900
\end{bmatrix}.
$$

Applying the sigmoid function element by element gives:

$$
A_{\mathrm{out}}
=g(Z)
\approx
\begin{bmatrix}
1 & 0 & 1
\end{bmatrix}.
$$

The sigmoid of $165$ and $900$ is so close to $1$, and the sigmoid of $-531$ is so close to $0$, that they appear as $1,0,1$ at the displayed numerical precision.

## NumPy implementation

```python
A_in = np.array([[200, 17]])

W = np.array([
    [1, -3,  5],
    [-2, 4, -6]
])

B = np.array([[-1, 1, 2]])

Z = np.matmul(A_in, W) + B
A_out = g(Z)
```

The reusable dense-layer function is:

```python
def dense(A_in, W, B, g):
    Z = np.matmul(A_in, W) + B
    A_out = g(Z)
    return A_out
```

TensorFlow conventionally places individual examples in the rows of the input matrix. For that reason, the implementation calls the row-oriented input `A_in` rather than `A^T`, even though the matrix multiplication follows the same row-by-column logic.

## Why this is efficient

The vectorized code replaces a loop over neurons with:

1. one matrix multiplication;
2. one bias addition;
3. one element-wise activation.

Modern computers execute matrix multiplications efficiently, so this short implementation provides a substantial speed improvement while computing the same activations as the neuron-by-neuron version.
