# More Complex Neural Networks

## Counting layers

Consider a network containing:

- **layer 0**: the input layer;
- **layers 1, 2, and 3**: hidden layers;
- **layer 4**: the output layer.

By convention, the input layer is not included when stating the number of layers in a neural network. This is therefore called a **four-layer neural network**: three hidden layers plus one output layer.

## A single layer's computation

Focus on layer 3, which receives the activation vector $\mathbf{a}^{[2]}$ from layer 2. Suppose layer 3 has three neurons. Each neuron has its own weight vector and bias:

$$
\left(\mathbf{w}_1^{[3]},b_1^{[3]}\right),\quad
\left(\mathbf{w}_2^{[3]},b_2^{[3]}\right),\quad
\left(\mathbf{w}_3^{[3]},b_3^{[3]}\right).
$$

The three activations are

$$
\begin{aligned}
a_1^{[3]} &= g\!\left(\mathbf{w}_1^{[3]}\cdot\mathbf{a}^{[2]}+b_1^{[3]}\right),\\
a_2^{[3]} &= g\!\left(\mathbf{w}_2^{[3]}\cdot\mathbf{a}^{[2]}+b_2^{[3]}\right),\\
a_3^{[3]} &= g\!\left(\mathbf{w}_3^{[3]}\cdot\mathbf{a}^{[2]}+b_3^{[3]}\right).
\end{aligned}
$$

Their outputs form the vector

$$
\mathbf{a}^{[3]}=
\begin{bmatrix}
a_1^{[3]}\\
a_2^{[3]}\\
a_3^{[3]}
\end{bmatrix}.
$$

The important layer relationship is:

- parameters carry the superscript of the **current** layer, such as $\mathbf{w}_j^{[3]}$ and $b_j^{[3]}$;
- the input activations carry the superscript of the **previous** layer, such as $\mathbf{a}^{[2]}$.

## Interpreting the notation

For a quantity such as $a_2^{[3]}$:

- the superscript $[3]$ means “associated with layer 3”;
- the subscript $2$ means “associated with the second neuron.”

The second neuron in layer 3 must therefore use the parameters $\mathbf{w}_2^{[3]}$ and $b_2^{[3]}$, while its input is the complete vector $\mathbf{a}^{[2]}$:

$$
a_2^{[3]}
=
g\!\left(
\mathbf{w}_2^{[3]}\cdot\mathbf{a}^{[2]}+b_2^{[3]}
\right).
$$

It would be incorrect to use $\mathbf{a}^{[3]}$, because that is the output of the layer currently being computed. It would also be incorrect to use only a scalar such as $a_2^{[2]}$, because each neuron receives the full activation vector from the previous layer.

The terms **unit** and **neuron** are used interchangeably: unit $j$ is the $j$-th neuron in a layer.

## General formula

For unit $j$ in any layer $l$:

$$
z_j^{[l]}
=
\mathbf{w}_j^{[l]}\cdot\mathbf{a}^{[l-1]}+b_j^{[l]},
$$

$$
a_j^{[l]}=g\!\left(z_j^{[l]}\right)
=
g\!\left(
\mathbf{w}_j^{[l]}\cdot\mathbf{a}^{[l-1]}+b_j^{[l]}
\right).
$$

Here:

| Symbol | Meaning |
|---|---|
| $l$ | Current layer |
| $j$ | Neuron within the current layer |
| $\mathbf{a}^{[l-1]}$ | Activation vector produced by the previous layer |
| $\mathbf{w}_j^{[l]},b_j^{[l]}$ | Parameters of neuron $j$ in layer $l$ |
| $g$ | Activation function |
| $a_j^{[l]}$ | Activation produced by neuron $j$ in layer $l$ |

In this discussion, $g$ is the sigmoid function. Other functions can also be used as activation functions.

## Applying the formula to the first layer

Define the input vector as

$$
\mathbf{a}^{[0]}=\mathbf{x}.
$$

The same general formula then works for layer 1:

$$
a_j^{[1]}
=
g\!\left(
\mathbf{w}_j^{[1]}\cdot\mathbf{a}^{[0]}+b_j^{[1]}
\right)
=
g\!\left(
\mathbf{w}_j^{[1]}\cdot\mathbf{x}+b_j^{[1]}
\right).
$$

Therefore, the activations of any layer can be computed from the previous layer's activations and the current layer's parameters. Repeating this operation across the network yields inference.
