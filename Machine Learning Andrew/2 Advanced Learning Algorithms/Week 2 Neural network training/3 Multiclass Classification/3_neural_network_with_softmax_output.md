# Neural Network with a Softmax Output

A neural network performs multiclass classification by placing the softmax regression model in its output layer.

## Architecture for ten handwritten digits

For binary recognition of digits 0 and 1, the earlier network had one output unit. To classify all ten digits, 0 through 9, change the final layer to **10 output units**. This final layer is called a **softmax output layer**, a **softmax layer**, or a **softmax activation function**.

The hidden-layer computations do not change:

1. compute the first hidden-layer activations $a^{[1]}$ from input $x$;
2. compute the second hidden-layer activations $a^{[2]}$;
3. compute ten output scores and convert them to ten probabilities.

## Forward propagation through the softmax layer

For output-layer unit $j$,

$$
z_j^{[3]}
=
w_j^{[3]}\cdot a^{[2]}+b_j^{[3]},
\qquad j=1,\ldots,10.
$$

Then

$$
a_j^{[3]}
=
\frac{e^{z_j^{[3]}}}
{\displaystyle\sum_{k=1}^{10}e^{z_k^{[3]}}},
\qquad j=1,\ldots,10.
$$

Here, $j=1,\ldots,10$ indexes the ten output units. Collectively, their activations estimate the probabilities of the ten digit labels $0,1,\ldots,9$.

The superscript $[3]$ identifies the third layer. It can make the notation more cluttered, but it makes explicit that the scores, activations, weights, and biases belong to the output layer.

## Why softmax is unusual

Sigmoid, ReLU, and linear activations operate element by element:

$$
a_j=g(z_j).
$$

For these activations, $a_1$ depends only on $z_1$, $a_2$ only on $z_2$, and so on.

Softmax is different because every output shares the same denominator:

$$
a_j^{[3]}
=
\frac{e^{z_j^{[3]}}}
{\sum_{k=1}^{10}e^{z_k^{[3]}}}.
$$

Consequently, each $a_j^{[3]}$ depends on **all** of

$$
z_1^{[3]},z_2^{[3]},\ldots,z_{10}^{[3]}.
$$

The ten activations are computed together rather than independently.

## TensorFlow training setup

The example follows the familiar three-step workflow.

### 1. Specify the model

Sequentially connect:

- a 25-unit hidden layer with ReLU;
- a 15-unit hidden layer with ReLU;
- a 10-unit output layer with softmax.

### 2. Specify the loss

TensorFlow calls the softmax loss introduced previously **SparseCategoricalCrossentropy**.

- **categorical** means that $y$ identifies a category;
- **sparse** means each training example belongs to exactly one of the categories.

For handwritten digits, an image is one digit—0, 1, 2, and so on through 9—not simultaneously two different digits.

### 3. Fit the model

Training is invoked in the same way as before: TensorFlow fits the model to the labeled data using the specified loss.

## Important implementation caveat

The direct implementation—softmax activation in the output layer followed by sparse categorical cross-entropy—works. However, a later implementation computes the same conceptual quantity with better numerical accuracy. That improved version is the recommended TensorFlow form.
