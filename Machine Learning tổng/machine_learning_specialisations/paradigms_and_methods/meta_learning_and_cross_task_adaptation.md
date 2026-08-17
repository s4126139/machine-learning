# Meta-Learning and Cross-Task Adaptation

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an AutoML synonym. Apply it when knowledge learned across a distribution of tasks is used to adapt to a new task with limited examples, labels, or updates.

## Use this guide when

Use it for few-shot episodic learning, metric-based or optimisation-based meta-learning, learned initialisation/optimisers, cross-task representation/adaptation, and task-level transfer evaluation. Use [AutoML](../operational_settings/automated_machine_learning.md) instead when prior tasks merely warm-start or choose an automated search procedure.

## Do not confuse it with

- Ordinary transfer learning adapts one source model/domain; meta-learning explicitly learns across tasks or episodes to improve adaptation.
- Few-shot prompting without learned cross-task adaptation is a foundation-model inference setting, not automatically meta-learning.
- AutoML may consume meta-features for search; that automation purpose has a separate owner.
- Support/query examples from one task are not independent tasks.

## Scope and major variants

Covered variants include metric-based, model/optimisation-based, memory-based and Bayesian meta-learning; few-shot classification/regression and cross-task adaptation; task-conditional models and learned update rules. Meta-RL also requires the RL overlay.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define task distribution, episode, support/query semantics, adaptation budget and transfer claim; audit task provenance, overlap and relatedness. | Task passport, provenance/overlap and adaptation contract. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Separate meta-train/meta-validation/meta-test tasks before episode generation; isolate within-task support/query and learned transforms. | Task-level split and episode-generation lineage. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare from-scratch, pooled, fixed-transfer and simple nearest/prototype baselines at equal adaptation data/compute; tune only on meta-validation tasks. | Budget-matched adaptation and selection report. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Report across unseen tasks, shots and adaptation steps with task-level uncertainty; test task-distribution shift and negative transfer. | Locked unseen-task curves, uncertainty and transfer analysis. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package meta-learner plus adaptation algorithm/budget/state; monitor new-task fit and transfer failures; govern retained support data. | Adaptation contract, monitoring/rollback and task-data retirement. |

## Problem and data contract

Define what constitutes a task, how tasks are sampled, support/query or adaptation/evaluation units, number of shots, adaptation steps/compute, allowed labels and expected task-distribution shift. Record source-task datasets, licences, sensitive information, task identifiers, ontology/label compatibility and overlap at example/entity/source level. State whether the goal is rapid adaptation, uncertainty, model selection or representation reuse.

## Split and evaluation protocol

Split entire tasks into meta-train, meta-validation and locked meta-test sets before episode construction. Within each task, preserve entity/time/group boundaries between support and query where required. Prevent shared examples, near duplicates, users, sources or benchmark versions from crossing task partitions. Report performance across many unseen tasks and several sampled support sets; final evidence must not reuse meta-test tasks for architecture, episode, shot or adaptation decisions.

## Baselines and model-family choices

Compare training from scratch on the same support set, pooled multi-task training, conventional transfer/fine-tuning from a fixed source model, simple prototype/nearest-centroid methods, and the incumbent. Equalise shots, labels, adaptation steps, compute and pretraining access. Meta-learning is justified only when it improves the declared adaptation objective beyond simpler reuse.

## Training and validation adaptations

Version task sampler/distribution, episode construction, ways/shots/queries, support/query transform, meta-batch, inner/outer objectives and optimisers, adaptation steps/rates, initialisation, seeds and compute. Tune on meta-validation tasks and inspect variance across tasks and support draws. Track negative transfer, task imbalance and whether a few large tasks dominate updates.

## Metrics and uncertainty

Use task-owned metrics after a declared number of shots/steps, plus adaptation curves, time/compute/label efficiency, failure/negative-transfer rate and calibration where relevant. Report macro distributions across tasks, not only pooled examples: median, tails and task-level confidence intervals. Slice by task similarity, domain, class/label set, shot count and support quality. A favourable average cannot hide catastrophic failure on a task family.

## Error analysis, safety, and robustness

Test task-distribution shift, label/ontology mismatch, corrupted or biased support examples, fewer/more shots, class imbalance, adversarial task selection and adaptation instability. Inspect memorisation of source tasks, benchmark leakage, negative transfer and sensitivity to support ordering. High-stakes adaptation needs bounded updates, validation before use, fallback to non-adapted behaviour and poisoning controls.

## Packaging, deployment, monitoring, and maintenance

Package meta-parameters, architecture, processor, task/episode schema, adaptation algorithm, allowed update scope, budgets, support-data handling, validation gate and fallback. Monitor adaptation frequency, task/domain mix, shot/support quality, pre/post-adaptation utility, negative transfer, calibration, latency/compute and retained sensitive task data. Version meta-training corpus and every update; retirement removes cached support sets, task embeddings and adaptation state according to policy.

## Minimum completion checklist

- [ ] Task distribution, support/query unit, shots, steps and transfer claim are explicit.
- [ ] Whole tasks are separated into meta-train, validation and locked test partitions.
- [ ] Within-task entity/time/group leakage and cross-task duplicates are controlled.
- [ ] From-scratch, pooled and conventional-transfer baselines are budget matched.
- [ ] Episode, sampler, inner/outer optimisation and adaptation budget are reproducible.
- [ ] Results and uncertainty are reported across unseen tasks, shots and shifts.
- [ ] Adaptation validation, poisoning, fallback, monitoring and retained-data retirement are controlled.

## Related guides

- [Deep learning, transfer, and multitask learning](deep_learning_transfer_and_multitask.md)
- [Automated machine learning](../operational_settings/automated_machine_learning.md)
- [Semi/weak/self-supervised learning](semi_weak_and_self_supervised_learning.md)
- [Reinforcement learning and bandits](reinforcement_learning_and_bandits.md)
- [Foundation-model dependencies](foundation_model_dependencies_and_system_patterns.md)
- [Specialisation index](../README.md)

## Official and primary references

- [Hospedales et al., Meta-Learning in Neural Networks: A Survey](https://arxiv.org/abs/2004.05439) — authoritative synthesis of meta-learning settings, methods and evaluation concerns.
- [Finn, Abbeel, and Levine, Model-Agnostic Meta-Learning](https://proceedings.mlr.press/v70/finn17a.html) — primary optimisation-based meta-learning method and few-shot evaluation protocol.
- [Vinyals et al., Matching Networks for One Shot Learning](https://papers.nips.cc/paper/6385-matching-networks-for-one-shot-learning) — foundational episodic metric-learning work.
- [AutoML open textbook: Meta-Learning](https://www.automl.org/book/) — authoritative open chapter situating meta-learning in automation and cross-task knowledge reuse.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
