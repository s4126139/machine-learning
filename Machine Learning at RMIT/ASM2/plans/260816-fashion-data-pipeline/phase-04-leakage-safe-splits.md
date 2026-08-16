# Phase 04 - Create leakage-safe rare-class-aware splits

## Context links

- [Plan](./plan.md)
- [Workflow research](./reports/workflow-research.md)
- [Lifecycle Phase 04](../../../../Machine%20Learning%20tổng/machine_learning_lifecycle_phases/04_data_splitting.md)
- [Computer Vision overlay](../../../../Machine%20Learning%20tổng/machine_learning_specialisations/data_modalities_and_structures/computer_vision.md)
- [Retrieval overlay](../../../../Machine%20Learning%20tổng/machine_learning_specialisations/task_families/recommendation_ranking_and_retrieval.md)

## Overview

- Priority: P1
- Status: Pending
- Effort: 8h
- Dependency: Phase 03
- Goal: reserve deterministic labeled `train`, `validation` and sealed `holdout` partitions, quarantine cross-role/conflicting families, and publish a Top-K retrieval protocol without leakage.

## Requirements

### Functional

- Use canonical image-backed train rows only; keep official-test rows in a separate locked `prediction` partition.
- Build visual families from exact SHA equality and accepted perceptual links without consulting labels. Record promotion evidence independently from supervised-label agreement.
- For every exact or accepted-near family spanning train and official test, retain all 5,829 official IDs but quarantine the train-side family from supervised splits, retrieval galleries and fitted statistics.
- If one visual family contains conflicting valid labels for a target, set that family's eligibility false for that target rather than splitting it, weakening containment or changing the source label map.
- Treat normalized repeated product names as a soft leakage diagnostic, never a blanket grouping key.
- Default ratios use integer basis points `7000/1500/1500`; each must be `0..10000`, total exactly 10,000, and train/validation/holdout are all required nonzero for this assignment.
- Publish one global disposition/partition plus four independent `eligible_<target>` and `reason_<target>` pairs; reconcile support separately for every target.
- Subject to the hard constraints below, optimize marginal distributions for `articleType`, `gender`, `season` and `usage` using only target-eligible labels.
- Keep every visual family wholly in one labeled partition.
- Save explicit IDs/group IDs/seed/algorithm version; never reconstruct partitions from seed alone.
- Keep holdout labels sealed from model selection, EDA decisions and normalization fitting.
- Modelling-facing support/count artifacts may show train/validation values only; holdout evidence outside the sealed answer key is limited to aggregate pass/fail commitments and digests, never class counts, labels or per-query scorable status.
- `split_manifest.csv` is label-free for every role. Train/validation targets are separate model-facing files; all four holdout targets/masks live only in a sealed answer key plus commitment and are accessible solely through the receipt-gated final evaluator.
- “Sealed” is an enforced API/workflow boundary, not encryption or OS access control: direct filesystem access or joining the supplied raw CSV can bypass it. README/model-evaluation procedures must honor the gate and disclose this limitation.
- Publish explicit query/gallery roles for validation, sealed holdout evaluation and unscored official-test demonstrations.

### Frozen accepted-near predicate

- All three pixel views come from the audited byte snapshot: decode -> EXIF transpose -> Pillow `L` -> locked `Resampling.LANCZOS`. dHash is 9x8, row-major MSB-first, bit `1` iff right > left. aHash is 8x8, row-major MSB-first, bit `1` iff `64*pixel >= sum(all_64_pixels)`. Near-constant uses 32x32 uint8 pixels and `int(max)-int(min) < 8`.
- The compressed key is exactly `(dhash64,ahash64,aspect_milli,near_constant)`. Exact SHA-256 equality is always an edge; non-exact edges touching `near_constant=true` are rejected. Otherwise accept iff all inclusive conditions hold: `dhash_hamming <= 2`, `ahash_hamming <= 4`, and `abs(aspect_milli_left-aspect_milli_right) <= 20`.
- `aspect_milli` uses post-EXIF dimensions and integer half-up rounding: `(2000 * width + height) // (2 * height)`. Hash resize/resampling/bit order are serialized in config with policy version `visual-family-v1`; floating comparisons are forbidden.
- Every member of an accepted compressed block is connected, and a visual family is the full undirected transitive closure of exact/accepted edges. Equality/just-outside tests include luma ranges 7/8 plus hash/aspect boundaries and chained `A-B-C` cases.

### Rare-class policy

Class eligibility is based on eligible independent visual-family count after cross-role/conflict quarantine, not raw row count. These are hard placement constraints, evaluated in this lexicographic order before any balancing objective:

1. Raw/decode eligibility plus cross-role and label-conflict quarantine.
2. Whole visual-family containment.
3. Every source class with pre-quarantine image-backed support has a named `train_presence` constraint, even if quarantine leaves it with zero variables; only the feasibility solver may classify that contradiction. Source classes already lacking any usable image remain explicitly unsupported rather than silently removed.
4. Coverage by family count according to the table below.
5. Partition-size tolerance.
6. Four-target marginal-distribution quality.

| Independent groups | Required placement | Evaluation disclosure |
|---|---|---|
| 3 or more | At least one group in train, validation and holdout | Eligible for all-partition metrics |
| 2 | One group in train and one in holdout | No validation claim for the class |
| 1 | Train only | Unsupported for independent class evaluation |

Missing-label rows remain available for targets whose labels are valid. `usage=Home` is expected train-only. Let `N` be globally eligible rows. Before solving, fail as `no_global_data` when `N=0`, as `no_supervised_signal:<target>` when any of the four required targets has zero eligible rows, or as `insufficient_partition_families` when fewer than three globally eligible visual families make the required nonzero train/validation/holdout split impossible. A class represented by one eligible family is still forced to train by the rare rule, while other families must populate validation and holdout. Otherwise take the largest globally eligible solver family only (never quarantined rows) and `tolerance_rows=max(largest_family_rows,ceil(N/100))`. Enforce `abs(10000*n_p-ratio_bp[p]*N)<=10000*tolerance_rows` together with the explicit nonzero-partition constraints.

Use installed SciPy 1.17.1 `scipy.optimize.milp`/bundled HiGHS with stable matrix order and frozen options: `presolve=true`, `threads=1`, `parallel=off`, `random_seed=2753`, main `node_limit=5_000_000`, no wall-clock limit. Status `0` is accepted only after exact-integer validation; `2` is infeasible; `1/3/4` or exceptions are inconclusive/model errors. For status `2`, first deletion-filter coarse target/constraint-type batches, then retained named rows, with `witness_node_limit=250_000` and at most 256 lexicographic subsolves. Any limited/error subsolve invalidates the witness and yields inconclusive failure.

## Architecture and data flow

```text
clean train manifest + exact groups + accepted near links
  -> label-independent visual families
  -> global disposition + four target eligibility contracts
  -> deterministic SciPy MILP feasibility + named constraints
  -> hard-valid assignment -> deterministic marginal improvement
  -> split + evaluation/final retrieval contracts + evidence

official-test inference index ----------------------------> retained prediction rows
```

MILP variables/rows are created in stable family/target/class order with integer coefficients, pinned SciPy 1.17.1/HiGHS provenance and deterministic node budget. A feasible assignment is rounded only after integrality-tolerance validation, then checked independently with exact Python integers. Later deterministic moves must preserve every hard rule; failure to improve is not infeasibility. Python's randomized `hash()` and filesystem order are forbidden.

## Related code files

### Create

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\duplicate_groups.py` - deterministic union-find and promotion policy.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\splitting.py` - SciPy MILP model, contradiction witness and deterministic marginal improvement.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\split_validation.py` - disjointness, coverage and leakage assertions.
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\src\fashion_data\evaluation_gate.py` - sealed supervised/retrieval evaluators, receipt validation and later final-gallery materializer.

### Generate

- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\artifacts\data_preparation\splits\split_manifest.csv`
- `...\splits\duplicate_family_manifest.csv`
- `...\splits\split_summary.json`
- `...\splits\train_validation_target_counts.csv`
- `...\splits\target_model_support.csv`
- `...\splits\model_label_contract.json`
- `...\splits\rare_class_policy.csv`
- `...\splits\leakage_report.json`
- `...\splits\split_digest.json`
- `...\splits\solver_receipt.json`
- `...\splits\infeasible_constraint_set.json` - failure-only deletion-filter witness; absent for inconclusive/model-error statuses.
- `...\splits\quarantine_manifest.csv`
- `...\splits\cross_role_disposition.csv`
- `...\supervised\train_targets.csv`
- `...\supervised\validation_targets.csv`
- `...\sealed\holdout_targets.csv`
- `...\sealed\holdout_targets_commitment.json`
- `...\retrieval\training_queries_train.csv`
- `...\retrieval\training_pair_policy.json`
- `...\retrieval\gallery_eval_train.csv`
- `...\retrieval\queries_validation.csv`
- `...\retrieval\validation_relevance.csv`
- `...\retrieval\queries_holdout_sealed.csv`
- `...\sealed\holdout_retrieval_answer_key.csv`
- `...\sealed\holdout_answer_commitment.json`
- `...\retrieval\final_gallery_contract.json` - selection/schema contract only; no holdout-bearing membership is materialized now.
- `...\retrieval\queries_official_demo.csv`
- `...\retrieval\retrieval_protocol.json`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\schemas\model_lock_receipt_v1.json`
- `C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at RMIT\ASM2\schemas\final_evaluation_receipt_v1.json`

### Modify

- Phase 01 config/CLI/pipeline to register ratios, exact near policy, deterministic MILP node budget, hard tolerance and split stage.
- Phase 03 canonical manifest loader to expose immutable target masks/group inputs.

### Delete

- None.

## Implementation steps

1. Create exact-image components from Phase 02 SHA groups/singletons. Apply the fully serialized `visual-family-v1` predicate to compressed signature edges and persist every accepted/rejected boundary reason.
2. Compute deterministic undirected transitive closure over accepted edges. Test threshold equality, just-outside cases and chains where `A-C` is outside threshold but connected through `B`; labels never influence family identity.
3. Assign every canonical train row one `global_disposition`: `eligible` or an explicit global quarantine reason. Quarantine the train side of every cross-role family from all model-facing training/gallery/statistics use while retaining all official IDs.
4. Add four orthogonal eligibility/reason pairs. Missing/invalid labels and per-target family conflicts disable only that target; they do not change global disposition, common partition, other targets or immutable source indices. Publish per-target/class pre/post support.
5. Produce the repeated-product-name diagnostic only. Compute target-eligible independent-family counts and hard placement rows: `>=3` train/validation/holdout; `2` train/holdout; `1` train.
6. Build the deterministic binary MILP with one partition assignment per globally eligible family, whole-family assignment, named class-coverage rows (including zero-variable contradictions) and exact integer size bounds. Persist matrix/config/runtime digests, node budget and raw solver status. Status `2` triggers the deterministic deletion-filter contradiction witness; limit/unbounded/model-error outcomes remain inconclusive failures.
7. Starting from a hard-valid solver assignment, perform lexicographically ordered deterministic improvement of integer row-size deviation then summed integer class-ratio deviation, accepting only moves that preserve all constraints. Persist start/final objective components, solver/version/seed and assignment digest; always re-run the independent hard validator and make no unsupported global-optimum claim.
8. Write a label-free split manifest for train/validation/holdout/prediction and retain all 5,829 official IDs. Write target-eligible train/validation answer files separately and a sealed four-target holdout key/commitment. The default API cannot join internal canonical labels to holdout IDs. Write `SPLIT_COMPLETE.json` only after checks; never create top-level `READY`.
9. Create retrieval contracts using only `eligible_articleType=true`: train queries/gallery and validation queries/relevance are model-facing; holdout queries are label-free and their relevance/scorable status stays sealed. Positives share article type across different families, negatives differ, metrics count unique families, and configured K values cover `precision@K`, `recall@K`, `mAP@K`.
10. Freeze receipt schemas. `model-lock-v1` binds model/config/code/split/training-ID/validation-selection digests and declares holdout unopened; `final-evaluation-v1` binds it plus evaluator/split and aggregate metric digests. Normal preparation emits only `final_gallery_contract.json`. Later, only `all --mode final-gallery --model-lock-receipt ... --final-evaluation-receipt ...` may create the approximately 38k membership as a derived verified generation through the same publisher transaction. Official-demo queries retain all official IDs.

## Todo list

- [ ] Build deterministic duplicate families.
- [ ] Implement and evidence near-duplicate promotion policy.
- [ ] Implement rare-class placement constraints.
- [ ] Implement deterministic SciPy MILP feasibility, contradiction witness and hard-valid improvement.
- [ ] Generate split/coverage/leakage artifacts.
- [ ] Generate label-separated supervised/retrieval evaluation keys and receipt-gated final-gallery contract.
- [ ] Prove disjointness, completeness and deterministic rerun.

## Success criteria and evidence

- Every canonical train ID has one global disposition and, if globally eligible, one common partition plus four target eligibility/reason pairs; the split manifest contains no labels. Train/validation/sealed-holdout targets reconcile independently, and every official ID appears once as prediction.
- Pairwise intersections of labeled IDs are empty.
- No visual family spans labeled partitions or intersects supervised train and official test.
- Official-test rows never influence label balance, target maps or fitted statistics.
- Every eligible class satisfies the hard placement table. Only MILP status `2` plus a successfully reproduced named contradiction set is an infeasibility claim; every other non-success status is inconclusive/model error and cannot publish.
- Achieved partition sizes are within the configured hard tolerance; otherwise the generation fails with a constraint witness rather than documenting a silent relaxation.
- Same inputs/config produce the same split digest.
- Retrieval evidence proves `eligible_articleType` training/evaluation rules and self/family exclusion. Holdout labels/status are unavailable to normal loaders. No final membership exists before valid receipts; afterward only `all --mode final-gallery` can publish the all-globally-eligible gallery.

## Risks, security and performance

- **Rare classes:** full stratification is impossible for singletons. Mitigation: explicit policy, train-only retention and honest metric support.
- **False grouping:** perceptual similarity is not identity. Mitigation: conservative versioned visual policy and evidence; labels do not decide family existence and repeated names remain diagnostic.
- **Leakage:** exact groups crossing partitions inflate metrics. Mitigation: union-find hard groups plus mandatory post-split audit.
- **Test contamination:** the official test may be inspected only for integrity/overlap, never labels or selection metrics.
- **Performance:** SciPy MILP operates on family/summary constraints using a deterministic node budget rather than elapsed time. Limit/error status halts but can never justify relaxed constraints or an infeasibility claim.

## Next steps

Phase 05 must read the persisted split manifest and may fit statistics only where `partition == train`.
