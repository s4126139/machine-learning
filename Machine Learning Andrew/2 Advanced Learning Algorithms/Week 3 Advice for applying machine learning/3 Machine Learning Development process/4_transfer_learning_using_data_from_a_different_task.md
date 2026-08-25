# Transfer Learning: Using Data from a Different Task

## Motivation

Transfer learning is useful when the target application has little labeled data. It uses parameters learned from a different task as the starting point for the target task.

Suppose the goal is to recognize handwritten digits 0–9, but only a small labeled digit dataset is available. A much larger dataset might contain one million images across 1,000 classes, including cats, dogs, cars, and people.

## Step 1: supervised pre-training

Train a neural network on the large 1,000-class dataset. The network learns parameters

$$
(W^{[1]},b^{[1]}),\ (W^{[2]},b^{[2]}),\ldots,(W^{[5]},b^{[5]}),
$$

where the fifth layer is the 1,000-unit output layer.

This first stage is called **supervised pre-training** because the network learns from a large labeled dataset, even though its task is not exactly the desired digit-recognition task.

In practice, it is often unnecessary to perform this expensive stage yourself. Researchers may publish freely licensed pre-trained networks that can be downloaded and reused.

## Step 2: replace the output layer

Copy the pre-trained network but remove its final 1,000-class output layer. Replace it with a new output layer containing 10 units, one for each digit from 0 through 9.

The first four parameter sets can be copied:

$$
(W^{[1]},b^{[1]}),\ldots,(W^{[4]},b^{[4]}).
$$

The original $(W^{[5]},b^{[5]})$ cannot be reused because the output dimension has changed. The new fifth-layer parameters must be initialized and learned for the digit task.

## Step 3: fine-tuning

Continue optimization on the small handwritten-digit dataset using gradient descent, stochastic gradient descent, or Adam. This stage is called **fine-tuning**.

There are two options:

| Option | Parameters updated | When it may work better |
|---|---|---|
| 1. Train only the output layer | Hold layers 1–4 fixed; update only $W^{[5]},b^{[5]}$ | Very small target dataset |
| 2. Train the entire network | Initialize layers 1–4 from pre-training, then update all layers | Somewhat larger target dataset |

In either case, the early layers start from values learned on a large dataset rather than from scratch.

## Why transfer learning can work

An image network trained to distinguish many objects learns reusable visual features:

- the first layer may detect edges;
- the next layer may combine edges into corners and simple shapes;
- later layers may detect curves and more complex but still generic shapes.

Edges, corners, curves, and basic shapes are useful not only for cats, dogs, cars, and people, but also for handwritten digits. Transferring the early parameters therefore places the target model at a much better starting point, after which a smaller amount of task-specific learning can produce a strong model.

## Required compatibility of input type

The pre-training and fine-tuning inputs must be of the same type:

- an image application should use a network pre-trained on images of the appropriate dimensions;
- a speech-recognition application should use a network pre-trained on audio;
- a text application should use a network pre-trained on text.

A network pre-trained on images is not expected to help much with audio because the input representation is different.

## Practical procedure

1. Download a neural network pre-trained on a large dataset with the same input type as the target application, or train such a model yourself.
2. Replace the output layer to match the target labels.
3. Fine-tune only the output layer or the entire network using the available target data.

A network pre-trained on roughly a million images may sometimes be fine-tuned successfully with a target dataset of only thousands of images, or even fewer. The lesson describes successful experiments with as few as 50 images, but emphasizes that transfer learning is not a universal solution and cannot make every application work with so little data.

## Shared pre-trained models

GPT-3, BERT, and networks pre-trained on ImageNet are cited as examples of models pre-trained on large text or image datasets and then adapted to other tasks. The availability of downloaded parameters allows practitioners to build on weeks of training already performed by other researchers.

This open sharing of ideas, code, and trained parameters lets the machine learning community collectively achieve better results than individuals working entirely alone.
