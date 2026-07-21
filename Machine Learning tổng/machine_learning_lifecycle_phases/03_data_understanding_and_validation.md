# Phase 03 — Data Understanding and Validation

## Purpose

Confirm that the collected data is structurally valid, understandable, sufficiently representative, and safe to move into model development.

## Visual map

```mermaid
flowchart TD
    A["Versioned raw data"] --> B["Check schema, keys, units, and timestamps"]
    B --> C["Check missingness, duplicates, and invalid values"]
    C --> D["Inspect distributions across target, groups, and time"]
    D --> E["Check labels, leakage, and production compatibility"]
    E --> F["Log issues, severity, and owners"]
    F --> G{"Ready for split design?"}
    G -->|No| H["Resolve, document, and rerun checks"]
    H --> B
    G -->|Yes| I["Approved data-readiness report"]
```

## When this phase applies / task-specific variants

- Run on the initial raw dataset and every new dataset version.
- Perform preliminary schema and quality checks before splitting.
- After the test set is locked, conduct target-informed exploration and modelling decisions on training data only.
- Reuse the same validation rules later for training–serving checks and monitoring.

## Inputs

- versioned raw dataset;
- problem, target, prediction-unit, cutoff, and horizon definitions;
- data dictionary and schema;
- source/lineage and label documentation;
- expected ranges, categories, frequencies, and quality thresholds.

## Core tasks checklist

- [ ] Verify row count, column count, schema, types, units, keys, and timestamp ranges.
- [ ] Measure missingness by column, target, group, and time.
- [ ] Detect exact duplicates, near-duplicates where relevant, and repeated entities.
- [ ] Review unique counts, constants, identifiers, rare values, and unexpected categories.
- [ ] Check allowed ranges, cross-field rules, impossible values, and referential integrity.
- [ ] Inspect numeric distributions, categorical frequencies, and target distribution.
- [ ] Review class balance, multilabel structure, and samples per class where applicable.
- [ ] Investigate outliers; distinguish valid rare events from measurement/data errors.
- [ ] Check label quality, disagreement, ambiguity, missing labels, and delayed labels.
- [ ] Inspect relationships that may reveal target leakage or post-outcome variables.
- [ ] Review patterns by time, entity/group, location, source, device, and important subgroup.
- [ ] Compare development data definitions with expected production inputs.
- [ ] Record each issue, severity, owner, resolution, and accepted limitation.
- [ ] Convert confirmed rules into repeatable validation tests.

## Case-specific decision table

| Case | Key checks | Key attention |
|---|---|---|
| Regression | Target range/distribution, units, missing labels, censoring, extreme errors | Invalid target values, caps/floors, skew, repeated measurements |
| Classification | Class counts, label policy, confusion in annotation, rare classes | Imbalance, label noise, class-definition drift, unsupported classes |
| Time series / forecasting | Ordering, frequency, gaps, duplicated timestamps, seasonality, revisions | Timezone, future-derived fields, irregular intervals, structural breaks |
| Grouped data | Group sizes, observations per entity, group overlap and identifiers | Dominant groups, duplicate identities, group-specific missingness |
| Unsupervised learning | Scale, distributions, correlations, density, missingness, outliers | Feature scale can dominate distance; validation needs domain review |
| Text | Empty/very short documents, language, encoding, length, duplicates, vocabulary | Templates, copied content, PII, label/source shortcuts |
| Image | File integrity, dimensions, channels, capture metadata, duplicates | Same subject in many images, metadata leakage, source/device artifacts |

## Scikit-learn keywords / APIs

| Need | Native scikit-learn API | Scope |
|---|---|---|
| Validate array shape/content | `sklearn.utils.validation.check_array` | Estimator-style numeric/array checks |
| Validate aligned features and target | `sklearn.utils.validation.check_X_y` | Consistent sample counts plus array validation |
| Validate finite values | `sklearn.utils.validation.assert_all_finite` | Detect NaN/infinity according to options |
| Inspect target type | `sklearn.utils.multiclass.type_of_target` | Binary, multiclass, multilabel, continuous, etc. |
| Check multilabel structure | `sklearn.utils.multiclass.is_multilabel` | Multilabel indicator detection |
| Inspect known labels | `sklearn.utils.multiclass.unique_labels` | Ordered label set across compatible targets |

Most exploratory analysis and business-rule validation is outside core scikit-learn:

- pandas/NumPy: summaries, duplicates, missingness, grouping, joins;
- Matplotlib/Seaborn/Plotly: distributions and visual checks;
- SciPy: statistical diagnostics;
- Great Expectations/Pandera: schema and data-contract tests;
- image/audio/text libraries: corrupt-file and modality-specific validation.

These are external tools, not scikit-learn APIs.

## Key attention / pitfalls

- Treating an unusual value as an error without checking domain provenance.
- Dropping missing values, outliers, or rare groups before understanding why they occur.
- Using the full test target distribution to select features, transformations, or models.
- Confusing correlation with causal value or valid prediction-time availability.
- Leaving ID-like, post-outcome, manually curated, or duplicated target-proxy fields unnoticed.
- Checking only global averages and missing failures in subgroups or time periods.
- Allowing exact or near duplicates to cross future train/test boundaries.
- “Fixing” data without recording the original value, rule, owner, and version.
- Assuming validation utilities replace domain-specific schema and semantic rules.
- Ignoring train–production differences in units, categories, timestamps, or collection logic.

## Outputs / deliverables

- data profile and target profile;
- validated schema and reusable data-quality rules;
- missingness, duplicate, outlier, class/group/time coverage summaries;
- leakage-candidate list and confirmed exclusions;
- data-issue log with severity, owner, and resolution;
- approved cleaning rules and accepted limitations;
- data-readiness report for split design.

## Exit criteria

- Schema, units, keys, timestamps, target, and prediction unit match their definitions.
- Critical missingness, duplication, invalid-value, label, and leakage issues are resolved or explicitly accepted.
- Important classes, groups, periods, sources, and modalities have documented coverage.
- Repeatable validation rules detect known failure modes.
- The correct random, stratified, grouped, temporal, or custom split strategy can now be specified.

---

[Previous: Data Collection and Governance](02_data_collection_and_governance.md) · [Index](README.md) · [Next: Data Splitting](04_data_splitting.md)
