# Machine Learning at RMIT — local study materials

The weekly folders contain notes, lecture files, datasets, and notebooks.
Start with the [course-material manifest](canvas_materials_manifest.md) for the
week map, the local file inventory, and the slide placeholders recorded on
2026-09-24. It retains source item IDs for provenance but omits direct Canvas
links because they require course access.

The week notes link to files stored in this repository. Earlier notebook or
data copies that differ from the captured course files have a `.local` suffix.
The original notebooks were written for mixed local and Colab environments;
the primary W2–W4, W6, W8, and W9 labs now use local dataset paths. Their
saved outputs are historical examples, so restart the kernel and run cells in
order when reproducing a result.

## Main Python environment (Windows PowerShell)

Install [uv](https://docs.astral.sh/uv/) and run these commands from this
directory:

```powershell
uv sync --locked
.\.venv\Scripts\python.exe -m ipykernel install --user --name ml-rmit --display-name "ML RMIT (Python 3.14.5)"
```

The tracked `.python-version` selects Python 3.14.5. Start Jupyter from the
week containing the notebook so relative data paths work. For example:

```powershell
Set-Location W2_Regression
& ..\.venv\Scripts\python.exe -m jupyter lab
```

Choose the `ML RMIT (Python 3.14.5)` kernel. W2–W4 use
`Dataset_for_tutorial/housing-2.data.csv`; W6 uses its adjacent
`bank-full-new.csv`. W6 visualises trees with Graphviz when the `dot`
executable is available, with a Matplotlib fallback otherwise.

## Week 8–9 neural-network labs

The Week 8 and 9 Keras notebooks need a separate Python 3.12 environment.
From this directory:

```powershell
uv venv --no-project --python 3.12 .venv-tensorflow
uv pip install --python .\.venv-tensorflow\Scripts\python.exe -r .\requirements-tensorflow.txt
.\.venv-tensorflow\Scripts\python.exe -m ipykernel install --user --name ml-rmit-tensorflow --display-name "ML RMIT TensorFlow (Python 3.12)"
```

Start Jupyter from `W8_Deep_Learning` or
`W9_Unsupervised_Learning_and_CNNs` with
`..\.venv-tensorflow\Scripts\python.exe -m jupyter lab`, and select the
TensorFlow kernel. Week 8 already has the CIFAR sample CSV and images. The
first setup cell in Week 9 extracts its tracked `CIFAR10_Lab9.zip` locally;
the extracted files and generated `.keras` models are ignored by Git. Model
training can take time on a CPU.

## Assignment and distribution boundaries

The ASM1 assignment and supplied dataset are excluded from this public
repository because their use is restricted to the course. The separate
`MLA2` repository is also outside this repository. In `ASM2-3`, group
deliverables are ignored; assignment briefs and a personal HTML lab remain
local and untracked.
