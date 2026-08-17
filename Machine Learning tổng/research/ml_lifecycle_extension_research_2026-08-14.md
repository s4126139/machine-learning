# Research Report: Extending the ML Lifecycle Across Major ML Families

Research date: **2026-08-14**

## Contents

- [Executive summary](#executive-summary)
- [Scope and method](#scope-and-method)
- [Architecture decision](#architecture-decision)
- [Taxonomy findings](#taxonomy-findings)
- [Lifecycle findings](#lifecycle-findings)
- [Source-to-claim map](#source-to-claim-map)
- [Implementation recommendations](#implementation-recommendations)
- [Unresolved questions and boundaries](#unresolved-questions-and-boundaries)

## Executive summary

The existing 16-phase lifecycle is suitable as a shared core, but its implementation vocabulary was centred on scikit-learn and classical tabular ML. Research across official framework documentation, authoritative textbooks, primary papers, benchmark organisations, and NIST guidance supports an overlay architecture rather than adding new numbered phases or duplicating the lifecycle for every field.

The central finding is that “types of machine learning” form multiple orthogonal axes. Supervision type, task, modality, model family, knowledge reuse, and operating setting are not interchangeable. A realistic project often combines several: for example, self-supervised image pretraining, supervised transfer learning, multimodal generation, federated data placement, and privacy accounting. The handbook therefore uses a taxonomy passport and composable overlays.

The scope is “major practically relevant ML families,” not every historical algorithm or emerging research label. Specialisations receive a guide when they materially change the observation unit, split, evaluation, training protocol, deployment, monitoring, safety, privacy, or maintenance requirements.

## Scope and method

### Research questions

1. Which ML labels represent learning paradigms, tasks, modalities, model families, or operational settings?
2. Which families require lifecycle adaptations beyond the existing classical core?
3. Which requirements belong in the core and which belong in an overlay?
4. Which authoritative sources support specialised evaluation and risk controls?

### Source criteria

Priority was given to:

- official framework and benchmark documentation;
- government/standards guidance;
- original or foundational publications;
- authoritative open textbooks and academic resources;
- primary engineering research for production-system claims.

The detailed source rules are maintained in the [source policy](../machine_learning_specialisations/research_and_source_policy.md). Web research was limited to five grouped searches under the research workflow; source claims were cross-checked against official pages where available.

### Recency

Framework, task-catalogue, federated-learning, and NIST sources were checked on 2026-08-14. Foundational definitions remain older where appropriate, such as Sutton and Barto for reinforcement learning and foundational federated-learning research.

## Architecture decision

### Rejected design: add Phase 17 onward

Computer vision, reinforcement learning, generative modelling, and federated learning are not steps that occur after retirement. Numbering them as new phases would be conceptually wrong.

### Rejected design: duplicate all 16 phases per field

Duplicating 16 phases for more than twenty specialisations would create hundreds of repeated sections, inconsistent definitions, and high maintenance cost.

### Adopted design: shared core plus overlays

```text
Shared lifecycle 01-16
    + task-family overlay
    + data-modality/structure overlay
    + learning-paradigm/method overlay
    + operational-setting overlay
```

This is consistent with the NIST AI RMF approach of contextual, continuous risk management rather than one rigid checklist. The [NIST AI RMF Core](https://airc.nist.gov/airmf-resources/airmf/5-sec-core/) states that Govern, Map, Measure, and Manage outcomes are applied across the lifecycle and tailored to context.

## Taxonomy findings

### Learning signals

The handbook must distinguish supervised, unsupervised, semi-supervised, weak supervision, self-supervision, reinforcement signals, and human/preference feedback. These can occur in stages rather than defining a whole project once. The [scikit-learn user guide](https://scikit-learn.org/stable/user_guide.html) supports the classical supervised/unsupervised/semi-supervised distinction; deep and reinforcement workflows require additional sources and controls.

### Tasks

The practical task inventory includes point/structured prediction, discovery/representation, anomaly/novelty detection, forecasting, ranking/retrieval, generation, causal/counterfactual inference, survival/time-to-event, and sequential decisions. Task ownership is important because the task determines target semantics, split, metrics, and final evidence.

### Modalities and structures

Tabular, text/document, image, video, audio/speech, time series, graph/relational, spatial, and multimodal data have materially different integrity, duplication, grouping, and shift controls. The [Hugging Face task catalogue](https://huggingface.co/tasks) and [task explanations](https://huggingface.co/docs/transformers/main/tasks_explained) provide an official evolving inventory across NLP, vision, audio, and multimodal tasks.

### Operational settings

Online/continual learning, active/HITL labelling, federated data placement, privacy mechanisms, and AutoML change how evidence is collected and how a system is updated. They are independent of modality and task.

## Lifecycle findings

The following universal additions should be routed through the core and overlays:

| Phase | Cross-family finding |
|---:|---|
| 01 | Record task, signal by stage, modality, model regime, update/data placement, feedback, and risk boundaries |
| 02 | Track label/reward/pretrained-model provenance, licences, consent, annotation, and client/environment provenance |
| 03 | Validate the true observation/feedback unit, modality/structure integrity, contamination, and feedback-loop risks |
| 04 | Design split/evaluation around deployment independence: entity, time, source, client, graph, environment, geography, session, or episode |
| 05 | Fit/learn transforms, tokenisers, augmentation policies, graph construction, pseudo-label logic, and representations within valid training boundaries |
| 06 | Use task-specific heuristics, pretrained/frozen, incumbent, behaviour-policy, or simple association baselines |
| 07 | Record stages, checkpoints, stochastic seeds, hardware/distribution, pretrained dependencies, and budgets |
| 08 | Control compute/label/privacy budgets, early stopping, nested selection, and search overfitting |
| 09 | Route metrics by task; record aggregation unit, operating point, uncertainty, and human evaluation where needed |
| 10 | Add OOD, adversarial, missing-modality, simulator, reward, causal-sensitivity, client, and temporal robustness as applicable |
| 11 | Locked evidence may be external, temporal, geographic, client-held, environment-based, simulator-based, or staged online—not merely random holdout |
| 12 | Package the full system: processors, tokenisers, label maps, prompts, retrievers/indexes, schemas, policies/rewards, and runtime contracts |
| 13 | Declare open/closed-loop operation, feedback collection, human override, action/output guardrails, and rollback |
| 14 | Monitor input, representation, output, decision utility, safety, fairness, privacy, and feedback-loop effects |
| 15 | Distinguish retraining, fine-tuning, index refresh, online update, policy update, and client rounds; test forgetting and regressions |
| 16 | Retire auxiliary models, indexes, processors, prompts, client versions, privacy records, cached outputs, credentials, and retained data |

## Source-to-claim map

| Source | Claim supported | Handbook use |
|---|---|---|
| [scikit-learn User Guide](https://scikit-learn.org/stable/user_guide.html) | Classical supervised, unsupervised, semi-supervised, model-selection, metrics, inspection | Core classical scope and learning-signal baseline |
| [PyTorch Tutorials](https://docs.pytorch.org/tutorials/) | End-to-end deep workflows plus official vision, text, audio, RL, distributed, and export tutorials | Deep/modality lifecycle controls |
| [TensorFlow transfer learning guide](https://www.tensorflow.org/guide/keras/transfer_learning) | Freeze, train new head, then optionally fine-tune with low learning rate | Transfer-learning stage design |
| [TensorFlow distributed training guide](https://www.tensorflow.org/guide/distributed_training) | Synchronous/asynchronous strategies, accelerator and multi-worker concerns | Deep-training reproducibility and scaling |
| [Hugging Face Tasks](https://huggingface.co/tasks) | Practical task inventory across multimodal, NLP, vision, audio, tabular, and RL | Task/modality routing |
| [Hugging Face task explanations](https://huggingface.co/docs/transformers/main/tasks_explained) | Different output structures for vision, audio, and language tasks | Task-specific preprocessing/output/evaluation |
| [sktime documentation](https://www.sktime.net/en/stable/get_started.html) | Time-series classification, regression, clustering, transformation and forecasting are distinct tasks over one temporal structure | Temporal-sequence modality separated from forecasting task |
| [Sutton and Barto, Reinforcement Learning: An Introduction](http://incompleteideas.net/book/the-book-2nd.html) | Agent-environment interaction, return, value, policy, exploration, sequential decisions | RL problem and evaluation contract |
| [Deep Reinforcement Learning That Matters](https://ojs.aaai.org/index.php/AAAI/article/view/11694) | RL sensitivity to seeds, implementations, and reporting choices | Repeated-seed and reproducibility controls |
| [PyTorch Geometric documentation](https://pytorch-geometric.readthedocs.io/en/stable/) | Graph data structures, GNNs, batching, datasets, transforms, explainability, distributed graph learning | Graph lifecycle scope |
| [Open Graph Benchmark](https://ogb.stanford.edu/docs/home/) | Task-specific graph datasets, splits, evaluators, and leakage-aware benchmarks | Graph split/evaluation design |
| [PyWhy/DoWhy user guide](https://www.pywhy.org/dowhy/v0.14/user_guide/index.html) | Causal graph assumptions, identification, effect estimation, refutation, sensitivity, counterfactual tasks | Causal workflow delta |
| [scikit-survival introduction](https://scikit-survival.readthedocs.io/en/stable/user_guide/00-introduction.html) | Censoring-aware targets and survival prediction/evaluation | Survival task separation |
| [scikit-survival evaluation guide](https://scikit-survival.readthedocs.io/en/stable/user_guide/evaluating-survival-models.html) | Concordance, time-dependent AUC, Brier scores under censoring | Survival metrics |
| [Stan posterior predictive checks](https://mc-stan.org/docs/stan-users-guide/posterior-predictive-checks.html) | Evaluate whether posterior predictive data resemble relevant observed properties | Bayesian model checking |
| [Bommasani et al., Foundation Models](https://arxiv.org/abs/2108.07258) | Broad pretraining and downstream adaptation define a dependency/model regime spanning tasks | Foundation-model guide separated from generation |
| [Hospedales et al., Meta-Learning Survey](https://arxiv.org/abs/2004.05439) | Meta-learning uses task distributions and adaptation protocols beyond AutoML warm-starting | Task-level meta-train/validation/test guide |
| [Raissi et al., Physics-informed neural networks](https://doi.org/10.1016/j.jcp.2018.10.045) | Governing equations and residuals materially alter scientific ML training/evaluation | Scientific/physics-informed lifecycle overlay |
| [TensorFlow Federated tutorials](https://www.tensorflow.org/federated/tutorials/tutorials_overview) | Federated training/evaluation, aggregation, client data, robustness, DP, simulation | Federated lifecycle stages |
| [Flower framework documentation](https://flower.ai/docs/framework/index.html) | Client/server federation, federated evaluation, strategies, DP and secure aggregation support | Federated operations and explicit privacy controls |
| [Communication-Efficient Learning of Deep Networks from Decentralized Data](https://research.google/pubs/communication-efficient-learning-of-deep-networks-from-decentralized-data/) | Decentralised client data, communication, non-IID and unbalanced constraints | Federated split and metrics |
| [NIST SP 800-226: Differential Privacy Guidelines](https://csrc.nist.gov/pubs/sp/800/226/final) | Privacy loss, implementation hazards, privacy/utility decisions | Privacy threat model/accounting |
| [NIST Privacy-Enhancing Cryptography](https://csrc.nist.gov/projects/pec) | Cryptographic protected-computation mechanisms have explicit security/party assumptions | HE/MPC/secure-compute source boundary |
| [AutoML open textbook](https://www.automl.org/book/) | HPO, meta-learning, NAS, and AutoML system scope | AutoML taxonomy and controls |
| [HPO best practices](https://www.automl.org/hpo-overview/hpo-best-practices/) | Search spaces, budgets, evaluation, reproducibility, and common HPO pitfalls | AutoML evaluation controls |
| [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework) | Lifecycle-wide trustworthy and responsible risk management | Shared governance |
| [NIST Generative AI Profile](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf) | Generative risks across design, development, deployment, and operation | GenAI-specific safety and monitoring |
| [Google Rules of ML](https://developers.google.com/machine-learning/guides/rules-of-ml) | Production system framing, simple baselines, instrumentation, and iteration | Core lifecycle |
| [Hidden Technical Debt in ML Systems](https://research.google/pubs/hidden-technical-debt-in-machine-learning-systems/) | System interactions, feedback loops, and dependencies create production risk | Whole-system packaging/monitoring |
| [Model Cards](https://research.google/pubs/model-cards-for-model-reporting/) | Intended use, contexts, subgroup evaluation, limitations | Phase 11–12 reporting |
| [Datasheets for Datasets](https://arxiv.org/abs/1803.09010) | Dataset provenance, composition, collection, distribution, use, maintenance | Phase 02–03 governance |

## Implementation recommendations

1. Preserve the existing phase pages as the canonical shared lifecycle.
2. Create a root portal and taxonomy passport.
3. Create overlays grouped by paradigm/method, task, modality/structure, and operation.
4. In each overlay, link only phases whose requirements materially change.
5. Keep task metrics in task guides and modality integrity in modality guides.
6. Separate federated placement from privacy guarantees.
7. Treat RAG and agentic systems as compositions, not new supervision categories.
8. Validate local links, overlay coverage, source quality, terminology, and prohibited overclaims.

## Unresolved questions and boundaries

- Sector regulation is intentionally outside this general handbook; domain projects must add their governing legal and clinical/engineering standards.
- Remote sensing, bioinformatics, medical ML, robotics and other sectors still add domain standards and compose task/modality/operational overlays. Scientific and physics-informed systems also use the dedicated scientific overlay when equations, solvers, geometries or conservation constraints materially change evidence.
- Neuro-symbolic, evolutionary and quantum approaches remain model/method tags rather than dedicated guides in this edition; they can be added under the new-guide criteria after a lifecycle-delta audit.
- Tool/API versions will change faster than lifecycle principles. Guides therefore cite stable official entry points and require version checks before implementation.

## Next steps

- Maintain coverage through the [taxonomy matrix](../machine_learning_specialisations/taxonomy_and_coverage.md).
- Author new pages with the [overlay template](../machine_learning_specialisations/_templates/specialisation_overlay_template.md).
- Apply the [research and source policy](../machine_learning_specialisations/research_and_source_policy.md) to every update.
- Re-audit external links and time-sensitive claims periodically.
