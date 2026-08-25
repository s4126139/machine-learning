# Additional Neural Network Layer Types

## Dense layers

All earlier networks used **dense layers**. In a dense layer, every neuron receives all activation values from the previous layer. For example, every unit in the second hidden layer is a function of the full activation vector $a^{[1]}$.

Dense layers alone can build powerful learning algorithms, but neural networks can also use layers with different connection patterns.

## Convolutional layers

In a **convolutional layer**, each neuron sees only a limited region, or window, of the preceding input rather than all of it.

### Image example

For an input image of a handwritten 9:

- one hidden unit may look only at pixels in one small rectangular region;
- another unit looks at a different region;
- later units cover other local regions of the image.

Possible benefits of these limited connections are:

1. faster computation;
2. less training data may be needed;
3. the model may be less prone to overfitting.

Yann LeCun worked out many of the details that made convolutional layers effective and helped popularize their use.

A neural network with multiple convolutional layers is called a **convolutional neural network**.

## One-dimensional convolutional example: EKG classification

An electrocardiogram—written ECG in some places and EKG in others—is a sequence of measured voltages over time. Suppose the signal is represented by 100 values:

$$
x_1,x_2,\ldots,x_{100}.
$$

The learning task is to classify from this time series whether a patient has a heart disease or another diagnosable heart condition.

### First convolutional hidden layer

Instead of giving every unit all 100 inputs, assign each unit a local window:

| Hidden unit | Input window |
|---|---|
| 1 | $x_1$ through $x_{20}$ |
| 2 | $x_{11}$ through $x_{30}$ |
| 3 | $x_{21}$ through $x_{40}$ |
| $\vdots$ | successive overlapping windows |
| 9 | $x_{81}$ through $x_{100}$ |

This first layer has nine units, each looking at a limited part of the EKG signal.

### Second convolutional hidden layer

The next layer can also use local windows instead of all nine preceding activations:

| Hidden unit | Previous-layer activations |
|---|---|
| 1 | $a_1^{[1]}$ through $a_5^{[1]}$ |
| 2 | $a_3^{[1]}$ through $a_7^{[1]}$ |
| 3 | $a_5^{[1]}$ through $a_9^{[1]}$ |

### Output layer

The three second-layer activations then feed a sigmoid output unit. This final unit can use all three values to make a binary prediction about the presence or absence of heart disease.

The resulting network contains:

1. a convolutional first hidden layer;
2. a convolutional second hidden layer;
3. a sigmoid output layer.

## Architectural choices

Convolutional layers introduce design choices such as:

- the size of the input window visible to each neuron;
- how the windows overlap;
- how many neurons a layer contains.

Choosing these parameters effectively can produce networks that outperform dense layers for some applications.

## Layer types as building blocks

Convolutional networks are not developed further in this course and are not required for its homework. Their broader lesson is that neural networks can be constructed from different kinds of layers.

Modern research continues to explore new layer types and combinations. Transformer models, LSTMs, and attention models are examples mentioned in this context. Different layers can be connected as building blocks to form more complex and potentially more powerful neural networks.

