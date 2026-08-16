---
title: "Fashion Data Preparation Pipeline"
description: "Build an immutable, audited, leakage-safe and reproducible data pipeline for all four COSC2753 Fashion Intelligence tasks."
status: pending
priority: P1
effort: 32h
issue: null
branch: main
tags: [feature, data, computer-vision, reproducibility]
created: 2026-08-16
---

# Fashion Data Preparation Pipeline

## Overview

Prepare the supplied fashion image corpus for article type, season, gender/usage classification and visual retrieval without mutating or copying the raw 0.53 GiB dataset. Produce versioned CSV/JSON/PNG evidence, deterministic split manifests and reusable train/evaluation transforms.

## Scope and invariants

- Raw `A2_FashionDataset` is read-only; content and filesystem-topology digests over every entry must match before/after.
- Official 5,829-image test set stays locked and unlabeled; only its IDs/schema/integrity are validated.
- Missing target labels are masked, never inferred or imputed.
- Exact/accepted-near visual families cannot cross labeled partitions; train-side members overlapping official test are quarantined.
- Normalization is fitted only on globally eligible images assigned to `partition=train`; target-label presence is irrelevant, and validation/holdout/prediction images are excluded.
- Only `all` publishes. Normal data preparation and later `all --mode final-gallery` both use the same lock, private verification, immutable rename, atomic `READY` and current-pointer switch.
- Outputs are canonical, idempotent and reproducible under the locked Windows/Python environment and seed `2753`.
- No pretrained model, model training, UI, report authoring, Parquet/PyArrow or copied processed-image corpus.

## Phases

| # | Phase | Status | Effort | Link |
|---|---|---|---|---|
| 1 | Scaffold contracts and runtime | Pending | 4h | [phase-01](./phase-01-scaffold-contracts.md) |
| 2 | Audit every image and duplicate signal | Pending | 6h | [phase-02](./phase-02-image-integrity-audit.md) |
| 3 | Repair metadata and build canonical manifests | Pending | 4h | [phase-03](./phase-03-canonical-manifests.md) |
| 4 | Create leakage-safe rare-class-aware splits/retrieval indexes | Pending | 8h | [phase-04](./phase-04-leakage-safe-splits.md) |
| 5 | Build transforms, train-only statistics and modelling-safe EDA | Pending | 5h | [phase-05](./phase-05-transforms-statistics-eda.md) |
| 6 | Verify full pipeline and document handoff | Pending | 5h | [phase-06](./phase-06-verification-documentation.md) |

## Sequential dependency graph

`Phase 1 -> Phase 2 -> Phase 3 -> Phase 4 -> Phase 5 -> Phase 6`

## Planned architecture

`raw files -> content audit -> canonical manifests -> visual families/quarantine -> supervised + retrieval indexes -> transforms/statistics/train-only EDA -> verification bundle`

One `fashion_data` package/CLI owns all contracts. `all` builds Phases 02-05, privately rebuilds a non-publishing verification payload under the same owner token, compares canonical evidence, freezes/renames the primary, then creates `READY` and swaps `current.json`. Diagnostics cannot publish.

## Evidence required for completion

- Exhaustive inventory classifies every raw directory entry and covers 38,612 train JPGs plus 5,829 official-test JPGs.
- Five missing train image IDs and all malformed/missing metadata are represented in the issue log.
- Canonical train maximum is 38,612 rows; a global disposition plus four orthogonal target-eligibility/reason pairs reconcile usable counts separately for each task without shrinking source taxonomies.
- Partition/visual-family intersections are empty; hard class-coverage rules pass or the stage fails without publishing `READY`.
- Original prediction template remains unchanged; internal inference index carries paths separately; submission validator enforces `id,gender,articleType,season,usage`.
- Label-free split/query files are separated from train/validation answers and sealed four-target/retrieval holdout keys; final-gallery membership is materialized only in a later receipt-bound generation.
- Full tests pass under one locked runtime across fresh Windows processes/worker counts, and raw content plus topology digests are unchanged.

## Research context

- [Assignment requirements](./reports/assignment-requirements.md)
- [Dataset scout](./reports/dataset-scout.md)
- [Workflow research](./reports/workflow-research.md)

## Risks held for implementation review

- Perceptual-hash neighbors are visual-family candidates; accepted families are contained regardless of label agreement, while conflicts are quarantined from supervised learning.
- Classes with fewer than three eligible independent visual families follow one policy; installed SciPy MILP either yields an independently validated assignment, a reproducible named contradiction set, or an inconclusive failure without publication.
- Parent `.venv` currently fails to launch; use the isolated ASM2 runtime defined in Phase 1.
