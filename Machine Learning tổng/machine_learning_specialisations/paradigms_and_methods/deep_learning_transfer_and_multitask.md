# Deep Learning, Transfer, and Multitask Learning

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an independent lifecycle. Apply every unchanged core requirement and add the controls below when neural optimisation, pretrained knowledge, or shared representations materially affect the system.

## Use this guide when

Use it for neural networks trained from scratch; frozen-feature or fine-tuned pretrained models; parameter-efficient adaptation; domain adaptation/generalisation or stateful test-time adaptation; or one model jointly optimising several tasks. Add the relevant task and modality overlays because they own target semantics, data integrity, and task-specific metrics.

## Do not confuse it with

- Deep learning is a model regime, not a data modality: image, text, audio, graphs, and tabular data need different integrity controls.
- Transfer learning reuses learned parameters or representations; it does not imply few-shot success or licence compatibility.
- Multitask learning shares parameters across objectives; ordinary multi-output prediction need not use a shared neural representation.
- Distributed data-parallel training is compute placement, not [federated learning](../operational_settings/federated_learning.md).

## Scope and major variants

The overlay covers training from scratch, frozen encoders and linear probes, full or parameter-efficient fine-tuning, distillation, multitask/shared-backbone models, staged pretraining-to-adaptation workflows, and source/target-domain adaptation or generalisation. Architecture catalogues and modality-specific layer choices are intentionally outside scope.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Declare stage sequence, reuse strategy, task weights, accelerator and latency/energy constraints. | Stage diagram, model passport fields, compute and serving budgets. |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Record pretrained artefact provenance, licences, training-data disclosures, checkpoint hashes, and known limitations. | Dependency register and contamination/provenance assessment. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Keep learned transforms and augmentation policies inside training boundaries; audit overlap with pretraining data where evidence is available. | Split manifest and stage-specific transform specification. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare simple, frozen, and fine-tuned baselines; define freeze/unfreeze, checkpoint selection, seeds, hardware, precision, and search budgets. | Baseline table, training ledger, checkpoint-selection record. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Evaluate every task plus aggregate utility, calibration and transfer slices; repeat stochastic runs where variance matters. | Per-task/slice results, uncertainty across runs, locked-test report. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package the exact graph, weights, processors and runtime; test export fidelity; monitor all heads and dependencies; retire derivative checkpoints. | Model/dependency manifest, export parity evidence, monitoring and retirement plan. |

## Problem and data contract

Specify the input and target for each training stage, the tasks and source/target domains sharing representations, and whether each pretrained component is frozen, adapted, or replaceable. Record checkpoint source, version/hash, licence and usage restrictions, disclosed pretraining domains, unresolved data overlap, and any unlabelled target-domain access. Data contracts must distinguish examples, augmentations, pairs/triplets, sequences, and task-specific labels so repeated views or shared entities cannot cross evaluation boundaries.

## Split and evaluation protocol

Split on the deployment-independent unit before generating augmented views. Preserve entity, source, time, site, scene, session, and declared source/target-domain boundaries required by the modality. A pretrained model may have seen evaluation material; treat this as a contamination risk, document what can and cannot be verified, and prefer fresh temporal, private, or otherwise external evidence when the risk is material. Multitask evaluation must report each task and important slices, not only a weighted aggregate.

## Baselines and model-family choices

Include a non-neural or small neural baseline where feasible, an untrained/simple-head baseline, a frozen pretrained representation, and the incumbent system. Fine-tuning must demonstrate value beyond frozen features at its extra compute and operational cost. Multitask models must be compared with credible single-task models to reveal negative transfer.

## Training and validation adaptations

Define stages explicitly: initialise, freeze or train a head, optionally unfreeze selected parameters, then fine-tune under a controlled learning-rate and stopping policy. For domain adaptation/generalisation, version source/target access, unlabelled-target use and domain weighting; test-time adaptation must declare which state mutates, reset boundaries, evidence available before prediction, and rollback. Record initialisation, optimiser state, data order, random seeds, precision mode, accelerator/runtime versions, effective batch size, gradient accumulation, distributed strategy, checkpoints, and compute use. Select checkpoints using validation evidence only. For multitask learning, version sampling schedules, loss scaling, missing-label handling, and head-specific stopping rules.

## Metrics and uncertainty

Task overlays own primary metrics. Add per-task performance, worst-task or constraint compliance, calibration where probabilities drive decisions, and resource measures such as latency, memory, throughput, model size, and energy when contractual. Report variability across seeds or runs for stochastic comparisons, and separate training-time proxy metrics from final task utility.

## Error analysis, safety, and robustness

Slice by pretraining/source/target-domain similarity, data scarcity, task, subgroup, device/source, sequence length or resolution as applicable. Test source-only, unseen-domain and adaptation-failure cases, including target-domain shift and corrupted adaptation batches. Also test modality-owned corruptions, sensitivity to initialisation and data order, catastrophic forgetting after adaptation, and task interference. Re-evaluate safety and fairness after every material fine-tune; inherited capabilities and limitations are not automatically preserved.

## Packaging, deployment, monitoring, and maintenance

Package architecture, weights/adapters, label maps, processors/tokenisers, domain/adaptation configuration and mutable state, numerical precision, runtime/accelerator requirements, and task-routing logic as one versioned unit. Verify exported outputs against the selected checkpoint within declared tolerances. Monitor input/representation/domain drift, per-task utility and calibration, adaptation state, latency/memory, head imbalance, and dependency changes. Distinguish full retraining, continued pretraining, fine-tuning, test-time adaptation, adapter replacement, distillation, and processor changes; each requires its own regression scope and rollback artefacts.

## Minimum completion checklist

- [ ] The project passport identifies every training stage, task, pretrained dependency, and update type.
- [ ] Pretrained provenance, licence, disclosed limitations, version/hash, and contamination uncertainty are recorded.
- [ ] Augmentations and learned transforms are fitted or generated only within valid training boundaries.
- [ ] Simple, frozen, fine-tuned, incumbent, and single-task baselines are compared where applicable.
- [ ] Seeds, hardware, precision, distributed strategy, checkpoints, and compute budget are reproducible.
- [ ] Every task and critical slice has locked-test evidence with uncertainty appropriate to stochastic training.
- [ ] Export parity, runtime limits, monitoring, rollback, and derivative-checkpoint retirement are verified.
- [ ] Source/target domains and any adaptation-time data/state mutation are declared and evaluated without target-test leakage.

## Related guides

- [Semi-, weakly, and self-supervised learning](semi_weak_and_self_supervised_learning.md)
- [Foundation-model dependencies and system patterns](foundation_model_dependencies_and_system_patterns.md)
- [Automated machine learning](../operational_settings/automated_machine_learning.md)
- [Computer vision](../data_modalities_and_structures/computer_vision.md)
- [NLP, documents, and LLM applications](../data_modalities_and_structures/nlp_documents_and_llms.md)
- [Specialisation index](../README.md)

## Official and primary references

- [TensorFlow: Transfer learning and fine-tuning](https://www.tensorflow.org/guide/keras/transfer_learning) — official staged freeze/head-training/fine-tuning guidance.
- [TensorFlow: Distributed training](https://www.tensorflow.org/guide/distributed_training) — official accelerator, multi-device, and multi-worker strategy guidance.
- [PyTorch Tutorials](https://docs.pytorch.org/tutorials/) — official workflows for training, distributed execution, domain tasks, and export.
- [Model Cards for Model Reporting](https://research.google/pubs/model-cards-for-model-reporting/) — primary reporting framework for intended uses, evaluation context, and limitations.
- [WILDS benchmark](https://wilds.stanford.edu/) — primary benchmark resource for in-the-wild distribution shifts and domain-aware evaluation.
- [DomainBed](https://arxiv.org/abs/2007.01434) — primary study and benchmark protocol for domain-generalisation selection and evaluation.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
