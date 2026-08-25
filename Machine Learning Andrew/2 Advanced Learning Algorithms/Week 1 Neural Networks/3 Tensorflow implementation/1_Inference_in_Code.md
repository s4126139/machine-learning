# Neural Network Inference in TensorFlow

## TensorFlow and the inference task

TensorFlow is a widely used framework for implementing deep learning algorithms. PyTorch is another popular framework, but this course focuses on TensorFlow.

The same neural-network algorithm can be applied to many different tasks. The examples here use coffee-roasting quality and handwritten-digit recognition to show the TensorFlow syntax for forward propagation.

## Example: coffee-roasting quality

Two controllable features affect the roasting process:

- roasting **temperature**;
- roasting **duration**.

Each training example also has a label:

- $y=1$: good-tasting coffee;
- $y=0$: bad-tasting coffee.

In the simplified dataset:

- a temperature that is too low can leave the beans undercooked;
- a duration that is too short can also leave them undercooked;
- a temperature that is too high or a duration that is too long can burn the beans;
- only a particular region of temperature-duration combinations produces good coffee.

For a new roast at $200^\circ\mathrm{C}$ for $17$ minutes, the input is represented as:

```python
x = np.array([[200, 17]])
```

### First dense layer

The first layer contains three units and uses the sigmoid activation function:

```python
layer_1 = Dense(units=3, activation="sigmoid")
a1 = layer_1(x)
```

A **dense layer** is the fully connected layer introduced earlier, in which every unit receives all activations from the previous layer.

Because the layer has three units, $\mathbf{a}^{[1]}$ contains three activation values. For illustration:

$$
\mathbf{a}^{[1]}=
\begin{bmatrix}
0.2 & 0.7 & 0.3
\end{bmatrix}.
$$

### Output layer

The second layer has one unit and also uses sigmoid:

```python
layer_2 = Dense(units=1, activation="sigmoid")
a2 = layer_2(a1)
```

The result may, for example, be the $1\times1$ tensor

$$
\mathbf{a}^{[2]}=
\begin{bmatrix}
0.8
\end{bmatrix}.
$$

It can optionally be converted into a binary prediction:

```python
if a2 >= 0.5:
    yhat = 1
else:
    yhat = 0
```

The essential forward-propagation sequence is therefore:

$$
\mathbf{x}
\xrightarrow{\text{layer 1}}
\mathbf{a}^{[1]}
\xrightarrow{\text{layer 2}}
\mathbf{a}^{[2]}
\xrightarrow{\text{optional threshold}}
\hat{y}.
$$

Loading TensorFlow and loading the trained parameters $\mathbf{w}$ and $b$ are additional implementation details handled in the lab.

## Example: handwritten-digit classification

For handwritten digits, $x$ is a NumPy array containing pixel-intensity values. The same TensorFlow pattern builds the previously defined network:

```python
x = np.array([pixel_intensity_values])

layer_1 = Dense(units=25, activation="sigmoid")
a1 = layer_1(x)

layer_2 = Dense(units=15, activation="sigmoid")
a2 = layer_2(a1)

layer_3 = Dense(units=1, activation="sigmoid")
a3 = layer_3(a2)
```

The one-unit output layer returns a one-element tensor `a3`. Its contained value is the predicted probability and may optionally be thresholded to produce $\hat{y}$.

In both examples, applying each layer as a function to the previous activation vector carries out neural-network inference.
