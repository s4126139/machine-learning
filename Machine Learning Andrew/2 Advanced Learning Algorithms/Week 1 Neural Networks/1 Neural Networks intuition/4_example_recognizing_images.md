# Neural Networks for Image Recognition

## Representing an image as input

In a face-recognition application, a neural network receives an image and predicts the identity of the person in it.

For a $1000\times1000$-pixel image:

- the computer stores a $1000\times1000$ matrix of pixel-intensity values;
- in the example, each brightness value ranges from $0$ to $255$;
- unrolling the matrix produces an input vector with

$$
1000\times1000=1{,}000{,}000
$$

pixel-intensity values.

The learning problem is therefore to map a feature vector containing one million brightness values to a person's identity.

## Layer-by-layer feature learning

The image vector $\mathbf{x}$ passes through a sequence of hidden layers and then an output layer:

1. The **first hidden layer** extracts simple image features.
2. Its activations feed a **second hidden layer**.
3. Those activations feed a **third hidden layer**.
4. The **output layer** estimates, for example, the probability that the image shows a particular person.

When the activations of a trained face-recognition network are visualized, different layers may detect features at different scales.

| Layer | Features it may learn to detect | Image region considered |
|---|---|---|
| First hidden layer | Short lines and edges with different orientations, such as vertical or slanted edges | Relatively small windows |
| Second hidden layer | Parts of faces assembled from short edges, such as an eye, the corner of a nose, or the bottom of an ear | Larger windows |
| Third hidden layer | Larger and coarser face shapes assembled from face parts | Even larger windows |
| Output layer | The identity of the person, using the learned face-shape features | Final learned representation |

The successive layers therefore build increasingly complex features from the activations of earlier layers.

## Features are learned from data

No one explicitly tells the network that the first layer should detect edges, the second should detect face parts, or the third should detect larger face shapes. The network learns these feature detectors from the training images.

If the same learning algorithm is instead trained on many pictures of cars:

- the first layer may still learn edges;
- the second layer learns parts of cars rather than parts of faces;
- the third layer learns more complete car shapes.

Changing the training data causes the network to learn different internal features suited to its prediction task. This automatic feature learning is what allows the same neural-network structure to support tasks such as face recognition, car detection, and handwritten digit recognition.
