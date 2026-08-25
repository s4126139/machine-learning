# One-Hot Encoding of Categorical Features

The first cat-classification examples used only binary categorical features:

- ear shape: pointy or floppy;
- face shape: round or not round;
- whiskers: present or absent.

A categorical feature may instead have more than two possible values. For example, ear shape could be **pointy**, **floppy**, or **oval**.

## The direct multiway split

One option is to split the ear-shape node into three branches, producing one subset for each of the three categories. The lesson instead develops another representation that keeps every input feature binary: **one-hot encoding**.

## Replacing one feature with binary features

Replace the original ear-shape feature with three new features:

| Original ear shape | Pointy? | Floppy? | Oval? |
|---|---:|---:|---:|
| Pointy | $1$ | $0$ | $0$ |
| Floppy | $0$ | $1$ | $0$ |
| Oval | $0$ | $0$ | $1$ |

Exactly one entry in each row equals $1$. That active entry is the “hot” feature, which gives the method its name.

## General rule

If a categorical feature can take one of $k$ possible values, replace it with $k$ binary features:

$$
x_{\text{category}}
\longrightarrow
\left(x_1,x_2,\ldots,x_k\right),
\qquad x_j\in\{0,1\},
$$

with exactly one of the $k$ values equal to $1$ for each example.

The transformation returns the dataset to the binary-feature setting, so the decision-tree algorithm already developed can be used without further modification.

## Encoding the complete cat example

The original categorical inputs can be represented by five numerical features:

1. pointy ears;
2. floppy ears;
3. oval ears;
4. round face;
5. whiskers present.

Face shape is encoded as $1$ for round and $0$ for not round. Whiskers are encoded as $1$ for present and $0$ for absent.

## Use beyond decision trees

One-hot encoding is not limited to decision trees. The resulting zeros and ones can also be used as numerical inputs for:

- neural networks;
- linear regression;
- logistic regression.

## Key takeaway

One-hot encoding converts one $k$-valued categorical feature into $k$ binary features. Each example activates exactly one of them, allowing algorithms that expect binary or numerical inputs to use the original category information.
