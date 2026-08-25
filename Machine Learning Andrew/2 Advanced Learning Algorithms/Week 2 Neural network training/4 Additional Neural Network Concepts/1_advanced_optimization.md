# Advanced Optimization with Adam

Gradient descent is widely used in machine learning and underlies linear regression, logistic regression, and early neural-network implementations. The **Adam** optimization algorithm can often minimize a neural network's cost faster.

## Limitation of one fixed learning rate

A gradient-descent update for parameter $w_j$ is

$$
w_j
\leftarrow
w_j-\alpha\frac{\partial J}{\partial w_j},
$$

where $\alpha$ is the learning rate.

Two patterns on a contour plot motivate adapting $\alpha$.

### Steps repeatedly move in the same direction

If a small learning rate produces many tiny steps in nearly the same direction, a larger learning rate could move toward the minimum faster.

### Steps oscillate back and forth

If a large learning rate makes the parameters bounce across the path to the minimum, a smaller learning rate could produce a smoother approach.

Depending on the direction of recent updates, the desired learning rate may therefore be larger or smaller.

## Adam's central idea

**Adam** stands for **Adaptive Moment Estimation**. It adjusts learning rates automatically during training.

Unlike ordinary gradient descent with one global learning rate, Adam uses a different learning rate for every parameter. If a model has parameters

$$
w_1,w_2,\ldots,w_{10},b,
$$

Adam effectively maintains corresponding rates

$$
\alpha_1,\alpha_2,\ldots,\alpha_{10},\alpha_{11}.
$$

The intuition is:

- if a parameter keeps moving in roughly the same direction, increase the learning rate for that parameter;
- if a parameter keeps oscillating back and forth, decrease its learning rate.

The detailed mechanism is more complicated and is outside the scope of this course.

## Using Adam in TensorFlow

The neural-network model itself remains unchanged. When compiling the model, specify the optimizer as **tf.keras.optimizers.Adam**.

Adam still needs an initial global learning rate. The example uses

$$
\alpha=10^{-3}=0.001.
$$

In practice, try several larger and smaller initial learning rates and compare which gives the fastest learning. Adam is more robust to this choice than ordinary gradient descent because it adapts its parameter-specific rates, but tuning the initial value can still improve speed.

## Practical recommendation

Adam typically works much faster than gradient descent and has become a de facto standard for neural-network training. When choosing an optimizer for a neural network, Adam is a safe default used by many practitioners.

