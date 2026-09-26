# Gaussian (Normal) Distribution

A Gaussian distribution describes a continuous feature using a center and a
spread. It is also called the normal distribution; “bell-shaped curve” refers
to its familiar density shape.

For a feature $x$ with mean $\mu$ and variance $\sigma^2$,

$$
p(x;\mu,\sigma^2)=
\frac{1}{\sqrt{2\pi\sigma^2}}
\exp\!\left(-\frac{(x-\mu)^2}{2\sigma^2}\right).
$$

The mean $\mu$ moves the center. The standard deviation $\sigma$ controls the
width: a smaller $\sigma$ makes the curve narrower and taller, while a larger
$\sigma$ makes it wider and shorter. The total area under every valid density
curve is one.

![Gaussian density curves showing how changing the mean shifts the center and changing the standard deviation changes the spread](<images/gaussian-distribution-parameters.png>)

The curve's height $p(x)$ is a **density**, not the probability of observing
one exact real number. Probabilities come from areas over intervals. For
example, $P(a\leq X\leq b)$ is the area under the curve from $a$ to $b$.

## Estimate the parameters from data

Given normal training values $x^{(1)},\ldots,x^{(m)}$, the course uses the
maximum-likelihood estimates

$$
\mu=\frac{1}{m}\sum_{i=1}^{m}x^{(i)},
\qquad
\sigma^2=\frac{1}{m}\sum_{i=1}^{m}(x^{(i)}-\mu)^2.
$$

The second expression uses $1/m$, which is the maximum-likelihood estimate;
the unbiased sample-variance formula commonly uses $1/(m-1)$ instead. For
fitting this model, follow the formula used by the algorithm.
