# Bias, Variance, and Neural Networks

## From a trade-off to an iterative recipe

With polynomial regression, a simple model tends toward high bias and a complex model tends toward high variance. Choosing model complexity or regularization therefore appears to require a bias–variance trade-off.

Large neural networks change this picture. When trained on small- to moderate-sized datasets, a sufficiently large network can usually fit the training set well and therefore often behaves as a **low-bias machine**. Together with access to large datasets, this provides separate ways to address bias and variance instead of always balancing one against the other.

## Neural-network development loop

1. **Train the neural network on the training set.**
2. **Ask whether it performs well on the training set.** Compare $J_{\text{train}}$ with a baseline such as human-level performance.
   - If not, the model has high bias.
   - Make the network larger by adding hidden layers or hidden units per layer, then train again.
   - Continue until training performance is roughly comparable to the target level.
3. **Ask whether it performs well on the cross-validation set.**
   - If training performance is good but CV performance is poor, the large gap
     $$
     J_{\text{cv}}-J_{\text{train}}
     $$
     indicates high variance.
   - Obtain more data, retrain, and repeat the checks.
4. **Stop when CV performance is good.** A model that performs well on the cross-validation set will hopefully generalize well to new examples.

This recipe is powerful when it applies, but not universal.

## Practical limitations

### Computational cost

Larger networks can reduce bias, but training eventually becomes expensive. Fast computers and especially GPUs have helped make large-network training practical, yet beyond some size the training time can still become infeasible. A larger network also slows both training and inference.

### Data availability

More data is a strong response to high variance, but some applications have a hard limit on how much data can be collected.

These two constraints explain why the loop cannot always be continued indefinitely.

## Bias and variance can change during development

The current diagnosis is not permanent. At one point, a network may have high bias, leading the team to enlarge it. After that change, it may fit the training set well but develop high variance, leading the team to collect more data. Measuring the two errors after each iteration determines which response is appropriate at that time.

## Does a network become “too large”?

A large neural network with appropriately chosen regularization will usually perform at least as well as, and sometimes better than, a smaller network. Moving to a larger network therefore rarely harms predictive performance when it is regularized appropriately.

The main caveat is computational: the larger model takes more time and resources to train and to run.

## Regularizing a neural network

If the unregularized network objective is the average loss—such as squared-error loss or logistic loss—regularization adds a penalty over all weights in the network:

$$
J(\mathbf{W},\mathbf{b})
=
\frac{1}{m}\sum_{i=1}^{m}
L\!\left(f_{\mathbf{W},\mathbf{b}}(\mathbf{x}^{(i)}),y^{(i)}\right)
+
\frac{\lambda}{2m}
\sum_{\text{all weights }W}W^2.
$$

As in linear and logistic regression, the bias parameters are usually not regularized, although the lesson notes that regularizing them makes very little difference in practice.

In TensorFlow, regularization is added to a layer with the argument **kernel_regularizer=tf.keras.regularizers.l2(0.01)**. The framework allows different $\lambda$ values for different layers, though the same value can be used for all weights across the layers for simplicity.

## Key conclusions

- A larger neural network rarely hurts predictive performance when regularization is chosen appropriately; its main cost is slower computation.
- If the training set is not too large, a sufficiently large neural network is often low bias because it can represent and fit complicated functions.
- Consequently, once a network is large enough, neural-network development often focuses more on variance than bias.
- Even though deep learning changes the traditional bias–variance trade-off, measuring bias and variance remains valuable for deciding what to do next.
