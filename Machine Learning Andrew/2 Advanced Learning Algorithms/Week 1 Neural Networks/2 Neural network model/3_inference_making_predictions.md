# Neural Network Inference: Making Predictions

## Example: recognizing handwritten 0 and 1

Neural-network inference can be organized as an algorithm called **forward propagation**. Consider a binary classification task that receives an image and predicts whether it contains the handwritten digit $0$ or $1$.

The example image is $8\times8$ pixels, so it contains

$$
8\times8=64
$$

pixel-intensity features. A value of $255$ represents a bright white pixel, $0$ represents a black pixel, and values between them represent shades of gray.

## Network architecture

The network has:

| Layer | Number of units | Output |
|---|---:|---|
| Input layer, $\mathbf{a}^{[0]}=\mathbf{x}$ | 64 input features | Pixel intensities |
| Hidden layer 1 | 25 | $\mathbf{a}^{[1]}$ |
| Hidden layer 2 | 15 | $\mathbf{a}^{[2]}$ |
| Output layer 3 | 1 | $a_1^{[3]}$, the probability that the digit is $1$ |

An architecture with more hidden units near the input and fewer units closer to the output is a common choice.

## Forward-propagation computations

### 1. Input to first hidden layer

The first hidden layer computes 25 activation values. For each unit $j=1,\ldots,25$:

$$
a_j^{[1]}
=
g\!\left(
\mathbf{w}_j^{[1]}\cdot\mathbf{x}+b_j^{[1]}
\right).
$$

Because $\mathbf{a}^{[0]}=\mathbf{x}$, this can equivalently be written as

$$
a_j^{[1]}
=
g\!\left(
\mathbf{w}_j^{[1]}\cdot\mathbf{a}^{[0]}+b_j^{[1]}
\right).
$$

### 2. First hidden layer to second hidden layer

The second hidden layer computes 15 activation values. For $j=1,\ldots,15$:

$$
a_j^{[2]}
=
g\!\left(
\mathbf{w}_j^{[2]}\cdot\mathbf{a}^{[1]}+b_j^{[2]}
\right).
$$

### 3. Second hidden layer to output layer

The output layer has one unit:

$$
a_1^{[3]}
=
g\!\left(
\mathbf{w}_1^{[3]}\cdot\mathbf{a}^{[2]}+b_1^{[3]}
\right).
$$

This scalar is the network's output:

$$
f(\mathbf{x})=a_1^{[3]}.
$$

As in linear and logistic regression, $f(\mathbf{x})$ denotes the function computed by the model.

## Optional binary classification

The output probability can be converted into a label:

$$
\hat{y}=
\begin{cases}
1, & a_1^{[3]}\ge 0.5,\\
0, & a_1^{[3]}<0.5.
\end{cases}
$$

## Why it is called forward propagation

The activation values are computed in sequence:

$$
\mathbf{x}
=\mathbf{a}^{[0]}
\longrightarrow
\mathbf{a}^{[1]}
\longrightarrow
\mathbf{a}^{[2]}
\longrightarrow
a_1^{[3]}.
$$

The algorithm propagates activations from the input toward the output, so it is called **forward propagation**. This contrasts with **backpropagation**, which proceeds in the opposite direction and is used for learning.

With trained parameters supplied by someone else, forward propagation is sufficient to run the network on new data and make predictions.
