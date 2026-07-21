# Phase 01 — Problem Definition

## Purpose

Convert a business or research need into a precise, measurable machine-learning task.

## Visual map

```mermaid
flowchart LR
    A["Business or research need"] --> B["Decision and prediction unit"]
    B --> C["Task type and target"]
    C --> D["Prediction-time inputs"]
    D --> E["Primary metric and baseline"]
    E --> F["Operational constraints"]
    F --> G["Success criteria and owner"]
```

## When this phase applies / task-specific variants

- Always complete this phase before collecting new data or selecting an algorithm.
- Revisit it when the user, decision, target, operating constraints, or data availability changes.
- The prediction **task** and the data **modality** are separate choices: text or images may support regression, classification, clustering, or another task.

## Inputs

- business or research objective;
- intended users and decision process;
- available data and label sources;
- current manual process or baseline;
- error costs and risk tolerance;
- latency, budget, privacy, fairness, and interpretability constraints.

## Core tasks checklist

- [ ] Define the decision or action that the output will support.
- [ ] Define the prediction unit: customer, transaction, device, image, time interval, etc.
- [ ] Define the target, target availability, and label policy.
- [ ] Define the observation window, cutoff time, and prediction horizon.
- [ ] Select the task type: regression, classification, forecasting, clustering, anomaly detection, ranking, or recommendation.
- [ ] Confirm which features will be available at prediction time.
- [ ] Select one primary offline metric and relevant secondary metrics.
- [ ] Connect offline metrics to a business KPI or research outcome.
- [ ] Record the relative cost of false positives, false negatives, over-prediction, and under-prediction.
- [ ] Define a simple baseline and minimum acceptable improvement.
- [ ] Define latency, throughput, memory, interpretability, fairness, privacy, and security requirements.
- [ ] Define acceptance criteria, exclusions, known risks, and non-goals.
- [ ] Decide whether machine learning is necessary and operationally actionable.

## Case-specific decision table

| Case | Define explicitly | Candidate metric keywords | Key attention |
|---|---|---|---|
| Regression | Continuous target, prediction unit, acceptable error scale | MAE, RMSE, median absolute error, \(R^2\), pinball loss | Outliers, asymmetric cost, non-negative target, target censoring |
| Binary classification | Positive class, decision action, threshold ownership | precision, recall, F1, ROC-AUC, Average Precision, log loss, Brier loss | Class imbalance, error costs, probability versus final decision |
| Multiclass / multilabel | Class taxonomy, single-label versus multilabel output | macro/micro/weighted F1, log loss, top-k accuracy | Rare classes, ambiguous labels, averaging method |
| Time series / forecasting | Forecast origin, horizon, frequency, update schedule | MAE, RMSE, MAPE, pinball loss; custom sMAPE/WAPE/MASE | Future-data leakage, seasonality, backtesting, delayed labels |
| Grouped data | Entity/group ID and required generalisation target | Task metric plus group-level or subgroup reporting | Same person/device/site must not leak across partitions |
| Unsupervised learning | Intended use of clusters/components/anomaly scores | silhouette, Davies–Bouldin, Calinski–Harabasz; domain review | No universal ground truth; operational usefulness matters |
| Text | Task plus language, document unit, vocabulary/update policy | Metric follows regression/classification/ranking task | Duplicates, language coverage, sensitive content, serving cost |
| Image | Task plus image unit, label granularity, capture conditions | Metric follows task; often per-class metrics for classification | Copyright/consent, subject leakage, acquisition shift, compute |

## Scikit-learn keywords / APIs

Scikit-learn helps inspect targets and evaluate predictions; it does **not** define the business objective.

| Need | Native scikit-learn API |
|---|---|
| Inspect target structure | `sklearn.utils.multiclass.type_of_target` |
| Detect multilabel targets | `sklearn.utils.multiclass.is_multilabel` |
| List available scorer names | `sklearn.metrics.get_scorer_names` |
| Regression metrics | `mean_absolute_error`, `root_mean_squared_error`, `r2_score`, `mean_pinball_loss` |
| Classification metrics | `precision_score`, `recall_score`, `f1_score`, `roc_auc_score`, `average_precision_score`, `log_loss`, `brier_score_loss` |
| Clustering metrics | `silhouette_score`, `davies_bouldin_score`, `calinski_harabasz_score` |
| Custom scorer for CV/search | `sklearn.metrics.make_scorer` |

Business KPIs, cost–benefit analysis, fairness policy, privacy review, and product requirements are broader product/MLOps/governance work, not native scikit-learn functions.

## Key attention / pitfalls

- Starting with an algorithm instead of a decision and measurable objective.
- Ambiguous target, positive class, prediction unit, time cutoff, or horizon.
- Defining a target that cannot be observed reliably or soon enough.
- Including features that will not exist at prediction time.
- Choosing accuracy for a highly imbalanced or asymmetric-cost problem without justification.
- Treating probability estimation and decision-threshold selection as the same task.
- Optimising an offline metric that does not support the intended action or KPI.
- Ignoring subgroup performance, fairness, privacy, safety, or human-review requirements.
- Setting acceptance criteria only after seeing model results.
- Assuming text/image is a task type rather than an input modality.

## Outputs / deliverables

- approved problem statement;
- prediction unit, target, cutoff time, and horizon specification;
- task and modality classification;
- primary/secondary metric list and business KPI mapping;
- baseline definition and acceptance criteria;
- constraints, risks, non-goals, and responsible owner;
- prediction-time feature availability statement.

## Exit criteria

- Stakeholders agree on what is predicted, for whom, when, and why.
- Labels and prediction-time inputs are realistically obtainable.
- The primary metric, baseline, and acceptance threshold are fixed before modelling.
- Error costs, constraints, and responsible decision owner are documented.
- A successful prediction can lead to a defined action or useful outcome.

---

[Previous: Lifecycle index](README.md) · [Index](README.md) · [Next: Data Collection and Governance](02_data_collection_and_governance.md)
