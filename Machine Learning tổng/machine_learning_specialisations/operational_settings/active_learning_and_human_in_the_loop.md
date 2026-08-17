# Active Learning and Human-in-the-Loop Systems

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay adds controls for systems that choose what humans label/review or that rely on human judgement during operation.

## Use this guide when

Use it when the system:

- selects unlabelled examples, pairs, regions, or trajectories for annotation;
- routes uncertain, high-impact, novel, or policy-defined cases to human review;
- uses human overrides, corrections, preferences, or adjudication as feedback;
- retains a human approval, escalation, or stop authority in the deployed decision path;
- optimises model quality jointly with label, review, time, or expert-capacity budgets.

## Do not confuse it with

- **Active learning:** the learner chooses queries to improve a learning objective under an acquisition budget.
- **Human-in-the-loop (HITL):** a broader system design in which humans label, review, approve, override, monitor, or govern decisions. A HITL system need not actively select training examples.
- **Human-on-the-loop:** humans supervise and can intervene, but do not approve every decision.
- **Ordinary annotation:** a fixed, independently sampled labelling plan is not active learning.
- **Weak supervision:** programmatic/noisy label sources are owned by the [semi/weak/self-supervised guide](../paradigms_and_methods/semi_weak_and_self_supervised_learning.md).
- **Preference learning or RLHF:** add the [reinforcement-learning](../paradigms_and_methods/reinforcement_learning_and_bandits.md) and task/modality overlays. Human feedback does not by itself make a system active learning.
- **Selective prediction:** abstention may trigger review, but a review rule becomes active learning only if acquired labels update the learner.

## Scope and major variants

- pool-based sampling from a finite unlabelled set;
- stream-based selective sampling under an immediate decision budget;
- membership-query or synthesised-query settings, when experts can safely label artificial cases;
- uncertainty, disagreement, expected-change/error-reduction, diversity/coverage, or hybrid acquisition;
- single annotator, redundant annotation, expert routing, and adjudication;
- per-decision approval, exception review, audit sampling, human override, and escalation;
- batch active learning, periodic retraining, or an online loop.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Define human roles, authority, review capacity, acquisition objective, label/review cost, and acceptable residual automation risk | Human–AI responsibility map and budgeted loop objective |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Track pool eligibility, query rationale, annotator identity/qualification, abstention, disagreement, adjudication, and feedback selection | Query/annotation ledger and annotator-quality evidence |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md) | Keep representative evaluation evidence outside the queryable pool; reproduce every acquisition round without leaking evaluation labels | Locked evaluation cohort and round-by-round split manifest |
| [05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Prevent embeddings, clustering, and uncertainty models from learning from locked evidence; version the acquisition representation | Versioned acquisition pipeline and pool snapshot |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare against random/passive sampling and incumbent review policy at equal cost; tune acquisition without exhausting the test set | Cost-matched learning/review curves and selected policy |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Measure utility per cost, coverage, human reliability, review burden, residual risk, and uncertainty on representative evidence | Budget curves, human-process metrics, and locked final result |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[13](../../machine_learning_lifecycle_phases/13_deployment.md) | Package query/review rules, interfaces, routing, authority, escalation, audit logs, and safe fallback | Reviewed human–AI operating procedure and fail-safe drill |
| [14](../../machine_learning_lifecycle_phases/14_monitoring.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Monitor pool/feedback bias, reviewer load and quality, automation bias, override outcomes, and stale queues; retain feedback lawfully | Review-quality dashboard, feedback audit, and retirement handoff |

## Problem and data contract

Define three separate units: the prediction unit, the query unit, and the human decision/label unit. They may differ—for example an image may be predicted as a whole, a region queried, and a case adjudicated with external records.

For every candidate and query, record:

- source, timestamp, entity/group, eligibility, and pool membership version;
- model/acquisition-policy version and acquisition score or rule;
- whether the candidate was offered, accepted, skipped, expired, or reassigned;
- annotator role and qualification, instructions/version, response time, confidence/abstention, and rationale where required;
- raw labels, revisions, disagreement, adjudicated label, and adjudication policy;
- monetary/time burden and any safety or privacy restriction on showing the case.

The label contract must allow **unknown**, **not enough information**, **out of scope**, and escalation where these are real states. Forcing a label turns ambiguity into hidden label noise.

Because queries are selected, the acquired set is generally not representative of deployment prevalence. Preserve the query probability or selection rule when possible; never report pool-label proportions as population prevalence without a justified correction.

## Split and evaluation protocol

Create a representative, independently sampled and locked evaluation set before active acquisition begins. It must never enter the query pool, diversity index, acquisition-model fitting, prompt examples, annotator coaching, or stopping-rule selection.

Run development as explicit rounds:

1. train only on labels available at the start of the round;
2. score the current eligible pool;
3. select queries subject to cost, diversity, safety, and reviewer constraints;
4. collect and adjudicate labels without exposing evaluation answers;
5. append labelled evidence and evaluate at the declared checkpoint.

Compare policies on the same initial labels, pool, label-quality process, and cumulative cost. Repeat runs across initial seeds or pool draws when acquisition is stochastic. If deploying on a stream, preserve chronological availability and add the [online/continual overlay](online_incremental_and_continual_learning.md).

Evaluate the human–AI workflow under realistic workload, information, timing, and UI conditions. Retrospective reviewers with unlimited time and outcome access are not a valid proxy for live oversight.

## Baselines and model-family choices

Active-learning baselines:

- uniform random sampling from the same eligible pool;
- passive stratified or coverage-based sampling that does not use model uncertainty;
- full-labelling performance when feasible as a reference ceiling, clearly separated from a budget-matched comparator;
- the same learner with different acquisition rules, so acquisition gains are not confused with model-family gains.

HITL baselines:

- human-only and model-only decisions where ethically and operationally evaluable;
- incumbent review-all, review-none, or rules-based routing;
- random audit at the same reviewer capacity;
- a simple threshold/abstention policy.

Do not select a complex acquisition function before showing that uncertainty is calibrated enough to support it and that a cheap diversity/random baseline is inadequate.

## Training and validation adaptations

- Pre-register the acquisition budget, batch size, stopping rule, initial labelled seed, candidate filters, diversity constraint, and retraining cadence.
- Fit acquisition representations and uncertainty/calibration models only from eligible development data.
- Separate the production model from any acquisition model; version and validate both when they differ.
- Treat annotator guidance, UI, model suggestions, and order of presentation as experimental factors that can change labels.
- Use blinded or model-hidden annotation for an audit sample to measure anchoring and automation bias.
- Route low-agreement or high-impact cases to qualified adjudicators; do not resolve disagreement automatically by majority vote without a domain justification.
- Correct or at least diagnose class/source coverage collapse caused by uncertainty-only querying.
- If override/correction data becomes training data, record exposure and review selection so future evaluation can account for the feedback loop.

## Metrics and uncertainty

Active learning requires a curve over cumulative resource, not one endpoint:

- task utility versus number of labels, monetary cost, reviewer minutes, and elapsed time;
- area under the learning curve or labels/cost required to reach a predeclared target;
- query yield: valid, novel, positive, corrected, duplicate, abstained, and out-of-scope rates;
- pool and slice coverage, including underrepresented sources/groups;
- variability across acquisition seeds, initial labelled sets, and annotators.

HITL reporting adds:

- automation coverage and review coverage;
- override/correction rate and outcome-conditioned value of overrides;
- residual error/harm among auto-approved and human-approved cases;
- reviewer sensitivity/specificity or agreement against adjudicated evidence where meaningful;
- queue delay, service-level attainment, review time, escalation and abandonment rates;
- inter-/intra-annotator agreement with uncertainty and prevalence context.

A falling override rate is not automatically improvement: it can mean better automation, reviewer fatigue, anchoring, or reduced authority. Interpret process metrics with audited outcomes.

## Error analysis, safety, and robustness

Slice by source, class, model confidence, reviewer, workload, time-of-shift, language/accessibility needs, protected groups where lawful, and disagreement category. Test:

- confidently wrong models that uncertainty sampling fails to query;
- rare but costly cases crowded out by average informativeness;
- duplicated/near-duplicated queries and pool exhaustion;
- adversarial candidates that manipulate uncertainty or reviewer attention;
- reviewers accepting incorrect model suggestions, especially under time pressure;
- inconsistent instructions, label drift, conflicts of interest, and expertise mismatch;
- queue overload, reviewer outage, stale decisions, and escalation dead ends;
- malicious or accidental labels and coordinated feedback poisoning.

Human involvement is not a safety guarantee. The NIST AI RMF Playbook recommends identifying features requiring oversight, defining roles and authority, testing oversight in deployment-like conditions, training personnel, and re-evaluating oversight when it changes.

## Packaging, deployment, monitoring, and maintenance

Package the acquisition and review system, not only the predictor: candidate filters, acquisition policy, calibration state, pool/version store, annotation schema, instructions, UI version, reviewer routing, qualification rules, adjudication, escalation, timeout, audit sampling, and fallback.

The interface must show sufficient context, uncertainty/limitations in a form reviewers understand, the consequence of each action, and a genuine abstain/escalate path. Define whether the model suggestion is initially hidden to reduce anchoring and which cases require independent dual review.

Monitor acquisition distribution, pool depletion, class/source coverage, annotation disagreement, adjudication reversals, reviewer workload/latency, model–human disagreement, overrides and their outcomes, automation coverage, and downstream harm. Trigger a pause when review capacity or feedback quality falls below its validated envelope.

Retirement must drain or reassign the queue, preserve required decision and consent/audit records, stop using stale annotation instructions, revoke reviewer access, and specify whether collected feedback may be reused by successor systems.

## Minimum completion checklist

- [ ] Prediction, query, label, and human-decision units are defined separately.
- [ ] Human roles, competence, authority, escalation, and accountability are documented.
- [ ] A representative locked evaluation set is isolated from every acquisition round.
- [ ] Query/annotation provenance, selection, cost, abstention, disagreement, and revisions are logged.
- [ ] Random/passive sampling and incumbent human-review policies are compared at equal budget.
- [ ] Utility-versus-cost curves and variability across acquisition seeds are reported.
- [ ] Review burden, delay, residual auto/human error, and audited override outcomes are reported.
- [ ] Automation bias, reviewer fatigue/outage, poisoning, and confidently wrong cases are tested.
- [ ] Feedback entering training retains exposure and selection provenance.
- [ ] Safe fallback, queue handling, and retirement of reviewer access are rehearsed.

## Related guides

- [Semi-, weakly, and self-supervised learning](../paradigms_and_methods/semi_weak_and_self_supervised_learning.md)
- [Reinforcement learning and contextual bandits](../paradigms_and_methods/reinforcement_learning_and_bandits.md)
- [Anomaly, novelty, and OOD detection](../task_families/anomaly_novelty_and_ood_detection.md)
- [Generative modelling](../task_families/generative_modelling_and_content_generation.md)
- [Online, incremental, and continual learning](online_incremental_and_continual_learning.md)
- [Privacy-preserving machine learning](privacy_preserving_machine_learning.md)

## Official and primary references

- [Settles, From Theories to Queries: Active Learning in Practice](https://proceedings.mlr.press/v16/settles11a.html) — primary practical survey of query selection, acquisition economics, and violated real-world assumptions.
- [Settles, Active Learning Literature Survey](https://minds.wisconsin.edu/handle/1793/60660) — foundational survey defining pool, stream, and query-synthesis settings.
- [NIST AI Risk Management Framework 1.0](https://doi.org/10.6028/NIST.AI.100-1) — normative risk-management framing for human–AI configurations and accountability.
- [NIST AI RMF Playbook](https://airc.nist.gov/docs/AI_RMF_Playbook.pdf) — official operational guidance for oversight roles, training, deployment-like testing, documentation, and re-evaluation.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
