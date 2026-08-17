# Reinforcement Learning and Contextual Bandits

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an independent lifecycle. Apply the core and add these controls when actions influence rewards, future observations, or the data subsequently available for learning.

## Use this guide when

Use it for sequential decision policies learned from agent–environment interaction, offline logged trajectories, simulators, or contextual-bandit feedback. The overlay also applies when a recommender, controller, or agent changes its policy through reward or preference optimisation.

## Do not confuse it with

- Supervised prediction estimates a labelled target; RL optimises actions under policy-dependent feedback and, for sequential RL, delayed consequences.
- A contextual bandit observes context, chooses an action, and receives action-specific feedback without modelling long state transitions; full RL models sequential state and return.
- Ranking metrics do not establish policy value; add the [recommendation/ranking](../task_families/recommendation_ranking_and_retrieval.md) overlay when candidates are ordered.
- A simulator is an evaluation instrument with a validity boundary, not automatically ground truth.

## Scope and major variants

Covered settings are online and offline RL, model-free and model-based methods, episodic and continuing tasks, contextual bandits, imitation/behaviour cloning as baselines or stages, and constrained or risk-sensitive policies. Robotics- and domain-specific safety standards must be added separately.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md) | Define observation/state, action, reward, horizon, discounting, termination, constraints, feedback delays, logging policy and propensities. | Environment/policy contract, reward specification, action and safety boundary. |
| [03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Validate trajectories, time order, action coverage, propensities, terminal handling, simulator assumptions, and policy-induced missing feedback. | Trajectory audit and support/coverage report. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Include behaviour, random/safe heuristic and supervised baselines; budget interactions; use repeated seeds and validation environments/logs. | Baseline policy table, interaction/compute ledger, seed-level selection evidence. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Report return and constraints with uncertainty; validate off-policy estimators and simulator-to-real limits; stage online experiments when authorised. | OPE/simulator report, safety results, locked or staged final evidence. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package policy plus state/action/reward interfaces and guardrails; monitor exploration, reward/constraint outcomes and feedback loops; retain rollback policy. | Policy manifest, action-gate tests, monitoring/rollback/retirement plan. |

## Problem and data contract

Specify the observation available at decision time, action space and legal actions, reward components and timing, transition/episode semantics, horizon, discount factor where used, terminal/truncated distinction, and hard constraints. Document who is affected by exploration and which actions require approval or prohibition. Logged data must include policy/version, timestamp, context/state, available actions, selected action, action probability when available, outcome/reward timing, censoring, and environment version.

## Split and evaluation protocol

Split by complete trajectory, episode, user/entity, time, environment or site so correlated transitions do not straddle folds. Preserve chronology when the deployed policy will face future conditions. Sequential offline policy evaluation requires adequate behaviour-policy support over state-action occupancy across the horizon; document concentrability/coverage limits, low-support regions, confounding/partial-observability assumptions and estimator-selection reuse. Tune on separate logs/environments from final evidence. Treat simulator results as conditional on documented fidelity tests, and stage any online experiment behind risk review, guardrails, stopping rules and rollback.

## Baselines and model-family choices

Required baselines include the logging/behaviour policy, a safe business heuristic or controller, random action only when ethical and valid, and supervised behaviour cloning for offline settings. Contextual bandits should compare simple non-contextual and supervised predictors. Full RL must justify sequential optimisation over a bandit or myopic policy. Compare reward gains with constraint violations, sample/interaction cost, and operational complexity.

## Training and validation adaptations

Version environment/simulator, policy, reward implementation, normalisation, replay/log dataset, target networks or model components, exploration schedule, seeds and budgets. For offline RL, prevent learned-policy interaction with held-out trajectories during selection and track extrapolation beyond logged action support. For online learning, cap exploration, enforce immutable action filters, isolate experiments, and log propensities. Use multiple seeds and report learning curves rather than selecting a favourable run.

## Metrics and uncertainty

Report episodic/discounted return or bandit reward at the decision-relevant aggregation unit, plus constraint violations, tail risk, failure rate, action coverage, regret when identifiable, interaction/sample efficiency, and stability across seeds/environments. For sequential off-policy evaluation, name whether evidence is importance-sampling, fitted-value/Q, model-based, doubly robust or another estimator; record target/logging policies, horizon, occupancy/support diagnostics, uncertainty, clipping/weighting and estimator-selection sensitivity. Offline value is evidence under assumptions, not proof of online impact.

## Error analysis, safety, and robustness

Inspect catastrophic states, reward hacking/specification gaming, unsafe exploration, delayed-credit failures, distribution shift, unobserved confounding, partial observability, simulator gaps, policy loops, action imbalance, horizon-driven variance, and performance under perturbations or adversaries. Slice by environment, initial state, horizon, user group, rare action and low-support region. Stress-test guardrails independently of expected return and define safe fallback behaviour for missing or invalid observations.

## Packaging, deployment, monitoring, and maintenance

Package policy weights/logic with observation encoder, action catalogue/mask, reward and termination versions, state/history contract, exploration configuration, safety shield, fallback policy, and simulator/evaluation dependencies. Monitor action distribution and support, realised reward and delay, constraint/failure rate, exploration exposure, state/representation shift, feedback-loop effects, and policy version. Distinguish policy retraining, reward change, simulator change, online update and guardrail change; reward or action-contract changes invalidate prior evaluation and require new approval.

## Minimum completion checklist

- [ ] State/observation, action, reward, horizon, termination, constraints and affected users are explicit.
- [ ] Logs contain policy versions and propensities where OPE requires them; coverage limitations are documented.
- [ ] Splits preserve trajectories, entities, environments and time boundaries.
- [ ] Behaviour, safe heuristic, cloning and simpler bandit/myopic baselines are compared as applicable.
- [ ] Multiple seeds, interaction/compute budgets, learning curves and environment versions are recorded.
- [ ] OPE/simulator assumptions, uncertainty, safety metrics and staged final evidence are reported honestly.
- [ ] Immutable action gates, fallback, monitoring, stopping, rollback and retirement controls are tested.

## Related guides

- [Recommendation, ranking, and retrieval](../task_families/recommendation_ranking_and_retrieval.md)
- [Deep learning, transfer, and multitask learning](deep_learning_transfer_and_multitask.md)
- [Online, incremental, and continual learning](../operational_settings/online_incremental_and_continual_learning.md)
- [Active learning and human-in-the-loop systems](../operational_settings/active_learning_and_human_in_the_loop.md)
- [Foundation-model dependencies and system patterns](foundation_model_dependencies_and_system_patterns.md)
- [Specialisation index](../README.md)

## Official and primary references

- [Sutton and Barto, *Reinforcement Learning: An Introduction*, second edition](http://incompleteideas.net/book/the-book-2nd.html) — authoritative definitions of policies, value, return, exploration, and agent–environment interaction.
- [Deep Reinforcement Learning That Matters](https://ojs.aaai.org/index.php/AAAI/article/view/11694) — primary evidence on sensitivity to seeds, implementations, hyperparameters, and reporting choices.
- [Unbiased Offline Evaluation of Contextual-bandit-based News Article Recommendation Algorithms](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/Published-3.pdf) — primary logged-policy evaluation method and assumptions.
- [Sample-efficient Nonstationary Policy Evaluation for Contextual Bandits](https://www.microsoft.com/en-us/research/publication/sample-efficient-nonstationary-policy-evaluation-for-contextual-bandits-2/) — primary work combining importance weighting, doubly robust, and nonstationary evaluation ideas.
- [Levine et al., Offline Reinforcement Learning: Tutorial, Review, and Perspectives](https://arxiv.org/abs/2005.01643) — authoritative sequential offline-RL review of distribution shift, support and algorithm/evaluation assumptions.
- [Thomas and Brunskill, Data-Efficient Off-Policy Policy Evaluation for Reinforcement Learning](https://proceedings.mlr.press/v48/thomasa16.html) — primary sequential-MDP doubly robust off-policy evaluation work.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
