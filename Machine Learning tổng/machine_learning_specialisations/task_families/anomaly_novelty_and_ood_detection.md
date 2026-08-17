# Anomaly, Novelty, and Out-of-Distribution Detection

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an independent lifecycle. Apply the core and add these controls whenever the system must flag rare, abnormal, novel, shifted, or unsupported inputs.

## Use this guide when

Use it for unsupervised/semi-supervised anomaly detection, one-class or novelty detection, event/sequence anomalies, or OOD detection attached to a predictive model. Add the modality guide that owns corruption, grouping and shift definitions.

## Do not confuse it with

- Outlier detection assumes training data may contain outliers; novelty detection trains on data intended to represent normality and evaluates new cases.
- OOD detection asks whether an input differs from the supported distribution; it is not identical to predicting whether the primary model is wrong.
- Rare-class supervised classification is appropriate when anomaly labels are representative; unsupervised scores are not automatically probabilities.
- Drift monitoring is population-level change; anomaly detection scores individual cases, though they may share signals.

## Scope and major variants

The guide covers point, contextual and collective anomalies; univariate/multivariate, temporal and structured cases; density, distance, reconstruction, isolation, one-class and predictive-error methods; and post-hoc OOD detectors. It does not assert one universal definition of abnormality.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define normality, anomaly/OOD families, score/threshold action, prevalence, label delay and contamination assumptions. | Detection contract, threat/shift catalogue, label and contamination audit. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Split by entity/time/source/session before windows/transforms; build training-normal pool without using locked anomalies; prevent synthetic anomaly leakage. | Normal/training-pool lineage and deployment-aware split manifest. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare rules/statistical detectors; tune operating thresholds on representative development anomalies/costs without test reuse. | Baseline and threshold-selection report. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Evaluate ranking plus declared operating points across anomaly/OOD families, sources and prevalence; include alert burden and detection delay. | Family/slice curves, operating-point table, locked prospective/external evidence. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package reference distribution, score, threshold and fallback; monitor score/alert/outcome drift; protect retraining from anomaly contamination; retire alert/reference state. | Detector contract, alert operations, clean-update, rollback and retirement plan. |

## Problem and data contract

Define the supported/normal distribution, each anomaly or OOD family in scope, detection unit, score semantics, threshold-dependent action, false-positive/false-negative costs, review capacity, label availability and delay. Record whether the training pool is assumed clean, its estimated contamination, exclusions and provenance. OOD test datasets or synthetic anomalies must represent named shifts or attacks; they cannot stand for every unknown future condition.

## Split and evaluation protocol

Split complete entities, sequences, sessions, devices, sites and time periods before deriving windows or representations. Do not tune contamination rate, detector, representation or threshold on the locked anomaly/OOD set. Use several independent anomaly/OOD families and a clean in-distribution set; reserve at least one source/time/family for final evidence when possible. Match operational prevalence or report prevalence-sensitive precision and alert volume under declared scenarios. Prospective shadow evaluation is preferred when labels are delayed or historical anomalies were selected by an old detector.

## Baselines and model-family choices

Include domain rules/limits, robust univariate or distance statistics, and a simple supervised classifier when representative labels exist. For OOD detection attached to a classifier, include a basic predictive-confidence score as a baseline, not as a guaranteed solution. Choose model families according to normal-pool cleanliness, local/global structure, dimensionality, temporal context, need for explanations, update rate, and scoring latency.

## Training and validation adaptations

Version the normal reference pool, contamination assumptions, representation, neighbourhood/window construction, synthetic-corruption generator, score direction/scale, random seeds and compute budget. Tune model and threshold separately: model selection may use ranking/coverage evidence, while the final operating threshold must reflect costs, capacity and safety constraints. If training updates from accepted traffic, quarantine reviewed anomalies and test poisoning/feedback risks.

## Metrics and uncertainty

Report AUROC only with prevalence-aware measures such as precision–recall, plus recall/sensitivity and false-positive rate at declared thresholds, precision/positive predictive value, alerts per operational unit, detection delay for sequences, and downstream review or loss outcomes. For OOD, break results down by each shift family and severity. Provide confidence intervals on independent entities/time blocks and threshold sensitivity. An unsupervised score requires empirical threshold and calibration evidence before probabilistic interpretation.

## Error analysis, safety, and robustness

Inspect false alarms and misses by anomaly family, severity, source, subgroup, time, density and distance from training support. Test mundane corruptions separately from semantic novelty, adversarial evasion/poisoning when relevant, correlated alert bursts, gradual change, new normal regimes and sensor failures. Verify that abstention, quarantine, blocking or human escalation is proportional to detector uncertainty and harm; a detector must fail safely when its reference distribution is unavailable or stale.

## Packaging, deployment, monitoring, and maintenance

Package preprocessing/representation, reference data summary or fitted detector, score definition/direction, threshold(s), calibration and version, expected prevalence, alert schema, explanation fields, suppression/dedup rules, fallback and reviewer workflow. Monitor score and alert distributions, volume/capacity, subgroup/source rates, confirmed precision/recall with label delay, reference age and upstream data quality. Changes to reference pool, contamination, representation, detector, threshold or anomaly definition are separate update types; retain old thresholds/models for rollback and never absorb unreviewed anomalies silently.

## Minimum completion checklist

- [ ] Normal/support scope, anomaly/OOD families, score, action, costs, capacity and label delay are explicit.
- [ ] Training-pool provenance and contamination assumptions are measured and documented.
- [ ] Entity/time/source/session boundaries precede windows, transforms and synthetic anomalies.
- [ ] Rules, robust statistics and confidence/simple supervised baselines are compared as applicable.
- [ ] Model selection and operational threshold selection use separate, non-test evidence.
- [ ] Prevalence-aware metrics, alert burden, delay, families/slices and uncertainty are reported.
- [ ] Reference freshness, poisoning/feedback controls, human workflow, fallback, rollback and retirement are tested.

## Related guides

- [Clustering and dimensionality reduction](clustering_and_dimensionality_reduction.md)
- [Time series and forecasting](time_series_and_forecasting.md)
- [Probabilistic and Bayesian learning](../paradigms_and_methods/probabilistic_and_bayesian_learning.md)
- [Online, incremental, and continual learning](../operational_settings/online_incremental_and_continual_learning.md)
- [Active learning and human-in-the-loop systems](../operational_settings/active_learning_and_human_in_the_loop.md)
- [Specialisation index](../README.md)

## Official and primary references

- [scikit-learn User Guide: Novelty and outlier detection](https://scikit-learn.org/stable/modules/outlier_detection.html) — official distinction between outlier and novelty detection and estimator-use constraints.
- [A Baseline for Detecting Misclassified and Out-of-Distribution Examples in Neural Networks](https://arxiv.org/abs/1610.02136) — primary OOD/confidence baseline and evaluation task.
- [NIST AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework) — normative lifecycle risk framing for measurement, monitoring and response.
- [The ML Test Score](https://research.google/pubs/the-ml-test-score-a-rubric-for-ml-production-readiness-and-technical-debt-reduction/) — primary production-readiness guidance for data/model monitoring and tests.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
