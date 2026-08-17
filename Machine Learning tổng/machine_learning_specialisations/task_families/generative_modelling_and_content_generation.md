# Generative Modelling and Content Generation

> This is a task overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an independent lifecycle. Apply the core and add these controls when the required output is generated content or synthetic data. A non-generative system that merely depends on a foundation model uses the separate [foundation-model dependency overlay](../paradigms_and_methods/foundation_model_dependencies_and_system_patterns.md).

## Use this guide when

Use it for text, code, image, audio, video or structured-data generation; synthetic-data generators; autoregressive, latent-variable, adversarial or diffusion generation; and generative components inside RAG or agentic systems. Add the foundation-model, modality, retrieval, deep-learning, RL/HITL, privacy and operational overlays that apply.

## Do not confuse it with

- NLP, vision and audio are modalities; generation is a task family.
- A foundation model is a pretrained dependency/model regime and can support discriminative or embedding tasks; use the [foundation-model guide](../paradigms_and_methods/foundation_model_dependencies_and_system_patterns.md) even when no content is generated.
- RAG, model cascades and agents are system patterns, not learning signals. Apply this guide only when their output includes generation, plus the foundation-model and component-owning guides.
- Fluent output is not verified truth; automatic similarity or model-judge scores do not fully establish human quality, safety or factuality.

## Scope and major variants

The guide covers autoregressive, masked/denoising, diffusion, latent-variable and adversarial generation at lifecycle level; prompt-only and fine-tuned generators; retrieval/tool-augmented generation; preference-adapted generators; and synthetic data. Foundation-model dependency controls and generic system patterns are owned separately.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define output/use boundaries, affected actors, unacceptable content/actions, model/corpus/tool provenance, licences, privacy and contamination. | System/use-case map, risk register, dependency and data provenance record. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Separate prompts/documents/entities/time and near-duplicates; prevent benchmark/evaluation ingestion by tuning, retrieval or synthetic-data loops. | Contamination-aware split and corpus/prompt lineage. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare retrieval/template/no-model and smaller/incumbent baselines; version prompts, decoding, retrieval, tools, judges and safety settings; budget human evaluation. | Baseline/ablation table and full experiment manifest. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Combine task-grounded, human, safety, factuality, privacy, security, diversity and efficiency evidence; lock adversarial and fresh evaluation. | Multi-layer evaluation, red-team findings, residual-risk approval. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package model/API plus prompts, retriever/index, tools, policies and filters; monitor inputs/outputs/abuse/cost; propagate deletion and retire cached/generated artefacts. | System card, deployment/incident controls, dependency/update/retirement plan. |

## Problem and data contract

Define allowed inputs, output modalities and formats, intended users and downstream uses, autonomy/action scope, citation/provenance expectations, human-review boundary, refusal/abstention behaviour and unacceptable outputs/actions. Catalogue base models/APIs, adapters, prompt templates, retrieval corpora/indexes, tool schemas/permissions, guard models and external services with owner, version, licence, data-use/retention terms and availability. For training/evaluation data, record consent, copyright/licence, sensitive content, annotator exposure, deduplication, synthetic origin and model-generated lineage.

## Split and evaluation protocol

Split by source, creator/entity, document/thread, time and near-duplicate family before prompt creation, chunking, synthetic expansion or retrieval indexing. Prevent training, fine-tuning, prompt optimisation, judge calibration and RAG corpora from exposing locked questions, answers or close paraphrases. Build fresh and adversarial sets around the declared risk taxonomy, plus domain/external evidence. Human evaluation must define rubric, rater expertise, blinding/randomisation, conflicts, adjudication and agreement; model-as-judge evidence requires validation against appropriate human judgement and disclosure of model/version/prompt.

## Baselines and model-family choices

Include no-generation/manual/template or retrieval-only responses when they can satisfy the need; a smaller or less capable model; prompt-only before fine-tuning; base model before adapters/preference tuning; and the incumbent. For RAG/agents, ablate retrieval, reranking, context, tools, memory and guardrails. Select a system on total task utility, residual risk, latency, cost, privacy and operational control—not a benchmark average alone.

## Training and validation adaptations

Version base checkpoint/provider snapshot, dataset/corpus cutoffs, mixture and filtering, tokenizer/processor, objective/stage, adapters, preference/reward data and models, prompts/system instructions, decoding/sampling, retrieval/index, tool descriptions/permissions, guardrails, seeds and compute. Separate training/tuning data from safety and final evaluation. Log human-feedback collection and rater welfare. Re-evaluate safety after fine-tuning or system-component changes because behaviour can change even when the base model is unchanged.

## Metrics and uncertainty

Use task-grounded correctness/utility and schema/constraint compliance; human preference or rubric scores; factual attribution and citation support when claims are made; harmful-content, bias, privacy leakage and security success rates; refusal/helpfulness trade-offs; diversity/duplication and memorisation diagnostics; and latency, throughput, token/compute and review cost. Report by risk category, language/domain/group and prompt family with uncertainty at the independent prompt/user/task unit. No single automatic metric or model judge replaces task evidence, human evaluation and safety analysis.

## Error analysis, safety, and robustness

Analyse confabulation, unsupported attribution, prompt injection, tool/data exfiltration, unsafe or illegal assistance, harmful bias, impersonation, privacy/memorisation, copyright-sensitive reproduction, malformed outputs, over-refusal, mode collapse/homogenisation and runaway action loops. Test direct/indirect injection, adversarial paraphrases, multilingual and long-context cases, conflicting/poisoned retrieval, tool failures, missing context and guardrail circumvention. Define least-privilege tools, execution confirmation, rate/impact limits, provenance display, safe fallback and incident escalation according to risk.

## Packaging, deployment, monitoring, and maintenance

Package the complete system graph: model/API and pinned version, adapters, tokenizer/processors, system/user prompt templates, decoding policy, retriever/chunker/index/corpus, tool schemas/credentials boundary, memory, output parser, filters/guard models, policy rules and audit schema. Monitor input/output/risk-category distributions, refusals and safety-filter events, factual/citation and task quality samples, prompt injection/tool incidents, latency/cost, provider/model drift, corpus/index freshness and user reports while minimising retained sensitive content. Treat provider/model update, prompt change, adapter tuning, corpus/index refresh, tool/permission change, judge/filter change and policy change as separate releases with targeted regression, canary, rollback and disclosure. Retirement must remove indexes, caches, generated datasets, adapters, prompts, tool credentials and retained interaction data under policy.

## Minimum completion checklist

- [ ] Intended use, users, output/action boundary, prohibited outcomes, review and refusal/fallback are explicit.
- [ ] Models/APIs, data, corpora, tools, licences, retention terms, synthetic lineage and contamination are documented.
- [ ] Entity/source/time/near-duplicate splitting protects evaluation from tuning, retrieval and generated-data leakage.
- [ ] No-generation, retrieval/template, smaller/base and component-ablation baselines are reported as applicable.
- [ ] Human, task, factuality, safety, privacy, security, diversity and efficiency evidence is reported by risk slice.
- [ ] Red-team/adversarial findings, model-judge limitations and residual-risk acceptance are documented.
- [ ] Full-system versioning, least privilege, monitoring, incident response, rollback, deletion and retirement are tested.

## Related guides

- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md)
- [Foundation-model dependencies and system patterns](../paradigms_and_methods/foundation_model_dependencies_and_system_patterns.md)
- [Recommendation, ranking, and retrieval](recommendation_ranking_and_retrieval.md)
- [NLP, documents, and LLM applications](../data_modalities_and_structures/nlp_documents_and_llms.md)
- [Multimodal learning](../data_modalities_and_structures/multimodal_learning.md)
- [Privacy-preserving machine learning](../operational_settings/privacy_preserving_machine_learning.md)

## Official and primary references

- [NIST AI 600-1: Generative Artificial Intelligence Profile](https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-generative-artificial-intelligence) — normative cross-sector generative-AI risk identification, measurement and management guidance.
- [Model Cards for Model Reporting](https://research.google/pubs/model-cards-for-model-reporting/) — primary framework for intended use, evaluation context, limitations and subgroup reporting.
- [Datasheets for Datasets](https://arxiv.org/abs/1803.09010) — primary framework for data motivation, composition, collection, distribution, use and maintenance.
- [Hugging Face Tasks](https://huggingface.co/tasks) — official evolving task inventory across text, image, audio, video and multimodal generation.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
