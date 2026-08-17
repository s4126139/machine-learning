# Automated Machine Learning

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay adds controls for automated search and selection over models, pipelines, architectures, ensembles, or development decisions. Automation does not waive human accountability or the locked final evaluation.

## Use this guide when

Use it when a system automates a material set of ML development decisions, including:

- hyperparameter optimisation (HPO);
- algorithm/model-family or pipeline selection (CASH);
- automated feature/preprocessing construction or selection;
- ensemble construction and weight/threshold/calibration search;
- neural architecture search (NAS);
- meta-learning, warm-starting, or transfer of search knowledge across tasks;
- multi-objective or constrained search over utility, latency, size, cost, fairness, privacy, or energy.

A small manually reviewed parameter sweep still follows the same leakage and selection principles, but a dedicated overlay is most valuable when search is adaptive, broad, expensive, repeated, or produces a deployable pipeline automatically.

## Do not confuse it with

- **HPO:** optimisation within a hyperparameter space; it is one component of AutoML, not the whole field.
- **Ordinary model fitting:** learned coefficients/weights are parameters, not automatically searched hyperparameters.
- **NAS:** automated architecture design; add the [deep-learning overlay](../paradigms_and_methods/deep_learning_transfer_and_multitask.md) for training/export controls.
- **Meta-learning:** learning from prior tasks may warm-start or govern search, but can also be used outside AutoML. Record prior-task provenance and transfer boundary.
- **No-code ML:** an interface style, not evidence that evaluation, governance, or deployment is automated correctly.
- **Auto-deployment:** selecting a candidate does not authorise release. Packaging, safety review, approval, canary, monitoring, and rollback remain separate lifecycle gates.
- **Autonomous science/agents:** agentic experimentation may include AutoML but also requires task-specific tool, data, safety, and human-authority controls.

## Scope and major variants

- grid, random, Bayesian/model-based, evolutionary/population-based, gradient-based, bandit/multi-fidelity, or portfolio search;
- conditional/hierarchical model and preprocessing spaces;
- single- or multi-objective, constrained, cost-aware, and hardware-aware optimisation;
- holdout, cross-validation, time/group-aware resampling, nested evaluation, or simulator/environment objectives;
- one-shot or weight-sharing NAS and full independent candidate training;
- ensembling, stacking, thresholding, calibration, and postprocessing search;
- cold-start search or meta-learned/warm-started search;
- manual approval, policy-based auto-selection, or continuous search in production.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Define automation boundary, human authority, objective/constraints, resource and data-query budgets, search-space ownership, and promotion rule | Search charter and human approval map |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Freeze eligible data/splits outside the optimiser; place every learned preprocessing/feature decision inside each candidate; govern prior-task/meta-data | Immutable split/data manifest and leakage-reviewed pipeline grammar |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md) | Compare defaults, manual/incumbent, and simple random search at equal resource; include complexity/cost baseline | Budget-matched baseline and search-value evidence |
| [07](../../machine_learning_lifecycle_phases/07_model_training.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Version search space, optimiser and scheduler; bound trials/time/compute/energy; handle failures, seeds, pruning, parallelism, and retraining | Complete trial lineage, budget ledger, and reproducible selection |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Separate search objective from diagnostic/constraint/final metrics; quantify optimiser variability and selection bias; use outer/locked evidence once | Search curves/Pareto evidence plus independently evaluated selected candidate |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[13](../../machine_learning_lifecycle_phases/13_deployment.md) | Package resolved pipeline and its provenance, not a mutable search; enforce constraints and human promotion; canary/rollback exact artefact | Immutable selected-pipeline bundle and signed promotion record |
| [14](../../machine_learning_lifecycle_phases/14_monitoring.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Monitor constraint/cost regressions and search-system drift; govern reruns, prior results, candidate retention, and automatic replacement | Re-search trigger, comparison report, artefact lineage, and search-data retirement |

## Problem and data contract

The AutoML contract must list what is fixed by humans and what the system may choose. Typical searchable dimensions include transforms, feature sets, algorithms, architecture, loss, class/reward weights, optimiser, augmentation, thresholds, calibration, ensemble membership, and resource allocation.

For each dimension, define valid type/range/categories, conditional dependencies, defaults, prohibited combinations, resource prerequisites, monotonic or domain constraints, and rationale. An unconstrained “all algorithms/all preprocessing” space is not neutral: it embeds defaults, invalid combinations, unequal training budgets, and potentially unsafe candidates.

Record every dataset/split version and the evaluation service interface available to trials. The optimiser must not read labels, features, metadata, or metrics outside its declared development interface. Protected groups, costs, latency, privacy budgets, and safety metrics needed for constraints must be available through approved measurements rather than inspected ad hoc.

Meta-learning/warm-start systems must record the source tasks, datasets, licences, privacy permissions, overlap with the target, extracted meta-features/results, and expiry. Prior benchmark knowledge can contaminate a supposedly unseen target or transfer unsuitable defaults.

## Split and evaluation protocol

Construct group-, time-, client-, graph-, environment-, or entity-aware partitions **before** search, following the applicable overlays. Every candidate must receive the same valid partitions unless fidelity itself is a predeclared search variable with a comparable final evaluation.

All data-dependent work—including imputation, scaling, feature selection, augmentation-policy fitting, representation learning, resampling, calibration, threshold selection, and ensemble selection—belongs inside the training/inner-selection boundary. Caching must be keyed by candidate, fold, and data version so fitted state cannot cross folds.

Use three evidence levels:

1. **inner/search evidence:** drives proposals, pruning, and candidate selection;
2. **outer development evidence:** estimates the performance of the complete search procedure when an unbiased procedure-level estimate is required, for example nested resampling;
3. **locked final evidence:** used once for the fully frozen search procedure/selected retraining recipe.

Nested evaluation is not automatically required for every low-risk project, but the performance reported from data repeatedly optimised by thousands of adaptive trials is optimistic. Use nested resampling, a fresh holdout, or a prospective/external final set proportional to the search scope and claim.

Do not run a fresh AutoML search independently on the test set, select the best test seed, or use final-test diagnostics to revise the space and still call the same test locked.

## Baselines and model-family choices

At equal wall-clock or compute budget, compare:

- framework/model defaults with no tuning;
- incumbent/manual pipeline and a simple task-appropriate model;
- random search over the same valid space;
- a reduced search space exposing whether broad automation adds value;
- best single candidate versus AutoML ensemble, including inference cost;
- optional oracle/post-hoc best trial only as analysis, never as a deployable prospective baseline.

Fair comparisons give each model family a reasonable conditional space and training resource; a family with one default should not be compared with another receiving thousands of trials without reporting that asymmetry.

Prefer a simpler near-optimal candidate when its latency, memory, calibration, interpretability, robustness, or operational reliability is materially better. AutoML objective rank does not override deployment requirements.

## Training and validation adaptations

- Version the search-space schema, optimiser/surrogate/scheduler, acquisition and pruning rules, initial design, seed, framework/environment, hardware, objective code, folds, and budget.
- Predeclare maximum trials, wall time, accelerator/CPU hours, memory/disk, concurrent workers, per-trial time/resource, data evaluations, and privacy/label budget where applicable.
- Log all proposed configurations, resolved defaults, status, intermediate/final metrics, constraints, resource use, failures, exceptions, prune reason, checkpoints, and parent/warm-start lineage—including unsuccessful trials.
- Make parallel search reproducible enough to explain order-dependent proposals, early stopping, duplicate trials, worker loss, and retries. Distinguish exact replay from statistically comparable rerun.
- Validate pruning/multi-fidelity assumptions: early low-fidelity rank may not predict full training, and it may disadvantage slow-starting families.
- Treat ensemble, calibration, and threshold selection as additional adaptive trials using development evidence only.
- After selection, retrain from the declared data and seed policy; do not deploy an opportunistic intermediate checkpoint unless that checkpoint was the defined selection unit.
- Re-evaluate every hard constraint after full retraining and packaging because latency, size, fairness, privacy, and utility can differ from proxy trials.

## Metrics and uncertainty

Separate metric roles:

- **search objective:** the scalar or vector exposed to the optimiser;
- **constraints:** feasibility thresholds such as memory, latency, fairness, privacy, or safety;
- **diagnostics:** robustness, calibration, slices, complexity, and failure indicators unavailable to optimisation unless deliberately included;
- **final metrics:** locked evidence for the selected complete procedure.

Report:

- incumbent and best-so-far objective versus trials, wall time, compute, and other budgets;
- final selected configuration and its validation-to-final generalisation gap;
- variability across search seeds/initial designs and model-training seeds;
- number of attempted, valid, failed, timed-out, pruned, duplicate, and constraint-violating trials;
- total and per-trial time/compute, peak memory, disk, communication, model size, and inference cost;
- Pareto front and final selection rationale for multi-objective search;
- task metrics, uncertainty, calibration, slices, robustness, and business/safety constraints from the owning guides.

The best observed validation score becomes more likely to exploit noise as trials accumulate. Do not attach the selected candidate's ordinary fold standard deviation to the whole search procedure as if selection had not occurred. Use outer repeats, fresh final evidence, or procedure-level bootstrap/repetition when uncertainty about AutoML selection is important.

## Error analysis, safety, and robustness

Inspect both the selected candidate and the search system. Test:

- preprocessing/feature leakage through folds, caches, target encoders, augmentation, embeddings, and stacking;
- invalid conditional spaces, silently ignored parameters, default substitution, failed/pruned-trial bias, and incomparable fidelities;
- optimiser exploiting a metric bug, unstable slice, simulator artefact, timing shortcut, leakage feature, or under-specified proxy;
- selection instability across seeds, small data changes, worker scheduling, and framework versions;
- rare but critical constraint violations hidden by mean objectives;
- unfair budget allocation across families and compute-heavy overfitting;
- resource exhaustion, runaway trials, orphan processes/artefacts, poisoned warm-start history, and untrusted candidate dependencies;
- robust/fair/private candidates losing feasibility after full-data retraining or export.

Use hard resource and safety boundaries enforced outside candidate code. Sandboxing, dependency governance, timeouts, quotas, and restricted credentials are necessary if trials execute generated or third-party components.

## Packaging, deployment, monitoring, and maintenance

Deploy a resolved immutable pipeline with fitted processors, architecture/model, thresholds/calibration/ensemble, schemas, runtime, and complete provenance. Also preserve the search manifest: data/split IDs, space, optimiser/version, budgets, full trial table, selected trial/rationale, retraining recipe, constraint checks, and final evidence.

Do not let a production AutoML service promote a new candidate merely because its development objective is higher. Require full constraints, robustness/safety/privacy review, locked or valid challenger evidence, signed approval according to risk, canary, and complete rollback.

Monitor the same constraints that governed search: task utility, calibration/slices, latency, memory, size, cost, fairness/safety/privacy status, dependency/runtime versions, and schema. Also monitor the search service itself: failure/timeout rate, resource consumption, duplicated trials, search-space drift, benchmark/meta-data age, and promotion frequency.

A re-search trigger must state which data becomes eligible, whether the space/objective changes, how the incumbent is compared, and what evidence remains locked. Changes to the space, metric, split, prior-task corpus, framework, or budget create a new selection procedure and require versioned validation.

Retirement includes selected and non-selected checkpoints, trial caches, logs, data snapshots, meta-features, benchmark histories, temporary credentials, search workers, and model registry entries according to retention/licence/privacy policy. Retain enough lineage to reproduce the released decision without retaining prohibited data.

## Minimum completion checklist

- [ ] Automation boundary, human authority, objectives, constraints, promotion rule, and budgets are explicit.
- [ ] Search space types, conditions, defaults, prohibitions, prior-task provenance, and ownership are versioned.
- [ ] Applicable grouped/temporal/client/task splits are fixed outside the optimiser.
- [ ] Every data-dependent transform and ensemble/calibration/threshold step stays inside the valid selection boundary.
- [ ] Defaults, incumbent/manual, random search, and reduced-space/single-model baselines are budget matched.
- [ ] All trials—including failures/prunes—have configurations, metrics, resource, seed, and lineage records.
- [ ] Search-seed variability, selection bias, failures, costs, constraints, and final independent evidence are reported.
- [ ] Metric exploitation, leakage caches, unstable fidelities, runaway trials, and poisoned prior history are tested.
- [ ] Full retraining/export rechecks every hard constraint before human-authorised promotion.
- [ ] Selected pipeline, search manifest, rollback, re-search trigger, and retirement of trial artefacts are complete.

## Related guides

- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md)
- [Probabilistic and Bayesian learning](../paradigms_and_methods/probabilistic_and_bayesian_learning.md)
- [Reinforcement learning and contextual bandits](../paradigms_and_methods/reinforcement_learning_and_bandits.md)
- [Online, incremental, and continual learning](online_incremental_and_continual_learning.md)
- [Federated learning](federated_learning.md)
- [Privacy-preserving machine learning](privacy_preserving_machine_learning.md)

## Official and primary references

- [Hutter, Kotthoff, and Vanschoren, AutoML: Methods, Systems, Challenges](https://www.automl.org/book/) — authoritative open-access book covering HPO, meta-learning, NAS, systems, and benchmark challenges.
- [Bischl et al., Hyperparameter Optimization: Foundations, Algorithms, Best Practices and Open Challenges](https://www.automl.org/hpo-overview/hpo-best-practices/) — primary best-practice synthesis for spaces, budgets, evaluation, reproducibility, and failure modes.
- [scikit-learn: Nested versus non-nested cross-validation](https://scikit-learn.org/stable/auto_examples/model_selection/plot_nested_cross_validation_iris.html) — official demonstration of optimistic error when selection and evaluation reuse the same evidence.
- [NIST AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework) — official lifecycle risk governance; automated selection remains subject to mapped, measured, managed, and documented risks.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
