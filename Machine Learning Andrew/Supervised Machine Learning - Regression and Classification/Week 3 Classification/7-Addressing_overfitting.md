# Addressing Overfitting

## 1. Recognizing the Goal

Later in the specialization, specific diagnostic tools will help identify whether a learning algorithm is underfitting or overfitting. For now, suppose a model has already been identified as overfit, meaning that it has **high variance**. There are three main ways to address the problem.

## 2. Collect More Training Data

The first option is to collect more training examples.

In the house-price example, adding more observations of house sizes and prices can constrain a flexible, high-order polynomial. With enough data, the learning algorithm is less likely to fit an unnecessarily wiggly curve and may generalize better.

Collecting more data can be effective against overfitting, but it is not always possible. For example, there may be only a limited number of house sales in the location being studied.

## 3. Use Fewer Features

The second option is to reduce the number of input features.

For a polynomial model, this could mean excluding some terms from:

$$
x,\ x^2,\ x^3,\ x^4,\ldots
$$

Overfitting can also occur when a dataset has many different features but not enough training examples. A house-price model might have $100$ features, including:

- size;
- number of bedrooms;
- number of floors;
- age of the house;
- average neighborhood income;
- distance to the nearest coffee shop.

Instead of using all $100$ features, the model could use a smaller set believed to be most useful, such as size, number of bedrooms, and age.

Choosing an appropriate subset of the available inputs is called **feature selection**. Domain knowledge can guide this choice, and later in Course 2, algorithms for selecting features automatically are introduced.

### Trade-Off of Feature Selection

Using fewer features can reduce overfitting, but it also discards information. If many or all of the original features genuinely help predict price, removing them may weaken the model. This motivates a gentler alternative that retains the features.

## 4. Use Regularization

The third option is **regularization**. In an overfit polynomial model, some parameters may become relatively large:

$$
f_{\mathbf{w},b}(x)
= w_1x + w_2x^2 + w_3x^3 + w_4x^4 + b
$$

Eliminating the feature $x^4$ is equivalent to setting its parameter to zero:

$$
w_4 = 0
$$

Regularization takes a less drastic approach. It encourages the learning algorithm to make the parameters smaller without necessarily forcing them to be exactly zero.

As a result, regularization:

- keeps all the features available to the model;
- reduces the influence of features whose weights would otherwise become too large;
- can turn a highly irregular high-order curve into a smoother curve that generalizes better.

By convention, regularization usually shrinks the weights $w_1,\ldots,w_n$ but not the bias $b$. Regularizing $b$ as well generally makes little practical difference, but it is commonly left unregularized.

Regularization is widely used not only in linear and logistic regression but also in other learning algorithms, including neural networks.

## 5. Three Ways to Reduce Overfitting

To recap:

1. **Collect more training data** when additional examples are available.
2. **Select fewer features** when the model has more inputs than the available data can support.
3. **Regularize the parameters** to reduce feature influence without discarding the features entirely.

## 6. Optional Lab and Next Step

The optional lab builds intuition about overfitting in both regression and classification. It allows you to:

- add training examples and observe how the fitted curve changes;
- include or exclude features;
- vary the polynomial degree using features such as $x$, $x^2$, and $x^3$;
- compare adding data and selecting features as methods for reducing overfitting.

The next video defines regularization more precisely and shows how to apply it to linear regression, logistic regression, and eventually other learning algorithms.

## Key Takeaway

Overfitting can be reduced by collecting more data, using fewer features, or regularizing the model's parameters. Regularization is especially useful because it preserves the available features while limiting their ability to distort the model.
