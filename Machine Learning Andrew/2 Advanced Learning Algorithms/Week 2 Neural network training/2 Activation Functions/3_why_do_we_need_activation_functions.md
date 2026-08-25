# Why Neural Networks Need Nonlinear Activation Functions

If every neuron uses the linear activation $g(z)=z$, a multilayer neural network becomes equivalent to linear regression. It cannot learn anything more complex than a linear model, defeating the purpose of using multiple layers.

## A two-layer scalar example

Consider a network with:

- one scalar input $x$;
- one hidden unit with parameters $w_1,b_1$ and activation $a_1$;
- one output unit with parameters $w_2,b_2$ and activation $a_2=f(x)$.

Use the linear activation in both layers.

### Hidden layer

$$
a_1=g(w_1x+b_1)=w_1x+b_1.
$$

### Output layer

$$
\begin{aligned}
a_2
&=g(w_2a_1+b_2)\\
&=w_2a_1+b_2\\
&=w_2(w_1x+b_1)+b_2\\
&=(w_2w_1)x+(w_2b_1+b_2).
\end{aligned}
$$

Define

$$
w=w_2w_1,
\qquad
b=w_2b_1+b_2.
$$

Then

$$
a_2=wx+b.
$$

The entire two-layer network is therefore just a linear function of $x$, equivalent to linear regression. This follows from the fact that a linear function of a linear function is still linear.

## The same collapse in deeper networks

Adding more hidden layers does not solve the problem if all of them remain linear. Repeated compositions of linear functions still reduce to one linear function, so a deep network with linear hidden and output layers can be written as

$$
a^{[L]}=Wx+b
$$

for some resulting $W$ and $b$.

Two important cases follow:

1. **Linear hidden layers + linear output:** the network is equivalent to linear regression.
2. **Linear hidden layers + sigmoid output:** the linear hidden stack first collapses to $Wx+b$, after which sigmoid gives

$$
a^{[L]}=\frac{1}{1+e^{-(Wx+b)}},
$$

so the network is equivalent to logistic regression.

A large network configured this way cannot do more than the corresponding single linear or logistic-regression model.

## Practical rule

Do not use linear activation in the hidden layers. ReLU is the recommended default:

$$
g(z)=\max(0,z).
$$

Nonlinear hidden activations are what allow multiple layers to learn computations more complex than a single linear function. Output activations should still be selected according to the task: sigmoid for binary classification, linear for signed regression targets, and ReLU for non-negative regression targets.

