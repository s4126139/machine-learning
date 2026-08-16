# Phase 02 - Audit every image and duplicate signal

## Context links

- [Plan](./plan.md)
- [Dataset scout](./reports/dataset-scout.md)
- [Computer Vision overlay](../../../../Machine%20Learning%20tổng/machine_learning_specialisations/data_modalities_and_structures/computer_vision.md)
- [Lifecycle Phase 03](../../../../Machine%20Learning%20tổng/machine_learning_lifecycle_phases/03_data_understanding_and_validation.md)

## Overview

- Priority: P1
- Status: Pending
- Effort: 6h
- Dependency: Phase 01
- Goal: exhaustively establish decodability, visual/file contracts and duplicate evidence for all 44,441 JPGs while proving the raw corpus is unchanged.

## Requirements

### Functional

- Classify every directory entry under both raw roles, including nested paths, directories, extension-case variants, leading-zero stems, hidden files, hard-link aliases and reparse points; key valid images by `(role, id)`. On Windows, stable file identity/link count/reparse metadata are mandatory; inability to obtain them fails publication.
- Record path role, byte size, SHA-256, decoder format, dimensions, mode, EXIF orientation, post-transpose dimensions and decode status.
- Fully load pixels to detect truncated/corrupt data; no `LOAD_TRUNCATED_IMAGES` override.
- Compute lightweight image diagnostics: RGB/grayscale extrema, mean, standard deviation, entropy proxy and near-constant flag on a deterministic thumbnail.
- Compute versioned 64-bit difference/average hashes, integer aspect signature and block-uniform near-constant flag after the fully frozen orientation/greyscale pipelines.
- Build exact SHA groups and complete within-threshold perceptual candidate blocks without materializing member Cartesian products; flag train-train and train-official-test overlaps for a frozen Phase 04 disposition.
- Preserve failed records in inventory/issues rather than silently dropping them.

### Non-functional

- Streaming/bounded memory; do not hold full images or the whole 0.53 GiB corpus in RAM.
- Bounded worker pool; deterministic output independent of completion order.
- No quadratic all-pairs perceptual comparison.
- Version 1 performs one complete scan without a resume cache. Any later cache must bind to the raw-content Merkle root, audit/transform code version and Pillow/NumPy versions.

## Architecture and data flow

```text
all raw entries -> stable `(role,id,path)` classification
  -> bounded workers: bytes/SHA + Pillow verify/load + diagnostics/dHash
  -> ordered inventory writer
  -> exact hash groups
  -> deterministic indexes over unique hash signatures
  -> compressed signature-block edges + membership
  -> issue/overlap summaries + AUDIT_COMPLETE stage receipt
```

Use SHA-256 for exact equality. Perceptual similarity is only a candidate signal. Build deterministic BK-tree indexes over sorted unique 64-bit hash values and query inclusive radii. The compressed key is exactly `(dhash64, ahash64, aspect_milli, near_constant)`; persist membership and one edge per neighboring block, never all member pairs. Fixture tests expand blocks only in-memory and compare complete implied results with brute force.

## Related code files

### Create

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\hashing.py` - streaming SHA-256, dHash and Hamming helpers.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\image_audit.py` - decoder/integrity/diagnostic scan.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\duplicate_candidates.py` - exact groups and indexed near-candidate generation.

### Generate

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\artifacts\data_preparation\audit\raw_content_manifest_before.csv`
- `...\audit\raw_content_merkle_before.json`
- `...\audit\raw_topology_before.json`
- `...\audit\raw_content_manifest_after.csv`
- `...\audit\raw_content_merkle_after.json`
- `...\audit\raw_topology_after.json`
- `...\audit\image_inventory.csv`
- `...\audit\image_quality_summary.json`
- `...\audit\exact_duplicate_groups.csv`
- `...\audit\hash_signature_members.csv`
- `...\audit\perceptual_candidate_blocks.csv`
- `...\audit\cross_role_duplicate_report.json`
- `...\audit\data_issues.csv`

### Modify

- Phase 01 config/contracts/CLI files only to register verified audit settings and stage.

### Delete

- None. Temporary files are replaced atomically and cleaned after success/failure.

## Implementation steps

1. Enumerate every entry recursively without following reparse points. Record role, relative path, entry kind, normalized extension, size, mandatory Windows volume/file identity, link count, reparse tag/target and SHA-256 for every regular file, including both CSVs, JPGs and `.DS_Store`. If identity/link APIs fail, or any reparse entry exists, classify the issue and fail publication.
2. Canonically hash sorted `{role,relative_path,entry_kind,size,sha256_or_link_payload}` rows into a portable content root. Separately canonicalize hard-link equivalence classes from sorted member paths plus reparse topology into a topology digest; reject any link count larger than the in-root equivalence class because an external alias could mutate raw bytes. Require both before/after roots equal. Timestamps remain diagnostics only.
3. Reconcile CSV IDs and filename stems using `(role,id)` before pixel work; emit missing/extra/non-numeric/duplicate/leading-zero/case/nested/link issues and require every discovered entry to have a disposition.
4. For each JPG, open once into a bounded byte snapshot, compute `snapshot_sha256`, and run Pillow `verify` plus reopen/`load` from independent `BytesIO` views of those exact bytes. Require pre/post handle identity/size/mtime equality and, per `(role,relative_path)`, assert `before_manifest_sha256 == snapshot_sha256 == after_manifest_sha256`; endpoint restoration cannot hide different decoded bytes.
5. Under explicit byte/pixel/decompression limits, record declared format/mode/size/EXIF orientation. Freeze `visual-family-v1` pixels as: decode snapshot -> EXIF transpose -> Pillow `L` -> `Resampling.LANCZOS`; use 9x8 for dHash, 8x8 for aHash and 32x32 uint8 extrema. Define `near_constant = (int(max)-int(min) < 8)`, and include it in the signature key. Record sanitized exceptions and continue.
6. Sort scan results by role, numeric ID and normalized relative path before writing, regardless of filesystem or worker completion order.
7. Group exact hashes with IDs derived from SHA-256. Form exact `(dhash64,ahash64,aspect_milli,near_constant)` buckets, index sorted unique hashes, and emit canonical unordered block edges with distances/aspect values and sorted membership IDs. Never expand a block edge to image-pair rows in persisted artifacts.
8. Summarize dimensions, aspect ratios, modes, formats, corrupt/truncated/near-constant counts and cross-role overlap flags. Label agreement is joined later and never changes candidate recall.
9. Repeat the complete entry/content/topology manifests after all scanning; require identical canonical rows/roots and the per-file before/snapshot/after SHA equality before writing `AUDIT_COMPLETE.json` inside the unready transaction draft. Phase 02 never creates top-level `READY` or updates `current.json`.
10. Run a deterministic artifact check with shuffled enumeration and worker counts on fixtures; reserve a second full raw scan for final independent verification in Phase 06.

## Todo list

- [ ] Implement exhaustive image scanner.
- [ ] Implement exact/perceptual hashing.
- [ ] Reconcile all CSV IDs and files.
- [ ] Produce duplicate/quality artifacts.
- [ ] Classify every raw directory entry and verify content plus topology equality before/after.
- [ ] Verify deterministic rerun and bounded-memory behavior.

## Success criteria and evidence

- Inventory reconciles to the currently observed 44,441 candidate JPG files (38,612 train and 5,829 official test); the usable/decode-ok count is not assumed and every invalid/corrupt discovery remains fully classified.
- Every record has either complete decode fields or an explicit failure issue; counts reconcile exactly.
- The known five missing train IDs appear in issues, `.DS_Store` is classified as ignored non-image input, and there are no unclassified entries.
- Exact groups and `(dhash,ahash,aspect_milli,near_constant)` blocks have deterministic IDs, complete implied-radius recall and no persisted Cartesian expansion; luma ranges 7/8 prove the threshold boundary.
- Every cross-role exact/accepted-near family receives evidence for Phase 04; it is never silently retained in labeled training.
- Every image's before-manifest, decoded-snapshot and after-manifest SHA-256 values are equal; content roots/topology digests cover bytes, hard-link equivalence and classified/rejected reparse entries.
- Peak process memory remains bounded by worker count rather than dataset size.

## Risks, security and performance

- **Decoder security:** malformed images can exercise parser bugs. Mitigation: current Pillow, size limits, no external command execution, controlled exception handling.
- **False near matches:** dHash is not identity. Mitigation: candidate-only status, Hamming evidence and later policy/adjudication.
- **Performance:** full decode/hash is I/O/CPU intensive. Mitigation: bounded byte snapshots/workers, streaming results, compressed signature edges and indexed-radius completeness tests; no unsafe partial cache in version 1.
- **Privacy/licence:** do not publish thumbnails or hashes outside assignment scope; artifacts remain local.

## Next steps

Phase 03 consumes only the completed inventory and issues; it must not assume all images are valid until audit evidence says so.
