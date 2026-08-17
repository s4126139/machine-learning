# NLP, Documents, and LLM Applications

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay documents only the extra requirements created by language, documents, conversations, prompts, tokenisers, and language-model components.

## Use this guide when

Use this overlay when text, code, document structure, dialogue, prompts, or a language model is part of the input, target, intermediate state, or output. It covers predictive NLP and the language-specific portions of retrieval-augmented, generative, and agentic systems.

## Do not confuse it with

- [Generative modelling](../task_families/generative_modelling_and_content_generation.md), which owns open-ended generation evaluation and content safety; the separate foundation-model guide owns broad pretrained dependencies and system patterns.
- [Recommendation, ranking, and retrieval](../task_families/recommendation_ranking_and_retrieval.md), which owns candidate/index evaluation and ranking utility in search or RAG.
- [Reinforcement learning and contextual bandits](../paradigms_and_methods/reinforcement_learning_and_bandits.md), which owns learned policies, rewards, and off-policy evidence.
- [Active learning and human-in-the-loop systems](../operational_settings/active_learning_and_human_in_the_loop.md), which owns review queues and human feedback operations.
- [Multimodal learning](multimodal_learning.md), when text must align or fuse with images, audio, video, or structured sensors.

An application that only calls a frozen LLM still needs this overlay: prompts, tokenisation, context assembly, data boundaries, evaluation and monitoring remain system components even without model training.

## Scope and major variants

| Variant | Output unit | Distinct lifecycle concern |
|---|---|---|
| Document/sentence classification | one or multiple labels | author/source/template leakage, thresholds and multilingual slices |
| Token/span/sequence labelling | tags, entities, relations, spans | character-token alignment and boundary conventions |
| Extractive question answering | source-grounded span | answerability, context construction and exact span mapping |
| Translation/summarisation | generated sequence | reference limitations, faithfulness and human utility |
| Language modelling and assistants | tokens, messages or actions | prompt/decode configuration, confabulation and misuse |
| Information extraction/document AI | fields, tables, layout and relations | parsing/OCR lineage, schema validity and page grouping |
| Code intelligence/generation | code, edits, explanations or tool calls | repository contamination, execution/security and licence risk |
| RAG and conversational systems | retrieved context plus response | corpus snapshot, access control, citation/grounding and multi-turn state |

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Define language/task unit, answerability, allowed evidence, interaction state, abstention/refusal and generated-output use | Language/system contract and prohibited-use boundary |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Preserve text/document provenance, licence, consent, language/script, extraction/OCR and annotation history; detect contamination and sensitive content | Corpus card, source/version manifest, contamination/privacy audit and annotation guide |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md) | Group by document, author/user, thread, template, source and duplicate cluster; respect publication and knowledge cutoffs | Group/time split manifest and cross-partition overlap report |
| [05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Version decoding, Unicode normalisation, segmentation, tokenisation, truncation/chunking, context and prompt construction | Reversible preprocessing/context specification and offset tests |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare lexical/rule/retrieval and frozen-model baselines; control prompt and decoding search | Baseline table, prompt/model selection log and budget |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Match metrics to linguistic output; add language/source/human evaluation and contamination-aware locked evidence | Evaluator/normalisation spec, slice/human-study report and locked test |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[15](../../machine_learning_lifecycle_phases/15_retraining_and_maintenance.md) | Package tokeniser, prompts, context/retrieval, decoding and safety components; monitor language, grounding, safety and cost | Versioned system manifest, red-team/evaluation set and component-specific update plan |
| [16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Retire corpora, indexes, caches, conversation memory, prompts, credentials and retained inputs/outputs | Language-system dependency and data disposition record |

## Problem and data contract

Define the canonical unit: document, paragraph, sentence, token, character span, message, conversation, query-document pair, code file/repository, or structured field. Record language, locale, script, encoding, Unicode normalisation, markup/layout, document hierarchy, source URL/identifier, publication/version dates, extraction method, and whether OCR or machine translation produced the text.

For labels and references, specify ontology, annotation unit, span-boundary convention, nested/overlapping entities, relation direction, unanswerable cases, acceptable alternatives, citation requirements and adjudication. Preserve offsets back to immutable raw content; destructive cleaning before annotation can make labels unrecoverable.

Corpus governance must cover copyright/licence, terms of access, consent, personal/confidential data, cultural sensitivity, deletion obligations and downstream redistribution. Record pretrained model and external corpus provenance separately from the project corpus. A provider's model name is insufficient when version, knowledge cutoff, safety behaviour or terms can change.

Validate encoding failures, empty/truncated documents, language/script mismatches, boilerplate/template dominance, OCR artefacts, broken offsets, invalid labels, source imbalance, personally identifiable information, exact duplicates and near duplicates. For web/code data, inspect copied mirrors, forks, quoted text and benchmark solutions. Document what can and cannot be audited in undisclosed pretraining data.

## Split and evaluation protocol

Split at the unit that can repeat language or knowledge: document family, author, user/account, conversation/thread, organisation, source site, template, event, code repository/fork or duplicate cluster. Keep chunks from the same document and turns from the same conversation together. Random sentence or chunk splits commonly leak style, boilerplate and answers.

Use time-aware splits when deployment asks about future documents, policies, products or knowledge. Fix the information cutoff and prevent later corpus versions, retrieved documents, annotations and generated summaries from entering earlier partitions. For RAG, version the corpus/index visible to each evaluation query and keep test questions/answers out of chunking, synthetic-query generation, hard-negative mining and prompt examples.

Contamination checks should search exact and fuzzy text overlap, normalised variants, paraphrased/template overlap, code forks and answer-bearing metadata. Benchmark performance from a model with unauditable pretraining must be labelled as potentially contaminated rather than asserted clean.

Lock context window, chunking, retrieval depth, prompt/chat template, tool availability, decoding parameters and repeated-sampling protocol before final evaluation. Aggregate uncertainty by independent user/document/source or question set, not tokens.

## Baselines and model-family choices

Choose baselines that isolate linguistic and system complexity:

- majority, length, keyword, regex or dictionary rules;
- bag-of-words/character n-gram with a linear estimator;
- BM25 or another lexical retrieval baseline for search/RAG;
- frozen embeddings with a simple classifier or nearest-neighbour decision;
- a smaller/frozen pretrained language model under the same prompt/context;
- extractive or retrieval-only output before adding open-ended generation;
- incumbent workflow and a human-only workflow where human review is the current service.

For prompted systems, a prompt is part of the model configuration. Compare baselines with identical corpus access, tools, sampling count and output constraints. Record model/API version, provider, context limit, licence/terms, training-data disclosure, quantisation and safety settings.

## Training and validation adaptations

Fit tokenisers, vocabularies, normalisers, topic models, learned chunking, pseudo-labels and retrieval encoders inside the training boundary. Version special tokens, casing, whitespace, max length, truncation direction, overflow/stride, padding and label-to-subword mapping. Unit-test round-trip offsets on every supported language/script.

Prompt examples, system messages, schemas, tool descriptions, decoding parameters and safety instructions are tunable components. Keep a prompt-development set separate from the final evaluation and log every evaluated variant to limit prompt overfitting. For stochastic generation, predeclare repetitions and seeds where supported.

For instruction or preference data, record who produced each response/comparison, rubric, model-assisted labelling, disagreement and filtering. Train/validation sampling must not over-represent prolific users, templates or synthetic sources without documenting the target distribution. Add the deep/transfer and semi/weak/self-supervised overlays for their training-stage controls.

## Metrics and uncertainty

Use a metric that matches the output contract and lock text normalisation before scoring:

- classification: class-sensitive metrics, calibration and deployed thresholds;
- token/span extraction: token and entity/span-level scores with exact boundary and partial-match rules;
- extractive QA: exact match and token overlap plus answerability and source/document slices;
- translation, summarisation and free-form answers: automatic similarity metrics only as diagnostics; add factuality/grounding, constraint adherence and blinded human evaluation tied to use;
- structured extraction, code and tool calls: schema validity plus field/test/task success, including security constraints;
- language modelling: loss/perplexity only under the same tokenisation and corpus; it does not establish downstream utility.

For RAG, report retrieval and response stages separately: retrieval coverage/ranking, evidence relevance, citation correctness, answer groundedness, answer utility and failure when evidence is absent or conflicting. Add the retrieval and generative guides for their authoritative protocols.

Report by language, locale, script, dialect, topic, source, document length, context position, answerability, protected/affected group and safety category as applicable. Human studies must define raters, rubric, blinding/randomisation, sampling, disagreement and uncertainty. Do not present one benchmark scalar as broad linguistic competence.

## Error analysis, safety, and robustness

Analyse confusion, span/boundary, retrieval, context-selection, reasoning, citation, refusal and formatting errors separately. Review examples by whole document/conversation so surrounding evidence and multi-turn state are visible.

Stress spelling/typographical noise, Unicode confusables, casing, dialect, code-switching, OCR noise, paraphrase, negation, long context, irrelevant/conflicting evidence, reordered instructions, prompt templates and low-resource languages. For code, test dependency/API changes, unsafe constructs and untrusted input.

Threat modelling for LLM applications must include prompt injection, indirect injection from retrieved content, jailbreaks, sensitive-data disclosure, membership/training-data extraction, corpus poisoning, tool misuse, malicious code, unsafe advice, confabulation, bias/homogenisation, abusive content and denial-of-wallet/latency attacks. Use access control at retrieval and tool execution; a system prompt is not an authorization boundary.

Define refusal/abstention and human escalation. Red-team cases must be risk-based and supplemented by ordinary-distribution evaluation; neither handpicked demos nor one automated judge is sufficient proof of quality or safety. When an LLM judges outputs, record judge version/prompt/order and audit against independent human ratings for the intended use.

## Packaging, deployment, monitoring, and maintenance

Package raw-text decoding and normalisation, tokeniser/vocabulary, language detector, parser/OCR contract, chunker, embedding model, corpus/index snapshot, retrieval/reranking, prompt/chat template, system policy, tool schema/permissions, model/API identifier, decoding settings, postprocessing/schema validation, safety filters and citation formatter. Golden cases must cover multilingual text, long/empty inputs, Unicode, unanswerable/conflicting evidence, injection and structured outputs.

Monitor source/language/script mix, length/token distributions, truncation, parser/OCR failures, retrieval coverage and access denials, citation/grounding samples, refusal/escalation, unsafe-output categories, user corrections, latency, token/cost consumption, provider/model changes and feedback-loop effects. Input drift alone does not establish performance drift.

Treat prompt, policy, parser, tokenizer, corpus/index, retrieval model, base model and tool changes as distinct update types. Evaluate each against the same regression, safety and contamination suites and maintain independent rollback. Purge deleted source documents from indexes, caches and conversation memory according to the data contract.

## Minimum completion checklist

- [ ] Language, document/conversation unit, evidence boundary and answerability are explicit.
- [ ] Source/version, licence, consent, extraction/OCR and pretrained-model provenance are recorded.
- [ ] Annotation offsets, normalisation, tokenisation, chunking and truncation are versioned and tested.
- [ ] Split grouping and time cutoffs prevent document/user/template/repository and answer leakage.
- [ ] Exact/fuzzy contamination was audited and unauditable pretraining overlap is disclosed.
- [ ] Lexical/rule/retrieval or smaller-model baselines were compared fairly.
- [ ] Task metric, normalisation, aggregation, human rubric and uncertainty are locked.
- [ ] Multilingual, long-context, conflicting-evidence and risk-based adversarial cases were tested.
- [ ] The full prompt/context/retrieval/tool/safety system is packaged with golden cases.
- [ ] Monitoring and retirement cover corpora, indexes, logs, caches and model/provider changes.

## Related guides

- [Generative modelling](../task_families/generative_modelling_and_content_generation.md)
- [Recommendation, ranking, and retrieval](../task_families/recommendation_ranking_and_retrieval.md)
- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md)
- [Semi-, weakly, and self-supervised learning](../paradigms_and_methods/semi_weak_and_self_supervised_learning.md)
- [Active learning and human-in-the-loop systems](../operational_settings/active_learning_and_human_in_the_loop.md)
- [Multimodal learning](multimodal_learning.md)

## Official and primary references

- [Hugging Face task explanations](https://huggingface.co/docs/transformers/main/tasks_explained) — official, evolving documentation distinguishing token classification, extractive QA, language modelling and sequence-to-sequence outputs.
- [Data Statements for Natural Language Processing](https://aclanthology.org/Q18-1041/) — primary ACL publication supporting documentation of language, speaker and collection context.
- [Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks](https://arxiv.org/abs/2005.11401) — primary RAG paper distinguishing parametric generation from retrieved non-parametric evidence.
- [NIST AI 600-1: Generative AI Profile](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf) — official risk guidance for confabulation, information integrity, privacy, harmful bias, misuse and human evaluation.
- [NIST AI 100-2e2025: Adversarial Machine Learning taxonomy and terminology](https://csrc.nist.gov/pubs/ai/100/2/e2025/final) — normative terminology covering prompt injection, data poisoning, evasion and privacy attacks.

Checked: 2026-08-14. Framework task catalogues and hosted model/API behaviour must be rechecked at implementation time.

[Back to the specialisation index](../README.md)
