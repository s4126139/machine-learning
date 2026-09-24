# Module 5 Summary and Highlights

![Validation workflow and metric-selection quick guide](../../assets/module-5-evaluation-and-validation-workflow.svg)

## What to remember

- Evaluation estimates behavior on unseen data. Choose a split strategy that reflects class balance, repeated entities, and time order.
- Classification metrics describe different errors: accuracy summarizes all decisions, precision focuses on false positives, recall on false negatives, and F1 balances precision and recall.
- Regression metrics make different error trade-offs: MAE weights absolute error evenly; RMSE emphasizes large misses; R-squared compares with a mean baseline and may be negative on held-out data.
- Unsupervised models lack target labels. Combine internal metrics, external comparison when reference labels exist, stability, visual inspection, and domain expertise.
- Cross-validation supports model and hyperparameter selection. Any learned preprocessing must be fitted inside each training fold.
- Regularization shrinks coefficients to control overfitting: Ridge uses L2, Lasso uses L1 and can create sparse coefficients. Tune the strength on validation data.
- Leakage happens when unavailable information crosses into training or evaluation. Protect time/group boundaries and keep the final test set out of tuning.

## Safe model-evaluation sequence

1. Define the prediction moment, outcome, positive class (if any), and cost of mistakes.
2. Build a leakage-safe split and pipeline.
3. Choose metrics before comparing models; inspect subgroup and residual/error patterns.
4. Select features, transformations, regularization, thresholds, and hyperparameters using training data and cross-validation.
5. Refit the chosen pipeline on the available training data and evaluate once on the reserved test set.
6. Document the split, metric, variation, limits, and production feature availability.

## Review prompts

- Which error is costly in this application: false positives, false negatives, or large numeric misses?
- Are validation samples independent, or should the split respect groups or time?
- Are transformations fitted separately inside every fold?
- Does an impressive score still hold for minority classes and important subgroups?
- Could a production feature contain future or post-outcome information?