# Data Representation in NumPy and TensorFlow

## Why the representation matters

NumPy became a standard Python library for linear algebra before TensorFlow was created. The two libraries consequently have some different conventions for representing data. Understanding these conventions helps prevent shape errors when implementing neural networks.

## Matrices in NumPy

A matrix is a two-dimensional array of numbers. Its dimensions are written as

$$
\text{number of rows}\times\text{number of columns}.
$$

For example, this is a $2\times3$ matrix:

$$
\begin{bmatrix}
1 & 2 & 3\\
4 & 5 & 6
\end{bmatrix}.
$$

It is stored in NumPy as:

```python
x = np.array([
    [1, 2, 3],
    [4, 5, 6]
])
```

The inner brackets define individual rows; the outer brackets group the rows into one matrix.

A matrix with four rows and two columns has shape $4\times2$. Matrices can also have shapes such as $1\times2$ or $2\times1$.

## Row matrices, column matrices, and 1D arrays

The same two values can be stored in three distinct ways:

### A $1\times2$ row matrix

```python
x = np.array([[200, 17]])
```

$$
x=
\begin{bmatrix}
200 & 17
\end{bmatrix}.
$$

This is a two-dimensional array with one row and two columns.

### A $2\times1$ column matrix

```python
x = np.array([
    [200],
    [17]
])
```

$$
x=
\begin{bmatrix}
200\\
17
\end{bmatrix}.
$$

This is a two-dimensional array with two rows and one column.

### A one-dimensional array

```python
x = np.array([200, 17])
```

This is a 1D vector. Technically, it has neither rows nor columns, even though it may be displayed vertically by convention. It is therefore not the same data structure as either a $1\times2$ or $2\times1$ matrix.

In the earlier linear- and logistic-regression material, input features were commonly represented as 1D arrays. TensorFlow conventionally uses matrices because matrix-based data representation supports efficient handling of large datasets.

For the coffee example, one input containing $200^\circ\mathrm{C}$ and $17$ minutes is represented as a $1\times2$ matrix:

```python
x = np.array([[200, 17]])
```

## TensorFlow tensors

Applying a three-unit TensorFlow layer to the $1\times2$ input gives three activations:

```python
a1 = layer_1(x)
```

For the illustrative values, TensorFlow displays a result like:

```text
tf.Tensor([[0.2, 0.7, 0.3]], shape=(1, 3), dtype=float32)
```

This tells us that:

- the data is a TensorFlow **tensor**;
- its shape is $(1,3)$, so it is a $1\times3$ matrix;
- its values use the `float32` type: floating-point numbers stored using 32 bits.

A TensorFlow tensor is a data type designed to store data and perform matrix computations efficiently. Tensors are more general than matrices, but for the purposes of this material, they can be viewed as TensorFlow's matrix representation.

## Converting a tensor to a NumPy array

Calling `.numpy()` converts a TensorFlow tensor into a NumPy array containing the same data:

```python
a1_numpy = a1.numpy()
```

For a second dense layer with one unit:

```python
a2 = layer_2(a1)
```

an illustrative output is a $1\times1$ tensor:

```text
tf.Tensor([[0.8]], shape=(1, 1), dtype=float32)
```

It can likewise be converted:

```python
a2_numpy = a2.numpy()
```

## Practical data flow

1. Data may be loaded and manipulated as NumPy arrays.
2. When a NumPy array is passed to TensorFlow, TensorFlow converts it to its internal tensor representation.
3. TensorFlow performs its computations using tensors.
4. The result may remain a tensor or be converted back to a NumPy array with `.numpy()`.

The numerical data remains the same; the important distinction is which library-specific representation and shape are being used.
