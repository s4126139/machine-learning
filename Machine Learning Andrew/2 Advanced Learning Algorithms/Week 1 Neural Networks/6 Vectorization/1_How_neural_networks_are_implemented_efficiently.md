# How Neural Networks Are Implemented Efficiently

## Why vectorization matters

Neural networks can be implemented efficiently by expressing their computations as matrix multiplications. This **vectorization** has helped deep learning scale to very large networks.

Parallel computing hardware is particularly effective at large matrix multiplications:

- GPUs can perform these operations efficiently;
- some CPU functions are also optimized for them.

Instead of computing one neuron at a time in a Python loop, a vectorized implementation computes all activations in a layer together.

## Loop-based dense-layer implementation

The earlier dense-layer function represents the previous layer's activations as a 1D array and computes each neuron separately:

```python
def dense(a_in, W, b, g):
    units = W.shape[1]
    a_out = np.zeros(units)

    for j in range(units):
        w = W[:, j]
        z = np.dot(w, a_in) + b[j]
        a_out[j] = g(z)

    return a_out
```

The loop selects each column of $W$, computes a dot product, adds the corresponding bias, and applies the activation function.

## Vectorized dense-layer implementation

For vectorization, the quantities are represented as 2D arrays:

- $A_{\mathrm{in}}$: matrix of input activations;
- $W$: matrix whose columns are neuron weight vectors;
- $B$: row matrix of biases;
- $Z$: matrix of pre-activation values;
- $A_{\mathrm{out}}$: matrix of output activations.

The entire loop is replaced by:

$$
Z=A_{\mathrm{in}}W+B,
$$

$$
A_{\mathrm{out}}=g(Z),
$$

where $g$, the sigmoid function in this example, is applied element by element.

```python
def dense(A_in, W, B, g):
    Z = np.matmul(A_in, W) + B
    A_out = g(Z)
    return A_out
```

`np.matmul` performs the matrix multiplication. Because every quantity is a matrix, one call computes all neurons in the layer simultaneously.

For the example discussed in the lecture, the resulting layer activations are:

$$
A_{\mathrm{out}}=
\begin{bmatrix}
1 & 0 & 1
\end{bmatrix}.
$$

## Comparison

| Approach | Data representation | Core computation |
|---|---|---|
| Loop-based | Mostly 1D arrays | Repeated dot product for each neuron |
| Vectorized | 2D arrays or matrices | One matrix multiplication for the layer |

Both approaches implement the same forward-propagation calculation. The vectorized version maps naturally to the matrix-multiplication operations that modern hardware can execute efficiently.
