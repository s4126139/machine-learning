# Classification: Predicting Categories

## Core idea

Classification is supervised learning where the target is a **finite set of labels**. A model learns from examples whose labels are known, then assigns a label (and sometimes a probability or score) to a new example. The model is useful only when the label has a clear operational meaning: for example, “default within 12 months,” not the vague label “risky.”

The boundary between classes may be simple or highly nonlinear. Logistic regression, decision trees, K-nearest neighbors (KNN), support vector machines (SVMs), Naive Bayes, and neural networks are all possible classifiers; they make different assumptions about that boundary.

## How training and prediction work

1. Define the label and prediction time horizon, then assemble labeled examples and input features available at that time.
2. Fit a classifier on the training examples. The learning objective depends on the algorithm: for example, a tree reduces class impurity, an SVM maximizes a margin, and KNN stores labeled examples for later comparison.
3. At prediction time, the model maps a feature vector to a class. A probabilistic model may also return class probabilities; a decision threshold then turns a probability into an action or label.

For (K) classes, a native multiclass model predicts among all (K) labels directly. A binary learner can also be extended using:

- **One-vs-rest (OvR):** fit (K) classifiers, each separating one class from all others. Select the class with the strongest score. It is compact, but scores from different classifiers may not be directly comparable.
- **One-vs-one (OvO):** fit one classifier for each class pair, giving (K(K-1)/2) models, then combine their votes or scores. This can work well with pairwise learners such as kernel SVMs but creates more models as the number of labels grows.

Scikit-learn estimators often handle multiclass classification automatically. `SVC` uses an OvO strategy internally; other estimators may use native multiclass learning or OvR. Check the estimator documentation when the strategy matters.

## Example: loan default

Suppose a bank wants to flag applicants likely to default within a year. Features might include income, debt-to-income ratio, and credit history, and the target is `default_within_12_months` (yes/no). Train on past applications, keeping only information that was available at application time. A predicted probability such as 0.18 is not itself a decision: the bank must choose a threshold based on the cost of missed defaults, unnecessary reviews, fairness requirements, and available capacity.

Other classification tasks include spam filtering, handwriting recognition, churn prediction, campaign response, document categorization, and choosing among three treatment categories. In medical use, a model should support qualified care and be validated for the intended population; it should not be treated as an automatic prescription.

## Multiclass and imbalanced labels

When one class is rare, accuracy can look high while the model misses most examples of that class. Inspect the confusion matrix and class-wise precision, recall, and F1; use balanced accuracy when appropriate. Consider class weights, resampling performed **inside each training fold**, or a threshold chosen for the desired precision/recall tradeoff. Probability scores may need calibration before they are interpreted as reliable risks.

## Scikit-learn pattern

```python
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report
from sklearn.tree import DecisionTreeClassifier

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, stratify=y, random_state=42
)
model = DecisionTreeClassifier(max_depth=4, class_weight="balanced", random_state=42)
model.fit(X_train, y_train)
predictions = model.predict(X_test)
print(classification_report(y_test, predictions))
```

Use stratification for a single holdout when class proportions should be preserved. In a real comparison, fit preprocessing and models within a cross-validation pipeline, and keep the final test set untouched until decisions are complete.

## Assumptions and common pitfalls

- The labels are accurate, consistent, and represent the decision you care about.
- Training examples resemble future examples; distribution shift can invalidate past performance.
- Features must be available at prediction time. Post-outcome fields leak the answer.
- A default 0.5 threshold is not automatically appropriate, especially under class imbalance or unequal error costs.
- Multiclass “probabilities” and scores are not necessarily calibrated or comparable across models.
- Do not evaluate on the same examples used to fit the model; use held-out data or cross-validation.

## Active recall

1. What makes a target a classification target rather than a regression target?
2. How do OvR and OvO turn a binary learner into a multiclass classifier?
3. Why can accuracy be misleading when defaults are rare, and what should you inspect instead?
