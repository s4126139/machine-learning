# Probabilistic and Bayesian Learning

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an independent lifecycle. Apply every core requirement and add these controls when distributions, posterior uncertainty, latent variables, or prior information are decision-critical outputs.

## Use this guide when

Use it when the required output is a predictive distribution; parameters or latent states are represented probabilistically; prior information is combined with data; hierarchical partial pooling is needed; or decisions explicitly integrate uncertainty and asymmetric costs.

## Do not confuse it with

- A model emitting a score is not probabilistic unless the score has validated probabilistic meaning.
- Bayesian parameter uncertainty and observation/noise uncertainty are distinct and must not be collapsed without explanation.
- Prediction intervals are not confidence/credible intervals for parameters.
- Calibration alone does not establish causal validity or decision usefulness; add [causal inference](../task_families/causal_inference_and_uplift.md) when interventions are claimed.

## Scope and major variants

The overlay covers Bayesian and hierarchical models, probabilistic graphical/latent-variable models, Bayesian neural models or approximations, probabilistic forecasting, and likelihood-based distributional prediction. It covers exact or approximate inference, including sampling and variational methods, without cataloguing algorithms.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define estimands/predictive quantities, uncertainty sources, likelihood/data-generating assumptions, priors and hierarchy/exchangeability. | Generative model statement, prior rationale, assumption register. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[06](../../machine_learning_lifecycle_phases/06_baseline_development.md) | Preserve deployment independence; conduct prior/prior-predictive checks; compare empirical/simple distributional baselines. | Split protocol, prior predictive evidence, baseline distributions. |
| [07](../../machine_learning_lifecycle_phases/07_model_training.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Version inference algorithm and parameterisation; diagnose convergence/approximation; separate prior/sensitivity choices from test evidence. | Inference ledger, diagnostics, sensitivity and selection record. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Use proper distributional scores/calibration and posterior predictive checks; report interval coverage and decision utility at the correct unit. | Predictive-check report, calibration/coverage results, locked evidence. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package posterior representation and inference contract; monitor calibration and uncertainty shift; rerun diagnostics after updates; retire posterior draws/state under retention policy. | Posterior/inference manifest, monitoring, refit and retirement protocol. |

## Problem and data contract

State the predictive distribution or estimand required by the decision, aggregation unit, conditioning information, observation process, missingness/censoring mechanism, latent variables, hierarchical levels and exchangeability assumptions. Document prior families, scales and scientific or regularising rationale. Distinguish aleatoric/observation variation, parameter/posterior uncertainty, model uncertainty, and unresolved distribution shift; the model may represent only a subset.

## Split and evaluation protocol

Use entity, group, time, site, spatial or other deployment-aware splits from the core and relevant modality/task overlay. Priors and model structure may use documented domain knowledge, but validation/test outcomes must not tune them. Validate extrapolation explicitly because posterior concentration inside the observed domain does not establish validity outside it. Report interval coverage and scores by relevant groups/horizons, with uncertainty computed on independent evaluation units.

## Baselines and model-family choices

Include an empirical marginal or historical-frequency distribution, a simple parametric distribution, and a deterministic/point model with a documented uncertainty wrapper where useful. Hierarchical models should compare complete/no pooling or simpler structures when defensible. A more complex inference method must improve predictive checks, calibrated uncertainty, decision value, or efficiency rather than merely producing narrower intervals.

## Training and validation adaptations

Before fitting, run prior predictive checks against plausible observable ranges. Version likelihood, priors, transformations, parameterisation, inference engine/version, chains/initialisation/seeds, warm-up and sample counts, variational objective or approximation, and numerical tolerances. For sampling, inspect convergence, effective sample size, Monte Carlo error, divergences and geometry-specific warnings. For approximate inference, validate approximation quality on tractable subsets or alternative methods where risk warrants. Use posterior predictive checks throughout development, not as a substitute for locked evaluation.

## Metrics and uncertainty

Use proper scoring rules appropriate to the task, such as log score, Brier score, CRPS or quantile score, alongside calibration/reliability, interval coverage and sharpness. Report posterior summaries that match the decision: means, medians, quantiles, tail probabilities or expected utility. Separate posterior uncertainty from repeated-sample uncertainty of evaluation metrics and from Monte Carlo error. Do not select models solely because intervals are narrow.

## Error analysis, safety, and robustness

Check posterior predictive discrepancies on outcome distribution, tails, zeros, counts, dependence, group structure and other decision-relevant statistics. Test sensitivity to reasonable priors, likelihood choices, influential observations, missingness assumptions, hierarchy, and outliers. Inspect weak identification, multimodality, divergent or non-mixing chains, variational under-dispersion, miscalibration by slice, and overconfident extrapolation. Escalate decisions when posterior conclusions change materially across defensible assumptions.

## Packaging, deployment, monitoring, and maintenance

Package the model specification, prior and likelihood versions, fitted posterior/approximation, draws or sufficient representation, preprocessing, calibration layer, random-generation settings, and inference/decision contract. Define reproducible predictive summaries and latency/memory limits. Monitor proper scores when outcomes arrive, calibration/coverage, interval width and tail alerts, posterior/predictive drift, sampler or optimisation diagnostics after refits, and changes in group composition. A prior, likelihood, hierarchy, inference-engine or approximation change is a model change requiring renewed checks and locked evaluation.

## Minimum completion checklist

- [ ] The predictive quantity/estimand, uncertainty sources, likelihood, priors, hierarchy and decision rule are explicit.
- [ ] Prior predictive checks reject implausible specifications before fitting.
- [ ] Splits reflect deployment independence and test outcomes never tune priors or assumptions.
- [ ] Empirical/simple distributional and point-prediction baselines are compared where meaningful.
- [ ] Inference settings, convergence/approximation diagnostics, seeds and Monte Carlo error are recorded.
- [ ] Proper scores, calibration, coverage, sharpness, posterior predictive checks and sensitivity analyses are reported.
- [ ] Posterior artefacts, decision contract, monitoring, refit diagnostics, rollback and retirement are versioned.

## Related guides

- [Time series and forecasting](../task_families/time_series_and_forecasting.md)
- [Survival and time-to-event modelling](../task_families/survival_and_time_to_event.md)
- [Causal inference and uplift modelling](../task_families/causal_inference_and_uplift.md)
- [Deep learning, transfer, and multitask learning](deep_learning_transfer_and_multitask.md)
- [Anomaly, novelty, and OOD detection](../task_families/anomaly_novelty_and_ood_detection.md)
- [Specialisation index](../README.md)

## Official and primary references

- [Stan User’s Guide: Posterior predictive checks](https://mc-stan.org/docs/stan-users-guide/posterior-predictive-checks.html) — official guidance on checking whether replicated data reproduce relevant observed properties.
- [Stan Reference Manual: Posterior analysis](https://mc-stan.org/docs/reference-manual/analysis.html) — official definitions and use of effective sample size, Monte Carlo error, and convergence diagnostics.
- [Convergence and efficiency diagnostics for Markov chains](https://mc-stan.org/rstan/reference/Rhat.html) — official current guidance for rank-normalised R-hat and bulk/tail effective sample size.
- [Strictly Proper Scoring Rules, Prediction, and Estimation](https://doi.org/10.1198/016214506000001437) — primary foundation for evaluating probabilistic forecasts with proper scores.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
