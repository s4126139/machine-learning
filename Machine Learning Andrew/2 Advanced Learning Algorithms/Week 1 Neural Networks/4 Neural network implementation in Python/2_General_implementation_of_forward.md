# A General Python Implementation of Forward Propagation

## From hard-coded neurons to a reusable layer

Instead of writing separate code for every neuron, define one function that computes an entire dense layer. The function receives:

- `a_in`: the activation vector from the previous layer;
- `W`: a matrix containing the weight vectors of the current layer;
- `b`: a 1D array containing the biases of the current layer;
- `g`: the activation function.

It returns the activation vector of the current layer.

## Organizing the parameters

Suppose the input has two values and the layer has three units. Stack each unit's weight vector as a column of $W$:

$$
W=
\begin{bmatrix}
\vert & \vert & \vert\\
\mathbf{w}_1 & \mathbf{w}_2 & \mathbf{w}_3\\
\vert & \vert & \vert
\end{bmatrix}.
$$

The resulting matrix has shape $2\times3$:

- two rows because each weight vector has two elements;
- three columns because the layer has three units.

The bias values are stored in a 1D array. In the example:

```python
b = np.array([-1, 1, 2])
```

Thus, column $j$ of $W$ and element $j$ of $b$ are the parameters of neuron $j$.

## The dense-layer function

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

### Line-by-line interpretation

1. `W.shape[1]` returns the number of columns in $W$, which equals the number of units in the layer.
2. `np.zeros(units)` creates the output vector and initializes every activation to zero.
3. `range(units)` iterates from $0$ through `units - 1`, following Python's zero-based indexing.
4. `W[:, j]` selects all rows of column $j$, giving the weight vector for neuron $j$.
5. The neuron computes

   $$
   z_j=\mathbf{w}_j\cdot\mathbf{a}_{\mathrm{in}}+b_j.
   $$

6. Applying $g$ produces the neuron's activation:

   $$
   a_{\mathrm{out},j}=g(z_j).
   $$

7. After every neuron has been evaluated, the function returns the complete vector $\mathbf{a}_{\mathrm{out}}$.

For the $2\times3$ example, the loop runs three times and computes three activations.

## Stringing layers together

Once `dense` has been defined, forward propagation through a four-layer network is:

```python
def sequential(x):
    a1 = dense(x,  W1, b1, g)
    a2 = dense(a1, W2, b2, g)
    a3 = dense(a2, W3, b3, g)
    a4 = dense(a3, W4, b4, g)
    f_x = a4
    return f_x
```

The data flow is:

$$
\mathbf{x}
\longrightarrow
\mathbf{a}^{[1]}
\longrightarrow
\mathbf{a}^{[2]}
\longrightarrow
\mathbf{a}^{[3]}
\longrightarrow
\mathbf{a}^{[4]}
=f(\mathbf{x}).
$$

Each call uses the previous layer's activations and the current layer's parameter matrix and bias vector.

## Capitalization convention

Linear-algebra notation conventionally uses:

- uppercase $W$ for a **matrix**;
- lowercase symbols for **vectors** and **scalars**.

Here, multiple neuron weight vectors are collected into the matrix $W$, while a selected column is the vector $\mathbf{w}$.

## Why an under-the-hood implementation is useful

Most machine learning engineers use TensorFlow, PyTorch, or another framework rather than implementing forward propagation directly. Understanding the underlying computation is still valuable when:

- code runs slowly;
- a result is unexpected;
- an implementation appears to contain a bug;
- a model does not work on the first attempt.

The reusable `dense` function exposes the exact layer-by-layer operations performed by the higher-level libraries and provides a basis for reasoning about and debugging neural-network code.
