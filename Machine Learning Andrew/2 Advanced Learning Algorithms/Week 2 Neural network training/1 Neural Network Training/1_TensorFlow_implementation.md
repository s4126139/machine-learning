# Training a Neural Network in TensorFlow

## From inference to training

The previous week introduced neural-network inference: computing a prediction from an input. The next goal is to train a neural network on a dataset so that its parameters produce useful predictions.

The running example is handwritten-digit recognition for images of either **0** or **1**. The network architecture is:

- input: an image $X$;
- first hidden layer: 25 units;
- second hidden layer: 15 units;
- output layer: 1 unit;
- sigmoid activations in the three layers shown in the example.

The training set contains input images $X$ and their ground-truth labels $Y$.

## The three TensorFlow steps

### 1. Specify the model

Ask TensorFlow to sequentially connect the three layers: a 25-unit hidden layer, a 15-unit hidden layer, and a one-unit output layer. This model specification defines how TensorFlow performs inference.

### 2. Compile the model with a loss function

Compiling the model tells TensorFlow which loss function to use. For this binary digit-classification problem, the example uses **binary cross-entropy**.

The loss function measures how well the model's prediction matches the target label. Its details are developed in the following lesson.

### 3. Fit the model to the data

Calling `fit` tells TensorFlow to train the model specified in step 1 on the dataset $(X,Y)$, using the loss chosen in step 2.

The `epochs` argument controls how many steps of the learning algorithm—such as gradient descent—TensorFlow should run.

## Training workflow

1. **Model:** define how to compute predictions.
2. **Loss:** define what counts as prediction error.
3. **Fit:** adjust the model parameters to reduce that error on $(X,Y)$.

Although TensorFlow performs these operations through a few library calls, understanding the ideas behind them remains important. If training does not work as expected, this conceptual framework helps identify and debug the problem.
