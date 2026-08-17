# Time Series and Forecasting

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an independent lifecycle. Apply the core and add these controls when observations are temporally ordered and the output predicts values or distributions available only after a forecast origin.

## Use this guide when

Use it for univariate or multivariate forecasts, panel/global forecasting across many series, probabilistic or hierarchical forecasts, intermittent demand, and forecasting used as an upstream decision input. Add geospatial, probabilistic or deep-learning overlays when their controls apply.

## Do not confuse it with

- Forecasting predicts future observations; causal inference estimates effects of interventions.
- Time-series classification/anomaly detection uses temporal inputs but is owned additionally by its task guide.
- A random row split is not a forecast-origin simulation.
- A predictor observed eventually is usable only if it is available, with the same revision state and latency, at the forecast origin.

## Scope and major variants

Covered variants include point, quantile and full-distribution forecasts; single and multiple horizons; regular/irregular and intermittent series; local/global/panel models; exogenous regressors; and hierarchical/grouped reconciliation. The guide does not prescribe one model family.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define forecast origin, horizon, cadence, latency, series hierarchy, target revision, predictor availability, interventions and structural breaks. | Forecast contract, availability/revision table, temporal-quality report. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Use chronological holdouts and rolling/expanding origins; construct lags/rolling features per origin with availability-safe cutoffs. | Backtest calendar and origin-safe feature lineage. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare naïve/seasonal/drift baselines; tune across multiple origins and horizons without adapting to the final period. | Baseline skill table and multi-origin selection record. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Report horizon/series/time aggregation, scaled errors and probabilistic scores/coverage; lock the most recent or external period. | Horizon/slice report with block/bootstrap uncertainty and final-origin evidence. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package cutoff/calendar/state/reconciliation logic; monitor error after outcomes mature, revisions and break indicators; backfill and retire state safely. | Forecast schema, backfill/revision, monitoring, update and retirement plan. |

## Problem and data contract

Specify target, unit/scale, timestamp meaning and timezone, forecast origin, horizon(s), issue cadence, required delivery latency, quantiles/intervals, hierarchy/aggregation constraints, and downstream decision/loss. For every covariate, record observation time, publication delay, revision/vintage policy, known-future status and missingness. Define gaps, irregular sampling, daylight-saving/calendar events, censoring, interventions and target revisions; retain data vintages when production would have seen earlier values.

## Split and evaluation protocol

Use expanding- or rolling-origin evaluation where every training window precedes its validation window. Preserve gaps/embargoes when label or feature windows overlap, and group related series/entities when leakage can cross them. Choose origins spanning relevant seasons and regimes; keep a final recent period, geography/site, or external release locked. Recompute preprocessing, lags, rolling statistics and feature availability at every origin. State whether evaluation is fixed-origin, rolling operational replay, or both.

## Baselines and model-family choices

Always include last-observation naïve, seasonal naïve when seasonality is plausible, and drift/mean or simple domain schedule as appropriate. For intermittent series, use an appropriate zero/inter-arrival baseline. Compare local versus pooled/global models and reconciled versus unreconciled outputs when relevant. A complex model must demonstrate skill relative to the strongest naïve baseline at decision-relevant horizons and series, not only aggregate RMSE.

## Training and validation adaptations

Version cutoff dates, windows, horizon sampling, lag/rolling/calendar construction, frequency conversion, missing-value policy, scaling per series, exogenous forecasts/scenarios, hierarchy and reconciliation matrix, random seeds and compute. Tune across origins rather than one favourable period; predeclare horizon and series weights. When updating model state incrementally, replay the actual update cadence and late-arriving/revised data behaviour.

## Metrics and uncertainty

Report MAE/RMSE where scale is meaningful, scaled or relative errors such as MASE/skill versus baseline for cross-series comparison, and business-weighted loss. Avoid MAPE when zeros or near-zeros make it undefined or unstable. For distributions/quantiles, use proper scores such as pinball/quantile score or CRPS, plus interval coverage and width. Break results down by horizon, series/group, season/regime and volume; use time-block or origin-level uncertainty that respects dependence.

## Error analysis, safety, and robustness

Inspect bias, residual autocorrelation, horizon degradation, seasonal/calendar errors, rare peaks, zeros/intermittency, cold-start series, missing covariates, delayed feeds, revisions and structural breaks. Stress-test plausible exogenous scenarios separately from forecasts. Check coherence across hierarchies and monotonicity across quantiles. Model intervals do not cover arbitrary regime change; define abstention/widening/manual-override behaviour when support or critical feeds fail.

## Packaging, deployment, monitoring, and maintenance

Package target/covariate schema, timestamp/timezone/calendar, cutoff and horizon contract, transforms, model state, hierarchy/reconciliation, exogenous-source versions, quantiles and output schema. Store every issued forecast with model/version and origin so outcomes can be joined when mature. Monitor availability latency, missingness/revisions, forecast/interval distribution, baseline-relative error, bias, coverage, break indicators and error by horizon/series after the label delay. Distinguish refit, state update, backfill, covariate revision, hierarchy change and cadence/horizon change; the last two require contract-level re-evaluation.

## Minimum completion checklist

- [ ] Target, origin, horizons, cadence, latency, calendar/timezone, hierarchy and decision loss are explicit.
- [ ] Predictor availability, delay, vintage/revision and known-future status are audited.
- [ ] Rolling/expanding origins reconstruct transforms and features using information available at each origin.
- [ ] Naïve, seasonal and simple domain baselines are compared at every decision-relevant horizon.
- [ ] Selection spans multiple origins; the final recent/external period remains locked.
- [ ] Metrics are reported by horizon/series/regime with scaled/probabilistic evidence and dependent-data uncertainty.
- [ ] Issued forecasts, late truth, revisions, breaks, update types, rollback and state retirement are operationally covered.

## Related guides

- [Probabilistic and Bayesian learning](../paradigms_and_methods/probabilistic_and_bayesian_learning.md)
- [Anomaly, novelty, and OOD detection](anomaly_novelty_and_ood_detection.md)
- [Survival and time-to-event modelling](survival_and_time_to_event.md)
- [Geospatial and spatiotemporal ML](../data_modalities_and_structures/geospatial_and_spatiotemporal_ml.md)
- [Online, incremental, and continual learning](../operational_settings/online_incremental_and_continual_learning.md)
- [Specialisation index](../README.md)

## Official and primary references

- [Forecasting: Principles and Practice, 3rd ed. — Time-series cross-validation](https://otexts.com/fpp3/tscv.html) — authoritative rolling-origin evaluation guidance.
- [Forecasting: Principles and Practice, 3rd ed. — Distributional forecast accuracy](https://otexts.com/fpp3/distaccuracy.html) — authoritative quantile-score and CRPS evaluation guidance.
- [Forecasting: Principles and Practice, 3rd ed. — Forecast accuracy](https://otexts.com/fpp3/accuracy.html) — authoritative point, scaled and percentage-error guidance.
- [Strictly Proper Scoring Rules, Prediction, and Estimation](https://doi.org/10.1198/016214506000001437) — primary foundation for proper probabilistic forecast evaluation.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
