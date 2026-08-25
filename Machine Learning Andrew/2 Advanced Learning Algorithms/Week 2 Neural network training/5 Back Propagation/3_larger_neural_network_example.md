# Backpropagation in a Larger Neural Network

This example applies a computation graph and backpropagation to a two-layer neural network with one hidden unit and one output unit.

## Network setup

Use one training example:

$$
x=1,\qquad y=5.
$$

The parameters are

$$
w_1=2,\qquad b_1=0,\qquad
w_2=3,\qquad b_2=1.
$$

Both units use ReLU:

$$
g(z)=\max(0,z).
$$

For the values in this example, both pre-activations are positive, so ReLU acts as $g(z)=z$.

## Forward propagation

The hidden unit computes

$$
a_1=g(w_1x+b_1),
$$

and the output unit computes

$$
a_2=g(w_2a_1+b_2).
$$

Using intermediate variables makes the computation graph explicit:

$$
\begin{aligned}
t_1 &= w_1x = 2(1)=2,\\
z_1 &= t_1+b_1=2+0=2,\\
a_1 &= g(z_1)=2,\$$4pt]
t_2 &= w_2a_1=3(2)=6,\\
z_2 &= t_2+b_2=6+1=7,\\
a_2 &= g(z_2)=7.
\end{aligned}
$$

The squared-error cost is

$$
\begin{aligned}
J(W,B)
&=\frac{1}{2}(a_2-y)^2\\
&=\frac{1}{2}(7-5)^2\\
&=2.
\end{aligned}
$$

~~~mermaid
flowchart LR
    W1["w₁ = 2"] --> T1["t₁ = w₁x = 2"]
    X["x = 1"] --> T1
    T1 --> Z1["z₁ = t₁ + b₁ = 2"]
    B1["b₁ = 0"] --> Z1
    Z1 --> A1["a₁ = ReLU(z₁) = 2"]
    A1 --> T2["t₂ = w₂a₁ = 6"]
    W2["w₂ = 3"] --> T2
    T2 --> Z2["z₂ = t₂ + b₂ = 7"]
    B2["b₂ = 1"] --> Z2
    Z2 --> A2["a₂ = ReLU(z₂) = 7"]
    A2 --> J["J = (1/2)(a₂-y)² = 2"]
    Y["y = 5"] --> J
~~~

## Backward propagation

Backpropagation moves from $J$ toward the parameters. Since $a_2-y=2$,

$$
\frac{\partial J}{\partial a_2}=a_2-y=2.
$$

Because $z_1$ and $z_2$ are both positive, the local ReLU derivative is 1 at both units. The derivatives propagate as follows.

### Through the output unit

$$
\frac{\partial J}{\partial z_2}
=
\frac{\partial J}{\partial a_2}
\frac{\partial a_2}{\partial z_2}
=
2(1)=2.
$$

Because $z_2=t_2+b_2$,

$$
\frac{\partial J}{\partial t_2}=2,
\qquad
\frac{\partial J}{\partial b_2}=2.
$$

Because $t_2=w_2a_1$,

$$
\frac{\partial J}{\partial w_2}
=
\frac{\partial J}{\partial t_2}
\frac{\partial t_2}{\partial w_2}
=
2a_1
=
4,
$$

and

$$
\frac{\partial J}{\partial a_1}
=
\frac{\partial J}{\partial t_2}
\frac{\partial t_2}{\partial a_1}
=
2w_2
=
6.
$$

### Through the hidden unit

Since ReLU is in its positive region,

$$
\frac{\partial J}{\partial z_1}
=
\frac{\partial J}{\partial a_1}
\frac{\partial a_1}{\partial z_1}
=
6(1)=6.
$$

Because $z_1=t_1+b_1$,

$$
\frac{\partial J}{\partial t_1}=6,
\qquad
\frac{\partial J}{\partial b_1}=6.
$$

Finally, because $t_1=w_1x$,

$$
\frac{\partial J}{\partial w_1}
=
\frac{\partial J}{\partial t_1}
\frac{\partial t_1}{\partial w_1}
=
6x
=
6.
$$

## Parameter derivatives

| Parameter | Derivative |
|---|---:|
| $w_1$ | $\dfrac{\partial J}{\partial w_1}=6$ |
| $b_1$ | $\dfrac{\partial J}{\partial b_1}=6$ |
| $w_2$ | $\dfrac{\partial J}{\partial w_2}=4$ |
| $b_2$ | $\dfrac{\partial J}{\partial b_2}=2$ |

These derivatives can be passed to gradient descent or Adam to update all four parameters.

## Numerical check for $w_1$

The result

$$
\frac{\partial J}{\partial w_1}=6
$$

predicts that increasing $w_1$ by $\epsilon$ should increase $J$ by approximately $6\epsilon$.

Let $\epsilon=0.001$, so $w_1=2.001$. Then

$$
a_1=g(2.001\cdot1+0)=2.001,
$$

and

$$
a_2=g(3\cdot2.001+1)=7.003.
$$

The new cost is

$$
\begin{aligned}
J
&=\frac{1}{2}(7.003-5)^2\\
&=\frac{1}{2}(2.003)^2\\
&\approx 2.006005.
\end{aligned}
$$

The cost rose from $2$ to approximately $2.006$, or about $6\epsilon$, confirming the derivative.

## Why not perturb each parameter separately?

One could estimate derivatives by increasing $w_1$, then $b_1$, then $w_2$, then $b_2$, and running a full left-to-right calculation after every change. However, that repeats the entire network computation for every parameter.

For a computation graph with $N$ nodes and $P$ parameters:

- separate perturbations require roughly $NP$ steps;
- backpropagation obtains all derivatives in roughly $N+P$ steps.

This difference is crucial when both the network and the parameter set are large.

## Automatic differentiation

Before frameworks such as TensorFlow and PyTorch, researchers often:

1. wrote a neural network's equations by hand;
2. used calculus to derive each required derivative;
3. implemented the resulting backpropagation equations manually.

Modern frameworks let developers specify forward propagation and then calculate the backward pass automatically. This process is called **automatic differentiation**, or **autodiff**, and is commonly implemented using computation graphs.

Autodiff reduces the amount of manual calculus needed to train neural networks while preserving the efficient derivative computation provided by backpropagation.

