# Phase 06 - Verify full pipeline and document handoff

## Context links

- [Plan](./plan.md)
- [Assignment requirements](./reports/assignment-requirements.md)
- [Lifecycle Phase 12](../../../../Machine%20Learning%20tổng/machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)

## Overview

- Priority: P1
- Status: Pending
- Effort: 5h
- Dependency: Phase 05
- Goal: prove each explicit data requirement with automated tests and a clean full-dataset run, then document exact commands/outputs for the group and assessor.

## Requirements

### Test coverage

- Unit tests: config/path isolation, raw schema, CSV repair, target masks/maps, SHA/dHash, duplicate grouping, split constraints, transforms, statistics and atomic writers.
- Integration tests: synthetic train/test fixture with corrupt/missing/exact/near duplicates, comma-spilled names, missing targets and rare classes.
- Full-data verification: all entry dispositions, raw-content Merkle equality, schema, quarantine/split/retrieval invariants, train-only statistics provenance and canonical deterministic rerun.
- Fixtures must be generated programmatically in pytest temp directories; do not copy restricted assignment images into tests.
- Determinism tests run fresh processes with shuffled input enumeration, worker counts `1` and `N`, Windows `spawn`, and paths containing spaces plus Vietnamese characters.

### Documentation

- README with supported Python, isolated setup, raw folder placement, dry-run/full-run commands, outputs and troubleshooting.
- Data-preparation guide with artifact schemas, split/rare-class/duplicate policies and downstream usage for four tasks.
- Final dataset card with permitted use and known limitations.
- Verification report mapping each assignment/data requirement to command and evidence path.

## Architecture and verification flow

```text
unit tests + synthetic integration fixture
                  |
                  v
`fashion_data all` owns exact `.building` generation
                  |
                  +-> Phases 02-05 stage receipts
                  +-> internal verify_draft(path, owner_token)
                  +-> fresh private verification worker(path, owner_token)
                  +-> compare + retained reproducibility receipt/payload
                  +-> final verify + provenance + immutable rename
                  +-> atomic READY -> atomic current.json
                  v
public `fashion_data verify` rechecks current READY read-only
```

Volatile duration/environment fields are stored separately from deterministic content so reproducibility comparison remains meaningful.

## Related code files

### Create

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\tests\conftest.py`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\tests\test_config_contracts.py`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\tests\test_image_audit_hashing.py`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\tests\test_metadata_manifests.py`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\tests\test_duplicate_groups_splits.py`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\tests\test_evaluation_gate.py`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\tests\test_transforms_statistics.py`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\tests\test_pipeline_integration.py`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\README.md`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\docs\data-preparation.md`

### Finalize/generated

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\artifacts\data_preparation\DATASET_CARD.md`
- `...\verification\verification_report.json`
- `...\verification\artifact_digests.json`
- `...\verification\runtime_environment.json`
- `...\verification\performance.json`
- `...\verification\raw_content_merkle_after.json`
- `...\verification\raw_topology_after.json`
- `...\verification\reproducibility_receipt.json`
- `...\verification_runs\<digest>\` - retained non-current verification payload and stage receipts; never `READY`.

### Modify

- Implementation files from Phases 01-05 only for defects exposed by tests.

### Delete

- None. The compact verification payload is retained by digest so the reproducibility receipt never points to deleted evidence.

## Implementation steps

1. Build synthetic images/CSVs in `tmp_path` covering RGB/grayscale/EXIF, corrupt JPG, exact hashes, luma ranges 7/8, hash/aspect boundaries/chains, cross-role/conflicting labels, hard links/reparse/nested/case/leading-zero entries, comma spills, label-free split/sealed keys and satisfiable/infeasible/limit solver cases.
2. Test pure functions plus transactions. Candidate-block implied edges equal brute force without Cartesian output. SciPy MILP status `0` passes only independent integer validation; `2` requires a reproducible deletion-filter contradiction set; `1/3/4` fail inconclusively. Unverified/unready/orphan generations never become current.
3. Add fresh-process integration tests for `all`, read-only `verify`, diagnostic prerequisite receipts, two publishers, two stale-lock recoverers and atomic pointer switching. Shuffle enumeration and compare workers `1`/`N` under Windows `spawn`, the exact runtime lock and paths with spaces/Vietnamese characters.
4. Map each invariant to one executable check: `check_runtime_lock`, `check_protected_baseline`, `check_raw_content_merkle`, `check_snapshot_sha_binding`, `check_raw_topology`, `check_all_entries_classified`, `check_metadata_repair_exact`, `check_metadata_issue_rows`, `check_source_taxonomy_immutable`, `check_target_masks_taxonomy`, `check_global_target_dispositions`, `check_cross_role_quarantine`, `check_visual_family_predicate`, `check_visual_family_disjointness`, `check_solver_receipt`, `check_hard_class_coverage`, `check_submission_schema`, `check_supervised_holdout_sealed`, `check_retrieval_protocol`, `check_receipt_gates`, `check_train_stats_observed_ids`, `check_generation_transaction`, and `check_canonical_determinism_windows`.
5. Run `python -m fashion_data runtime-check --lock config/runtime_lock.json`, format/static checks and `python -m pytest -q`; an autouse test also enforces the runtime lock and no core check may skip. Run one outer `all` on supplied data under its exclusive lock.
6. Inside that owner process, spawn private fresh-process `build_verification_generation(exact_path,owner_token)`. It validates the live lock/token, never acquires another lock, never creates `READY`/changes current, rebuilds Phases 02-05 and writes a completion receipt. The parent requires byte equality for canonical CSV/JSON/Markdown, including each canonical plot source/specification manifest. PNGs are presentation artifacts: independently require successful decode, declared dimensions/mode, absence of volatile metadata and a valid binding to the canonical plot manifest, but exclude encoded bytes and decoded pixels from cross-process equality. Copy the full canonical comparison plus PNG-validation mapping into the primary receipt and retain the verification payload by digest.
7. Re-enumerate and SHA-256 every raw regular file after all phases; rebuild content and hard-link/reparse topology roots and require equality with Phase 02. Independently require the raw prediction-template and named Phase 01 protected-file SHA-256 values unchanged.
8. Verify supervised and retrieval holdout sealing without emitting labels/counts/scorable status: split/query manifests are label-free, both answer-key commitments match, default APIs cannot load keys, and receipt-schema negative tests reject missing/mismatched model-lock/final-evaluation evidence. Confirm final-gallery membership is not materialized in this generation.
9. Record exact Python/lock/package/OS versions and stage durations separately from deterministic content. Write Windows-safe README guidance for production, diagnostic stages, artifact schemas, target eligibility, training/evaluation/final retrieval roles and troubleshooting.
10. Finalize the dataset card and requirement report, re-run the exact-draft verifier including reproducibility evidence, write provenance, rename the frozen payload, create `READY` atomically and only then switch `current.json`. Retain the digest-addressed verification payload.

## Todo list

- [ ] Create synthetic fixtures and unit tests.
- [ ] Create end-to-end integration test.
- [ ] Pass all static/test checks.
- [ ] Complete and verify full-dataset run.
- [ ] Prove deterministic second run.
- [ ] Prove raw and prediction template unchanged.
- [ ] Exercise every named invariant, MILP status/witness, transaction race, supervised/retrieval gate and Windows determinism matrix.
- [ ] Finalize README, guide, dataset card and verification report.

## Success criteria and evidence

- Test suite reports 100% pass; no skipped core invariants.
- Full inventory/manifests reconcile to current raw evidence and all critical issues have explicit status.
- `verification_report.json` maps every named check to pass/fail evidence and proves content/topology immutability; complete classification; row-level repairs/issues; immutable source maps plus target eligibility; exact submission schema; cross-role quarantine; frozen visual-family predicate/containment; exact solver status/hard coverage; evaluation/final retrieval gates; holdout sealing; observed-ID train statistics; and Windows-stable canonical output.
- README commands work from a clean ASM2-local environment without the parent `.venv`.
- No raw image, model, secret, credential or external upload is added.
- Documentation states educational-use restriction and limitations for rare/unsupported classes and near-duplicate decisions.

## Risks, security and performance

- **False green tests:** synthetic tests alone are insufficient. Mitigation: mandatory full-data verifier with requirement mapping.
- **Nondeterministic PNG rendering:** make source tables and plot specifications canonical and cross-process byte-equal; bind every PNG to those inputs plus backend/font/version metadata, validate decode/dimensions/mode and reject volatile metadata, while deliberately excluding PNG bytes/pixels from the reproducibility equality claim.
- **Dirty worktree:** verification and documentation are scoped to ASM2; never reset or stage unrelated files.
- **Reproducibility:** exact CPython 3.14.3 plus `runtime_lock.json`/`requirements.lock.txt` are mandatory for `READY`; record their digests and imported package versions.
- **Data exposure:** no upload, telemetry or public artifact publishing.

## Next steps

After this phase, Cook testing and code-review subagents must independently validate results before plan sync-back/finalization. Model development can then consume the immutable split/transform contracts without reopening data decisions.
