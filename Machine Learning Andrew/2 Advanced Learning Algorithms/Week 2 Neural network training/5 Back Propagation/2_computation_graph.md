# Computation Graphs and Backpropagation

A **computation graph** breaks a calculation into individual operations connected by arrows. Deep-learning frameworks such as TensorFlow use this structure to compute neural-network derivatives automatically.

## Example network and cost

Consider a neural network with one linear output unit:

$$
a=wx+b.
$$

For one training example, use squared-error cost:

$$
J=\frac{1}{2}(a-y)^2.
$$

The values are

$$
x=-2,\qquad y=2,\qquad w=2,\qquad b=8.
$$

The cost is viewed as a function of the trainable parameters $w$ and $b$.

## Forward propagation: left to right

Break the calculation into four operations:

$$
\begin{aligned}
c &= wx,\\
a &= c+b,\\
d &= a-y,\\
J &= \frac{1}{2}d^2.
\end{aligned}
$$

Substituting the values gives

$$
\begin{aligned}
c &= 2(-2)=-4,\\
a &= -4+8=4,\\
d &= 4-2=2,\\
J &= \frac{1}{2}(2)^2=2.
\end{aligned}
$$

~~~mermaid
flowchart LR
    W["w = 2"] --> C["c = wx = -4"]
    X["x = -2"] --> C
    C --> A["a = c + b = 4"]
    B["b = 8"] --> A
    A --> D["d = a - y = 2"]
    Y["y = 2"] --> D
    D --> J["J = (1/2)d² = 2"]
~~~

This left-to-right calculation is forward propagation. It computes both the network output $a$ and the final cost $J$.

## Backpropagation: right to left

The goal is to compute

$$
\frac{\partial J}{\partial w}
\qquad\text{and}\qquad
\frac{\partial J}{\partial b}.
$$

Backpropagation begins at $J$ and moves right to left through the graph.

### 1. Derivative with respect to $d$

Because

$$
J=\frac{1}{2}d^2,
$$

at $d=2$,

$$
\frac{\partial J}{\partial d}=d=2.
$$

Intuitively, if $d$ increases from $2$ to $2+\epsilon$, then

$$
J
=
\frac{1}{2}(2+\epsilon)^2
\approx
2+2\epsilon.
$$

Thus $J$ increases by about $2\epsilon$.

### 2. Derivative with respect to $a$

Since

$$
d=a-y,
$$

increasing $a$ by $\epsilon$ increases $d$ by $\epsilon$. The resulting cost change is therefore about $2\epsilon$:

$$
\frac{\partial J}{\partial a}=2.
$$

Using the chain rule,

$$
\frac{\partial J}{\partial a}
=
\frac{\partial d}{\partial a}
\frac{\partial J}{\partial d}
=
1\cdot 2
=
2.
$$

### 3. Derivatives with respect to $c$ and $b$

Because

$$
a=c+b,
$$

a small increase in either $c$ or $b$ increases $a$ by the same amount. Therefore,

$$
\frac{\partial J}{\partial c}
=
\frac{\partial a}{\partial c}
\frac{\partial J}{\partial a}
=
1\cdot 2
=
2,
$$

and

$$
\frac{\partial J}{\partial b}
=
\frac{\partial a}{\partial b}
\frac{\partial J}{\partial a}
=
1\cdot 2
=
2.
$$

### 4. Derivative with respect to $w$

Because

$$
c=wx
$$

and $x=-2$, increasing $w$ by $\epsilon$ changes $c$ by $-2\epsilon$. Since $\partial J/\partial c=2$, the resulting change in $J$ is about

$$
2(-2\epsilon)=-4\epsilon.
$$

Therefore,

$$
\frac{\partial J}{\partial w}=-4.
$$

By the chain rule,

$$
\frac{\partial J}{\partial w}
=
\frac{\partial c}{\partial w}
\frac{\partial J}{\partial c}
=
x\cdot 2
=
(-2)(2)
=
-4.
$$

## Result of the backward pass

| Quantity | Derivative |
|---|---:|
| $d$ | $\dfrac{\partial J}{\partial d}=2$ |
| $a$ | $\dfrac{\partial J}{\partial a}=2$ |
| $c$ | $\dfrac{\partial J}{\partial c}=2$ |
| $b$ | $\dfrac{\partial J}{\partial b}=2$ |
| $w$ | $\dfrac{\partial J}{\partial w}=-4$ |

The chain rule notation is useful if it is familiar, but the same result follows from tracking how a tiny change propagates through each operation.

## Numerical checks

The full cost is

$$
J(w,b)=\frac{1}{2}(wx+b-y)^2.
$$

### Perturbing $w$

With $w=2.001$,

$$
\begin{aligned}
J
&=\frac{1}{2}\left((2.001)(-2)+8-2\right)^2\\
&=1.996002.
\end{aligned}
$$

The cost changes from $2$ to approximately $2-0.004$, confirming a change of about $-4\epsilon$ and hence

$$
\frac{\partial J}{\partial w}=-4.
$$

### Perturbing $b$

If $b$ increases by $\epsilon$, then $a$ and $d$ also increase by $\epsilon$, causing $J$ to increase by approximately $2\epsilon$. This confirms

$$
\frac{\partial J}{\partial b}=2.
$$

## Why the backward direction is efficient

To determine how $w$ affects $J$, it helps first to know how $c$ affects $J$. To determine how $c$ affects $J$, it helps first to know how $a$ affects $J$, and so on. This naturally orders derivative calculations from the cost backward toward the parameters.

The backward pass also reuses intermediate derivatives. For example, $\partial J/\partial a$ is computed once and then used to obtain derivatives for both the $c$ and $b$ branches.

If a computation graph has:

- $n$ computation nodes;
- $p$ parameters;

backpropagation computes all parameter derivatives in roughly

$$
n+p
$$

steps, rather than roughly

$$
np
$$

steps.

For a network with 10,000 nodes and 100,000 parameters, this is about 110,000 steps instead of one billion steps. This efficiency is why computation graphs and backpropagation are central to modern deep learning.

