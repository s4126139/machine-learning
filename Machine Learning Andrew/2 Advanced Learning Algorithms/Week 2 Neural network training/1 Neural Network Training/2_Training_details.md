# Neural Network Training Details

Training a neural network follows the same three-part pattern used to train logistic regression:

1. specify how the model computes an output from an input and its parameters;
2. specify the loss and cost functions;
3. minimize the cost with respect to the parameters.

## Review: training logistic regression

### 1. Specify the input-to-output function

For input features $x$ and parameters $w,b$, logistic regression computes

$$
z = w \cdot x + b,
\qquad
f_{w,b}(x) = g(z) = \frac{1}{1+e^{-z}},
$$

where $g$ is the sigmoid function.

### 2. Specify the loss and cost

For one training example $(x,y)$, the logistic loss is

$$
L\left(f_{w,b}(x),y\right)
= -y\log f_{w,b}(x)
  -(1-y)\log\left(1-f_{w,b}(x)\right).
$$

This loss measures performance on one example. The cost is its average over all $m$ training examples:

$$
J(w,b)=\frac{1}{m}\sum_{i=1}^{m}
L\left(f_{w,b}\left(x^{(i)}\right),y^{(i)}\right).
$$

Thus, the **loss** applies to a single example, while the **cost** summarizes the whole training set.

### 3. Minimize the cost

Gradient descent repeatedly updates the parameters:

$$
w \leftarrow w-\alpha\frac{\partial J(w,b)}{\partial w},
\qquad
b \leftarrow b-\alpha\frac{\partial J(w,b)}{\partial b},
$$

where $\alpha$ is the learning rate.

## Mapping the same three steps to a neural network

### Step 1: define the architecture and forward computation

The TensorFlow model specification describes the entire neural-network architecture. In the handwritten-digit example, it declares:

- a first hidden layer with 25 units;
- a second hidden layer with 15 units;
- an output layer with 1 unit;
- sigmoid activation in the example shown.

This is enough to specify forward propagation and therefore the output

$$
a^{[3]}=f_{W,B}(x),
$$

as a function of $x$ and all layer parameters

$$
W=\{W^{[1]},W^{[2]},W^{[3]}\},
\qquad
B=\{b^{[1]},b^{[2]},b^{[3]}\}.
$$

### Step 2: choose a loss, which determines the cost

#### Binary classification

For classifying an image as either 0 or 1, the standard loss is the same cross-entropy loss used for logistic regression:

$$
L\left(f_{W,B}(x),y\right)
=-y\log f_{W,B}(x)
-(1-y)\log\left(1-f_{W,B}(x)\right).
$$

TensorFlow calls this **binary cross-entropy**:

- **cross-entropy** is the name of the loss;
- **binary** emphasizes that the target has two possible classes.

After the loss for one example has been specified, TensorFlow treats the cost as its average over all $m$ examples:

$$
J(W,B)=\frac{1}{m}\sum_{i=1}^{m}
L\left(f_{W,B}\left(x^{(i)}\right),y^{(i)}\right).
$$

#### Regression

For a regression problem, a different loss can be used. For one example, the lesson writes the squared-error loss as

$$
L\left(f_{W,B}(x),y\right)
=\frac{1}{2}\left(f_{W,B}(x)-y\right)^2.
$$

For the TensorFlow implementation, the lesson selects mean squared error, so the model is trained to minimize mean squared error rather than binary cross-entropy.

### Step 3: minimize the cost over every layer's parameters

For gradient descent, every parameter in every layer is updated. For layer $l$ and unit $j$:

$$
w_j^{[l]} \leftarrow
w_j^{[l]}-\alpha\frac{\partial J(W,B)}{\partial w_j^{[l]}},
$$

with analogous updates for $b_j^{[l]}$.

The central computational requirement is therefore to obtain all partial derivatives of $J$ with respect to all weights and biases. Neural-network training uses **backpropagation** to compute these derivatives efficiently.

TensorFlow performs this work inside `model.fit(X, Y, epochs=100)` in the example: it runs backpropagation, updates the parameters, and repeats the learning procedure for the requested number of epochs. TensorFlow can also use optimization algorithms faster than ordinary gradient descent, introduced later in the week.

## Why libraries and underlying understanding both matter

Modern neural networks are usually implemented with mature libraries such as TensorFlow or PyTorch, just as programmers commonly use libraries for sorting, square roots, and matrix multiplication instead of recreating them from scratch. Earlier deep-learning implementations were more often written directly in Python, C++, or other environments.

Using a library does not remove the value of understanding the three-step training framework. Knowing what the model, loss, cost, derivatives, and optimizer are doing makes unexpected behavior easier to diagnose.

The basic network described here is also called a **multilayer perceptron**. Its capabilities can be improved further by changing the activation functions used in its layers.
