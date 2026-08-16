# Phase 03 - Repair metadata and build canonical manifests

## Context links

- [Plan](./plan.md)
- [Assignment requirements](./reports/assignment-requirements.md)
- [Dataset scout](./reports/dataset-scout.md)
- [Lifecycle Phase 03](../../../../Machine%20Learning%20tổng/machine_learning_lifecycle_phases/03_data_understanding_and_validation.md)

## Overview

- Priority: P1
- Status: Pending
- Effort: 4h
- Dependency: Phase 02
- Goal: create canonical, traceable manifests and stable label maps without altering raw CSVs or inventing missing targets.

## Requirements

### Functional

- Parse the 12 raw columns explicitly; never rely on pandas auto-generated unnamed column names as a permanent contract.
- Reconstruct each product display name by joining stripped non-empty name segments in source order with `", "`.
- Preserve raw values/audit flags needed to explain every repair.
- Filter `role=train` and join the image inventory by composite `(role,id)`; exclude non-image-backed rows from usable image manifests and retain them in issue evidence.
- Add `has_gender_label`, `has_articleType_label`, `has_season_label`, `has_usage_label` booleans; valid means stripped non-empty text that belongs to the frozen taxonomy for that target.
- Create immutable source string-to-index maps from an independently versioned allowlist covering valid raw training labels; later quarantine never renumbers or shrinks these maps.
- Emit one row-level issue per missing/invalid field, including the 14 `baseColour` and seven `productDisplayName` cases, then reconcile aggregate counts from that ledger.
- Validate official prediction CSV columns/order/IDs but do not fill labels or overwrite the provided file.
- Expose a future submission validator that requires the exact five-column order/official ID order, no missing predictions, and values in the immutable source maps; it never generates model predictions.

### Non-functional

- Every model-input manifest row is sorted by numeric ID and contains a relative, portable POSIX-style path from ASM2. Submission templates contain only the assignment columns.
- Canonical CSV output uses UTF-8, explicit empty strings for missing values and stable line endings.
- Repair/filter counts must exactly reconcile to the raw counts and audit inventory.

## Architecture and data flow

```text
raw styles_train.csv + image_inventory.csv
  -> explicit raw parser
  -> product-name repair + whitespace normalization
  -> independent allowlist validation + source target masks
  -> `(role,id)` image join
  -> clean train manifest + row issue ledger + immutable source maps

raw styles_prediction.csv + official-test inventory
  -> strict schema/ID check
  -> internal official-test inference index (paths/audit fields)
  -> separate exact five-column submission template + schema receipt
```

## Related code files

### Create

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\metadata.py` - explicit parsing and repair rules.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\manifests.py` - inventory joins and canonical schemas.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\labels.py` - target masks and stable maps.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\config\label_taxonomy.json` - independently versioned source-label allowlist and digest; future category drift requires explicit review.

### Generate

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\artifacts\data_preparation\manifests\clean_train_manifest.csv`
- `...\manifests\official_test_inference_index.csv`
- `...\manifests\submission_template.csv`
- `...\manifests\submission_schema_receipt.json`
- `...\manifests\taxonomy_candidates.json`
- `...\manifests\taxonomy_validation_receipt.json`
- `...\manifests\source_label_maps.json`
- `...\manifests\metadata_summary.json`
- `...\manifests\metadata_repairs.csv`
- `...\manifests\data_issues.csv`

### Modify

- Phase 01 CLI/pipeline/contracts to register the metadata stage and artifact schemas.

### Delete

- None.

## Implementation steps

1. Read each raw CSV/template once into a bounded byte snapshot, require its SHA-256 to equal Phase 02's content-manifest value, and parse only that snapshot. Require the train header's 12 fields with the last two blank; fail loudly on drift and persist the snapshot SHA.
2. Parse all 38,617 rows while preserving the three product-name segments separately during repair.
3. Compute all IDs satisfying the exact trailing-spill predicate and require set equality with the frozen 21-ID set; either symmetric difference is schema drift and fails. Only then join stripped non-empty name segments with comma-space and log originals, joined result, predicate and rule version.
4. Normalize only surrounding whitespace. Do not lowercase or merge category spellings without a separately approved taxonomy rule.
5. Before the first production `all`, run diagnostic `metadata --discover-taxonomy` to extract the sorted structurally valid non-empty values. Review its full diff, then author/freeze values plus SHA-256 in `config/label_taxonomy.json`; the production transaction never mutates config.
6. During every production run, independently re-extract observed values and require an exact match to the versioned allowlist before setting `has_*_label=true`. Create immutable source maps/inverse maps from that config, validate contiguous indices/round trips, and report raw versus image-backed support without deleting zero-image classes. Any new/missing category fails and requires a new reviewed config version.
7. Filter the audit to `role=train`, join by `(role,id)`, and classify absent/corrupt/unsupported rows. Emit field-level issues as `(role,id,field,issue_code,severity,disposition)`; keep original records in evidence and omit only unusable images from the model-input manifest.
8. Strictly validate the raw prediction template: `id,gender,articleType,season,usage` in exact order, 5,829 unique IDs, all four target columns empty, and IDs matching the complete official-test file inventory 1:1. Write an internal inference index with path/decode status separately from an exact-schema submission template; add a validator contract for later filled predictions. Any non-decodable official image is critical but its ID is not dropped.
9. Write canonical manifests and summaries into the same transaction draft; record source/artifact/allowlist digests, parser/rule versions and a submission schema receipt. Write `METADATA_COMPLETE.json` only after checks; never publish top-level `READY`.
10. Assert row-level then aggregate reconciliations for the observed source: five missing-image IDs; exact 21 repair IDs; 14 missing `baseColour`; 20 missing `season`; 72 missing `usage`; seven missing `productDisplayName`; 125 raw source article types; and an expected maximum 124 image-backed article types before any Phase 04 quarantine.

## Todo list

- [ ] Implement explicit raw CSV parser.
- [ ] Implement auditable product-name repair.
- [ ] Join inventory and build target masks.
- [ ] Freeze/validate the independent source allowlist and immutable label maps.
- [ ] Validate and separate the internal inference index from the exact submission schema.
- [ ] Reconcile every missing/repair issue by `(role,id,field)` and artifact digest.

## Success criteria and evidence

- Usable train count equals the Phase 02 `decode_ok` intersection (currently expected maximum 38,612), with unique IDs.
- Predicate-positive IDs equal the frozen 21-ID set exactly (not count-only); all 21 repairs are logged and two include all three source segments.
- Known missing-image IDs exist only in the issue ledger, not the usable manifest.
- No missing target value is replaced; `has_*_label=true` counts match stripped non-empty values accepted by the independent allowlist.
- Immutable source maps round-trip and currently contain five gender, four season, eight usage and 125 article-type values. Support evidence separately records the missing-image-only `Suits` class and any audited decode loss; Phase 04 cannot renumber these maps.
- Row-level issue IDs exactly roll up to all known missing-field counts, including `baseColour=14` and `productDisplayName=7`.
- The internal inference index retains all 5,829 official IDs and valid paths; the separate submission template has exactly five columns in required order, and the raw template SHA-256 is unchanged.

## Risks, security and performance

- **CSV ambiguity:** comma-spilled names could be repaired incorrectly. Mitigation: exact ID set plus structural predicate, per-row repair evidence and joined-result tests for all 21 IDs.
- **Label leakage:** auxiliary product metadata must not become image-model inputs by accident. Mitigation: roles documented; loaders expose targets/path separately.
- **Target integrity:** never use model-based/heuristic label filling or auto-admit a newly observed category into the versioned allowlist.
- **Performance:** CSV/inventory joins are small relative to image data; enforce unique-key validation to prevent accidental row multiplication.

## Next steps

Phase 04 may split only the canonical image-backed manifest and must consume duplicate evidence from Phase 02.
