# ML Taxonomy and Coverage

> This page is the vocabulary authority for the handbook. It separates concepts that are frequently mixed together and routes each one to its owning guide.

## Why a multi-axis taxonomy is required

There is no single flat list of “all ML types.” Common labels answer different questions:

| Axis | Question | Examples |
|---|---|---|
| Learning signal | Where does the training signal come from? | supervised, unsupervised, self-supervised, reinforcement |
| Task/objective | What output or decision is required? | classification, forecasting, ranking, generation, causal effect |
| Modality/structure | What form does the data take? | tabular, image, text, graph, audio, multimodal |
| Model family | How is the function/distribution represented? | linear, trees, kernels, probabilistic, deep neural network |
| Knowledge reuse | How are previous models/data reused? | transfer, fine-tuning, multitask, few-shot, meta-learning |
| Operational setting | Where and when does learning occur? | batch, online, active, federated, edge, privacy-preserving |
| System pattern | How are components composed? | RAG, candidate-generation/reranking, model cascade, agentic system |

A project normally has values on several axes. A training pipeline may also change signal by stage, for example self-supervised pretraining followed by supervised fine-tuning and preference optimisation.

## ML taxonomy passport

Record this passport in Phase 01 and update it whenever the system design changes.

| Field | Required description |
|---|---|
| Decision and user | Who acts on the output, how, and with what consequences? |
| Prediction/decision unit | Row, entity, image, document, node, edge, episode, user-query pair, time origin, etc. |
| Learning signal by stage | Supervised, unsupervised, semi/weak/self-supervised, reward, preference, or combinations |
| Task/objective | Prediction, discovery, detection, ranking/retrieval, generation, causal, survival, or sequential control |
| Modality/structure | Tabular, text, image, video, audio, series, graph, spatial, or multimodal |
| Model family | Classical estimator, probabilistic model, deep network, ensemble, etc. |
| Knowledge reuse | From scratch, pretrained/frozen, fine-tuned, multitask, few/zero-shot, meta-learned |
| Update regime | Static, scheduled batch, incremental, streaming, continual, or policy update |
| Data placement | Centralised, client-held/federated, distributed storage, or edge-only |
| Compute placement | Local, cluster, cloud, accelerator, edge/on-device |
| Feedback source | Labels, outcomes, rewards, preferences, human review, delayed/selected feedback |
| System pattern/components | Single model, RAG, cascade, router, tools, memory, agent loop, judge/guard, or other composition |
| Privacy and safety boundary | Sensitive unit, threat model, constraints, unsafe actions/outputs, required controls |
| Applicable overlays | Links to every specialisation guide used by the project |

## Axis A: learning signal

| Type | Handbook definition | Owner |
|---|---|---|
| Supervised | Learn from observations paired with explicit targets or labels | Core lifecycle |
| Unsupervised | Learn structure, density, clusters, or representations without an external target | Core + clustering/anomaly guide as appropriate |
| Semi-supervised | Combine labelled and unlabelled examples for one task | [Semi/weak/self-supervised](paradigms_and_methods/semi_weak_and_self_supervised_learning.md) |
| Weak/programmatic/distant supervision | Learn from noisy, incomplete, inexact, heuristic, or automatically produced labels | [Semi/weak/self-supervised](paradigms_and_methods/semi_weak_and_self_supervised_learning.md) |
| Self-supervised | Construct surrogate targets from unlabelled observations to learn representations | [Semi/weak/self-supervised](paradigms_and_methods/semi_weak_and_self_supervised_learning.md) |
| Reinforcement learning | Learn a policy from state/observation, actions, rewards, transitions, and horizons | [RL and bandits](paradigms_and_methods/reinforcement_learning_and_bandits.md) |
| Preference/human-feedback learning | Learn reward, ranking, or policy signals from ratings/comparisons/reviews | RL/bandits + active/HITL + generative as applicable |

The scikit-learn user guide distinguishes supervised, unsupervised, and semi-supervised families. The handbook adds other signals because their split, evaluation, deployment, and monitoring requirements differ materially. See the [official scikit-learn user guide](https://scikit-learn.org/stable/user_guide.html).

## Axis B: task or decision objective

| Group | Included tasks | Owner |
|---|---|---|
| Point prediction | Regression, binary/multiclass/multilabel/multioutput/ordinal classification | Core lifecycle |
| Structured prediction | Token/span labelling, sequence labelling, structured output | Modality guide, especially NLP/audio/video |
| Discovery/representation | Clustering, components, manifold, embedding, density | [Clustering and dimensionality reduction](task_families/clustering_and_dimensionality_reduction.md) |
| Detection | Outlier, novelty, OOD, rare event, change-point | [Anomaly/novelty/OOD](task_families/anomaly_novelty_and_ood_detection.md) |
| Forecasting | Future point, quantile, distribution, hierarchy, intermittent series | [Time series and forecasting](task_families/time_series_and_forecasting.md) |
| Ranking/retrieval | Search, recommendation, matching, learning-to-rank, metric retrieval | [Recommendation/ranking/retrieval](task_families/recommendation_ranking_and_retrieval.md) |
| Generation | Autoregressive, VAE, GAN, diffusion, synthetic-data and open-ended generated outputs | [Generative modelling](task_families/generative_modelling_and_content_generation.md) |
| Causal/counterfactual | ATE/CATE, uplift, mediation, intervention, policy value | [Causal inference/uplift](task_families/causal_inference_and_uplift.md) |
| Time-to-event | Survival, hazards, cumulative incidence, competing risks | [Survival/time-to-event](task_families/survival_and_time_to_event.md) |
| Sequential decision | Contextual bandit, RL, planning, control, multi-agent action | [RL and bandits](paradigms_and_methods/reinforcement_learning_and_bandits.md) |

## Axis C: modality and structure

| Modality/structure | Owner |
|---|---|
| Tabular numeric/categorical | Core lifecycle |
| Text, code, document, dialogue | [NLP/documents/LLMs](data_modalities_and_structures/nlp_documents_and_llms.md) |
| Image | [Computer vision](data_modalities_and_structures/computer_vision.md) |
| Video/temporal media | [Video and temporal media](data_modalities_and_structures/video_and_temporal_media.md) |
| Audio, speech, music, waveform | [Speech and audio](data_modalities_and_structures/speech_and_audio.md) |
| Time series, sensor stream, event log | [Temporal-sequence data](data_modalities_and_structures/time_series_and_temporal_sequences.md) plus forecasting/anomaly/clustering/supervised task route; add online/audio/spatial as applicable |
| Graph, network, relation | [Graph/network/relational ML](data_modalities_and_structures/graph_network_and_relational_ml.md) |
| Spatial/geospatial/spatiotemporal | [Geospatial/spatiotemporal ML](data_modalities_and_structures/geospatial_and_spatiotemporal_ml.md) |
| Two or more aligned modalities | [Multimodal learning](data_modalities_and_structures/multimodal_learning.md) plus every relevant single-modality guide |

The [Hugging Face task catalogue](https://huggingface.co/tasks) is a practical, evolving inventory of NLP, vision, audio, multimodal, tabular, and reinforcement-learning tasks. It supports routing, not a normative taxonomy.

## Axis D: operational setting

| Dimension | Values | Owner |
|---|---|---|
| Update cadence | static, periodic batch, incremental, streaming, continual/lifelong | [Online/incremental/continual](operational_settings/online_incremental_and_continual_learning.md) when state changes incrementally |
| Label acquisition | passive labels, active queries, human review, preference feedback | [Active/HITL](operational_settings/active_learning_and_human_in_the_loop.md) |
| Data placement | centralised, cross-device, cross-silo, federated/decentralised | [Federated learning](operational_settings/federated_learning.md) |
| Privacy mechanism | minimisation/access control, DP, secure aggregation, MPC, HE, TEE | [Privacy-preserving ML](operational_settings/privacy_preserving_machine_learning.md) |
| Automation | manual, HPO, pipeline/model search, NAS, meta-learning for search warm-starting/algorithm selection | [AutoML](operational_settings/automated_machine_learning.md) |
| Compute placement | local, distributed cluster, cloud service, edge/on-device | Core deployment + modality/method guide |

## Model families and knowledge-reuse tags

Most model families do not need a separate lifecycle. Record them in the passport and use task/modality guides. The following cross-cutting model regimes and knowledge-reuse patterns materially change lifecycle controls and therefore have overlays:

- [deep learning, transfer, and multitask learning](paradigms_and_methods/deep_learning_transfer_and_multitask.md);
- [probabilistic and Bayesian learning](paradigms_and_methods/probabilistic_and_bayesian_learning.md);
- [foundation-model dependencies and system patterns](paradigms_and_methods/foundation_model_dependencies_and_system_patterns.md);
- [meta-learning and cross-task adaptation](paradigms_and_methods/meta_learning_and_cross_task_adaptation.md);
- [scientific and physics-informed ML](paradigms_and_methods/scientific_and_physics_informed_ml.md).

Mapping for common terms:

| Term | Route |
|---|---|
| Fine-tuning, frozen encoder, parameter-efficient tuning | Deep/transfer + modality guide; add foundation dependency when the base model is broadly pretrained/external |
| Few-shot or zero-shot inference | Deep/transfer + modality/task guide; generative when output is open-ended |
| Contrastive learning, masked modelling | Semi/weak/self-supervised + modality guide |
| Multi-task learning | Deep/transfer + every owned task guide |
| Meta-learning for unseen-task adaptation | Meta-learning/cross-task adaptation + task/modality guide |
| Meta-learning to warm-start search/algorithm selection | AutoML + provenance of prior tasks |
| Neural architecture search | AutoML + deep learning |
| Domain adaptation/generalisation/test-time adaptation | Deep/transfer + modality guide; declare source/target domains and adaptation-time state |
| Foundation model used for classification/embedding | Foundation-model dependency + actual task/modality; no generative guide unless content is generated |
| RAG | Foundation-model dependency/system pattern + NLP/LLM + recommendation/retrieval; add generative when output is generated |
| Agentic LLM system | Foundation-model/system-pattern + NLP/LLM + generative when content is generated + RL/HITL if feedback/actions are learned |
| Synthetic data | Generative + privacy when records may be memorised or sensitive |
| Graph propagation for labels | Semi-supervised; add graph ML only when the input itself is a graph |
| Differential privacy | Privacy-preserving ML |
| Secure aggregation | Federated + privacy-preserving ML |
| Distributed data-parallel training | Deep learning + core deployment; not automatically federated learning |

## Coverage matrix

| Major family | Coverage | Canonical location |
|---|---|---|
| Regression/classification/multilabel/multioutput | Core | Core phases 01–11 |
| Classical ensembles/kernels/neighbours/linear models | Core | Phase 07 and single-page reference |
| Clustering/dimensionality reduction | Core + overlay | Task guide |
| Anomaly/novelty/OOD | Core + overlay | Task guide |
| Temporal-sequence modality | Overlay | Modality guide; compose with supervised/clustering/anomaly/forecasting task |
| Forecasting | Overlay | Task guide + temporal-sequence modality |
| Ranking/recommendation/retrieval | Overlay | Task guide |
| Generative modelling | Overlay | Task guide + modality guides |
| Foundation models/RAG/cascades/agents | Overlay | Method/system-pattern guide + actual task/modality guides |
| Causal/uplift | Overlay | Task guide |
| Survival/time-to-event | Overlay | Task guide |
| Deep/transfer/multitask | Overlay | Paradigm/method guide |
| Semi/weak/self-supervised | Overlay | Paradigm/method guide |
| RL/contextual bandits | Overlay | Paradigm/method guide |
| Probabilistic/Bayesian | Overlay | Paradigm/method guide |
| Computer vision/video | Overlay | Modality guides |
| NLP/document/LLM | Overlay | Modality guide |
| Speech/audio | Overlay | Modality guide |
| Graph/relational | Overlay | Modality guide |
| Multimodal | Overlay | Modality guide |
| Geospatial/spatiotemporal | Overlay | Modality guide |
| Online/incremental/continual | Overlay | Operational guide |
| Active learning/HITL | Overlay | Operational guide |
| Federated learning | Overlay | Operational guide |
| Privacy-preserving ML | Overlay | Operational guide |
| AutoML/HPO/NAS | Overlay | Operational guide |
| Meta-learning/cross-task adaptation | Overlay | Paradigm/method guide |
| Scientific/physics-informed ML | Overlay | Paradigm/method guide + scientific domain standards |

## Scope boundary

Scientific and sector-specific areas—medical ML, remote sensing, bioinformatics, finance, robotics, physics-informed ML, and others—compose the relevant task, modality, paradigm, and operational overlays plus domain regulation and validation. They do not become new learning-signal categories merely because the domain is specialised.

The taxonomy is intentionally extensible. A proposed new guide should demonstrate that existing overlays cannot express its lifecycle changes and that it changes at least three of: observation unit, split, evaluation, training protocol, deployment, monitoring, safety, privacy, or maintenance.

## References

- [scikit-learn User Guide](https://scikit-learn.org/stable/user_guide.html)
- [PyTorch Tutorials: complete ML workflows and domain tutorials](https://docs.pytorch.org/tutorials/)
- [Hugging Face Tasks](https://huggingface.co/tasks)
- [NIST AI RMF Core](https://airc.nist.gov/airmf-resources/airmf/5-sec-core/)
- [Research report and source-to-claim map](../research/ml_lifecycle_extension_research_2026-08-14.md)

[Back to the specialisation index](README.md)
