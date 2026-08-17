# Causal Inference and Uplift Modelling

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an independent lifecycle. Apply the core and add these controls when the claim concerns interventions, treatment effects, counterfactuals, uplift, mediation, or learned treatment policies.

## Use this guide when

Use it to estimate whether or how an intervention changes an outcome, average or heterogeneous treatment effects, incremental/uplift response, causal mediation, counterfactual quantities, or policy value under explicit causal assumptions.

## Do not confuse it with

- Predictive association, feature importance, SHAP values, partial dependence and temporal precedence do not identify causal effects.
- Forecasting predicts what may happen; causal inference asks what would happen under a specified intervention.
- Uplift estimates differential treatment response, not merely high outcome probability.
- A causal graph encodes assumptions to scrutinise; it is not evidence that those assumptions are true.

## Scope and major variants

The guide covers randomised experiments and observational studies; average, conditional and individualised-effect targets where identifiable; back-door/front-door and instrumental-variable designs; difference-in-differences and regression-discontinuity designs; mediation, uplift and policy learning. Domain statistical standards and ethical/regulatory requirements must be added.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define estimand, intervention/comparator, population, outcome/time, causal graph/design, treatment assignment, positivity, interference and missingness assumptions. | Target-trial/estimand specification, graph/design and assumption register. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Preserve treatment–outcome time order, cluster/entity boundaries and pre-treatment covariates; prohibit post-treatment adjustment unless the estimand/design requires it. | Analysis cohort, temporal lineage and split/cross-fit protocol. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare unadjusted/design-based and simple adjusted estimates; isolate nuisance-model tuning via cross-fitting or independent data. | Baseline estimands, balance/overlap diagnostics, estimator-selection record. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Report effect estimates with uncertainty, overlap/balance, falsification/refutation and sensitivity; evaluate uplift/policies on randomised or causally justified evidence. | Identification argument, stated assumptions, diagnostic/sensitivity report, locked causal evidence. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package estimand/graph/design and nuisance models; deploy policies with eligibility/constraints; monitor assignment, overlap, outcomes and assumption drift; retire policy/analysis dependencies. | Causal model/policy card, monitoring, re-identification and retirement protocol. |

## Problem and data contract

Write the estimand before choosing an estimator: population, treatment/intervention and versions, comparator, outcome and measurement time, aggregation, and effect scale. Emulate a target trial where applicable by defining eligibility, assignment, time zero, follow-up and analysis. Record causal graph/design, confounders, mediators, colliders, instruments, selection, treatment propensity, interference/spillover, consistency, positivity, missingness and measurement assumptions. Distinguish variables observed before treatment from post-treatment data and align all timestamps.

## Split and evaluation protocol

Preserve units of treatment assignment and interference clusters; use chronological/site/external splits when the claim transfers across them. Keep repeated people/entities together. Use sample splitting or cross-fitting so flexible nuisance functions are evaluated out of sample, while maintaining design requirements. Randomised holdout or a new experiment is strongest for policy/uplift final evidence; otherwise state the identification strategy and its untestable assumptions. Do not use predictive train/test accuracy as validation of a causal effect.

## Baselines and model-family choices

Report raw/unadjusted group differences with a warning that they may be confounded, plus a design-based or simple regression/standardisation estimate. Compare multiple defensible adjustment sets or estimators when assumptions allow. For uplift/policy learning, include treat-all, treat-none, current-policy and outcome-risk baselines under the same cost/capacity constraint. Prefer the simplest estimator that identifies the declared estimand and supports diagnostics.

## Training and validation adaptations

Version cohort construction, treatment/outcome definitions, time zero, adjustment set, graph, propensity/outcome/censoring nuisance models, trimming/clipping, cross-fit folds, effect learner, policy constraints and random seeds. Tune nuisance predictive models without selecting the final causal conclusion from repeated test-set analyses. Predefine subgroup/heterogeneity analyses or control multiplicity. Keep design decisions distinct from outcome-driven model selection, and record deviations from the analysis plan.

## Metrics and uncertainty

Primary outputs are effect estimates or policy value with confidence/credible intervals appropriate to the assignment and clustering design. Add covariate balance, propensity/overlap and effective-sample diagnostics, influence/weight tails, negative controls/placebos/refutations, and sensitivity to unmeasured confounding or design violations. For heterogeneous effects, report calibration/validation on randomised or justified data, subgroup stability and policy value/regret under costs; Qini/AUUC-style curves require clear treatment/control and randomisation/propensity assumptions. Factual outcome prediction metrics are nuisance diagnostics, not causal validation.

## Error analysis, safety, and robustness

Inspect overlap violations, extreme weights, treatment-version ambiguity, immortal-time or selection bias, post-treatment conditioning, outcome leakage, interference, missing-not-at-random mechanisms, weak instruments, pre-trend/discontinuity failures, and unstable subgroup effects. Run alternative adjustment sets, trimming thresholds, functional forms and negative-control/placebo tests consistent with the design. Evaluate allocation fairness, capacity constraints and harm from withholding or assigning treatment; uncertainty must trigger conservative policy or human review when stakes require it.

## Packaging, deployment, monitoring, and maintenance

Package the estimand, target population, cohort/time-zero logic, graph/design and identification assumptions, feature timing, treatment/outcome definitions, nuisance/effect models, uncertainty method, eligibility and policy constraints, versioned data sources and decision rule. Monitor treatment propensity and assignment, overlap, covariate and population shift, outcome delay/missingness, treatment versions, policy compliance, effect/policy value when identifiable, and interference signals. A change to treatment, comparator, population, outcome, measurement timing, assignment mechanism or graph is an estimand/design change requiring re-identification—not routine retraining.

## Minimum completion checklist

- [ ] Population, intervention/comparator, outcome/time, effect scale and target estimand are explicit.
- [ ] The causal graph/design, identification argument and assumptions are documented before estimation.
- [ ] Treatment timing, eligibility/time zero, pre-treatment covariates, clusters and interference are controlled.
- [ ] Unadjusted, simple/design-based, treat-all/none/current-policy baselines are reported as applicable.
- [ ] Overlap/balance, cross-fitting, weights, uncertainty and nuisance-model diagnostics are recorded.
- [ ] Refutations/placebos/negative controls and sensitivity to key assumptions accompany effect claims.
- [ ] Deployment constraints, assignment/assumption monitoring, rollback and re-identification triggers are defined.

## Related guides

- [Survival and time-to-event modelling](survival_and_time_to_event.md)
- [Time series and forecasting](time_series_and_forecasting.md)
- [Probabilistic and Bayesian learning](../paradigms_and_methods/probabilistic_and_bayesian_learning.md)
- [Reinforcement learning and contextual bandits](../paradigms_and_methods/reinforcement_learning_and_bandits.md)
- [Active learning and human-in-the-loop systems](../operational_settings/active_learning_and_human_in_the_loop.md)
- [Specialisation index](../README.md)

## Official and primary references

- [PyWhy/DoWhy User Guide](https://www.pywhy.org/dowhy/v0.14/user_guide/index.html) — official workflow for modelling assumptions, identification, estimation, refutation, sensitivity and counterfactual tasks.
- [Hernán and Robins, *Causal Inference: What If*](https://miguelhernan.org/whatifbook) — authoritative open textbook on target trials, causal estimands, standardisation, weighting and longitudinal causal inference.
- [NIST AI Risk Management Framework Core](https://airc.nist.gov/airmf-resources/airmf/5-sec-core/) — normative contextual and lifecycle-wide governance, measurement and management of risk.
- [Model Cards for Model Reporting](https://research.google/pubs/model-cards-for-model-reporting/) — primary framework for intended use, evaluation context, subgroup results and limitations.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
