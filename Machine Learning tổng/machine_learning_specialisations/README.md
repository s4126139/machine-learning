# Machine Learning Specialisation Overlays

> These pages extend the [shared 16-phase lifecycle](../machine_learning_lifecycle_phases/README.md). They are not independent lifecycles, and unchanged core requirements still apply.

## How to compose a project route

Describe the project using the [ML taxonomy passport](taxonomy_and_coverage.md#ml-taxonomy-passport), then select all applicable overlays:

1. task family;
2. data modality or structure;
3. learning paradigm or model regime;
4. operational setting.

Apply task requirements first, then modality, paradigm/method, and operational requirements. This order is for reading convenience, not precedence. When controls conflict, retain the stricter requirement for leakage prevention, privacy, safety, reproducibility, or final evaluation.

## Paradigms and methods

| Guide | Use it when |
|---|---|
| [Deep learning, transfer, and multitask learning](paradigms_and_methods/deep_learning_transfer_and_multitask.md) | Training neural networks, reusing pretrained weights, fine-tuning, or sharing representations across tasks |
| [Semi-supervised, weakly supervised, and self-supervised learning](paradigms_and_methods/semi_weak_and_self_supervised_learning.md) | Labels are incomplete/noisy or training targets are constructed from unlabelled data |
| [Reinforcement learning and contextual bandits](paradigms_and_methods/reinforcement_learning_and_bandits.md) | The system learns actions from rewards and sequential interaction |
| [Probabilistic and Bayesian learning](paradigms_and_methods/probabilistic_and_bayesian_learning.md) | The primary output is a distribution or posterior uncertainty is part of the decision |
| [Foundation-model dependencies and system patterns](paradigms_and_methods/foundation_model_dependencies_and_system_patterns.md) | A broadly pretrained model/API, RAG, cascade, router, tool, memory, judge, or agent materially shapes the system |
| [Meta-learning and cross-task adaptation](paradigms_and_methods/meta_learning_and_cross_task_adaptation.md) | Knowledge is learned across tasks to support limited-data adaptation on unseen tasks |
| [Scientific and physics-informed ML](paradigms_and_methods/scientific_and_physics_informed_ml.md) | Equations, simulators, solvers, conservation laws, geometries, or scientific constraints shape training and validation |

Supervised regression/classification and classical unsupervised estimators are covered by the core. Use task overlays when their evaluation protocol differs materially.

## Task families

| Guide | Use it when |
|---|---|
| [Clustering and dimensionality reduction](task_families/clustering_and_dimensionality_reduction.md) | Discovering structure, groups, components, manifolds, or lower-dimensional representations |
| [Anomaly, novelty, and out-of-distribution detection](task_families/anomaly_novelty_and_ood_detection.md) | Detecting rare, abnormal, novel, shifted, or unsupported cases |
| [Time series and forecasting](task_families/time_series_and_forecasting.md) | Predicting future values or distributions from temporally ordered information |
| [Recommendation, ranking, and retrieval](task_families/recommendation_ranking_and_retrieval.md) | Ordering or retrieving candidates for users, queries, or contexts |
| [Generative modelling and content generation](task_families/generative_modelling_and_content_generation.md) | Generating text, image, audio, video, structured data, or synthetic samples |
| [Causal inference and uplift modelling](task_families/causal_inference_and_uplift.md) | Estimating interventions, treatment effects, counterfactuals, or policies |
| [Survival and time-to-event modelling](task_families/survival_and_time_to_event.md) | Right-censored event-time prognosis; other censoring/event processes require a sourced project addendum |
| [Sequential decision and control](paradigms_and_methods/reinforcement_learning_and_bandits.md) | Actions affect rewards, later observations, and the data available for learning |

Regression, binary/multiclass/multilabel classification, and ordinary tabular prediction remain core-owned.

## Data modalities and structures

| Guide | Use it when |
|---|---|
| [Computer vision](data_modalities_and_structures/computer_vision.md) | Images, pixels, bounding boxes, masks, keypoints, OCR, or visual retrieval are primary inputs/outputs |
| [Video and temporal media](data_modalities_and_structures/video_and_temporal_media.md) | Frame sequences, clips, tracks, temporal segments, or audiovisual events are modelled |
| [Time-series and temporal-sequence data](data_modalities_and_structures/time_series_and_temporal_sequences.md) | Ordered measurements, events, episodes, longitudinal records, or sensor windows structure any task—not only forecasting |
| [NLP, documents, and LLM applications](data_modalities_and_structures/nlp_documents_and_llms.md) | Text, code, documents, conversations, prompts, or language models are involved |
| [Speech and audio](data_modalities_and_structures/speech_and_audio.md) | Waveforms, spectrograms, speech, music, speakers, or acoustic events are modelled |
| [Graph, network, and relational ML](data_modalities_and_structures/graph_network_and_relational_ml.md) | Nodes, edges, relations, topology, or graph-level objects are part of the prediction unit |
| [Multimodal learning](data_modalities_and_structures/multimodal_learning.md) | Two or more aligned modalities are fused, translated, retrieved, or generated |
| [Geospatial and spatiotemporal ML](data_modalities_and_structures/geospatial_and_spatiotemporal_ml.md) | Coordinates, regions, rasters, trajectories, spatial dependence, or geographic transfer matter |

Tabular numeric/categorical data use the core lifecycle unless another task or operational overlay applies.

## Operational settings

| Guide | Use it when |
|---|---|
| [Online, incremental, and continual learning](operational_settings/online_incremental_and_continual_learning.md) | Model state changes incrementally or knowledge must be retained across evolving tasks/domains |
| [Active learning and human-in-the-loop systems](operational_settings/active_learning_and_human_in_the_loop.md) | The system selects examples for review or human judgement remains part of prediction/control |
| [Federated learning](operational_settings/federated_learning.md) | Training/evaluation occurs across client-held data without centralising raw examples |
| [Privacy-preserving machine learning](operational_settings/privacy_preserving_machine_learning.md) | Formal or technical privacy guarantees, threat models, or protected computation are required |
| [Automated machine learning](operational_settings/automated_machine_learning.md) | HPO, model/pipeline search, ensembling, NAS, or meta-learning automates development decisions |

Federated learning and privacy-preserving ML are separate guides: data remaining distributed is not, by itself, a privacy guarantee.

## Example compositions

### Image classification with transfer learning

`Core + computer vision + deep learning/transfer`

The vision guide owns decoding, image integrity, subject/session splits, augmentation, and image metrics. The deep-learning guide owns pretrained provenance, freeze/unfreeze, checkpoint selection, accelerator reproducibility, and export constraints.

### Retrieval-augmented language system

`Core + NLP/LLM + recommendation/retrieval + foundation-model dependencies + generative modelling`

Add privacy for sensitive corpora, active/HITL for review queues, and online/continual only if the model or index is updated incrementally.

### Federated medical survival model

`Core + survival + federated + privacy`

Add a modality guide for images, text, signals, or graphs. The survival guide owns censoring-aware evaluation; the federated guide owns client/site evaluation; the privacy guide owns the threat model and formal accounting.

### Sequential recommender

`Core + recommendation/ranking + reinforcement learning/bandits`

The ranking guide owns candidates, exposure bias, top-k utility, and cold start. The RL/bandit guide owns logged-policy coverage, off-policy evaluation, exploration, constraints, and policy-induced feedback.

## Ownership and maintenance rules

- Core pages own universal lifecycle definitions and gates.
- Overlay pages contain only the delta from the core.
- A dedicated task guide owns its target and metrics. When no dedicated task guide exists, the modality guide owns output-structure-specific evaluation (for example detection, segmentation, OCR, speech recognition, or graph link prediction).
- A modality-specific integrity check belongs to the modality guide.
- A learning objective or stage transition belongs to the paradigm/method guide.
- A deployment topology or update protocol belongs to the operational guide.
- Each guide must link claims to official, primary, or authoritative sources under the [source policy](research_and_source_policy.md).
- New pages require a material change to at least three lifecycle concerns such as data unit, split, metric, training protocol, deployment, or monitoring.

## Common mistakes

- Calling image, text, or graph a learning paradigm.
- Treating deep learning as synonymous with computer vision.
- Treating LLM, RAG, or AutoML as a supervision type.
- Treating federated learning as proof of privacy.
- Treating predictive feature importance as a causal effect.
- Using random-row evaluation for trajectories, users/items, graphs, time series, speakers, patients, or repeated scenes.
- Assuming one offline scalar metric proves online decision value, generative quality, policy safety, or causal validity.

## Further documentation

- [Taxonomy and coverage matrix](taxonomy_and_coverage.md)
- [Research and source policy](research_and_source_policy.md)
- [Overlay authoring template](_templates/specialisation_overlay_template.md)
- [Research report](../research/ml_lifecycle_extension_research_2026-08-14.md)
- [Root handbook portal](../README.md)
