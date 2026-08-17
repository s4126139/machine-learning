# Clustering and Dimensionality Reduction

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not an independent lifecycle. Apply the core and add these controls when the output is discovered structure, groups, components, manifolds, or a learned lower-dimensional representation.

## Use this guide when

Use it when clusters or low-dimensional coordinates are a primary deliverable, or when an unsupervised representation is a material upstream component whose stability and downstream effects must be validated.

## Do not confuse it with

- Clustering has no external target by definition; grouping examples by a known label is classification.
- Dimensionality reduction can be exploratory visualisation, compression, denoising, or a downstream feature transform; these purposes require different evidence.
- A visually separated two-dimensional plot is not evidence that the original space contains discrete, stable clusters.
- [Anomaly detection](anomaly_novelty_and_ood_detection.md) identifies unusual cases; a small cluster is not automatically anomalous.

## Scope and major variants

The guide covers partitioning, hierarchical, density-based, spectral and mixture-style clustering; linear/nonlinear reduction; manifold and embedding methods; and cluster/embedding use as downstream features. It does not catalogue algorithms or prescribe a universal intrinsic score.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define the discovery unit, similarity/distance meaning, intended interpretation/use, scale, missingness, duplication, and density assumptions. | Discovery contract and feature/distance rationale. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Fit preprocessing/representation on training data for generalisation claims; keep grouped/time/source units intact. | Split or resampling protocol and fitted-transform lineage. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare trivial/random/simple projections; select cluster count/dimension and hyperparameters using multiple criteria and stability, not one plot/score. | Baseline and stability/selection report. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Separate internal, external, stability, reconstruction/neighbourhood, and downstream evidence; use independent labels only as external evaluation. | Multi-criterion final report with uncertainty/resampling. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package preprocessing, distance, fitted representation and assignment/out-of-sample rules; monitor cluster/embedding drift and semantic continuity; retire mappings/embeddings. | Artefact manifest, assignment contract, drift/remapping and retirement plan. |

## Problem and data contract

Define the observation/entity to group or embed, feature provenance, similarity/distance and its domain meaning, expected use, and whether new observations require out-of-sample assignment. State whether clusters are operational segments, exploratory hypotheses, compression units, or downstream features. Record scale, sparsity, mixed data types, missingness, repeated entities, weights, duplicates and protected/sensitive attributes; representation choices can dominate the discovered structure.

## Split and evaluation protocol

Exploratory analysis on one dataset still requires resampling or perturbation to assess stability. Claims about future/source/generalised assignments require train/validation/test splits by entity, time, site, source or other deployment unit; fit scalers, encoders, feature selection and reducers on training data only. If external labels exist, reserve them for interpretation/evaluation and disclose if they influenced algorithm, feature, cluster-count, or naming choices. Evaluate out-of-sample transform and assignment explicitly when deployment requires them.

## Baselines and model-family choices

Use a one-cluster/no-reduction baseline, random or shuffled assignments for chance comparison where suitable, simple centroid/hierarchical clustering, and linear reduction such as PCA before complex nonlinear methods. Compare raw approved features with reduced representations. Choose families based on distance geometry, cluster shape/density, noise handling, scalability, probabilistic membership, and out-of-sample needs—not a visually pleasing projection.

## Training and validation adaptations

Version features, scaling, distance/kernel, neighbour graph, initialisation/seeds, cluster count or density thresholds, target dimension, optimisation budgets, and stopping conditions. Repeat stochastic fits and align labels/components before comparing them. Selection must combine domain usefulness with stability and appropriate intrinsic/external/downstream evidence. Treat cluster naming and expert interpretation as a separate, documented step after fitting.

## Metrics and uncertainty

For clustering, consider silhouette, Calinski–Harabasz or Davies–Bouldin as internal diagnostics; adjusted Rand/mutual information, homogeneity/completeness or task utility when independent reference labels exist; and membership/assignment stability under resampling. For reduction, consider reconstruction error or explained variance for linear compression, trustworthiness/neighbour preservation for embeddings, downstream validation, and runtime/memory. Report cluster-size distribution, unassigned/noise rate, and uncertainty across seeds/resamples. No single intrinsic metric proves semantic validity.

## Error analysis, safety, and robustness

Inspect unstable assignments, boundary points, tiny/empty clusters, sensitivity to scale, distance, seed, sampling and outliers, and neighbourhood distortions in low dimensions. Slice cluster composition and downstream impact by relevant groups without treating protected attributes as ground-truth cluster identities. Test whether operational actions attached to clusters create unfair exclusion, self-fulfilling feedback, or misleading essentialist labels.

## Packaging, deployment, monitoring, and maintenance

Package the ordered feature schema, missing-value/scaling transforms, reducer, clustering model, distance/kernel, reference centroids/exemplars, cluster naming/version map, noise/unknown rule, and out-of-sample transform/assignment logic. Monitor input and embedding drift, distance-to-reference, cluster sizes, noise rate, assignment confidence/stability and downstream outcomes. Never silently reuse cluster identifiers after refitting: align, map and review semantics, or issue a new version and migrate consumers.

## Minimum completion checklist

- [ ] The observation unit, intended use, similarity/distance, features and out-of-sample requirement are explicit.
- [ ] Preprocessing and representations respect entity/source/time split boundaries for generalisation claims.
- [ ] Trivial, simple clustering and linear-reduction baselines are included where applicable.
- [ ] Seeds, resampling, stability and sensitivity to cluster count/dimension are documented.
- [ ] Internal, external, stability, representation and downstream metrics are not conflated.
- [ ] Cluster interpretations, harmful-action risks and critical slices receive human/domain review.
- [ ] Assignment logic, drift monitoring, semantic remapping, rollback and retirement are defined.

## Related guides

- [Anomaly, novelty, and OOD detection](anomaly_novelty_and_ood_detection.md)
- [Semi-, weakly, and self-supervised learning](../paradigms_and_methods/semi_weak_and_self_supervised_learning.md)
- [Probabilistic and Bayesian learning](../paradigms_and_methods/probabilistic_and_bayesian_learning.md)
- [Graph, network, and relational ML](../data_modalities_and_structures/graph_network_and_relational_ml.md)
- [Geospatial and spatiotemporal ML](../data_modalities_and_structures/geospatial_and_spatiotemporal_ml.md)
- [Specialisation index](../README.md)

## Official and primary references

- [scikit-learn User Guide: Clustering](https://scikit-learn.org/stable/modules/clustering.html) — official algorithm scope and clustering-performance evaluation guidance.
- [scikit-learn User Guide: Decomposing signals in components](https://scikit-learn.org/stable/modules/decomposition.html) — official decomposition, component and dimensionality-reduction guidance.
- [scikit-learn metrics API: clustering metrics](https://scikit-learn.org/stable/api/sklearn.metrics.html) — official definitions for internal and external clustering metrics.
- [Datasheets for Datasets](https://arxiv.org/abs/1803.09010) — primary documentation framework for dataset provenance and composition that shape discovered structure.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
