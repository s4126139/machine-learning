# COSC2753 Assignment 1 - Run Guide

Student: Kai Nguyen  
Student ID: `s4126139`

This folder is self-contained. The notebook rebuilds every model from source,
validates the final selection, and creates or verifies the prediction CSV. No
pickled model or machine-specific path is required.

## Keep this folder layout

Do not rename or move individual files after extracting the ZIP:

```text
Submission/
|-- ASM1_master_notebook.ipynb
|-- train.csv
|-- test.csv
|-- s1234567_predictions.csv
|-- COSC2753_A1_Predictions_s4126139.csv
|-- README.md
`-- requirements.txt
```

`s1234567_predictions.csv` is the supplied immutable template. The notebook
never writes to it. Predictions are written to the separate student-named CSV.

## Environment setup

The verified environment uses Python `3.14.5`. Python `3.14` is recommended.

### Windows PowerShell

Open PowerShell in the extracted `Submission` folder, then run:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m ipykernel install --user --name cosc2753-a1 --display-name "COSC2753 A1"
python -m jupyter lab
```

### macOS or Linux

Open a terminal in the extracted `Submission` folder, then run:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m ipykernel install --user --name cosc2753-a1 --display-name "COSC2753 A1"
python -m jupyter lab
```

VS Code may be used instead of JupyterLab. Select the newly created
`COSC2753 A1` kernel before running the notebook.

## Reproduce the result

1. Keep the terminal or VS Code workspace in the extracted folder.
2. Open `ASM1_master_notebook.ipynb`.
3. Select the environment created from `requirements.txt`.
4. Restart the kernel to remove stale state.
5. Choose **Run All** and run every cell from top to bottom.
6. Confirm the final message is:

```text
PHASE 8 COMPLETE: notebook code and prediction CSV are ready.
```

The complete run takes approximately two minutes on the verified machine. The
exact runtime depends on CPU resources because grouped cross-validation and
hyperparameter tuning are executed from source.

## Expected output

The notebook creates or validates:

```text
COSC2753_A1_Predictions_s4126139.csv
```

The expected contract is:

- 867 prediction rows;
- ordered columns `ID,TARGET_Capacity`;
- unique IDs in the exact supplied template/test order;
- finite predictions;
- SHA-256
  `992c4cb35f16187e62cb8fd19752b60ae996b0b7b3e245e6afa27ac5efbaad8c`.

If the prediction file already exists and is byte-identical, the notebook
verifies it without rewriting it. If it is absent, the notebook creates and
round-trip validates it. If a different file exists under the same name, the
notebook stops deliberately rather than overwriting unknown work.

The immutable template SHA-256 is
`84f16dc7d74757c2e4d74902ebabd5bc2ac5976d76b42404bdf293f84245e0e4`.

## ZIP submission

Do not include `.venv`, `.ipynb_checkpoints`, `__pycache__`, or temporary
`.pending.csv` files. Compress the seven files listed above and name the code
archive according to the assignment convention, for example:

```text
COSC2753_A1_s4126139.zip
```

The prediction CSV is also submitted separately through the Canvas prediction
submission page.

## Data-use boundary

The supplied dataset is restricted to this course assignment. Do not
redistribute it or use it outside the permitted assessment context.
