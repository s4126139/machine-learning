# Phase 01 - Scaffold contracts and locked runtime

## Context links

- [Plan](./plan.md)
- [Assignment requirements](./reports/assignment-requirements.md)
- [Dataset scout](./reports/dataset-scout.md)
- [Lifecycle Phase 02](../../../../Machine%20Learning%20tổng/machine_learning_lifecycle_phases/02_data_collection_and_governance.md)

## Overview

- Priority: P1
- Status: Pending
- Effort: 4h
- Goal: establish a self-contained ASM2 Python project, exact available-runtime lock, immutable path contract and generation-level atomic publishing without touching the dirty parent project.

## Requirements

### Functional

- Resolve raw train CSV/images and official prediction CSV/images from one checked config.
- Define exact required/allowed columns, four targets and prediction column order.
- Expose one production publisher, `all`, with normal preparation and later receipt-gated `--mode final-gallery`; `audit`, `metadata`, `split` and `artifacts` are diagnostic-only and never update `current.json` or create top-level `READY`.
- Each diagnostic stage either reruns all prerequisites inside its own diagnostic root or accepts explicit `--from-receipt` paths whose schema plus raw/config/code/runtime/input digests validate; implicit mixing with `current.json` is forbidden.
- `verify` is read-only for an already published current generation. The `all` orchestrator alone may call an internal `verify_draft(exact_generation_path, owner_token)` before publication.
- Create every output under fixed `ASM2/artifacts/data_preparation`, partitioned into `control`, `generations`, `diagnostics` and `verification_runs`; the raw root is never an output.
- Expose one package CLI (`python -m fashion_data`); do not duplicate stage logic in standalone scripts.
- Build Phases 02-05 plus the internal reproducibility proof in one unique `.building` transaction under one exclusive owner-token lock. After verification, write provenance, rename the frozen payload to its immutable generation path, create `READY` there atomically, then replace `current.json`.

### Non-functional

- Use available CPython 3.14.3 with exact `runtime_lock.json`: implementation/version/platform plus each distribution version and digest of sorted wheel `RECORD` entries `{relative_path,recorded_hash,size}` (excluding `.pyc` and `RECORD` self-row); startup/tests fail on drift.
- Deterministic seed `2753`, stable numeric-ID ordering and explicit config version.
- Never write beneath `A2_FashionDataset`, through a symlink/junction/reparse point, or outside the fixed ASM2 artifact base.
- Keep imports side-effect free and functions testable independently of CLI parsing.
- Reject overlap in both directions (`raw` contains `output` or `output` contains `raw`) and re-resolve every parent immediately before a write.

## Architecture and data flow

```text
config/data_pipeline.json
        |
        v
Config + PathContract -> Stage orchestrator -> locked staging generation
        |
        +-> reject raw/output overlap, reparse traversal and unsafe paths
        +-> Phase 02 -> 03 -> 04 -> 05 stage receipts
        +-> internal verify + fresh-process verification payload + compare
        +-> provenance -> immutable rename -> atomic READY -> current.json
```

The raw-root contract is resolved before any stage. Every planned output path must be a descendant of the fixed ASM2 artifact base, with raw/output ancestry checked both ways. A write rechecks resolved parents so a path cannot be swapped to a junction after startup. Normal consumers resolve `current.json` and require `READY`; only the lock-owning `all` process may pass exact unready paths plus its owner token to private verifier/reproducibility workers. A crash may leave an unready/ready orphan, but no incomplete or unverified generation can become current.

## Related code files

### Create

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\pyproject.toml` - isolated dependencies and package metadata.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\.python-version` - exact `3.14.3` interpreter selection.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\requirements.lock.txt` - exact currently available package versions for recreation.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\config\runtime_lock.json` - executable Python/package-version contract checked at startup.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\artifacts\data_preparation\control\preflight\protected_files_before.json` - durable pre-implementation protected-file baseline/control input.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\.gitignore` - raw corpus, virtualenv and transient cache protection.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\config\data_pipeline.json` - versioned paths, seed, split ratios and transform/audit settings.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\__init__.py` - package version.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\__main__.py` - module entry point.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\cli.py` - argument parsing/stage dispatch.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\config.py` - typed config loader and validation.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\contracts.py` - schemas, targets and invariants.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\io_utils.py` - canonical writers, stable digests, run lock and generation publisher.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\pipeline.py` - stage orchestration.

### Explicitly do not modify/delete

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\pyproject.toml`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\uv.lock`
- Any file under `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\A2_FashionDataset`

## Implementation steps

1. Before the first implementation mutation, SHA-256 the named protected parent `pyproject.toml`/`uv.lock`, assignment PDF/DOCX files and two raw CSVs. Persist canonical JSON with `schema_version`, sorted `{role,relative_path,size,sha256}` rows and `manifest_sha256` at `artifacts/data_preparation/control/preflight/protected_files_before.json`; `all` treats it as immutable control input and binds its digest into provenance. Phase 02 owns the exhaustive image/tree baseline.
2. Create an ASM2-local `pyproject.toml`, exact-version `requirements.lock.txt`, `.python-version=3.14.3` and `config/runtime_lock.json` matching the importable system runtime. Canonical wheel-`RECORD` digests distinguish same-version build drift without machine-specific paths/bytecode. Use SciPy/HiGHS already present; add no unavailable solver dependency.
3. Implement a runtime preflight that compares Python/platform, package versions, canonical `RECORD` digests and each declared installed-file hash before any data-side-effect import. `READY` requires its receipt; README provides recreation and drift-failure commands.
4. Add local ignore rules for `.venv`, caches, `.DS_Store`, `A2_FashionDataset/`, optional raw-image previews and artifact diagnostic/building/lock files. Do not ignore published audit/manifests/reports or the protected baseline.
5. Define `DataConfig` validation: absolute resolved raw root, fixed artifact base outside raw in both ancestry directions, no reparse traversal, integer split basis points each in `[0,10000]`, sum exactly 10,000 and all of train/validation/holdout strictly positive, plus positive worker/batch counts, complete near policy, hard tolerance and versioned seed.
6. Define constants for raw train columns, canonical columns, targets and exact official prediction columns.
7. Implement canonical writers in a unique `.building` generation: fixed schemas/column order/row sort keys, UTF-8 LF, explicit missing encoding, finite fixed-precision floats and sorted-key JSON. Every `STAGE_COMPLETE` receipt freezes `schema_version,stage,raw_content_root,raw_topology_root,config_digest,code_digest,runtime_lock_digest,parent_receipt_digests,output_digest`; `--from-receipt` recomputes and compares both live raw roots before validating the chain.
8. Acquire the publisher lock by atomic create and record owner UUID, PID, process creation time and host. Expose `lock-status` and `recover-stale-lock --expected-owner-token`; its exclusive recovery claim records claimant UUID/PID/process-creation/host, claim token and target-lock token. A stale claim is reclaimable only with its expected token after proving that exact same-host claimant dead; live/PID-reused, foreign-host or denied-inspection cases refuse. Recheck both claim/lock tokens before atomic removal and write a receipt. Test two recoverers, crashed recoverer, concurrent publisher and pointer atomicity.
9. Implement `all` as the sole transaction. Normal mode runs stages plus the owner-token reproducibility worker. Later `all --mode final-gallery` derives from a verified current generation, validates both receipt schemas/digests, adds gallery membership, privately verifies the derived payload, then uses the identical rename/`READY`/pointer transaction. Diagnostics bind prerequisite receipts; public `verify` is read-only.
10. Pin the production allowed root to ASM2; expose an injected allowed-root dependency only for isolated `tmp_path` tests. Add `--dry-run` plus smoke checks for importability, paths with spaces/Vietnamese text, overlap in either direction and parent reparse substitution.

## Todo list

- [ ] Create isolated project/runtime files.
- [ ] Implement config/path validation.
- [ ] Implement schema contracts and target definitions.
- [ ] Implement locked staging generations and deterministic writers.
- [ ] Implement sole-publisher transaction, diagnostic stages, read-only verify and dry-run.
- [ ] Capture named protected-file baseline before implementation mutation.

## Success criteria and evidence

- `python -m fashion_data runtime-check --lock config/runtime_lock.json` and `python -m pytest -q` succeed under the exact locked CPython 3.14.3 runtime.
- `python -m fashion_data all --config config/data_pipeline.json --runtime-lock config/runtime_lock.json --dry-run` lists only raw inputs and approved ASM2 outputs.
- A config placing output beneath raw is rejected before filesystem mutation.
- Pre/post SHA-256 evidence, not Git status alone, shows no edit to protected parent files; Phase 02 extends this proof to every raw entry.
- Unit smoke tests prove unverified payloads never receive `READY`, diagnostic/unready/ready-orphan generations never become current, concurrent publishers/recoverers cannot race, and stale locks require a proven-dead same-host owner plus matching token.

## Risks, security and performance

- **Runtime risk:** parent `.venv` is unusable and network is restricted. Mitigation: execute with the already available CPython 3.14.3/SciPy stack, enforce the exact ASM2 runtime lock, and document recreation separately.
- **Path risk:** accidental raw overwrite or junction escape. Mitigation: bidirectional ancestry checks, fixed artifact base, per-write parent resolution and read-only raw opens.
- **Data governance:** raw images are educational-use-only. Mitigation: local ignore rule and no upload/publish automation.
- **Performance:** no heavy scanning in this phase; configuration keeps worker count bounded for Phase 2.

## Next steps

Phase 02 may begin only after dry-run proves the input/output boundary and the package is importable.
