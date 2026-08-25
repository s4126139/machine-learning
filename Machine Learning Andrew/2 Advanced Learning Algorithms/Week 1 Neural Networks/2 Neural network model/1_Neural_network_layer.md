# The Neural Network Layer

## A layer as the fundamental building block

A layer of neurons is the basic building block of a modern neural network. Each layer:

1. receives a vector of numbers;
2. applies several neuron computations to that same vector;
3. produces a new vector of activation values;
4. passes that vector to the next layer.

In the T-shirt demand-prediction example, four input features enter a hidden layer with three neurons. The hidden layer's three activations then enter an output layer with one neuron.

## Computation in the hidden layer

Let the input vector be $\mathbf{x}$. Each neuron is a logistic regression unit with its own parameters.

For hidden neuron $j$:

$$
z_j^{[1]}=\mathbf{w}_j^{[1]}\cdot\mathbf{x}+b_j^{[1]},
$$

$$
a_j^{[1]}=g\!\left(z_j^{[1]}\right),
\qquad
g(z)=\frac{1}{1+e^{-z}}.
$$

The superscript $[1]$ identifies quantities associated with layer 1, while the subscript $j$ identifies a neuron within that layer.

For the three hidden neurons:

$$
\begin{aligned}
a_1^{[1]} &= g\!\left(\mathbf{w}_1^{[1]}\cdot\mathbf{x}+b_1^{[1]}\right),\\
a_2^{[1]} &= g\!\left(\mathbf{w}_2^{[1]}\cdot\mathbf{x}+b_2^{[1]}\right),\\
a_3^{[1]} &= g\!\left(\mathbf{w}_3^{[1]}\cdot\mathbf{x}+b_3^{[1]}\right).
\end{aligned}
$$

In the example, these may evaluate to

$$
a_1^{[1]}=0.3,\qquad
a_2^{[1]}=0.7,\qquad
a_3^{[1]}=0.2.
$$

They can be interpreted as estimated probabilities of high affordability, high awareness, and high perceived quality. Together they form the hidden layer's output vector:

$$
\mathbf{a}^{[1]}=
\begin{bmatrix}
0.3\\
0.7\\
0.2
\end{bmatrix}.
$$

## Layer numbering

By convention:

- the input layer may be called **layer 0**;
- the first hidden layer is **layer 1**;
- the next layer is **layer 2**, and so on.

A superscript in square brackets identifies the layer:

- $\mathbf{a}^{[1]}$: output activations of layer 1;
- $\mathbf{w}_j^{[1]}, b_j^{[1]}$: parameters of neuron $j$ in layer 1;
- $\mathbf{a}^{[2]}$: output activations of layer 2.

This notation scales to networks with dozens or hundreds of layers.

## Computation in the output layer

The output of layer 1 becomes the input to layer 2. Because the output layer in this example has only one neuron, it computes one scalar:

$$
a_1^{[2]}
=
g\!\left(
\mathbf{w}_1^{[2]}\cdot\mathbf{a}^{[1]}+b_1^{[2]}
\right).
$$

For example, the result may be

$$
a_1^{[2]}=0.84,
$$

which is the predicted probability that the T-shirt is a top seller.

## Optional binary decision

The probability may be left as the final network output, or it may be converted into a binary prediction:

$$
\hat{y}=
\begin{cases}
1, & a_1^{[2]}\ge 0.5,\\
0, & a_1^{[2]}<0.5.
\end{cases}
$$

Thus, neural-network inference repeatedly maps one activation vector to another until the output layer produces the prediction.
