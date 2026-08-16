# Workflow research summary

## Selected route

Use the shared ML lifecycle with the Computer Vision and retrieval concerns composed into data preparation:

1. Phase 02: source, permitted use, raw version and lineage.
2. Phase 03: schema, image integrity, EDA, missingness, labels and duplicate diagnostics.
3. Phase 04: independence unit, duplicate-aware labeled partitions and locked official test.
4. Phase 05: reproducible decode/resize/normalization/augmentation with train-only fitting.

Compose `machine_learning_specialisations/task_families/recommendation_ranking_and_retrieval.md` for Task 4 query/gallery roles, relevance semantics, self/family exclusion, open-set cases and later ranking metrics.

Primary references are under `Machine Learning tổng/machine_learning_lifecycle_phases/02-05` and `machine_learning_specialisations/data_modalities_and_structures/computer_vision.md`.

## Non-negotiable controls

- Split before learned preprocessing, augmentation, feature learning or model selection.
- Save explicit partition IDs; a seed alone is insufficient.
- Keep exact/near duplicate families within a single labeled partition.
- Validate decoder, dimensions, channels, orientation, file format and corrupt/truncated files.
- Fit normalization on training only; use deterministic validation/holdout/prediction transforms.
- Record each data issue, resolution, downstream impact and accepted limitation.
- Preserve raw bytes plus hard-link/reparse topology and generated-artifact provenance.
- Retain every official-test row; quarantine the train-side member of any accepted exact/near cross-role visual family before supervised splitting/statistics.

## Chosen implementation posture

- Manifest-first; images remain at their original paths and are decoded on demand.
- CSV/JSON/PNG artifacts only; no optional storage stack.
- Streaming/concurrent audit with bounded memory.
- SHA-256 establishes exact equality. Deterministic dHash/aHash indexes emit compressed signature-block edges; the fully serialized inclusive acceptance predicate and transitive closure define visual families without all-pairs expansion.
- Repeated product names remain a diagnostic unless image/record evidence justifies grouping.
- One global disposition/common split is orthogonal to four target eligibility/reason pairs; immutable source label indices never shrink after quarantine.
- Installed SciPy 1.17.1 MILP/HiGHS establishes hard rare-class/containment/size feasibility; status `2` is deletion-filtered into a reproducible named contradiction set, while limits/errors remain inconclusive.
- Retrieval preparation separates training-pair contracts, train-gallery/validation/sealed-holdout evaluation, and a gated all-eligible final gallery for official demos; same-`articleType` is only an offline relevance proxy, not human visual-similarity ground truth.
- `all` is one locked transaction; a private owner-token worker builds the fresh verification payload without a nested lock, diagnostics cannot publish, and `READY` appears only after comparison and immutable rename.
