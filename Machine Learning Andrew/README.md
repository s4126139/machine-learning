# Machine Learning Specialization — study workspace

Lecture notes and Jupyter labs are grouped into two courses:

| Course | Start here | Topics |
| --- | --- | --- |
| 1 | [Supervised Machine Learning: Regression and Classification](<1 Supervised Machine Learning - Regression and Classification>) | Linear regression, multiple features, logistic regression |
| 2 | [Advanced Learning Algorithms](<2 Advanced Learning Algorithms/README.md>) | Neural networks, model development, decision trees |

The notebooks keep their saved outputs for reading on GitHub. Each lab's
`README.md` or adjacent `data/` directory describes its inputs. Start Jupyter
from the notebook's directory when rerunning it so relative paths and helper
imports resolve. Course 1 keeps notebooks in week folders; Course 2 uses
`Labs` subfolders.

## Main environment (Windows PowerShell)

From this directory:

```powershell
uv sync --locked
.\.venv\Scripts\python.exe -m ipykernel install --user --name ml-andrew --display-name "ML Andrew (Python 3.14)"
```

The tracked `.python-version` selects Python 3.14. For example, to open a
Course 1 lab, change into its folder and start Jupyter with the same Python:

```powershell
Set-Location '1 Supervised Machine Learning - Regression and Classification\Week 1 Introduction to Machine Learning'
& ..\..\.venv\Scripts\python.exe -m jupyter lab
```

Select the `ML Andrew (Python 3.14)` kernel. Repeat from the desired lab
directory for other weeks.

## TensorFlow labs in Course 2

Course 2's Keras and TensorFlow labs require a separate Python 3.10–3.13
environment. From this directory, create it with Python 3.12:

```powershell
uv venv --no-project --python 3.12 .venv-tensorflow
uv pip install --python .\.venv-tensorflow\Scripts\python.exe -r '2 Advanced Learning Algorithms\requirements-course2-tensorflow.txt'
.\.venv-tensorflow\Scripts\python.exe -m ipykernel install --user --name ml-andrew-tensorflow --display-name "ML Andrew TensorFlow (Python 3.12)"
```

Start Jupyter from the relevant Course 2 `Labs` directory using
`..\..\..\.venv-tensorflow\Scripts\python.exe -m jupyter lab`, then select
the TensorFlow kernel. The [Course 2 guide](<2 Advanced Learning Algorithms/README.md>)
identifies the weeks that need it.

The course material is for personal study. Review the
[Course 2 third-party notices](<2 Advanced Learning Algorithms/THIRD_PARTY_NOTICES.md>)
before redistributing or submitting completed lab solutions.
