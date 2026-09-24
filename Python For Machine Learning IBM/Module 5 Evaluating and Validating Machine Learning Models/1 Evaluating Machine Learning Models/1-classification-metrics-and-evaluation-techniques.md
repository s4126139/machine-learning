# Classification Metrics and Evaluation Techniques

## What evaluation estimates

A classifier predicts a category; evaluation compares predictions with known labels on observations that were not used to fit that model. Keep a final test set aside until all model, feature, and threshold choices are finished. For a basic independent-data task, use a stratified train/test split so each partition keeps approximately the same class proportions.

## Confusion matrix

For a binary classifier, define the positive class before interpreting the matrix:

|  | Predicted positive | Predicted negative |
| --- | ---: | ---: |
| **Actually positive** | True positive (TP) | False negative (FN) |
| **Actually negative** | False positive (FP) | True negative (TN) |

Rows are actual classes and columns are predicted classes in scikit-learn’s confusion matrix. In multiclass classification, each diagonal cell is correct; off-diagonal cells show which classes are confused.

## Metrics and what they trade off

- **Accuracy** = (TP + TN) / (TP + TN + FP + FN). Fraction classified correctly. It can look excellent when a rare class is always missed.
- **Precision** = TP / (TP + FP). Of positive predictions, how many are correct? Higher precision reduces false alarms. Useful when acting on a false positive is costly, such as an expensive recommendation.
- **Recall / sensitivity** = TP / (TP + FN). Of actual positives, how many were found? Higher recall reduces missed positives. It matters in screening when a false negative is costly.
- **F1** = 2 × precision × recall / (precision + recall). Harmonic mean that is high only when both precision and recall are high. It ignores true negatives and does not include business costs.
- **Specificity** = TN / (TN + FP). Fraction of actual negatives correctly rejected. Consider it alongside recall when both types of error matter.

A classifier’s probability threshold controls a trade-off: lowering it usually increases recall and false positives; raising it usually increases precision while missing more positives. Pick the threshold on validation data using the costs of each error, not on the final test set.

For imbalanced classes, report per-class precision/recall/F1 and support. Macro average weights each class equally; weighted average weights by class count and can hide poor minority-class performance; micro average pools decisions across classes. Accuracy alone is rarely sufficient. If probability quality matters, also inspect calibration.

## scikit-learn pattern

    from sklearn.metrics import classification_report, confusion_matrix
    from sklearn.model_selection import train_test_split
    from sklearn.neighbors import KNeighborsClassifier

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )
    model = KNeighborsClassifier(n_neighbors=5).fit(X_train, y_train)
    predictions = model.predict(X_test)
    print(confusion_matrix(y_test, predictions))
    print(classification_report(y_test, predictions, zero_division=0))

If the model needs scaling, put the scaler and classifier in a pipeline and fit the pipeline only on training data. Do not choose K, features, or the decision threshold by repeatedly looking at the test scores.

## Example and interpretation

A disease screen can have high accuracy if most people are healthy, yet miss many sick patients. Recall exposes those false negatives; precision tells clinicians how many positive alerts are likely to be true. A movie recommender may instead prioritize precision if showing an unwanted recommendation has a cost. There is no universally best metric—the error consequences determine the choice.

## Pitfalls and recall questions

- Always state which label counts as positive.
- Check the denominator: precision is about predicted positives; recall is about actual positives.
- Metrics are estimates on a sample and vary with the split.
- A high score does not establish causality or guarantee performance after deployment.

1. Which metric answers “of the patients who are ill, how many did we detect”?
2. Which confusion-matrix cell is a false alarm? Which is a miss?
3. Why can weighted F1 conceal minority-class failure?
4. Where should a probability threshold be selected?