# Checking Gradient Descent for Convergence

## Purpose

Check whether gradient descent is moving the parameters `w` and `b` toward values close to the global minimum of the cost function `J`.

Recognising correct convergence also helps identify problems with the learning rate `alpha` or the implementation.

## Plot the cost against iterations

During training, calculate the training cost after every simultaneous update of `w` and `b`, then plot:

- **Horizontal axis:** number of gradient-descent iterations.
- **Vertical axis:** training cost `J(w, b)` after each iteration.

The horizontal axis represents iterations, not a parameter such as `w` or `b`.

This plot is called a **learning curve** in this lesson. For example:

- the point at iteration 100 is the cost produced by the parameters learned after 100 updates;
- the point at iteration 200 is the cost produced after 200 updates.

## How to interpret the curve

| Curve behaviour | Meaning |
|---|---|
| `J` decreases after every iteration | Gradient descent is behaving as expected |
| `J` increases after an iteration | The learning rate may be too large, or the code may contain a bug |
| `J` is still decreasing noticeably | Training has not converged yet |
| `J` levels off and changes very little | Gradient descent has approximately converged |

A correctly running gradient descent should make `J` decrease after every iteration.

## Number of iterations

The required number of iterations cannot usually be predicted in advance and can vary greatly between applications:

- one problem may converge after about 30 iterations;
- another may require 1,000 iterations;
- another may require 100,000 iterations.

Therefore, plotting the learning curve is useful for deciding whether training should continue.

## Automatic convergence test

Let `epsilon` be a small number, for example:

```text
epsilon = 0.001 = 10^-3
```

If the decrease in cost during one iteration is smaller than `epsilon`, the curve is probably in its flat region and convergence may be declared:

```text
J(previous iteration) - J(current iteration) < epsilon
```

Choosing a suitable value for `epsilon` can be difficult. The lesson therefore prefers inspecting the learning curve because it also provides an early warning when gradient descent is not working correctly.

## Key checklist

- Record the training cost after every simultaneous parameter update.
- Confirm that the cost decreases after each iteration.
- Investigate the learning rate or code if the cost increases.
- Continue training while the cost is still decreasing noticeably.
- Treat a nearly flat cost curve as evidence of convergence.
- Do not assume the same iteration count will work for every problem.

## ML lifecycle phase

**Primary phase: Phase 07 — Model Training.**

Checking the convergence curve is part of monitoring the optimisation process while model parameters are being learned.

It also informs **Phase 08 — Validation and Hyperparameter Tuning**, because the observed behaviour helps with the later choice of learning rate `alpha`.

