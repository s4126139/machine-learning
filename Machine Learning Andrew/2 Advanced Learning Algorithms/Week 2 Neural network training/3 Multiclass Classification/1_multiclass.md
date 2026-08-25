# Multiclass Classification

## Definition

A **multiclass classification** problem has more than two possible output labels. The target $y$ still belongs to a small set of discrete categories rather than taking any numerical value, but the set contains more than the two classes used in binary classification.

Examples include:

- recognizing all ten handwritten digits, 0 through 9, when reading a postal or ZIP code;
- classifying a patient into one of three or five possible diseases;
- inspecting a manufactured pill for different defect categories, such as a scratch, discoloration, or a chip.

## From binary to multiclass prediction

In binary classification, $y\in\{0,1\}$, and logistic regression estimates

$$
P(y=1\mid x).
$$

A dataset might be plotted using two input features, $x_1$ and $x_2$, with one symbol for each of the two classes.

In a four-class problem, the plot could instead use circles, crosses, triangles, and squares for the four categories. The model must estimate a probability for each possible label:

$$
P(y=1\mid x),\quad
P(y=2\mid x),\quad
P(y=3\mid x),\quad
P(y=4\mid x).
$$

The learned decision boundaries divide the feature space into four regions instead of only two.

## Next model

**Softmax regression** generalizes logistic regression from binary to multiclass classification. Once softmax is placed in the output layer of a neural network, the entire network can perform multiclass classification.

