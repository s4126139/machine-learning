# Choosing Activation Functions

A neural network may use different activation functions in different layers. The most natural choice for the output layer depends on the target label $y$, while ReLU is the usual default for hidden layers.

## Choosing the output-layer activation

| Prediction task | Range or meaning of $y$ | Recommended output activation | Reason |
|---|---|---|---|
| Binary classification | $y\in\{0,1\}$ | Sigmoid | The output can represent the probability that $y=1$, as in logistic regression. |
| Regression with signed values | $y$ may be positive or negative | Linear | $g(z)=z$ can output either positive or negative values. |
| Regression with non-negative values | $y\ge 0$ | ReLU | $g(z)=\max(0,z)$ outputs only zero or positive values. |

Examples from the lesson:

- For a binary classification problem, use sigmoid at the output layer.
- To predict tomorrow's stock-price change relative to today's price, the target may rise or fall, so use a linear output.
- To predict a house price, which cannot be negative, a ReLU output is a natural choice.

If the network's final activation is $a^{[3]}$, then

$$
f(x)=a^{[3]}=g\!\left(z^{[3]}\right),
$$

and the range of $g$ should match the possible values of $y$.

## Choosing hidden-layer activations

The recommended default for hidden layers is **ReLU**. Although sigmoid activations were common earlier in the history of neural networks, practitioners now use ReLU much more often. A major exception is the output layer of a binary classifier, where sigmoid remains appropriate.

### Why ReLU is preferred

1. **It is faster to compute.** ReLU requires only $\max(0,z)$, whereas sigmoid requires exponentiation, inversion, and related operations.
2. **It is flat in fewer regions.** ReLU is flat only for negative $z$. Sigmoid becomes flat for both very negative and very positive $z$.
3. **It often enables faster learning.** Flat activation regions contribute to more flat regions and small gradients in the cost $J(W,B)$, which can slow gradient descent. ReLU therefore often allows the network to learn faster.

This is an intuitive explanation: gradient descent minimizes $J(W,B)$ rather than the activation function itself, but the activation function participates in the computation of $J$.

## Practical recommendation

For a network with two hidden layers and one output layer:

- use ReLU for the first hidden layer;
- use ReLU for the second hidden layer;
- choose sigmoid, linear, or ReLU for the output according to the label range.

In TensorFlow, the corresponding activation names are **relu**, **sigmoid**, and **linear**.

## Other activations mentioned

Research literature also contains activation functions such as:

- $\tanh$;
- LeakyReLU;
- swish.

They can sometimes work a little better for particular applications—LeakyReLU is one example used successfully in some work—but the sigmoid/linear/ReLU guidance above is sufficient for the vast majority of applications discussed here.

## Summary

- **Hidden layers:** use ReLU by default.
- **Binary output:** use sigmoid.
- **Signed regression output:** use linear.
- **Non-negative regression output:** use ReLU.

Using a linear activation everywhere is not a useful substitute for nonlinear activations: as the next derivation shows, it collapses a multilayer network into a much simpler model.

