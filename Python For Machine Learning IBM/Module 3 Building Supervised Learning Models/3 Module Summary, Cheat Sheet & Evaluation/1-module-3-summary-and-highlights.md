# Module 3 Summary and Highlights

Module 3 broadens supervised learning beyond linear and logistic regression. Its central choice is the target type: **classification** predicts a category; **regression** predicts a numeric value. Within either task, models differ in the shapes they can learn, how they react to feature scale and noise, their training and prediction cost, and how easily people can interpret their decisions.

![Model selection starting points for classification and regression](../../assets/module-3-model-selection.svg)

## Models covered

| Model | Target | Learning intuition | Useful when | Main caution |
| --- | --- | --- | --- | --- |
| Decision tree | Categorical | Repeated feature tests create regions; predict the most common class at a leaf. | Rules, threshold effects, and interactions matter. | Deep trees overfit and can be unstable. |
| Regression tree | Numeric | Repeated splits reduce within-leaf target error; predict a leaf summary. | Piecewise-constant nonlinear predictions are useful. | Does not extrapolate naturally; deep leaves fit noise. |
| SVM / SVR | Categorical / numeric | Maximum-margin boundary or epsilon-tolerant regression function; kernels model nonlinear structure. | Scaled, moderate-sized data; high-dimensional or margin-based problems. | Tune scale, kernel, `C`, `gamma`, and `epsilon`; kernel models can be costly. |
| KNN | Categorical / numeric | Nearby training examples vote or contribute to an average. | Local similarity is meaningful and feature space is modest. | Scaling, irrelevant features, high dimension, and prediction-time cost matter. |
| Random forest | Categorical / numeric | Average/vote over randomized, bootstrap-trained trees. | Nonlinear tabular baseline; reduce single-tree variance. | Less transparent than one tree; tune tree size and check cost. |
| Boosting | Categorical / numeric | Sequential weak learners improve the current ensemble's errors. | A strong nonlinear additive fit is useful and tuning is possible. | Sensitive to noise and tuning; stages can overfit. |

The target determines the task, but it does not dictate one algorithm. Run comparable candidates on the same train/validation splits and select using a metric aligned with the real objective.

## A practical model-selection loop

1. **Specify the target and decision.** Define which label or numeric quantity is predicted, when prediction occurs, and how its output will be used.
2. **Start with a simple reference model.** A constant baseline, linear/logistic model from Module 2, or shallow tree reveals whether more complex models add value.
3. **Prepare features without leakage.** Fit scaling and encoding on training folds only. SVM and KNN depend on scale; trees generally do not. Remove information that would only be known after the prediction time.
4. **Compare suitable candidates.** Choose a validation scheme that reflects how data arrives (for example, stratified folds for classification or time/group-aware splits when observations are dependent). Tune hyperparameters on validation data only.
5. **Diagnose fit.** Poor training and validation scores can indicate underfitting, weak features, or label problems. Strong training performance with weak validation performance indicates overfitting or distribution mismatch.
6. **Keep an untouched final test set.** After choosing the approach, report its performance once on data not used for fitting, feature decisions, or tuning.

Possible classification metrics include precision, recall, F1, balanced accuracy, and ROC-AUC; choose based on class balance, error costs, and how the model is used. For regression, MAE is directly interpretable in target units; RMSE penalizes large errors more strongly. Do not compare algorithms with a metric that does not reflect the intended outcome.

## Multiclass reminder

Some classifiers learn multiple categories directly; binary classifiers can be combined using one-vs-rest (one model per category) or one-vs-one (one per pair, then combine votes/scores). Scikit-learn estimators may choose their own strategy. Verify behavior when the strategy or probability output affects the application.

## Main lesson

There is no universally best supervised model. Prefer the simplest candidate that meets the validated quality, robustness, interpretability, and cost requirements. A complex model is justified when it improves performance on unseen data enough to matter.

## Related notes

- [Classification](../1%20Classification%20and%20Regression/1-classification.md)
- [Classification decision trees](../1%20Classification%20and%20Regression/2-decision-trees.md)
- [Regression trees](../1%20Classification%20and%20Regression/3-regression-trees.md)
- [Support vector machines](../2%20Other%20Supervised%20Learning%20Models/4-supervised-learning-with-svms.md)
- [K-nearest neighbors](../2%20Other%20Supervised%20Learning%20Models/5-supervised-learning-with-knn.md)
- [Bias, variance, and ensembles](../2%20Other%20Supervised%20Learning%20Models/6-bias-variance-and-ensemble-models.md)

## Review prompts

1. Which models in this module need feature scaling, and why?
2. What evidence distinguishes underfitting from overfitting?
3. Why must the final test set remain untouched while choosing models and hyperparameters?
