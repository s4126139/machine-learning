# Foundation-Model Dependencies and System Patterns

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not a generation task or independent lifecycle. Apply it whenever a broadly pretrained model, hosted model API, or multi-component AI pattern materially determines system behaviour, even if the downstream task is classification, embedding, retrieval, or scoring.

## Use this guide when

Use it for foundation/base models consumed through prompting, embeddings, adapters, fine-tuning or hosted APIs; and for system patterns such as RAG, model cascades, tool-using/agentic systems, routers, memory, and model-judge pipelines. Add the actual task, modality, deep/transfer, generative, retrieval, RL/HITL, privacy and operational guides.

## Do not confuse it with

- A foundation model is a broadly pretrained dependency/model regime, not a task; it can support discriminative, embedding or generative outputs.
- Generation is a task and uses the [generative modelling](../task_families/generative_modelling_and_content_generation.md) guide.
- RAG, cascades and agents are system compositions, not learning signals.
- Using a hosted API does not transfer accountability for validation, data governance, security, monitoring or incident response.

## Scope and major variants

Covered dependencies include open or closed base models, hosted APIs, embedding models, adapters and parameter-efficient tuning. Covered patterns include prompt pipelines, retrieval/chunking/indexing/reranking, tools and permissions, memory/state, routers/cascades, guard/judge models, and agent loops. Provider-specific contractual/legal review remains additional.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define component graph, task boundary, autonomy, provider/model/data provenance, licence/terms, sensitive-data flow, inherited limitations and substitution risk. | System map, dependency bill, data-flow/threat and provenance record. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Audit pretraining/evaluation overlap where knowable; isolate prompts, corpora, indexes, adapters, judges and calibration from locked evidence. | Contamination statement and component-specific data lineage. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare no-model/smaller/incumbent and component ablations; version every prompt, model, corpus, tool and routing decision; budget end-to-end evaluation. | Ablation table and complete configuration manifest. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Use task-owned evidence plus system reliability, security, privacy, cost and dependency-failure tests; evaluate model/provider substitutions as releases. | End-to-end and component evaluation with residual-risk approval. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package/version the full graph; enforce least privilege and fallbacks; detect silent provider/component changes; retire prompts, indexes, credentials, state and cached outputs. | System card, compatibility/rollback, monitoring and retirement plan. |

## Problem and data contract

Record each component's owner, purpose, interface, version/snapshot, provider, licence/terms, training cutoff if disclosed, retention/training-on-input policy, regions, availability, cost and replacement path. Map data and trust boundaries across prompts, embeddings, retrieval stores, tools, memory, judges/guards and logs. Define which components may make recommendations, execute actions, access secrets or write state, and which require human confirmation.

## Split and evaluation protocol

Protect locked examples and close paraphrases from prompt development, fine-tuning, adapter/reward training, retrieval indexes, judge calibration and synthetic-data loops. Because pretraining corpora may be undisclosed, record contamination uncertainty and use fresh, private, temporal or adversarial evidence where needed. Evaluate the complete component graph and each critical ablation/failure path. A provider/model revision, index change, tool permission or router change is a new system release.

## Baselines and model-family choices

Compare manual/rule/template/no-model alternatives, simpler classical or smaller pretrained models, retrieval without generation, generation without retrieval, base versus adapted model and incumbent system. For cascades/routers, compare one-model operation. For agents, compare a bounded single-step workflow. Selection must include task utility, control, security, privacy, latency, cost, portability and provider concentration risk.

## Training and validation adaptations

Version base identifier and immutable hash/snapshot where available, adapters, tokenizer/processor, prompts and chat templates, decoding, embedding/chunker/retriever/reranker/index/corpus, tools and schemas, permissions, memory, router, judge/guard, seeds and evaluation harness. Keep component tuning separate from final evidence. Validate judges against human/task evidence and treat fine-tuning, prompt edits, index refreshes, tool changes and provider upgrades as distinct interventions.

## Metrics and uncertainty

The owning task guide defines primary quality metrics. Add end-to-end completion/reliability, schema/tool-call correctness, retrieval attribution where applicable, component/fallback failure rate, security/privacy test success, latency, availability and cost. Report by model/provider/version, component path, domain/language/group and risk category with uncertainty over independent tasks/users. A model judge is a measurement instrument that needs versioning and validation, not ground truth.

## Error analysis, safety, and robustness

Test provider/model drift, hidden deprecation, prompt/template regressions, retrieval poisoning, indirect prompt injection, tool/data exfiltration, permission escalation, unsafe loops, memory contamination, router errors, judge bias, component timeouts and inconsistent fallbacks. Analyse inherited model limitations and which downstream controls mitigate or amplify them. Use least privilege, bounded actions, confirmation, rate/impact limits and auditable traces according to risk.

## Packaging, deployment, monitoring, and maintenance

Package a machine-readable system graph and all component contracts, versions, policies, credentials boundaries, fallbacks and evaluation fingerprints. Monitor component/model/provider versions, response/output distributions, retrieval/index freshness, tool actions, permission denials, judge/guard behaviour, user reports, latency/cost and provider incidents while minimising sensitive logs. Maintain substitution and rollback tests. Retirement revokes tools/credentials, deletes governed indexes/memory/caches and records dependencies/consumers.

## Minimum completion checklist

- [ ] Task, component graph, autonomy and human authority are explicit.
- [ ] Every model/API/corpus/index/tool/judge/guard dependency has provenance, terms and an owner.
- [ ] Contamination and data-flow uncertainty are documented.
- [ ] Simpler/no-model and component-ablation baselines are evaluated.
- [ ] All component versions and change types are independently traceable.
- [ ] Task, system, security, privacy, cost and failure-path evidence is reported.
- [ ] Least privilege, substitution, monitoring, incident, rollback and retirement are tested.

## Related guides

- [Generative modelling](../task_families/generative_modelling_and_content_generation.md)
- [Deep learning, transfer, and multitask learning](deep_learning_transfer_and_multitask.md)
- [Recommendation, ranking, and retrieval](../task_families/recommendation_ranking_and_retrieval.md)
- [NLP, documents, and LLM applications](../data_modalities_and_structures/nlp_documents_and_llms.md)
- [Privacy-preserving ML](../operational_settings/privacy_preserving_machine_learning.md)
- [Active learning and HITL](../operational_settings/active_learning_and_human_in_the_loop.md)

## Official and primary references

- [Bommasani et al., On the Opportunities and Risks of Foundation Models](https://arxiv.org/abs/2108.07258) — primary taxonomy and analysis of broadly trained models adapted across downstream tasks.
- [NIST AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework) — lifecycle-wide governance, measurement and management for AI-system risks and dependencies.
- [Model Cards for Model Reporting](https://research.google/pubs/model-cards-for-model-reporting/) — primary reporting framework for intended use, evaluation context, limitations and groups.
- [Hugging Face Model Cards](https://huggingface.co/docs/hub/model-cards) — official documentation for model metadata, intended uses, limitations, datasets and evaluation results.
- [NIST AI 600-1, Artificial Intelligence Risk Management Framework: Generative AI Profile](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf) — official GenAI risk guidance covering system-level governance, content provenance, evaluation, misuse and third-party dependencies.
- [OWASP Top 10 for LLM Applications](https://genai.owasp.org/llm-top-10/) — maintained application-security guidance for prompt injection, sensitive-information disclosure, excessive agency, data/model poisoning and related LLM-system threats.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
