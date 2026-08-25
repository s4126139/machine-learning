# Alternatives to the Sigmoid Activation Function

Early examples used sigmoid activation in both hidden and output layers because a neural network was introduced as many logistic-regression units connected together. Other activation functions, however, make neural networks more powerful.

## Motivation: awareness is not necessarily binary

In the demand-prediction example, the inputs were price, shipping cost, marketing, and material. Hidden units represented quantities such as affordability, awareness, and perceived quality, which were then used to predict whether a product would be a top seller.

Modeling awareness with a sigmoid constrains its activation to the interval from 0 to 1. That may be too restrictive: potential buyers might be slightly aware, moderately aware, extremely aware, or the product might have gone viral. A more suitable representation could allow awareness to take any non-negative value, from 0 to a very large number.

## ReLU

The **rectified linear unit**, usually called **ReLU**, is

$$
g(z)=\max(0,z)
=
\begin{cases}
0, & z<0,\\
z, & z\ge 0.
\end{cases}
$$

Its graph is flat at zero for negative inputs and follows a straight line for non-negative inputs. Therefore, an activation such as $a_2^{[1]}=g(z)$ can be zero or any positive value.

“ReLU” is simply the standard name practitioners use; it expands to “rectified linear unit.”

## The most common activation functions

| Activation | Definition | Output behavior |
|---|---|---|
| Sigmoid | $\displaystyle g(z)=\frac{1}{1+e^{-z}}$ | Produces values between 0 and 1 |
| ReLU | $g(z)=\max(0,z)$ | Produces 0 for negative $z$ and $z$ itself for non-negative $z$ |
| Linear | $g(z)=z$ | Leaves $z$ unchanged |

With linear activation,

$$
a=g(z)=z=w\cdot x+b.
$$

For this reason, using a linear activation is sometimes described as using **no activation function**: the output is the same as if $g$ were absent. In these notes, it is still called the linear activation function.

Sigmoid, ReLU, and linear activations are the three main choices introduced here. A fourth activation, **softmax**, is introduced later for multiclass classification.

## Design choice

A neural network does not need to use the same activation everywhere. The activation function is chosen for each neuron or layer according to the role that output must play. The next step is therefore to decide when sigmoid, ReLU, or linear activation is the appropriate choice.

