# Python For Machine Learning IBM — local labs

This folder contains the local, offline-oriented lab workspace for IBM's
[Machine Learning with Python](https://www.coursera.org/learn/machine-learning-with-python)
course. The course outline currently groups the practical work into Modules 2
through 6; Module 1 is introductory content without a separate public lab
app in the course outline.

## Study notes

The lesson notes explain the concepts behind the course scripts, connect each
method to its assumptions and trade-offs, and add short examples and review
questions. Start with the Module 1 guide, then use each later module's summary
as an index into its lesson notes.

| Module | Study guide | Main ideas |
| --- | --- | --- |
| 1 | [Introduction to Machine Learning](<Module  1 Introduction to Machine Learning/README.md>) | ML foundations, lifecycle, roles, tools, and Scikit-learn |
| 2 | [Linear and Logistic Regression](<Module 2 Linear and Logistic Regression/3 Module Summary, Cheat Sheet & Evaluation/1-module-2-summary-and-highlights.md>) | Regression, feature relationships, classification probabilities |
| 3 | [Supervised Learning Models](<Module 3 Building Supervised Learning Models/3 Module Summary, Cheat Sheet & Evaluation/1-module-3-summary-and-highlights.md>) | Classification, trees, SVM, KNN, bias-variance, ensembles |
| 4 | [Unsupervised Learning Models](<Module 4 Building Unsupervised Learning Models/3 Module Summary, Cheat Sheet & Evaluation/1-module-4-summary-and-highlights.md>) | Clustering, dimensionality reduction, feature engineering |
| 5 | [Evaluation and Validation](<Module 5 Evaluating and Validating Machine Learning Models/3 Module Summary, Cheat Sheet & Evaluation/1-module-5-summary-and-highlights.md>) | Metrics, cross-validation, regularization, leakage |
| 6 | [Course wrap-up and final project](<Module 6 Final Project and Exam/1 Course Summary and Final Exam/1-course-wrap-up.md>) | End-to-end model choice, evaluation, and project workflow |

All illustrations referenced by these notes are stored locally in [`assets/`](assets/); see the [visual asset index](assets/README.md) for descriptions.

For the workspace setup and repository workflow, see [Python environment notes](python_ml_environment_notes_final.md) and [Git and PowerShell notes](git_nested_repo_powershell_notes.md).

## Course-aligned structure

| Module | Local lab directory | Contents |
| --- | --- | --- |
| 1 | `Module  1 Introduction to Machine Learning` | Introduction notes and assets |
| 2 | `Module 2 Linear and Logistic Regression/labs` | Simple, multiple and logistic regression |
| 3 | `Module 3 Building Supervised Learning Models/labs` | Classification, trees, SVM/KNN, ensembles and fraud detection |
| 4 | `Module 4 Building Unsupervised Learning Models/labs` | K-Means, DBSCAN/HDBSCAN, PCA, t-SNE and UMAP |
| 5 | `Module 5 Evaluating and Validating Machine Learning Models/labs` | Classification, random forest and K-Means evaluation, regularization, pipelines/GridSearchCV |
| 6 | `Module 6 Final Project and Exam/labs` | Titanic practice project, rainfall classifier and submission evaluation |

Each module's notebook data is under its adjacent `labs/data` directory. The
notebooks use a shared `_resolve_local_data(...)` bootstrap cell, so they can
be opened from the notebook directory or from the project root.

## Setup on Windows

Run these commands from this directory in PowerShell:

```powershell
uv sync
.\.venv\Scripts\Activate.ps1
python -m ipykernel install --user --name python-for-machine-learning-ibm --display-name "Python For Machine Learning IBM"
jupyter lab
```

Select the `Python For Machine Learning IBM` kernel when opening a notebook.
The tracked `.python-version` selects Python 3.12. The project pins the course-compatible core stack and includes the local-lab
extras used by the notebooks: SciPy, Seaborn, XGBoost, HDBSCAN and UMAP.

The fraud-detection lab also needs `creditcard.csv`. Git does not include this
150 MB dataset. Follow [the data setup instructions](<Module 3 Building Supervised Learning Models/labs/data/README.md>)
before running that notebook; the other lab datasets are already tracked.

## Smoke-test all notebooks

The lightweight runner executes ordinary Python cells headlessly, skips
Jupyter magics/shell commands and reports learner-placeholder cells. It also
skips cells that only fail because a preceding learner answer was intentionally
left blank; this is a diagnostic check, not a replacement for completing the
course exercises.

```powershell
$labs = Get-ChildItem -Recurse -File -Filter *.ipynb -Path . | Where-Object { $_.FullName -match '\\labs\\' } | Select-Object -ExpandProperty FullName
& .\.venv\Scripts\python.exe tools\smoke_test_notebooks.py $labs
```

## Source and adaptation notes

- Module 2 and most Module 3/4 notebooks use public IBM/Skills Network lab
  artifacts, with hosted download/install commands disabled and data paths
  localized.
- The Module 3 fraud notebook uses a scikit-learn fallback for optional Snap ML
  sections when Snap ML is unavailable on Windows; the local run keeps the
  comparison workflow executable.
- The current public object store does not expose exact notebook keys for all
  current Module 4–6 apps. The HDBSCAN extension, t-SNE/UMAP lab and several
  Module 5/6 labs are therefore marked or structured as local adaptations of
  the closest IBM-compatible public materials.
- The large `creditcard.csv` dataset is excluded from Git. Once downloaded as
  described above, the fraud lab can run offline.

Never place Coursera credentials, API keys or session cookies in this folder.
