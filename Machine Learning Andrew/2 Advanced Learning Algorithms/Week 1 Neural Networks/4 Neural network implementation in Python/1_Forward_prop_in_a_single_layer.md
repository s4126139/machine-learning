# Forward Propagation in a Single Layer with Python

## Goal and representation

Implementing forward propagation directly in Python reveals what libraries such as TensorFlow and PyTorch do underneath. The coffee-roasting network is used again, and all vectors and parameters in this implementation are represented as **one-dimensional NumPy arrays**.

The input is therefore written with one pair of brackets:

```python
x = np.array([200, 17])
```

This is a 1D array, not the 2D $1\times2$ matrix used in the TensorFlow example.

## Notation in variable names

The mathematical activation of neuron $j$ in layer $l$,

$$
a_j^{[l]},
$$

is represented in Python as `al_j`. For example:

| Mathematical symbol | Python variable |
|---|---|
| $\mathbf{w}_1^{[1]}$ | `w1_1` |
| $b_1^{[1]}$ | `b1_1` |
| $z_1^{[1]}$ | `z1_1` |
| $a_1^{[1]}$ | `a1_1` |
| $\mathbf{w}_1^{[2]}$ | `w2_1` |
| $a_1^{[2]}$ | `a2_1` |

The number before the underscore identifies the layer; the number after it identifies the neuron.

## Computing the first hidden layer

For each hidden neuron:

$$
z_j^{[1]}
=
\mathbf{w}_j^{[1]}\cdot\mathbf{x}+b_j^{[1]},
\qquad
a_j^{[1]}=g\!\left(z_j^{[1]}\right),
$$

where $g$ is the sigmoid function.

The first neuron's parameters in the example are

```python
w1_1 = np.array([1, 2])
b1_1 = np.array([-1])
```

and its activation is computed as:

```python
z1_1 = np.dot(w1_1, x) + b1_1
a1_1 = g(z1_1)
```

The second neuron uses its own parameters:

```python
w1_2 = np.array([-3, 4])
b1_2 = np.array([1])

z1_2 = np.dot(w1_2, x) + b1_2
a1_2 = g(z1_2)
```

The third neuron follows the same computation with its own parameter arrays, `w1_3` and `b1_3`:

```python
z1_3 = np.dot(w1_3, x) + b1_3
a1_3 = g(z1_3)
```

After the three scalar activations have been computed, they are grouped into the output vector of layer 1:

```python
a1 = np.array([a1_1, a1_2, a1_3])
```

Mathematically,

$$
\mathbf{a}^{[1]}=
\begin{bmatrix}
a_1^{[1]} &
a_2^{[1]} &
a_3^{[1]}
\end{bmatrix}.
$$

## Computing the output layer

The output layer receives $\mathbf{a}^{[1]}$, not the original input $\mathbf{x}$:

$$
z_1^{[2]}
=
\mathbf{w}_1^{[2]}\cdot\mathbf{a}^{[1]}+b_1^{[2]},
\qquad
a_1^{[2]}=g\!\left(z_1^{[2]}\right).
$$

With the output neuron's own parameter arrays, `w2_1` and `b2_1`, the same operation is:

```python
z2_1 = np.dot(w2_1, a1) + b2_1
a2_1 = g(z2_1)
```

The final value `a2_1` is the network's output for this example.

## Limitation of hard-coded forward propagation

This implementation makes every neuron computation explicit, but it repeats nearly identical code:

1. select a neuron's weight vector and bias;
2. compute a dot product plus the bias;
3. apply the sigmoid function;
4. collect the activations;
5. repeat for the next layer.

Hard-coding every neuron becomes impractical for larger networks. A general dense-layer function can express this repeated operation once and reuse it for any layer.
