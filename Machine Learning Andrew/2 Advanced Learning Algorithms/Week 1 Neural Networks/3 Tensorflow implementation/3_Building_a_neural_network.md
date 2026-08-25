# Building a Neural Network in TensorFlow

## Two ways to carry out forward propagation

The explicit approach creates each layer and manually passes activations from one layer to the next:

```python
layer_1 = Dense(units=3, activation="sigmoid")
a1 = layer_1(x)

layer_2 = Dense(units=1, activation="sigmoid")
a2 = layer_2(a1)
```

This makes the layer-by-layer computation visible:

$$
\mathbf{x}
\longrightarrow
\mathbf{a}^{[1]}
\longrightarrow
\mathbf{a}^{[2]}.
$$

TensorFlow can instead join the layers into a single model and manage this sequence automatically.

## Creating a Sequential model

The `Sequential` function tells TensorFlow to string the layers together in the specified order:

```python
layer_1 = Dense(units=3, activation="sigmoid")
layer_2 = Dense(units=1, activation="sigmoid")

model = Sequential([layer_1, layer_2])
```

The usual TensorFlow convention is even more compact: place each layer directly in the `Sequential` definition.

```python
model = Sequential([
    Dense(units=3, activation="sigmoid"),
    Dense(units=1, activation="sigmoid")
])
```

This defines the same two-layer coffee-classification network.

## Training data and model operations

For the coffee example:

- $X$ is a $4\times2$ NumPy matrix: four training examples with two features each;
- $Y$ is a one-dimensional array of four labels, represented in the example as $[1,0,0,1]$.

Once the model and data are available, TensorFlow uses three main operations:

```python
model.compile(...)
model.fit(X, Y)
prediction = model.predict(X_new)
```

Their roles are:

| Operation | Purpose |
|---|---|
| `model.compile(...)` | Configures the model for training; its parameters are introduced later. |
| `model.fit(X, Y)` | Trains the sequential network using inputs $X$ and targets $Y$. |
| `model.predict(X_new)` | Runs forward propagation on a new example and returns the output activation. |

With `model.predict`, there is no need to call each layer manually. TensorFlow passes the new input through the sequence of layers.

## Handwritten-digit network

The same construction applies to the three-layer digit-classification model:

```python
model = Sequential([
    Dense(units=25, activation="sigmoid"),
    Dense(units=15, activation="sigmoid"),
    Dense(units=1, activation="sigmoid")
])
```

The model can then be compiled and fitted to its training data:

```python
model.compile(...)
model.fit(X, Y)
```

Inference on a new digit image is:

```python
prediction = model.predict(X_new)
```

TensorFlow performs the same layer-by-layer forward propagation as the explicit implementation, but the `Sequential` model organizes the layers and their data flow.

## Why the underlying computation still matters

High-level libraries such as TensorFlow and PyTorch make it possible to define, train, and run a neural network in only a few lines. In practical work, machine learning engineers commonly use these libraries rather than implementing forward propagation from scratch.

Understanding what the library does underneath remains important. It makes it possible to reason about the model when something goes wrong, determine what may need to change, and judge which approaches are likely to work. The next implementation therefore reconstructs forward propagation directly in Python even though production code would usually rely on a framework.
