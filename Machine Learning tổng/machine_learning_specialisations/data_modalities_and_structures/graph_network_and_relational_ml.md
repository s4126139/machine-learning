# Graph, Network, and Relational Machine Learning

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay documents only the additional controls introduced when entities, relationships, topology, or graph construction are part of the model input or prediction unit.

## Use this guide when

Use this overlay for node, edge/link, subgraph or graph-level prediction; knowledge graphs; social, transaction, biological or citation networks; molecular graphs; relational recommendation; and temporal/heterogeneous graph learning. Apply it whenever a prediction can receive information through graph structure, even if the final estimator is not a graph neural network.

## Do not confuse it with

- [Recommendation, ranking, and retrieval](../task_families/recommendation_ranking_and_retrieval.md), which owns user/query candidate ranking, exposure and top-k utility.
- [Clustering and dimensionality reduction](../task_families/clustering_and_dimensionality_reduction.md), which owns community/discovery evaluation when no external predictive target exists.
- [Time series and forecasting](../task_families/time_series_and_forecasting.md), which owns future-origin evaluation; add it for temporal graph forecasting.
- [Causal inference and uplift modelling](../task_families/causal_inference_and_uplift.md), because graph connectivity or message passing does not establish a causal effect.
- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md), which owns neural optimisation and pretrained stages rather than graph semantics.

Tabular data with foreign keys is not automatically graph ML. Use this overlay when graph construction, relational neighbourhoods, paths, or topology materially affect training or inference.

## Scope and major variants

| Variant | Prediction unit | Distinct lifecycle concern |
|---|---|---|
| Node property prediction | existing or new node | transductive versus inductive evidence and neighbourhood leakage |
| Link/edge prediction | candidate relation or edge attribute | target-edge removal, negatives and reciprocal/path leakage |
| Graph property prediction | whole graph/molecule/document tree | graph/entity grouping and size/scaffold/domain shift |
| Knowledge-graph completion | subject-relation-object triple | filtered ranking, inverse relations and closed/open world assumptions |
| Heterogeneous/multiplex graph | typed nodes/edges/layers | type schema, relation-specific coverage and missing relation types |
| Temporal/dynamic graph | timestamped events or snapshots | causal neighbourhoods, evolving identifiers and future-edge leakage |
| Subgraph/path prediction | motif, community, route or local structure | candidate generation and boundary construction |

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Define graph snapshot/event semantics, node/edge/graph prediction unit, transductive/inductive scope and permitted neighbourhood at decision time | Graph task and information-availability contract |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Version sources, entity resolution, graph construction, types, timestamps, features/labels and relationship consent | Graph schema, snapshot manifest, construction lineage and integrity audit |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md) | Design node/edge/graph/time split and message-passing graph jointly; block target, path, reciprocal and shared-entity leakage | Split-edge/node/graph manifests and accessible-adjacency specification |
| [05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Fit entity resolution, graph transforms, structural features and sampling within valid boundaries | Versioned graph builder/feature contract and leakage tests |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare feature-only, topology-only and shallow relational baselines; control negative/neighbour sampling and graph-compute budgets | Baseline/ablation table and sampling-aware selection log |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Use candidate/split-specific graph evaluators, dependence-aware aggregation and realistic OOD/cold-start evidence | Frozen evaluator/candidate set, structural slices and locked graph evaluation |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[15](../../machine_learning_lifecycle_phases/15_retraining_and_maintenance.md) | Package schema, ID maps, graph snapshot/store, sampler and serving-time neighbourhood rules; monitor topology and staleness | Graph-system manifest, point-in-time parity test and snapshot/update plan |
| [16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Retire graph snapshots, derived relationships, embeddings, indexes and entity mappings under source deletion obligations | Relational artefact/data disposition record |

## Problem and data contract

Define node, edge/relation and graph semantics independently. Record direction, multiplicity, self-loops, weights, timestamps/validity intervals, node/edge types, feature availability time, labels, graph membership and whether absent edges mean negative, unknown or unobserved. State whether the graph is static, snapshot-based or event-driven.

Version graph construction: data sources, entity resolution/deduplication, edge creation and expiry, filtering, projection from heterogeneous to homogeneous structure, temporal cutoff and treatment of isolated nodes/components. A changed join or identity-resolution rule creates a different dataset even when source tables are unchanged.

For each feature, record whether it is intrinsic, aggregated from neighbours, learned from the whole graph, or derived from future interactions. Labels and target events must not enter degrees, components, embeddings or paths available at training/inference time unless the deployment process genuinely exposes them.

Validate referential integrity, duplicate/conflicting edges, invalid types/timestamps, impossible self-loops, orphan nodes, disconnected components, label/feature coverage by type, degree and graph-size distributions, hubs, temporal ordering and train/test entity overlap. Document sampling bias: observed networks are often incomplete and edge absence is rarely a verified negative.

## Split and evaluation protocol

Start by declaring the generalisation question:

- transductive node evaluation may expose test nodes and permissible edges/features without their labels;
- inductive node evaluation withholds nodes, subgraphs, sites or future arrivals and their unavailable neighbourhoods;
- graph-level evaluation groups graphs sharing patients, molecules/scaffolds, templates, organisations or source processes;
- temporal evaluation exposes only nodes, edges and features known at the prediction timestamp.

For link prediction, remove validation/test target edges from the training message-passing graph and audit reverse edges, duplicate relations, multi-hop shortcuts, future edges and target-derived features. Define negatives as sampled non-edges, verified negatives or candidate-set exclusions; keep negative sampling fixed for comparable final evaluation and report its distribution.

For knowledge graphs, declare raw versus filtered ranking and which known true triples are excluded from corruption candidates. For recommender graphs, add the ranking guide's exposure and user/item split controls. OGB demonstrates why graph benchmarks require application-specific splits and evaluators rather than one random split.

Graph observations are dependent. Report uncertainty across independent graphs, communities, time blocks, sites or entities appropriate to deployment; do not treat millions of connected nodes/edges as independent replicates.

## Baselines and model-family choices

Require baselines that isolate structure from attributes:

- class prior or feature-only linear/tree model with no adjacency;
- topology-only degree, common-neighbour, preferential-attachment, shortest-path or PageRank-style heuristic as appropriate;
- matrix factorisation or shallow random-walk embedding;
- simple one-hop aggregation or shallow message-passing model;
- temporal recency/frequency heuristic for evolving links;
- incumbent graph/query system.

Include node-feature ablation, edge/topology ablation and shuffled-edge diagnostics where valid. Compare models with the same candidate set, negative samples, permitted graph, external features and neighbour budget. A transductive model using test-node topology is not directly comparable to an inductive feature-only deployment unless the distinction is explicit.

## Training and validation adaptations

Fit entity resolution, graph statistics, structural encodings, embedding vocabularies and graph transforms within the allowed partition/time boundary. Version self-loop addition, direction symmetrisation, relation projection, normalisation, positional/structural encodings, subgraph extraction and feature imputation.

Record full-graph versus sampled training, neighbourhood fan-out, walk/subgraph sampler, negative sampler, batch construction, seed, number of graph passes and hardware/distribution. Sampling changes the objective and node/edge exposure; log effective inclusion rates by degree/type.

For temporal graphs, construct causal neighbourhoods for every training and evaluation event and specify memory reset/update order. For heterogeneous graphs, monitor loss and sampling balance across node/relation types. Select depth and aggregation with over-smoothing, over-squashing, hub dominance and deployment neighbourhood cost in mind.

## Metrics and uncertainty

The exact task and evaluator own the metric:

- node/edge/graph classification or regression: core metrics with macro/per-type and graph/entity aggregation;
- binary link prediction: precision-recall/ROC diagnostics under a disclosed negative/candidate distribution and thresholded utility at deployment prevalence;
- ranked link/knowledge-graph completion: MRR or Hits@K with exact corruption, tie and filtered-ranking rules;
- retrieval/recommendation: add the ranking guide for Recall/NDCG/MAP and exposure-aware evidence;
- clustering/communities: add the clustering guide and distinguish external-label from structural quality.

Report by node/edge/relation type, degree, component/community, graph size, path distance, cold/new status, time, source and label coverage. Include calibration at the decision unit when scores trigger action. Use grouped/bootstrap uncertainty over independent graphs/entities/blocks, and disclose evaluator version, candidate set and negative seed.

## Error analysis, safety, and robustness

Inspect false cases with their permitted ego graph, path evidence and feature provenance. Slice isolated/cold nodes, hubs, low/high degree, rare relation types, small/large components, heterophilous neighbourhoods, temporal age and cross-domain graphs. Separate candidate-generation, graph-construction, feature, message-passing and threshold errors.

Stress missing/spurious edges, delayed/stale relations, node-feature corruption, graph fragmentation, hub removal, new relation/node types, identity-merge/split errors and realistic temporal/domain shifts. Perturbation levels must reflect data-source failure, not arbitrary graph edits alone.

Threats include poisoning through nodes/edges/features, sybil/fraud networks, inference of sensitive relationships, link re-identification, malicious neighbourhood amplification and denial through high-degree/path explosion. Apply access control before graph construction and serving; embeddings or inferred edges may remain sensitive even after raw attributes are removed.

## Packaging, deployment, monitoring, and maintenance

Package the graph schema/version, source cutoff, entity/ID mappings, graph builder, snapshot or event-log position, feature store and point-in-time joins, adjacency/index, transforms/encodings, neighbour/subgraph sampler, model, candidate/negative rules, postprocessing and thresholds. Golden subgraphs must test isolated nodes, unseen types, duplicate edges, time cutoffs and batch/online parity.

Declare whether inference uses a frozen snapshot, periodically rebuilt graph or live mutations. Define consistency, staleness, late-event and concurrent-update behaviour. Budget graph lookup and sampling latency/memory separately from model compute; cap neighbourhood expansion safely.

Monitor node/edge/graph counts, type mix, degree/component/graph-size distributions, churn, edge age/staleness, orphan/unknown IDs, feature/label coverage, sampling truncation, embedding/prediction drift, cold-start rates, per-type performance and graph-store latency. A topology change is not automatically a performance failure, but it triggers targeted evaluation. Retest when construction, entity resolution, snapshot, candidate set or relation schema changes.

## Minimum completion checklist

- [ ] Node, edge/relation, graph, timestamp and absent-edge semantics are explicit.
- [ ] Entity resolution, graph construction, schema, source and snapshot lineage are versioned.
- [ ] Referential, duplicate, temporal, type, degree/component and coverage checks pass.
- [ ] Transductive/inductive/temporal scope and accessible message-passing graph are locked.
- [ ] Target-edge, reverse/path, future and negative-sampling leakage were audited.
- [ ] Feature-only, topology-only and shallow relational baselines were compared fairly.
- [ ] Evaluator, candidates/negatives, aggregation and group uncertainty are reproducible.
- [ ] Cold nodes, rare types, graph shifts, construction errors and adversarial threats were tested.
- [ ] Schema, graph snapshot/store, ID maps, sampler and point-in-time features are packaged.
- [ ] Monitoring/retirement cover topology, inferred relations, embeddings and source deletion.

## Related guides

- [Recommendation, ranking, and retrieval](../task_families/recommendation_ranking_and_retrieval.md)
- [Clustering and dimensionality reduction](../task_families/clustering_and_dimensionality_reduction.md)
- [Time series and forecasting](../task_families/time_series_and_forecasting.md)
- [Anomaly, novelty, and OOD detection](../task_families/anomaly_novelty_and_ood_detection.md)
- [Causal inference and uplift modelling](../task_families/causal_inference_and_uplift.md)
- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md)

## Official and primary references

- [Open Graph Benchmark](https://ogb.stanford.edu/docs/home/) and the [primary NeurIPS paper](https://proceedings.neurips.cc/paper/2020/hash/fb60d411a5c5b72b2e7d3527cfc84fd0-Abstract.html) — application-specific graph splits, evaluators and reproducible node/link/graph benchmarks.
- [PyTorch Geometric documentation](https://pytorch-geometric.readthedocs.io/en/stable/) — official graph data, sampling, mini-batching, heterogeneous/temporal graph and distributed-learning capabilities.
- [Inductive Representation Learning on Large Graphs (GraphSAGE)](https://papers.nips.cc/paper/6703-inductive-representation-learning-on-large-graphs) — primary distinction and method for inductive node representations.
- [Rules for the OGB experimental protocol](https://ogb.stanford.edu/docs/leader_rules/) — official controls on validation/test labels, external data and final evaluation.

Checked: 2026-08-14. OGB datasets, evaluators and framework APIs are evolving and must be version-pinned for a project.

[Back to the specialisation index](../README.md)
