# XGBoost

**XGBoost**, short for **Extreme Gradient Boosting**, is a widely used open-source implementation of boosted decision trees. It runs quickly, is easy to use through its libraries, and has been successful in machine-learning competitions and commercial applications.

## From bagging to boosting

Bagging repeatedly:

1. samples a new training set with replacement;
2. trains a decision tree on that sample.

Every original example has equal probability of being selected for each bagged dataset.

Boosting changes the emphasis after the first tree. Later trees focus more on training examples that the earlier trees or current ensemble still handles poorly.

## Deliberate-practice intuition

The lesson compares boosting with learning a piano piece. Repeating the entire piece gives equal practice to easy and difficult passages. A more efficient strategy is to identify the passages that are still weak and practice those more often.

Boosting follows the same idea:

- evaluate what the existing trees are getting wrong;
- direct the next tree's attention toward those difficult examples;
- repeat so that each new tree works on weaknesses remaining in the ensemble.

## Iterative boosting procedure

For trees $b=1,2,\ldots,B$:

1. Train the first tree using the training data.
2. Evaluate the tree on the **original** training set and mark correct and incorrect predictions.
3. When constructing the next tree, give misclassified examples a higher chance of influencing its training.
4. For tree $b$, emphasize examples that the ensemble of trees $1$ through $b-1$ still predicts poorly.
5. Continue until $B$ trees have been built.

The exact mathematics that controls how much each example's importance changes is complex and is handled by boosted-tree libraries.

## How XGBoost implements the idea

The sampling explanation captures the intuition, but XGBoost does not need to generate many random training sets. It assigns different **weights** to training examples, making the procedure more efficient while retaining the focus on examples the current ensemble handles poorly.

XGBoost also provides:

- fast and efficient training;
- useful default criteria for splitting;
- useful default stopping criteria;
- built-in regularization to reduce overfitting.

These properties have made XGBoost highly competitive on platforms such as Kaggle. The lesson notes that XGBoost and deep-learning algorithms are two types of algorithms that win many competitions.

## Library interface

The detailed algorithm is complex to implement from scratch, so practitioners commonly use the open-source library:

- use **XGBClassifier** for classification;
- use **XGBRegressor** for regression.

In each case, initialize the model, fit it to the training data, and then use it to make predictions.

## Bagging versus boosting

| Bagging | Boosting |
|---|---|
| Trains trees on resampled datasets | Trains trees sequentially with changing example emphasis |
| Initially treats examples equally in each sampling procedure | Focuses later trees on examples the current ensemble handles poorly |
| Diversifies trees through resampling; the lesson's classifier combines their votes | Gains performance by repeatedly addressing remaining errors |

## Key takeaway

Boosting builds trees sequentially. Each new tree concentrates on examples that the existing ensemble has not yet learned well; XGBoost provides a fast, regularized implementation of that idea for classification and regression.
