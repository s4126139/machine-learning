# Feature Engineering

## Core idea

The choice of input features can strongly affect the performance of a learning algorithm. Feature engineering uses knowledge or intuition about the problem to transform or combine existing features into new features that may make accurate prediction easier.

## House-price example

Assume a rectangular plot of land has two original features:

- `x1`: frontage or width;
- `x2`: depth.

A multiple linear regression model using only these features is:

```text
f(x) = w1*x1 + w2*x2 + b
```

Width and depth may be useful, but the area of the land may be more directly related to the price.

Create a new feature:

```text
x3 = x1 * x2
```

Here, `x3` represents the area of the plot.

The model can then use all three features:

```text
f(x) = w1*x1 + w2*x2 + w3*x3 + b
```

During training, the model learns `w1`, `w2`, and `w3`. The data therefore determines how much frontage, depth, and area contribute to the prediction.

## What feature engineering means

Feature engineering consists of:

- using knowledge or intuition about the application;
- transforming original features;
- combining multiple original features;
- designing a representation that makes prediction easier for the learning algorithm.

It is not necessary to use only the features originally provided by the dataset. A meaningful derived feature can produce a better model.

## Reasoning pattern

| Step | Question | House example |
|---|---|---|
| Understand the original variables | What does each feature represent? | Width and depth |
| Use problem knowledge | Is another quantity more meaningful? | Land area |
| Construct the feature | How can it be calculated? | `x3 = x1 * x2` |
| Add it to the model | Can the data determine its usefulness? | Learn `w3` together with `w1` and `w2` |

## Main takeaway

Good features can make a model more effective because they express useful relationships that may not be represented clearly by the original variables.

Creating powers or other transformations of a feature is another form of feature engineering that allows a model to fit curves rather than only straight lines.

## ML lifecycle phase

**Primary phase: Phase 05 — Preprocessing and Feature Engineering.**

This is the phase where original inputs are transformed or combined into model-ready features.

