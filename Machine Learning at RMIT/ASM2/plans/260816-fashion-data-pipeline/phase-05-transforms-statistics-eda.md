# Phase 05 - Build transforms, train-only statistics and EDA

## Context links

- [Plan](./plan.md)
- [Workflow research](./reports/workflow-research.md)
- [Lifecycle Phase 05](../../../../Machine%20Learning%20tổng/machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md)
- [Computer Vision overlay](../../../../Machine%20Learning%20tổng/machine_learning_specialisations/data_modalities_and_structures/computer_vision.md)

## Overview

- Priority: P1
- Status: Pending
- Effort: 5h
- Dependency: Phase 04
- Goal: define one reusable image input contract, fit normalization strictly on training IDs and create compact EDA/evidence artifacts without materializing a second image corpus.

## Requirements

### Transform contract

- Read one bounded byte snapshot, require SHA-256 equality with the audited inventory, then decode that snapshot with Pillow, EXIF-transpose, convert RGB, preserve aspect ratio, letterbox/pad to configurable 128x128 and scale float32 `[0,1]`.
- Use explicit interpolation/padding/channel-order rules and validate shapes/ranges.
- Evaluation transform is deterministic for validation, holdout and prediction.
- Training transform accepts a seed/sample ID/epoch and can apply only configured label-preserving augmentation; RNG seed material is a stable SHA-256 derivation, never Python `hash()`, and all augmentation is disabled by default until preview/evidence review.
- Horizontal flip and geometry-changing augmentation remain disabled by default because logos/asymmetry may matter; enabling requires a recorded decision.

### Statistics and EDA

- Compute per-channel mean/std after the deterministic base transform using exactly rows with `global_disposition=eligible` and `partition=train`; target-label presence does not affect statistics eligibility. Use float64 Welford/Chan moments with a fixed chunk/merge order.
- Record both the expected train-ID digest and the digest of IDs actually consumed by the statistics iterator; require exact equality before publishing.
- Bind any reusable statistics artifact to raw content/topology roots, image-audit digest, split digest, transform-spec/code version and Pillow/NumPy versions.
- Generate modelling EDA from training rows only: target/missingness, image-dimension/aspect/mode, brightness/contrast/file-size, duplicate and label co-occurrence summaries. Validation labels support ordinary model selection, but no holdout label/count/scorable aggregate is emitted before the later receipt-gated final evaluator.
- Commit only synthetic transform previews. Any optional preview made from assignment images stays in an explicitly gitignored local directory and is never an evidence dependency.
- Produce data-loader helpers that return paths/targets/masks on demand, not copied pixels.
- Produce supervised/retrieval helpers for train/validation roles; normal APIs cannot read either sealed holdout key. Final-gallery membership does not yet exist and can be materialized only in a later generation after valid model-lock/final-evaluation receipts.

## Architecture and data flow

```text
split manifest
  +-> train IDs -> deterministic base transform -> streaming mean/std
  +-> all partitions -> manifest-backed dataset/loaders -> saved transform spec
  +-> training-only audit + metadata -> EDA tables/PNG/findings/data card draft
  +-> retrieval manifests -> query/gallery dataset contracts
```

Training augmentation wraps the same canonical base transform. Normalization consumes saved train-only statistics and never refits during inference.

## Related code files

### Create

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\transforms.py` - decode, orientation, resize/pad, scaling, normalization and seeded optional augmentation.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\statistics.py` - numerically stable streaming channel moments and train-ID provenance.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\dataset.py` - manifest-backed samples and target-specific filters/masks.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\eda.py` - tables, plots and finding records.

### Generate

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\artifacts\data_preparation\transforms\transform_spec.json`
- `...\transforms\normalization_stats.json`
- `...\transforms\synthetic_transform_preview.png`
- `...\eda\target_counts.csv`
- `...\eda\image_profile.csv`
- `...\eda\train_profile.csv`
- `...\eda\eda_summary.json`
- `...\eda\eda_findings.md`
- `...\eda\plot_manifest.json` - canonical plot specifications plus source-table, backend, font and rendering-version digests.
- `...\eda\plots\*.png`
- `...\DATASET_CARD.md` - generated evidence draft finalized in Phase 06.

### Modify

- Phase 01 config/CLI/pipeline to register transform/EDA settings and stage.

### Delete

- None. Do not create `processed_images`, tensor dumps or feature arrays in this scope.

## Implementation steps

1. Implement SHA-bound byte-snapshot decode, EXIF-safe RGB conversion and aspect-preserving letterbox using explicit Pillow resampling/pad color. All statistics and default loaders verify expected audit SHA before pixels are consumed.
2. Implement deterministic evaluation transform and validate shape `(H,W,3)`, float32 dtype, finite values and `[0,1]` pre-normalization range.
3. Implement optional seeded training augmentations with SHA-256-derived per-sample/per-epoch seeds. Default to disabled; never apply to validation/holdout/prediction.
4. Stream all globally statistics-eligible training pixels through the deterministic base transform and update float64 Welford states in fixed-size ID-ordered chunks; merge chunks with deterministic Chan formulas. Accumulate the observed `(role,id)` sequence digest inside the iterator and require it to equal the expected digest.
5. Save normalization stats with raw content/topology, audit, split, config, transform, code and locked-runtime digests, image/pixel counts, algorithm/chunk order, and expected/observed ID digests; reject any mismatched reuse.
6. Implement manifest-backed access using `has_*_label` and Phase 04 `eligible_*`/`reason_*`. Default loaders read the label-free split plus train/validation target files only; sealed supervised/retrieval holdout keys require the final evaluator and validated receipts. Add training/evaluation retrieval loaders with self/family exclusion and only a receipt-gated final-gallery builder.
7. Build EDA tables/plots from training rows only and write a canonical `plot_manifest.json` binding every PNG to its source-table digest, sorted plot specification, dimensions, backend, font-file digest and rendering-library versions. Validation labels remain available only through the validation target/evaluator contracts, never through EDA. Holdout labels, counts, scorable status and aggregates stay out of all normal modelling-facing and general verification artifacts until the receipt-gated final evaluator.
8. Create deterministic synthetic previews for canonical/augmentation behavior. Permit optional assignment-image previews only beneath a gitignored local path, never in committed/generated evidence.
9. Generate the dataset-card draft describing provenance, allowed use, raw/usable counts, labels, missingness, repairs, split policy, transforms, known limitations and leakage audit.
10. Validate the draft artifact schemas/digests, write `ARTIFACTS_COMPLETE.json`, and leave cross-process second-generation comparison to Phase 06; never create top-level `READY` here.

## Todo list

- [ ] Implement canonical/evaluation transform.
- [ ] Implement seeded optional train augmentation.
- [ ] Compute and provenance train-only normalization.
- [ ] Implement manifest-backed loaders and target masks.
- [ ] Generate EDA tables/plots/findings.
- [ ] Generate synthetic transform preview and dataset-card draft.
- [ ] Prove draft consistency and absence of processed-image copies; Phase 06 owns the independent rerun.

## Success criteria and evidence

- Expected and actually consumed normalization ID digests match exactly and contain only globally statistics-eligible training IDs; intersection with validation/holdout/prediction/cross-role quarantine is empty.
- Recomputed channel moments on a deterministic verification subset match within documented tolerance.
- Same image/config produces identical evaluation tensors; same train sample/seed/epoch is reproducible while a changed epoch can change enabled augmentation.
- All output arrays have expected shape/dtype/finiteness and no division by zero.
- Modelling EDA includes training-only distributions for all four targets, missingness, class imbalance, image integrity/dimensions and duplicate evidence; it does not expose validation/holdout outcomes.
- Retrieval loaders reproduce training/evaluation membership and reject self/family candidates; default imports cannot access sealed answers or the gated final gallery.
- Artifact tree contains no copied JPG corpus or cached full tensors.

## Risks, security and performance

- **Leakage:** fitting statistics on all rows inflates evidence. Mitigation: split-manifest filter and persisted train-ID digest assertion.
- **Transform distortion:** naive resize changes proportions. Mitigation: letterbox/pad and preview review.
- **Augmentation harm:** flips/crops can damage logos or item identity. Mitigation: disabled-by-default policy and explicit evidence gate.
- **Numerical stability:** sum/squared-sum cancellation can corrupt variance. Mitigation: float64 Welford updates, deterministic Chan merges and an independent subset cross-check.
- **Licence/privacy:** committed preview evidence is synthetic; any raw-image preview remains local, gitignored and inherits the educational-use restriction.
- **Performance:** stream batches; never retain all transformed images.

## Next steps

Phase 06 validates the package, artifacts, reproducibility and documentation as one clean end-to-end run.
