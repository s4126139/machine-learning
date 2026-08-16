# Dataset scout report

## Inventory

- `styles_train.csv`: 38,617 unique IDs.
- `images_train`: 38,612 JPGs plus one `.DS_Store`; five CSV IDs lack images.
- `styles_prediction.csv`: 5,829 unique IDs.
- `images_test`: 5,829 JPGs matching prediction IDs 1:1.
- No existing scripts, notebooks, configs or README inside the dataset.

## Confirmed data issues

- Missing train images: `12347`, `39401`, `39403`, `39410`, `39425`.
- The raw CSV has two trailing unnamed columns. Twenty-one product names spill into the first; IDs `23124` and `23127` spill into both.
- Exact spill-row IDs are `3413`, `3418`, `3428`, `4854`, `23100`, `23101`, `23103`, `23107`, `23108`, `23109`, `23110`, `23111`, `23112`, `23114`, `23115`, `23116`, `23117`, `23118`, `23124`, `23127`, `44065`.
- Missing values: `baseColour=14`, `season=20`, `usage=72`, `productDisplayName=7`.
- `gender` and `articleType` are complete before image reconciliation.
- The missing image for ID `12347` is the sole `Suits` row, reducing image-backed `articleType` classes from 125 to 124.
- Severe imbalance: examples include `usage=Home` with one row and multiple one-sample article types.
- 15,514 rows have repeated product display names across 4,447 repeated names. This is a leakage diagnostic, not proof that all equal names are the same item.

## Checks not yet proven

- Exhaustive decode/corruption status, actual dimensions, modes and JPEG format.
- Byte-identical and perceptually similar duplicate groups within and across supplied partitions.
- Image-level brightness/contrast anomalies and near-constant images.

These become mandatory Phase 2 outputs rather than assumptions.

The repair predicate is exact: rows with any non-empty trailing spill field. Each repaired name must equal the ordered non-empty source name segments joined by comma-space; a count-only assertion is insufficient.

## Repository constraints

- The repository worktree contains extensive unrelated user changes; ASM2 is currently untracked.
- Do not reset or modify unrelated paths.
- Parent `.venv` launch returned `Access denied`; do not rely on it.
- Parent `pyproject.toml` is already modified and lacks Pillow/pytest; avoid editing it by creating an isolated ASM2 project.
- System CPython 3.14.3 is usable and already imports NumPy 2.4.6, pandas 3.0.3, Pillow 12.2.0, SciPy 1.17.1, scikit-learn 1.9.0, matplotlib 3.11.0, seaborn 0.13.2 and pytest 9.0.3; lock and validate this available runtime instead of adding unavailable OR-Tools.
