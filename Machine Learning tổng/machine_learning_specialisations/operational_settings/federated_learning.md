# Federated Learning

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay adds controls for learning and evaluation across client-held data without centralising raw examples.

## Use this guide when

Use it when multiple organisations, devices, sites, or other clients compute on locally held examples and exchange model updates, aggregates, or approved statistics under a federated protocol.

The defining lifecycle change is the **placement and coordination boundary**: data is partitioned by real clients, client availability and distributions affect training, and evaluation must show who benefits—not merely the pooled average.

## Do not confuse it with

- **Distributed data-parallel training:** workers process centrally governed shards and normally approximate one pooled-data optimisation problem. It is not federated merely because several machines participate.
- **Edge inference:** inference occurs on-device; learning may remain centralised.
- **Decentralised/peer-to-peer federation:** one federated topology without a permanent central coordinator. This overlay also covers coordinator-based federation.
- **Federated analytics:** distributed aggregate computation without necessarily training a model.
- **Personalisation:** a global, clustered, or local model may be personalised, but personalisation is a separate modelling decision.
- **Privacy-preserving ML:** keeping raw records local reduces some data movement but does not prevent update leakage, malicious clients, server misuse, or disclosure by the released model. Add the [privacy-preserving overlay](privacy_preserving_machine_learning.md) whenever a privacy claim is required.
- **Online/continual learning:** repeated federation rounds need not consume a time stream. Add the [online/continual overlay](online_incremental_and_continual_learning.md) only when temporal adaptation or retention is an objective.

## Scope and major variants

- **cross-device:** many intermittently available devices, small local datasets, limited compute/bandwidth, and partial participation;
- **cross-silo:** fewer stable organisations/sites with larger datasets, contractual governance, and heterogeneous infrastructure;
- central coordinator, hierarchical federation, or decentralised/peer-to-peer coordination;
- global, clustered, multi-task, or personalised models;
- synchronous, asynchronous, or buffered rounds;
- federated training, evaluation, analytics, or combinations;
- trusted, honest-but-curious, unreliable, Byzantine, or mixed participant assumptions.

Name the variant, topology, trust model, client population, participation assumptions, and whether client identity persists across rounds.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Define client unit/population, topology, coordinator and client responsibilities, personalisation target, trust/threat assumptions, and communication/availability constraints | Federation charter, topology, and client-level success criteria |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Preserve client ownership, local schema/version, eligibility, sample counts, distribution heterogeneity, and permitted telemetry without centralising prohibited data | Client data contract, participation inventory, and federated diagnostics |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md) | Split within clients and across clients/sites; reserve unseen clients or later client periods when deployment requires transfer | Client-aware split manifest and locked federated evaluation plan |
| [05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Specify local versus global transforms, aggregate-statistic protocol, schema/label-map compatibility, and state placement | Placement-annotated preprocessing contract |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare local-only, pooled/simulated where lawful, and simple federated aggregation under equal budgets; tune across realistic client samples | Per-client baseline table and round/communication budget study |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Report example-, client-, and population-level utility, dispersion/tails, participation and system cost; validate on real client placement | Locked federated result with client-level uncertainty |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[13](../../machine_learning_lifecycle_phases/13_deployment.md) | Package coordinator/client logic, protocol and state schemas, compatibility, eligibility, aggregation, authentication, retries, rollout, and rollback | Signed compatibility matrix and rehearsed federated release |
| [14](../../machine_learning_lifecycle_phases/14_monitoring.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Monitor client participation/coverage, heterogeneity, failures, update anomalies, communication, versions and local residuals; retire all endpoints and state | Federated operations dashboard, incident drill, and endpoint retirement record |

## Problem and data contract

The primary grouping unit is the real client: device, user, hospital, bank, factory, region, or other data controller/holder. Do not manufacture random pseudo-clients and then claim evidence for real federation.

Record for each participating client class, without collecting prohibited raw data:

- eligibility, consent/contract/legal basis, authentication, withdrawal, and expected population coverage;
- local observation unit, schema, label definition, time span, sample-count range, and quality checks;
- hardware/runtime, network, power, storage, and update-size constraints;
- availability and selection mechanism by time/region/device/site;
- permitted telemetry, aggregation thresholds, retention, and access boundaries;
- whether local labels/outcomes are observable and comparable across clients;
- whether the model is global, client-local, clustered, or personalised and what state remains local.

Client sample counts and local examples may themselves be sensitive. Minimise telemetry and route privacy requirements to the privacy overlay.

Data heterogeneity includes feature, label, quantity, temporal, language, device, and concept differences. A global schema does not imply identical client distributions. Validate semantic equivalence—not just dtype compatibility—before aggregating updates or metrics.

## Split and evaluation protocol

Use two complementary axes:

1. **within-client split:** earlier/later or local train/validation/test evidence without local leakage;
2. **across-client split:** development clients, held-out clients/sites, and—when relevant—new-client or new-period evaluation.

Do not randomly pool all records before splitting; that destroys the deployment grouping and can leak the same person/site/device across partitions. For cross-device deployment, simulate realistic availability and client sampling, then confirm the final result on actual federated placement or a justified representative pilot. For cross-silo deployment, keep at least one site external when the intended claim includes transfer to new sites and the number of sites permits meaningful inference.

Federated evaluation must define who computes metrics, what leaves the client, minimum aggregation cohort, handling of small cells, weighting, dropouts, and whether secure/private aggregation is used. A client selected for tuning must not be silently treated as an unseen-client final test.

## Baselines and model-family choices

Use applicable baselines:

- local-only model per client, exposing whether collaboration helps;
- no-personalisation global model versus local fine-tuning/personalisation;
- simple sample-count-weighted federated averaging;
- rules/incumbent model and central pooled training only where data use is lawful and the result is clearly labelled as an oracle/reference rather than a deployable assumption;
- no-training/frozen model where communication or update risk is material.

Compare baselines using identical eligible clients, round budget, local epochs/steps, total example exposure, and privacy/security mechanisms. A method with extra client contact or compute has not earned a fair algorithmic gain unless that extra budget is reported.

Choose model families for serialisation size, local memory/compute, robustness to heterogeneous local optimisation, update sparsity/compressibility, version compatibility, and personalisation requirements in addition to predictive utility.

## Training and validation adaptations

Specify the complete round protocol:

1. client eligibility and sampling;
2. server-to-client model/config broadcast;
3. local preprocessing, optimisation, clipping/validation, and checkpoint behaviour;
4. update encoding, authentication, retry and timeout;
5. aggregation weighting and robust/secure mechanism;
6. server state update, evaluation, checkpoint, and promotion decision.

Record clients per round, local batch/epochs/steps, optimiser(s), weighting, round timeout, straggler/dropout treatment, retry idempotency, aggregation rule, compression, model/state size, and randomisation. Test sensitivity to non-IID severity, quantity imbalance, partial participation, availability bias, local label noise, and client sampling.

Do not tune solely on a centralised simulation that can inspect all client data. Treat the simulator as development evidence and preserve the same observability restrictions as production wherever possible. Hyperparameter selection must aggregate client evidence under a declared weighting and fairness criterion.

If secure aggregation, differential privacy, trusted execution, or encrypted computation is used, state the mechanism and adversary separately; federation alone is not the guarantee.

## Metrics and uncertainty

Report task utility at multiple aggregation levels:

- micro/example-weighted aggregate;
- macro/client-weighted aggregate;
- median and predeclared low quantiles or worst-client/site results when safe to disclose;
- dispersion and uncertainty across clients, sites, rounds, and repeated client samples;
- new-client, low-data, low-connectivity, and underrepresented client slices;
- global versus personalised performance and personalisation cost.

System metrics include rounds and wall time to target, clients/examples processed, total bytes uplink/downlink, update/model size, local compute/energy proxy, participation/acceptance/completion/dropout rates, straggler delay, failure/retry rate, and coordinator availability.

State the metric weighting. An example-weighted mean can hide poor small-client performance; an unweighted client mean can overstate unstable tiny clients. Report both when they answer distinct deployment questions.

When privacy mechanisms apply, report their parameters/accounting and utility impact in the privacy guide; do not fold a privacy claim into “raw data stayed local.”

## Error analysis, safety, and robustness

Test plausible failures across client classes:

- highly non-IID labels/features and severely unbalanced quantities;
- client selection/availability bias and long-offline returning clients;
- stale/asynchronous updates, stragglers, dropped rounds, retries, and version mismatch;
- corrupted local data, local preprocessing divergence, label-semantic mismatch, and clock skew;
- Byzantine, poisoned, backdoored, Sybil, replayed, or abnormally scaled updates;
- compromised or honest-but-curious coordinator/client assumptions from the threat model;
- global improvement with material harm to a minority of clients;
- personalisation overfit, loss of global fallback, and state reset/migration failures.

Robust aggregation may reduce some update anomalies but does not prove correctness, security, fairness, or privacy. Validate it against named attacks/failures and record its cost and false-rejection effects on legitimate heterogeneous clients.

## Packaging, deployment, monitoring, and maintenance

Package both sides of the system:

- coordinator strategy, state and checkpoint schema;
- client runtime/model, local training/evaluation logic, preprocessing and constraints;
- protocol/API, message schemas, authentication/attestation if used, and compatibility matrix;
- eligibility/sampling policy, aggregation and minimum-cohort rules;
- timeout, retry/idempotency, quarantine, canary, rollout and rollback;
- personalisation/local-state migration and deletion behaviour;
- privacy/security configuration and keys by reference, never embedded as secrets.

Roll out coordinator and client versions under an explicit compatibility window. Canary across representative client classes, not only reliable internal devices/sites. A rollback must address server model, optimiser/aggregator state, protocol version, and client-local personalised state.

Monitor client coverage and participation distribution, per-client-class utility, new/returning clients, update norms/anomalies, model/version adoption, completion/dropout/straggler rates, rounds/bytes/latency, coordinator errors, aggregate privacy/security status, and personalisation health. Preserve minimum cohort/privacy thresholds in monitoring itself.

Retirement must stop new rounds, revoke coordinator/client credentials, retire incompatible client binaries, handle offline clients that return later, delete coordinator and local training state under contracts, and document the disposition of personalised models and audit evidence.

## Minimum completion checklist

- [ ] Real client unit, population, topology, trust model, and personalisation target are defined.
- [ ] Federation is explicitly separated from privacy, distributed data parallelism, edge inference, and continual learning.
- [ ] Client data/schema, eligibility, selection, availability, telemetry, and withdrawal are governed.
- [ ] Splits preserve clients and include within-client and across-client evidence as required.
- [ ] Local-only, simple aggregation, global/personalised, and lawful pooled-reference baselines are cost matched.
- [ ] The round protocol, client/round budgets, weighting, failure handling, and state lineage are reproducible.
- [ ] Micro, macro, tail/client dispersion, participation, communication, latency, and failure metrics are reported.
- [ ] Non-IID, imbalance, availability, stale versions, Byzantine/poisoned updates, and rollback are tested.
- [ ] Coordinator/client compatibility and offline-client retirement are rehearsed.
- [ ] Any privacy guarantee names its separate mechanism, threat model, and evidence.

## Related guides

- [Privacy-preserving machine learning](privacy_preserving_machine_learning.md)
- [Online, incremental, and continual learning](online_incremental_and_continual_learning.md)
- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md)
- [Active learning and human-in-the-loop systems](active_learning_and_human_in_the_loop.md)
- [Automated machine learning](automated_machine_learning.md)
- [Anomaly, novelty, and OOD detection](../task_families/anomaly_novelty_and_ood_detection.md)

## Official and primary references

- [McMahan et al., Communication-Efficient Learning of Deep Networks from Decentralized Data](https://proceedings.mlr.press/v54/mcmahan17a.html) — foundational federated averaging paper identifying decentralised, unbalanced, non-IID data and communication constraints.
- [TensorFlow Federated tutorials](https://www.tensorflow.org/federated/tutorials/tutorials_overview) — official training/evaluation, client-data, aggregation, robustness, compression, and explicit differential-privacy tutorials.
- [TensorFlow Federated: Building a federated learning algorithm](https://www.tensorflow.org/federated/tutorials/building_your_own_federated_learning_algorithm) — official broadcast, local update, upload/aggregation, and server-update structure.
- [Flower Framework documentation](https://flower.ai/docs/framework/index.html) — official client/server strategy, deployment, federated evaluation, differential privacy, and secure aggregation documentation.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
