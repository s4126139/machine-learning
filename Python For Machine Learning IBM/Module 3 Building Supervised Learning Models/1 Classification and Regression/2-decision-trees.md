# Classification Decision Trees

## Core idea

A decision tree turns feature tests into a sequence of rules. Each internal node asks a question (for example, `debt_to_income <= 0.35`), each branch follows an answer, and a leaf gives a class prediction. This resembles a flowchart and makes a small tree relatively easy to explain.

## How it learns and predicts

The tree starts with all training rows at the root. At every node it searches over candidate features and thresholds, choosing the split that most improves class homogeneity. Common criteria are **Gini impurity** and **entropy/information gain**. A pure node has all examples from one class; a mixed node has greater impurity. The data is partitioned recursively until a stopping condition is reached. At a leaf, classification is based on the class distribution among its training examples (the most common class by default).

To control complexity, stop growth early (**pre-pruning**) or grow a larger tree and prune weak branches (**cost-complexity pruning**). Relevant scikit-learn controls include:

| Control | Effect |
| --- | --- |
| `max_depth` | Caps the number of rule levels. |
| `min_samples_split` | Requires enough samples before a node may split. |
| `min_samples_leaf` | Keeps leaves from representing too few training cases. |
| `max_leaf_nodes` | Caps the number of terminal regions. |
| `ccp_alpha` | Penalizes tree size during cost-complexity pruning. |
| `criterion` | Chooses Gini, entropy, or log-loss split quality. |

## Example: selecting a treatment category

Given historical patient features (such as age group and blood-pressure category) and the treatment associated with each observed outcome, a tree might first split on a clinically useful measurement and then refine only one branch using another feature. For a new patient, the model follows the learned tests to a leaf and predicts its most common treatment label. The tree describes associations in the historical data; it does not prove that the selected treatment caused better outcomes.

## Scikit-learn pattern

```python
from sklearn.tree import DecisionTreeClassifier, export_text

tree = DecisionTreeClassifier(
    criterion="gini", max_depth=4, min_samples_leaf=10, random_state=42
)
tree.fit(X_train, y_train)
print(export_text(tree, feature_names=list(X_train.columns)))
predictions = tree.predict(X_test)
```

For mixed numeric and categorical columns, encode categorical variables with a preprocessing pipeline. Current scikit-learn decision trees do not accept arbitrary string categories directly. Trees do not require feature scaling, though missing values and category encoding still need a deliberate strategy.

## When it works well

- The problem has threshold effects or feature interactions that a linear model cannot capture easily.
- Rules need to be inspected, explained, or visualized; keep the tree small enough for people to follow.
- Features have different scales: a tree's split order is generally unaffected by monotonic rescaling.
- You need a fast, interpretable baseline for tabular classification.

## Assumptions, limitations, and pitfalls

- Greedy splitting chooses the best local split, not necessarily the globally best tree.
- Deep trees can memorize training noise. Compare training and validation performance and prune or regularize.
- Small changes in the data can produce a very different tree; a single tree has high variance.
- Axis-aligned splits can require many rules for a diagonal boundary.
- Impurity-based feature importance can favor features with many possible split points; treat it as a clue, not a causal explanation.
- Imbalanced classes may produce leaves dominated by the majority class. Consider `class_weight`, suitable metrics, and threshold selection.
- A leaf's apparent class certainty can be unreliable when it contains few observations.

## Active recall

1. What is measured by Gini impurity or entropy, and what does a pure node look like?
2. How do `max_depth` and `min_samples_leaf` affect overfitting and interpretability?
3. Why can a readable tree still be unstable across different training samples?
