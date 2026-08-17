# Online, Incremental, and Continual Learning

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay documents only the additional controls needed when model state changes over time or learning must preserve useful knowledge across an evolving stream.

## Use this guide when

Use this overlay when one or more of the following is part of the intended operating contract:

- examples arrive sequentially and the model is evaluated in arrival order;
- the deployed model is updated per example, micro-batch, window, or event;
- the data distribution, label space, task, or environment may evolve;
- knowledge from earlier tasks or periods must be retained while new knowledge is acquired;
- labels are delayed and prediction, learning, and evaluation occur at different times.

A stream processed once by a frozen model does not require this overlay. Scheduled full retraining on accumulated data remains a batch lifecycle unless it is explicitly evaluated as an adaptive policy.

## Do not confuse it with

- **Streaming inference:** data may arrive continuously while the model remains frozen.
- **Incremental learning:** the estimator supports state updates without refitting from scratch; this says nothing by itself about drift or retention.
- **Online learning:** prediction and update decisions are made sequentially, often under bounded latency or memory.
- **Continual learning:** the objective includes acquiring new tasks/domains/classes while limiting forgetting or enabling transfer. Task boundaries may be known or latent.
- **Concept-drift detection:** a detector raises evidence of change; it is not an update policy and a detected distribution change does not automatically prove performance loss.
- **Online reinforcement learning:** actions change future observations and rewards. Add the [reinforcement-learning overlay](../paradigms_and_methods/reinforcement_learning_and_bandits.md).
- **Federated rounds:** repeated client aggregation is distributed training. Add [federated learning](federated_learning.md); it is not necessarily online or continual.

## Scope and major variants

Record the operating variant in the Phase 01 taxonomy passport:

- per-example, micro-batch, sliding-window, expanding-window, or scheduled incremental updates;
- immediate, delayed, selectively observed, revised, or missing labels;
- stationary stream, gradual/sudden/recurring drift, new classes, or task/domain increments;
- single-pass or replay-enabled learning, with a declared memory and retention policy;
- task-incremental, domain-incremental, or class-incremental continual learning;
- supervised, unsupervised, self-supervised, or reward-based update signals;
- shadow, human-approved, canary, or automatic production updates.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Define event, prediction, label, evaluation, and update clocks; update authority; adaptation/retention objective; acceptable recovery time | Temporal decision contract and update-state diagram |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Preserve event/arrival/label times, ordering, revision history, source identity, and observability of feedback | Append-only event schema, delay profile, and stream-quality report |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md) | Evaluate in deployment order; prevent future features, future labels, and post-outcome revisions from entering earlier predictions | Time-respecting replay protocol and locked prospective or terminal window |
| [05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Give every stateful transform an update rule, warm-up rule, and snapshot; bound window/replay memory | Transform-state contract and cold-start behaviour |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare adaptation with frozen and scheduled-batch alternatives under the same stream; tune without reusing future evidence | Baseline replay and selection results under fixed budgets |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Report time-local utility, stability, delay, compute, and retention/transfer where applicable; preserve final temporal evidence | Curves/slices with uncertainty plus locked-stream result |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[13](../../machine_learning_lifecycle_phases/13_deployment.md) | Package mutable learner state, update logic, checkpoints, event deduplication, rollback, and compatibility rules | Versioned state bundle and rehearsed update/rollback runbook |
| [14](../../machine_learning_lifecycle_phases/14_monitoring.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Monitor each prediction/update version, adaptation triggers, forgetting, state growth, and feedback health; retire state and replay data | State lineage, trigger audit, retention regression, and retirement record |

## Problem and data contract

Define the temporal unit precisely. At minimum, distinguish:

- **event time:** when the underlying event occurred;
- **arrival time:** when the system could first observe the input;
- **prediction time:** when the decision was made and which state version was used;
- **label time:** when the outcome became observable, including later revisions;
- **update time:** when the observation was allowed to change learner or transform state.

The feature contract must reproduce what was knowable at prediction time. Record duplicate/retry identifiers, out-of-order handling, watermark or lateness policy, event revisions, schema evolution, and source outages. Never treat a late label as if it had been available when the prediction was issued.

For continual learning, define task/domain/class boundaries when known and how latent boundaries will be inferred when unknown. Declare whether old examples may be stored or replayed, for how long, under which licence/consent/privacy controls, and what approximation is used when replay is prohibited.

Feedback is often selected by past decisions. Log eligibility, exposure, abstention, human review, and label-acquisition mechanisms so that missing-not-at-random outcomes and policy feedback loops are visible.

## Split and evaluation protocol

Use chronological replay that executes **predict first, then reveal the eligible feedback, then update**. River's official progressive validation documentation describes this ordering and supports delayed labels; it is a suitable operational pattern, not a universal metric prescription.

The replay must specify:

- warm-up period and initial model state;
- state reset boundaries and whether comparisons share identical starting states;
- maximum label delay and treatment of censored outcomes;
- window definitions chosen before inspecting final evidence;
- grouping rules for users, devices, sites, or sessions in addition to time;
- whether preprocessing, drift detectors, thresholds, and calibration update online;
- a terminal historical window or prospective shadow period that is never used to choose the adaptation policy.

For continual scenarios, evaluate after each experience on all eligible previous and current experiences, not only on the newest task. Keep the same task order and resource/replay budget for model comparisons; repeat stochastic orders or seeds when order sensitivity is material.

## Baselines and model-family choices

At least three reference policies are normally required:

1. a frozen model, exposing the value and risk of adaptation;
2. a scheduled full-batch retrain or rolling-window refit, exposing whether incremental complexity is justified;
3. a simple incremental learner with a fixed update cadence and no drift-triggered resets.

For continual learning, add naive sequential fine-tuning as a forgetting baseline and, when permitted, a simple replay baseline. Choose model families for their state size, update latency, convergence behaviour, failure recovery, and compatibility with evolving classes/features—not only their batch accuracy.

## Training and validation adaptations

- Pre-register update cadence/trigger, learning-rate schedule, window/replay size, reset policy, and rollback threshold.
- Separate a **drift signal** from the decision to update, reset, retrain, or escalate; estimate detector false alarms and detection delay on relevant change patterns.
- Version model, optimizer, calibration, feature-statistic, label-map, and detector state together. Partial rollback of coupled state is unsafe.
- Make retries idempotent. Replaying a message must not silently apply the same learning update twice.
- Bound memory, state growth, per-update compute, and update latency. Record dropped or deferred updates.
- Tune only through past-to-future development replays. Repeatedly selecting a policy on the same terminal period overfits that period.
- For continual learning, record replay composition, task/order exposure, frozen modules, regularisation or expansion rules, and capacity growth.
- Re-run the complete stream from a clean initial state before final selection; resumed runs must identify their exact state checkpoint.

## Metrics and uncertainty

Report the task metric as a trajectory, not only a lifetime average. Include:

- progressive/prequential performance overall and over predeclared rolling or calendar windows;
- cold-start and post-change recovery performance;
- label delay, prediction latency, update latency, throughput, memory, and state size;
- number of updates, resets, detector alarms, false alarms where observable, and rollback events;
- age-weighted versus unweighted performance, clearly labelled;
- uncertainty across time blocks, entities, stream replays, or stochastic seeds as appropriate.

For continual learning, add an explicit performance matrix across train/evaluation experiences. Derive retention/forgetting, backward transfer, and forward transfer only after stating the exact formula and reference point; terminology varies across literature and libraries. Avalanche exposes forgetting, backward-transfer, and forward-transfer metrics, demonstrating why these are separate from ordinary task accuracy.

Do not aggregate away a long harmful interval. Report worst window, affected slices, and time to recover alongside averages.

## Error analysis, safety, and robustness

Test at least the plausible stream failures:

- sudden, gradual, recurring, and seasonal changes;
- class-prior change versus conditional-concept change;
- new or disappearing classes, features, sources, or devices;
- delayed, missing, revised, corrupted, and bursty feedback;
- out-of-order, duplicated, and replayed messages;
- adversarial or erroneous update batches and poisoned replay memory;
- prolonged outage followed by backlog catch-up;
- continual forgetting, negative backward transfer, task-order sensitivity, and unbounded model growth.

Specify a safe frozen-state behaviour when feedback or updates are unhealthy. Human approval is required when automatic adaptation could materially change safety, fairness, or decision authority without adequate online safeguards.

## Packaging, deployment, monitoring, and maintenance

The deployable artefact includes the initial state, update function/version, state schema, feature and label maps, buffer/window definition, drift detector, thresholds, checkpoint format, migration logic, and event deduplication contract.

Production records must join every prediction and later label to the exact state version. Monitor utility by state version and window, label availability/delay, state divergence across replicas, update failures, queue lag, detector signals, rollbacks, resource growth, and protected/safety slices where permitted.

Use shadow learning before allowing state mutation to affect decisions. Promotion should be atomic, canaried where feasible, and reversible to a known complete state. Periodically replay from clean state to detect unrecoverable lineage or numerical divergence.

Retirement must stop updates, archive only policy-permitted state and evidence, delete replay buffers under retention rules, revoke writers, and ensure no stale learner continues to publish predictions.

## Minimum completion checklist

- [ ] Event, arrival, prediction, label, evaluation, and update clocks are defined.
- [ ] Future information is excluded by a predict-then-update replay.
- [ ] Frozen, batch-retrain, and simple incremental baselines use the same stream and budget.
- [ ] Stateful transforms, model, optimizer, detector, and calibration state are versioned together.
- [ ] Label delay, retries, ordering, deduplication, and schema evolution are tested.
- [ ] Time-local utility, cost/latency, recovery, and worst-window results are reported.
- [ ] Continual projects report retention/forgetting across previous experiences.
- [ ] Update triggers, authority, canary/shadow path, complete rollback, and safe frozen mode are rehearsed.
- [ ] Replay memory and mutable state have privacy, retention, and retirement controls.
- [ ] Final evidence comes from a locked temporal replay or prospective period.

## Related guides

- [Reinforcement learning and contextual bandits](../paradigms_and_methods/reinforcement_learning_and_bandits.md)
- [Semi-, weakly, and self-supervised learning](../paradigms_and_methods/semi_weak_and_self_supervised_learning.md)
- [Time series and forecasting](../task_families/time_series_and_forecasting.md)
- [Anomaly, novelty, and OOD detection](../task_families/anomaly_novelty_and_ood_detection.md)
- [Active learning and human-in-the-loop systems](active_learning_and_human_in_the_loop.md)
- [Federated learning](federated_learning.md)

## Official and primary references

- [scikit-learn: Strategies to scale computationally—out-of-core learning](https://scikit-learn.org/stable/computing/scaling_strategies.html) — official distinction among streaming instances, feature extraction, and incremental estimators.
- [River: Progressive validation](https://riverml.xyz/latest/api/evaluate/progressive-val-score/) — official predict-before-update evaluation, including delayed-label handling.
- [Avalanche evaluation module](https://avalanche-api.continualai.org/en/latest/evaluation.html) — official continual-learning metrics including forgetting and transfer.
- [Van de Ven and Tolias, Three scenarios for continual learning](https://arxiv.org/abs/1904.07734) — primary scenario definitions and evaluation-protocol motivation.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
