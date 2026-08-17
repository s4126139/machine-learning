# Time-Series and Temporal-Sequence Data

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an independent lifecycle. Apply it whenever ordering, sampling, windows, episodes, or temporal dependence define the observation structure—even when the task is classification, regression, clustering, segmentation, representation learning, or anomaly detection rather than forecasting.

## Use this guide when

Use it for univariate or multivariate time series, longitudinal records, sensor streams, event sequences, temporal panels, trajectories, variable-length sequences, and windowed signals. Add the [forecasting](../task_families/time_series_and_forecasting.md), [anomaly/OOD](../task_families/anomaly_novelty_and_ood_detection.md), clustering, supervised core, audio, video, geospatial, graph, or online overlay according to the actual task and modality.

## Do not confuse it with

- Forecasting is one temporal task; a temporal classifier or clusterer still needs this modality overlay without being a forecaster.
- Online learning changes model state incrementally; a batch model can still consume temporal sequences.
- Sequence order is not automatically causal order, and temporal precedence does not identify an intervention effect.
- Randomly splitting overlapping windows does not produce independent evidence.

## Scope and major variants

Covered structures include regularly or irregularly sampled series, longitudinal panels, event sequences, fixed or variable-length episodes, windowed sensor data, sequence-to-label/sequence-to-sequence outputs, temporal segmentation and change-point representations. Forecasting-specific horizons and backtests remain owned by the forecasting task guide.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define sequence/entity, clock, sampling, ordering, episode/window boundaries, availability time, missing intervals and label alignment. | Temporal data contract and integrity/availability audit. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Split source entities/sessions/time before windowing; prevent overlap and future-derived transforms; fit resampling, imputation, scaling and spectral/sequence transforms inside development folds. | Window-lineage and leakage-safe transform manifest. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare aggregate/static and simple temporal baselines; tune window, stride, context, padding/masking and temporal representation under the deployment protocol. | Budget-matched baseline and temporal-selection report. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Use task-owned metrics but aggregate uncertainty at independent entity/session/episode level; evaluate across regimes, durations and time. | Task report with temporal slices and independent-unit uncertainty. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package clock/window/state/mask contracts; monitor sampling, delay, missingness, duration and regime drift; retire sequence caches/state. | Temporal serving contract, monitoring and state-retirement plan. |

## Problem and data contract

Define the physical/business clock, timestamp source and timezone, entity/session/episode, sequence start/end, sample/event semantics, expected frequency or irregularity, duplicate/same-time ordering, measurement availability, label interval and output alignment. Record units, sensor/device/site, acquisition revisions, censoring or delayed labels, and whether a row represents a state, event, interval, or derived window. Separate event time, ingestion time and the time information becomes usable.

## Split and evaluation protocol

Choose the independent unit before constructing windows. Keep a person, device, session, trajectory, recording, or source group in one partition when deployment requires new-unit generalisation. For future deployment, preserve chronological order and use realistic gaps. Windows that share raw samples, targets, future context or derived statistics must not cross partitions. Evaluate variable-length and rare regimes explicitly; aggregate confidence intervals over independent entities/episodes rather than treating correlated timesteps as independent samples.

## Baselines and model-family choices

Include a non-temporal aggregate/static-feature baseline when it tests whether sequence modelling adds value; a persistence/last-value or seasonal baseline only for forecasting; simple distance/shapelet or linear/tree models on leakage-safe summaries; and an incumbent. Compare sequence architectures only after controlling context length, latency, parameter/compute budget and information available at decision time.

## Training and validation adaptations

Version resampling grid, timestamp alignment, window length/stride, context and prediction boundary, padding/mask, truncation, normalisation, missingness handling, interpolation, frequency/spectral transform, augmentation, sampler and sequence batching. Temporal augmentation must preserve label and domain meaning and occur only within training data. Tune across realistic entities/times and report sensitivity to window construction; do not select a window after inspecting locked future periods.

## Metrics and uncertainty

The owning task guide defines primary metrics. Additionally report results by sequence length, temporal regime, entity/session/device, sampling quality, missingness and time period. For per-step outputs, state whether averaging is micro by timestep or macro by sequence/entity and report support. Use block/entity/episode-aware uncertainty or repeated valid splits; naive per-timestep confidence intervals are usually too narrow under temporal dependence.

## Error analysis, safety, and robustness

Test timestamp disorder, clock drift, duplicated/missing intervals, irregular sampling, shorter/longer sequences, padding/mask errors, boundary windows, regime shifts, sensor replacements, delayed ingestion and missing channels. Inspect leakage from smoothing, centred rolling windows, interpolation, normalisation, event duration, post-outcome measurements and window overlap. For high-stakes sequences, test safe behaviour when history is insufficient or stale.

## Packaging, deployment, monitoring, and maintenance

Package schema and units, clock/timezone, entity/session key, resampling, ordering, window/state construction, masks, transforms, model and output alignment. Stateful serving must define state ownership, expiry, replay/idempotency, late/out-of-order events and rollback compatibility. Monitor sampling frequency, delay, missingness, sequence length, device/source mix, regime and task performance at the correct independent unit. Retraining or state migration must preserve chronology and prevent historical/future contamination; retirement removes state stores, feature windows and cached sequences under retention policy.

## Minimum completion checklist

- [ ] Clock, entity/session/episode, sequence boundaries, sampling and availability times are explicit.
- [ ] Partitions are created before overlapping windows or learned temporal transforms.
- [ ] Entity/session/time independence matches the deployment claim.
- [ ] Aggregate/static and simple temporal baselines test the value of sequence modelling.
- [ ] Window, stride, context, padding/mask, resampling and augmentation are versioned.
- [ ] Task metrics are aggregated with entity/episode-aware slices and uncertainty.
- [ ] Timestamp, missingness, regime, state, monitoring, rollback and retirement controls are tested.

## Related guides

- [Time series and forecasting](../task_families/time_series_and_forecasting.md)
- [Anomaly, novelty, and OOD detection](../task_families/anomaly_novelty_and_ood_detection.md)
- [Online, incremental, and continual learning](../operational_settings/online_incremental_and_continual_learning.md)
- [Speech and audio](speech_and_audio.md)
- [Video and temporal media](video_and_temporal_media.md)
- [Geospatial and spatiotemporal ML](geospatial_and_spatiotemporal_ml.md)

## Official and primary references

- [sktime documentation](https://www.sktime.net/en/stable/get_started.html) — official task-oriented time-series framework covering classification, regression, clustering, transformation and forecasting.
- [tslearn User Guide](https://tslearn.readthedocs.io/en/stable/user_guide/userguide.html) — official guidance for time-series preprocessing, metrics, classification, clustering and variable-length data.
- [The UCR Time Series Archive](https://www.cs.ucr.edu/~eamonn/time_series_data_2018/) — authoritative archive and benchmark resource for time-series classification and related tasks.
- [scikit-learn TimeSeriesSplit](https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.TimeSeriesSplit.html) — official time-ordered cross-validation behaviour and constraints.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
