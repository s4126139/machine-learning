# Recommendation, Ranking, and Retrieval

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an independent lifecycle. Apply the core and add these controls when a system retrieves or orders candidates for a user, query, context, or downstream generator.

## Use this guide when

Use it for personalised recommendation, information/product retrieval, learning-to-rank, semantic/vector search, candidate generation, reranking, or retrieval components in RAG. Add NLP/LLM, graph, multimodal or RL/bandit overlays when they own the data or feedback regime.

## Do not confuse it with

- Retrieval selects candidates; ranking orders them; recommendation may compose candidate generation, scoring and reranking.
- A classifier AUC over sampled pairs does not establish top-k corpus retrieval quality.
- Logged clicks reflect exposure, position, interface and policy; they are not complete relevance labels.
- RAG is a system composition: retrieval plus a generative model and usually a text/document modality.

## Scope and major variants

Covered settings include content-based and collaborative recommendation, two-tower/vector retrieval, sparse/dense/hybrid search, pointwise/pairwise/listwise ranking, multi-stage candidate–rank–rerank systems, and session/context-aware recommendation. Sequential policy optimisation additionally uses the RL/bandit guide.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define query/user, candidate corpus, relevance/utility, exposure policy, slate/action, freshness, eligibility and feedback delay. | Retrieval/ranking contract, corpus and exposure audit. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Split by time and user/query/session/item as deployment requires; build histories, negatives, vocabulary and indexes inside boundaries. | Leakage-safe interaction/corpus split and negative-sampling lineage. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare popularity/recency/lexical/simple collaborative baselines; tune stages jointly enough to expose retrieval ceilings and reranking effects. | Stage-wise baseline, ablation and selection report. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Evaluate full-corpus top-k utility, coverage/diversity/fairness, latency and cold-start slices; separate logged offline from causal online evidence. | Stage/end-to-end metrics, bias assumptions, locked temporal and staged-online evidence. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package models plus corpus/index/filters; monitor exposure, freshness, feedback loops and stage health; version index refresh separately. | System manifest, index parity/freshness, monitoring/rollback/retirement plan. |

## Problem and data contract

Define the query/user/context, eligible corpus and filters, relevance or utility label, slate size/order, feedback and attribution window, exposure/logging policy, positions, propensities when available, negative/unobserved semantics, availability/freshness and latency budget. Version item/document content, user consent and deletion requirements, interaction events, deduplication and catalogue state. Distinguish explicit negatives from unseen or unexposed items.

## Split and evaluation protocol

Use chronological evaluation for future interactions and apply user, query, session and item boundaries matching cold/warm-start claims. Prevent histories, co-occurrence features, vocabularies, embeddings, hard negatives and indexes from incorporating future/held-out interactions or content. Evaluate against the eligible corpus available at each historical cutoff; sampled negatives may support development but do not replace full- or realistic-corpus final evaluation. Record exposure/position assumptions and use counterfactual methods only when their logging-policy support requirements are met.

## Baselines and model-family choices

Include non-personalised popularity, recency/trending and random eligible baselines; lexical retrieval for text search; simple content similarity and matrix-factorisation/collaborative baselines where applicable; and the incumbent. Evaluate each stage: candidate recall bounds downstream ranking, while reranking can trade relevance for diversity, freshness, fairness or policy constraints. Justify approximate retrieval by both quality loss and latency/resource gain.

## Training and validation adaptations

Version corpus cutoff, eligibility, interaction attribution, history window, positive/negative sampling, in-batch/hard-negative logic, loss, candidate generators, ranker, reranking rules, index build parameters and seeds. Avoid accidental false negatives and leakage from future clicks/content. Tune stage objectives against end-to-end validation, while preserving stage diagnostics. If feedback is policy-dependent, document weighting/debiasing assumptions and do not claim unbiased utility without support evidence.

## Metrics and uncertainty

Use retrieval recall@k/hit rate and full-corpus candidate coverage; ranking precision@k, recall@k, MAP, MRR or NDCG according to graded/binary and single/multiple relevance; and end-to-end utility at the served slate. Add catalogue/user coverage, novelty, diversity, freshness, calibration, fairness/exposure, cold-start performance, latency, index size and cost. Report by user/query/session rather than treating all pairs as independent. Offline metrics do not prove online incremental impact; use guarded experiments or valid counterfactual evaluation for causal claims.

## Error analysis, safety, and robustness

Inspect zero-result and missed-candidate cases, false negatives, popularity bias, filter bubbles, duplicate/redundant slates, position/exposure bias, cold users/items, head/tail catalogue, stale or deleted content, adversarial/spam items and sensitive-query failures. Slice by language, region, device, cohort and query type as relevant. Test index corruption/staleness, unavailable candidate generators and latency degradation; enforce eligibility, policy and safety filters after retrieval and before display.

## Packaging, deployment, monitoring, and maintenance

Package query/user and item encoders, feature/history logic, candidate generators, ranker, reranker, eligibility/safety filters, corpus snapshot, embedding/index build, score calibration and API schema. Verify offline/online feature parity and exact-versus-approximate retrieval deltas. Monitor candidate recall proxies, rank/score/exposure distribution, zero-result rate, catalogue coverage/diversity, freshness, latency, index age, feedback/outcomes and subgroup metrics. Treat model retrain, corpus refresh, embedding recompute, index rebuild, rule/filter change and online policy change as distinct updates with compatible rollback bundles and deletion propagation.

## Minimum completion checklist

- [ ] Query/user, eligible corpus, relevance/utility, slate, exposure policy, negatives and feedback delay are explicit.
- [ ] Time and entity splits protect histories, features, negatives, content, embeddings and indexes from leakage.
- [ ] Popularity, recency, lexical/content, simple collaborative and incumbent baselines are compared as applicable.
- [ ] Candidate, ranker, reranker and end-to-end stages have separate diagnostics and joint validation.
- [ ] Full/realistic-corpus top-k, coverage/diversity/fairness, cold-start, latency and uncertainty are reported.
- [ ] Offline association evidence is distinguished from counterfactual or randomised online impact.
- [ ] Index/corpus freshness, filters, feedback loops, deletion, rollback and retirement are operationally tested.

## Related guides

- [Reinforcement learning and contextual bandits](../paradigms_and_methods/reinforcement_learning_and_bandits.md)
- [Generative modelling](generative_modelling_and_content_generation.md)
- [NLP, documents, and LLM applications](../data_modalities_and_structures/nlp_documents_and_llms.md)
- [Graph, network, and relational ML](../data_modalities_and_structures/graph_network_and_relational_ml.md)
- [Online, incremental, and continual learning](../operational_settings/online_incremental_and_continual_learning.md)
- [Specialisation index](../README.md)

## Official and primary references

- [Google for Developers: Recommendation systems overview](https://developers.google.com/machine-learning/recommendation/overview/types) — official candidate-generation, scoring and reranking system decomposition.
- [TensorFlow Recommenders](https://www.tensorflow.org/recommenders) — official workflow and task documentation for retrieval, ranking, evaluation and deployment.
- [TensorFlow Recommenders: Retrieval task](https://www.tensorflow.org/recommenders/api_docs/python/tfrs/tasks/Retrieval) — official full-corpus factorised top-k and in-batch evaluation distinctions.
- [Unbiased Offline Evaluation of Contextual-bandit-based News Article Recommendation Algorithms](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/Published-3.pdf) — primary assumptions for logged-policy offline evaluation.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
