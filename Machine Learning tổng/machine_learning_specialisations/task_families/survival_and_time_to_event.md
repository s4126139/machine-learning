# Survival and Time-to-Event Modelling

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an independent lifecycle. This edition provides a complete route for right-censored prognostic time-to-event prediction. Other observation schemes and event processes require a method-specific addendum and direct supporting sources before claims are made.

## Use this guide when

Use it to estimate survival/event-free probabilities or hazards, predict risk by one or more horizons, rank time-to-event risk, or model right-censored durations. Add causal guidance if the question is treatment effect rather than prognosis.

## Do not confuse it with

- Ordinary regression on observed event times discards or mishandles censoring.
- Binary classification at a horizon can be valid only with explicit handling of people whose status is unknown by that horizon.
- High concordance measures ranking, not probability calibration or causal effect.
- Competing events are not ordinary censoring. Do not reuse this right-censoring protocol without a competing-risk estimand, evaluator and direct sources.

## Scope and major variants

The complete scope in this edition is right-censored prognosis with proportional/non-proportional hazards, accelerated failure-time or flexible survival models, and fixed-origin horizon-specific prediction. Left/interval censoring, delayed entry, competing risks, recurrent events, multi-state outcomes and dynamic landmarking are recognised variants but are **out of scope until a project adds variant-specific risk sets, likelihood/evaluation, calibration and authoritative sources**. Domain reporting standards remain additional.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define time origin, target event, right-censoring, horizons, follow-up and covariate availability. | Time-to-event estimand/data contract and follow-up audit. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Split by subject/site/time; keep predictors prior to prediction time; fit censoring estimates inside folds. | Subject-level split and leakage-safe feature/evaluation lineage. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare Kaplan–Meier/group and simple proportional-hazards or horizon baselines; validate assumptions and tune across horizons. | Baseline curves, assumption diagnostics and selection report. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Use right-censoring-aware discrimination, calibration and prediction error at declared horizons; report follow-up and at-risk support. | Horizon/slice metric curves, uncertainty and locked temporal/external evaluation. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package time origin/grid, curve semantics and censoring logic; monitor follow-up, event/censoring mix and calibration as outcomes mature; retire derived curves/state. | Survival-output contract, delayed-outcome monitoring, refit and retirement plan. |

## Problem and data contract

Specify population, fixed time origin, target-event definition/coding, right-censoring mechanism and assumptions, follow-up end, prediction horizons, output (survival, hazard, restricted mean or risk), aggregation and decision use. Record exact event/censor timestamps, same-time ordering, covariate measurement windows, lost-to-follow-up reasons and administrative cutoffs. Define the independent subject or cluster and avoid immortal-time construction. If delayed entry, competing/recurrent events or dynamic prediction occur, stop and add a variant-specific protocol.

## Split and evaluation protocol

Keep all records for a subject in one fold; add site/family/cluster grouping and temporal/external validation to match deployment. Features must be available at the prediction origin. Estimate preprocessing, censoring distributions and other learned evaluation weights within valid development folds; never use final outcomes to construct predictors or evaluation weights. Choose final horizons with enough at-risk subjects and follow-up, and report support as it declines. Do not code competing events as right censoring without an explicit competing-risk estimand and evaluator.

## Baselines and model-family choices

Include the training-set Kaplan–Meier curve, meaningful stratified/group curves, and a simple Cox proportional-hazards or parametric/horizon model as appropriate. Compare against binary-horizon models only when censoring is handled consistently. Choose models according to output need, time-varying effects/covariates, proportional-hazards assumptions, sample/event count, interpretability and calibration—not concordance alone.

## Training and validation adaptations

Version origin/event/censor rules, horizons/time grid, feature timing, tie handling, stratification, censoring model, loss, regularisation, seeds and follow-up cutoff. Tune using censoring-aware validation at predeclared horizons. Check proportional-hazards or other structural assumptions and use alternatives when materially violated.

## Metrics and uncertainty

Report discrimination with an appropriate concordance measure and/or cumulative/dynamic time-dependent AUC; prediction error with time-dependent Brier score or integrated Brier score; and calibration of survival/risk at relevant horizons. State censoring-adjustment method and time range. Add decision-curve/utility analysis only with declared consequences. Report metric curves and confidence intervals by horizon and important groups, event counts and numbers at risk; do not extrapolate metrics beyond supported follow-up.

## Error analysis, safety, and robustness

Inspect early/late horizons, rare events, heavy/informative censoring, site/cohort shifts, time-varying effects, missing visits and calibration by group. Stress-test alternative plausible censoring definitions and follow-up cutoffs. Check implausible or non-monotone survival curves, risk estimates outside valid ranges and unstable tail predictions. Avoid interpreting prognostic associations or risk-group curves as treatment effects.

## Packaging, deployment, monitoring, and maintenance

Package feature and timestamp schema, fixed-origin logic, event/censor definitions, preprocessors, model, baseline hazard/survival or time grid, censoring/calibration components and output schema with horizon support. Monitor cohort mix, follow-up length, event/censor rates, missing visits, prediction distribution, discrimination and calibration only after outcomes mature, plus numbers at risk. Distinguish retraining from changing event definition, origin, horizon, follow-up or output semantics; contract changes require renewed validation and consumer migration.

## Minimum completion checklist

- [ ] Origin, target event, right-censoring, follow-up, horizons and output semantics are explicit.
- [ ] Subject/site/time splits precede feature and evaluation-weight construction.
- [ ] Prediction-time feature availability and event/censor timestamp ordering are audited.
- [ ] Kaplan–Meier and simple survival baselines are compared.
- [ ] Structural assumptions, censoring method, event counts and at-risk support are documented.
- [ ] Censoring-aware discrimination, calibration and prediction error are reported by horizon/group with uncertainty.
- [ ] Delayed-outcome monitoring, contract changes, rollback, migration and retirement are defined.
- [ ] Out-of-scope censoring/event-process variants are not analysed without a dedicated addendum and sources.

## Related guides

- [Causal inference and uplift modelling](causal_inference_and_uplift.md)
- [Time series and forecasting](time_series_and_forecasting.md)
- [Probabilistic and Bayesian learning](../paradigms_and_methods/probabilistic_and_bayesian_learning.md)
- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md)
- [Federated learning](../operational_settings/federated_learning.md)
- [Specialisation index](../README.md)

## Official and primary references

- [scikit-survival User Guide: Introduction](https://scikit-survival.readthedocs.io/en/stable/user_guide/00-introduction.html) — official censored target representation and survival-analysis scope.
- [scikit-survival User Guide: Evaluating Survival Models](https://scikit-survival.readthedocs.io/en/stable/user_guide/evaluating-survival-models.html) — official concordance, cumulative/dynamic AUC and Brier-score guidance under censoring.
- [Cox, “Regression Models and Life-Tables”](https://doi.org/10.1111/j.2517-6161.1972.tb00899.x) — primary proportional-hazards model and partial-likelihood foundation.
- [Model Cards for Model Reporting](https://research.google/pubs/model-cards-for-model-reporting/) — primary framework for intended use, subgroup evaluation and limitations.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
