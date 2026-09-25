# Machine Learning study repository

This repository collects three independent Jupyter workspaces and one
documentation handbook. Each Python workspace has its own `pyproject.toml`,
`uv.lock`, Python version, datasets, and setup guide. Install and launch each
workspace from its own directory.

| Section | What is here | Start here |
| --- | --- | --- |
| IBM Machine Learning with Python | Concept notes and 23 local lab notebooks | [IBM guide](<Python For Machine Learning IBM/README.md>) |
| Andrew Ng Machine Learning Specialization | Course 1 and 2 notes, helpers, and 37 lab notebooks | [Andrew guide](<Machine Learning Andrew/README.md>) |
| RMIT Machine Learning | Week notes, teaching files, datasets, and 17 tracked notebooks | [RMIT guide](<Machine Learning at RMIT/README.md>) |
| ML lifecycle handbook | Documentation for project design, evaluation, deployment, and monitoring | [Handbook](<Machine Learning tổng/README.md>) |

## Start using the notebooks

Install [uv](https://docs.astral.sh/uv/) and clone this repository. On Windows,
open PowerShell in the section you want and run `uv sync --locked`. Then open
that section's README for the Jupyter command, kernel selection, and working
directory. The pinned Python versions are 3.12 for IBM, 3.14 for Andrew, and
3.14.5 for RMIT. Andrew Course 2 and RMIT Week 8–9 TensorFlow labs use separate
Python 3.12 environments described in their guides.

Open notebooks on GitHub to read saved code and outputs. All nonempty code
cells in the IBM and Andrew notebooks have saved execution counts and no
saved error outputs. The RMIT notebooks include course templates and older
copies; some have no saved run. To reproduce any result, use its section's
environment, start Jupyter from the notebook or lab directory, restart the
kernel, and run cells in order.

## Data and access

- Most lab data is next to its notebook. The IBM fraud lab is the exception:
  its 151 MB `creditcard.csv` is not in Git. Use the
  [fraud data instructions](<Python For Machine Learning IBM/Module 3 Building Supervised Learning Models/labs/data/README.md>)
  before running that notebook.
- RMIT Canvas pages require a course login. Direct Canvas links were removed
  from notes, notebooks, and the personal HTML lab. Two retained assignment
  brief PDFs still contain their original course links and may require RMIT
  access. The [local material manifest](<Machine Learning at RMIT/canvas_materials_manifest.md>)
  records what was captured and which slide placeholders remained unresolved.
- The RMIT ASM1 assignment and supplied dataset are excluded from this public
  repository because their use is restricted to the course. Keep private
  copies within the permitted assessment context.
- The separate `MLA2` repository is outside this repo. In `ASM2-3`, the two
  group deliverables are excluded by `.gitignore`; three assignment briefs and
  the personal HTML lab are included. The HTML works as a standalone page: it
  uses in-page navigation and embeds the original project figures without
  loading files from the separate `MLA2` repository.

## Repository checks

The three lockfiles can be checked from their own directories with
`uv lock --check`. A fresh Jupyter installation can validate a notebook with
`python -m nbconvert --to notebook --execute <file.ipynb>`; this may take time
for model-training labs and requires the datasets noted above. Do not save
private credentials, local virtual environments, or generated model files in
Git.
