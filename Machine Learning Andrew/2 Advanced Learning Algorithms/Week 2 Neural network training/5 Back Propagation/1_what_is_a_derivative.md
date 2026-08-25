# What Is a Derivative?

TensorFlow uses backpropagation to compute derivatives of the cost with respect to a neural network's parameters. Gradient descent or Adam then uses those derivatives to train the parameters. This optional lesson develops the derivative intuition needed to understand backpropagation.

## Informal definition

Suppose changing $w$ by a tiny amount $\epsilon$ changes $J(w)$ by approximately $k\epsilon$:

$$
w\longrightarrow w+\epsilon
\quad\Rightarrow\quad
J(w)\longrightarrow J(w)+k\epsilon.
$$

Then the derivative of $J$ with respect to $w$ is $k$:

$$
\frac{\partial J}{\partial w}=k.
$$

The smaller $\epsilon$ is, the more accurate this local approximation becomes.

## First example: $J(w)=w^2$

Let

$$
J(w)=w^2
$$

and evaluate it at $w=3$:

$$
J(3)=3^2=9.
$$

If $\epsilon=0.001$, then

$$
J(3.001)=3.001^2=9.006001.
$$

The change in $J$ is approximately

$$
0.006=6(0.001)=6\epsilon.
$$

Thus, at $w=3$,

$$
\frac{\partial J}{\partial w}\approx 6.
$$

Trying $\epsilon=0.002$ gives

$$
J(3.002)=9.012004,
$$

which is again approximately $9+6\epsilon$. The small extra term is present because $\epsilon$ is small but not infinitesimally small.

Calculus gives the derivative function

$$
\frac{\partial}{\partial w}w^2=2w.
$$

Therefore, the derivative depends on the value of $w$:

| $w$ | $J(w)=w^2$ | $\dfrac{\partial J}{\partial w}=2w$ | Meaning of a small increase in $w$ |
|---:|---:|---:|---|
| $3$ | $9$ | $6$ | $J$ rises by about $6\epsilon$ |
| $2$ | $4$ | $4$ | $J$ rises by about $4\epsilon$ |
| $-3$ | $9$ | $-6$ | $J$ falls by about $6\epsilon$, or rises by $-6\epsilon$ |

For the negative example,

$$
J(-2.999)=(-2.999)^2=8.994001,
$$

so increasing $w$ from $-3$ by $0.001$ decreases $J$ by approximately $0.006$.

## Derivative as slope

On a plot of $J(w)$ against $w$, the derivative is the slope of the line that just touches the curve at the chosen value of $w$.

For $J(w)=w^2$:

- the tangent slope at $w=3$ is $6$;
- the tangent slope at $w=2$ is $4$;
- the tangent slope at $w=-3$ is $-6$.

The same function has different derivatives at different locations.

## Why the derivative matters for gradient descent

Gradient descent updates a parameter with

$$
w_j
\leftarrow
w_j-\alpha\frac{\partial J}{\partial w_j}.
$$

- If the derivative is small, changing $w_j$ has little effect on $J$, so the update is small.
- If the derivative is large, even a small parameter change has a large effect on $J$, so the update is larger.

The derivative therefore tells the optimizer how sensitively the cost responds to that parameter.

## More derivative examples at $w=2$

| Function $J(w)$ | Derivative | Derivative at $w=2$ |
|---|---|---:|
| $w^2$ | $2w$ | $4$ |
| $w^3$ | $3w^2$ | $12$ |
| $w$ | $1$ | $1$ |
| $\dfrac{1}{w}$ | $-\dfrac{1}{w^2}$ | $-\dfrac14=-0.25$ |

### Checking $J(w)=w^3$

At $w=2$, $J=8$. With $\epsilon=0.001$,

$$
J(2.001)=2.001^3\approx 8.012,
$$

so $J$ increases by approximately $12\epsilon$, matching the derivative $3w^2=12$.

### Checking $J(w)=w$

At $w=2$, increasing $w$ to $2.001$ changes $J$ from $2$ to $2.001$. The change is exactly $1\epsilon$, so the derivative is $1$.

### Checking $J(w)=1/w$

At $w=2$, $J=0.5$. With $\epsilon=0.001$,

$$
J(2.001)=\frac{1}{2.001}\approx 0.49975.
$$

The change is approximately

$$
-0.00025=-0.25\epsilon,
$$

so the derivative is $-0.25=-1/4$.

These examples show that the derivative depends on both the function being differentiated and the value at which it is evaluated.

## Computing derivatives with SymPy

The Python package **SymPy** can calculate symbolic derivatives.

The workflow shown is:

1. import SymPy;
2. define $J$ and $w$ as symbolic expressions;
3. compute the derivative with `sympy.diff(J, w)`;
4. substitute a numerical value using the derivative's `subs(w, 2)` operation.

For example:

- if $J=w^2$, SymPy returns $2w$, which becomes $4$ at $w=2$;
- if $J=w^3$, it returns $3w^2$, which becomes $12$ at $w=2$;
- if $J=w$, it returns $1$;
- if $J=1/w$, it returns $-1/w^2$, which becomes $-1/4$ at $w=2$.

## Derivative notation

When a function has one variable, calculus texts often use an ordinary derivative:

$$
\frac{dJ}{dw}.
$$

When $J$ depends on multiple variables and the derivative is taken with respect to one of them, texts use the partial-derivative symbol:

$$
\frac{\partial J}{\partial w_i}.
$$

Because machine-learning cost functions usually depend on many parameters, the partial-derivative notation is usually appropriate. These notes use it consistently, even when illustrating a one-variable example.

Common abbreviated forms include

$$
\frac{\partial J}{\partial w_i},
\qquad
\partial J/\partial w_i.
$$

The essential interpretation is unchanged: if $w_i$ increases by a tiny $\epsilon$, the derivative tells how many times $\epsilon$ the cost changes by.
