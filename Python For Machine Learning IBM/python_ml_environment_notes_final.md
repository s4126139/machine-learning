# Python Environments for Machine Learning: `uv`, `.venv`, `pip`, Jupyter Kernels, and Git

These notes summarize the full conversation about setting up Python environments for Machine Learning courses from multiple sources, such as MIT/RMIT and IBM. The notes are grouped by topic, not by the order of questions.

---

## Table of Contents

1. [The Core Problem](#1-the-core-problem)
2. [Mental Model: Python, `.venv`, `pip`, `uv`, and Kernels](#2-mental-model-python-venv-pip-uv-and-kernels)
3. [Recommended Repository Structure](#3-recommended-repository-structure)
4. [What Is `.venv`?](#4-what-is-venv)
5. [What Is `pip`?](#5-what-is-pip)
6. [What Is `uv`?](#6-what-is-uv)
7. [Where `uv` and Python Are Installed](#7-where-uv-and-python-are-installed)
8. [Pinning Python Versions with `uv`](#8-pinning-python-versions-with-uv)
9. [Why Python 3.14 Caused a Pandas Error](#9-why-python-314-caused-a-pandas-error)
10. [Project Files: `pyproject.toml`, `uv.lock`, `.python-version`, `main.py`](#10-project-files-pyprojecttoml-uvlock-python-version-mainpy)
11. [Why `uv.lock` Is So Long](#11-why-uvlock-is-so-long)
12. [Jupyter Kernel and VS Code](#12-jupyter-kernel-and-vs-code)
13. [How to Select the Correct Kernel in VS Code](#13-how-to-select-the-correct-kernel-in-vs-code)
14. [Terminal Environment vs Notebook Kernel](#14-terminal-environment-vs-notebook-kernel)
15. [Switching Between Courses](#15-switching-between-courses)
16. [Git and `.gitignore`](#16-git-and-gitignore)
17. [One `.gitignore` or Many `.gitignore` Files?](#17-one-gitignore-or-many-gitignore-files)
18. [What to Commit to GitHub](#18-what-to-commit-to-github)
19. [Should You Use `jupyter` or Only `ipykernel`?](#19-should-you-use-jupyter-or-only-ipykernel)
20. [Do Not Mix `uv add` and `!pip install` Carelessly](#20-do-not-mix-uv-add-and-pip-install-carelessly)
21. [Useful Commands](#21-useful-commands)
22. [Recommended Workflow for Your Current Setup](#22-recommended-workflow-for-your-current-setup)
23. [Common Mistakes and Fixes](#23-common-mistakes-and-fixes)
24. [Quick Summary](#24-quick-summary)

---

# 1. The Core Problem

You are learning Machine Learning from multiple sources, for example:

```text
MACHINE_LEARNING/
├── Machine Learning at MIT/
└── Python For Machine Learning IBM/
```

Each course may require different Python package versions.

Example:

```text
MIT/RMIT course:
- numpy 1.x
- scikit-learn 1.4

IBM course:
- numpy 2.2.0
- pandas 2.2.3
- scikit-learn 1.6.0
- matplotlib 3.9.3
```

If you use one shared environment for all courses, package versions may conflict.

The best setup is:

```text
One large GitHub repository
    contains many course folders

Each course folder
    is its own Python project
    has its own .venv
    has its own pyproject.toml
    has its own uv.lock
    has its own notebook kernel
```

Core rule:

```text
One course/project = one folder = one .venv = one kernel.
```

---

# 2. Mental Model: Python, `.venv`, `pip`, `uv`, and Kernels

Use this mental model:

```text
Python base/global Python
    = the original Python installed on your machine

.venv
    = a private Python room for one project

pip
    = the traditional package installer

uv
    = the modern manager that creates environments, installs packages,
      locks versions, and runs code

kernel
    = the Python environment that actually runs code inside a notebook
```

Another analogy:

```text
.venv       = the private room
pip         = the person who puts packages into the room
uv          = the manager who creates the room, chooses Python, installs packages,
              locks versions, and runs commands
notebook    = your coding notebook
kernel      = the Python engine behind the notebook
```

Important:

```text
uv does not replace .venv.
uv creates and manages .venv better.
```

---

# 3. Recommended Repository Structure

For your case, a good structure is:

```text
MACHINE_LEARNING/
├── .gitignore
├── README.md
│
├── Machine Learning at MIT/
│   ├── .venv/
│   ├── .python-version
│   ├── pyproject.toml
│   ├── uv.lock
│   ├── README.md
│   ├── chart.ipynb
│   └── week01_lab_exercises_python-1.ipynb
│
└── Python For Machine Learning IBM/
    ├── .venv/
    ├── .python-version
    ├── pyproject.toml
    ├── uv.lock
    ├── README.md
    ├── FuelConsumptionCo2.csv
    ├── Logistic-Regression-v1.ipynb
    ├── Multiple-Linear-Regression-v1.ipynb
    └── Simple-Linear-Regression-v1.ipynb
```

Meaning:

```text
MACHINE_LEARNING/
    = one big learning repository

Machine Learning at MIT/
    = one course/project

Python For Machine Learning IBM/
    = another course/project

Each course folder:
    = separate Python environment
```

---

# 4. What Is `.venv`?

`.venv` is a virtual environment folder.

It contains a separate Python interpreter and packages for one project.

Example:

```text
Python For Machine Learning IBM/
└── .venv/
    ├── Scripts/
    ├── Lib/
    ├── share/
    └── pyvenv.cfg
```

Why use `.venv`?

Because two projects may need different package versions.

Example:

```text
Project A needs numpy==1.26
Project B needs numpy==2.2
```

If both use the same Python environment, they may conflict.

If each has its own `.venv`, they are isolated.

Important:

```text
.venv solves conflicts between projects.
It does not automatically solve conflicts between incompatible packages inside the same project.
```

---

# 5. What Is `pip`?

`pip` is the traditional Python package installer.

Example:

```powershell
pip install numpy pandas scikit-learn
```

Usually, with the old workflow:

```powershell
python -m venv .venv
.venv\Scripts\activate
pip install numpy pandas matplotlib scikit-learn
```

This works, but it can get messy because:

```text
- pip installs packages one by one
- it does not naturally create a modern project lockfile
- the environment can become inconsistent over time
```

You still need to understand `pip` because many tutorials use it:

```python
!pip install numpy
```

But for your own project setup, prefer `uv`.

---

# 6. What Is `uv`?

`uv` is a modern Python package and project manager.

It can replace much of the manual workflow around:

```text
pip
venv
virtualenv
pip-tools
some parts of poetry
```

Common `uv` commands:

```powershell
uv init
uv add numpy pandas matplotlib scikit-learn
uv run python main.py
uv run python -m ipykernel install --user --name ibm-ml --display-name "Python (IBM ML)"
```

With `uv`, you usually do not need to manually activate `.venv` every time. You can use:

```powershell
uv run python main.py
```

or:

```powershell
uv run python -c "print('hello')"
```

`uv` will use the correct project environment.

Important:

```text
uv = tool installed once on your machine
.venv = environment created inside each project
packages = installed into that project’s .venv
```

---

# 7. Where `uv` and Python Are Installed

## 7.1 Where is `uv` installed?

`uv` is installed once globally or at user level.

It is not a folder that you create inside the project.

Wrong mental model:

```text
MACHINE_LEARNING/
├── uv/
├── pip/
└── venv/
```

Correct mental model:

```text
uv is a command available on your machine.
Each project gets its own .venv folder.
```

## 7.2 Where does `uv python install 3.12` install Python?

This command:

```powershell
uv python install 3.12
```

does not install Python 3.12 inside the current project.

It installs Python 3.12 into `uv`'s user-level Python storage.

On Windows, it is usually somewhere like:

```text
C:\Users\<username>\AppData\Roaming\uv\python\
```

To see the actual location:

```powershell
uv python dir
```

## 7.3 What is “Python gốc” / base Python?

Base Python means Python installed on the machine or user account, not inside a project.

Examples:

```text
C:\Users\Khoai\AppData\Local\Programs\Python\Python312\python.exe
C:\Users\Khoai\AppData\Local\Python\pythoncore-3.14-64\python.exe
C:\Users\Khoai\AppData\Roaming\uv\python\...
```

Three layers:

```text
1. Global/base Python
2. uv-managed Python
3. Project .venv Python
```

The notebook should usually use the project `.venv` Python, for example:

```text
C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

---

# 8. Pinning Python Versions with `uv`

For Machine Learning, Python 3.12 is a safe choice.

Inside a project folder:

```powershell
uv python install 3.12
uv python pin 3.12
```

This creates:

```text
.python-version
```

Example content:

```text
3.12
```

This tells `uv`:

```text
This project should use Python 3.12.
```

Then install packages:

```powershell
uv add numpy pandas matplotlib scikit-learn ipykernel
```

You can check the Python version with:

```powershell
uv run python --version
```

Expected:

```text
Python 3.12.x
```

---

# 9. Why Python 3.14 Caused a Pandas Error

You got an error when installing:

```powershell
uv add numpy==2.2.0 pandas==2.2.3 scikit-learn==1.6.0 matplotlib==3.9.3 jupyter ipykernel
```

The important line was:

```text
Using CPython 3.14.3 interpreter
```

Then pandas failed to build:

```text
Failed to build pandas==2.2.3
ERROR: Could not find C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe
```

Meaning:

```text
uv selected Python 3.14
pandas did not have a suitable prebuilt wheel for that setup
uv tried to build pandas from source
Windows did not have Visual Studio Build Tools
installation failed
```

Best fix:

```text
Do not use Python 3.14 for this ML setup.
Use Python 3.12.
```

Reset and fix:

```powershell
Remove-Item -Recurse -Force .venv
Remove-Item -Force uv.lock

uv python install 3.12
uv python pin 3.12

uv add numpy==2.2.0 pandas==2.2.3 scikit-learn==1.6.0 matplotlib==3.9.3 ipykernel
```

---

# 10. Project Files: `pyproject.toml`, `uv.lock`, `.python-version`, `main.py`

When you run:

```powershell
uv init
```

and then:

```powershell
uv add numpy pandas matplotlib scikit-learn ipykernel
```

you may see files like:

```text
pyproject.toml
uv.lock
.python-version
main.py
README.md
```

## 10.1 `pyproject.toml`

This is the main project configuration file.

It records the direct dependencies you asked for.

Example:

```toml
[project]
name = "python-for-machine-learning-ibm"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = [
    "numpy==2.2.0",
    "pandas==2.2.3",
    "scikit-learn==1.6.0",
    "matplotlib==3.9.3",
    "ipykernel",
]
```

You can read this file.

## 10.2 `uv.lock`

This locks exact package versions and dependency details.

It is for reproducibility.

You usually do not edit it manually.

## 10.3 `.python-version`

This records which Python version the project uses.

Example:

```text
3.12
```

It is created by:

```powershell
uv python pin 3.12
```

## 10.4 `main.py`

`main.py` may be created by `uv init`.

If your project is mainly notebooks, `main.py` is not important.

You can keep it or delete it.

---

# 11. Why `uv.lock` Is So Long

You may install only a few packages:

```powershell
uv add numpy==2.2.0 pandas==2.2.3 scikit-learn==1.6.0 matplotlib==3.9.3 jupyter ipykernel
```

But those packages depend on many other packages.

For example, `jupyter` can pull:

```text
ipykernel
ipython
jupyter-client
jupyter-core
jupyter-server
notebook
traitlets
pyzmq
tornado
prompt-toolkit
pygments
nbconvert
nbformat
many more...
```

`uv.lock` stores:

```text
- package names
- exact versions
- dependency relationships
- download URLs
- cryptographic hashes
- wheels for different operating systems
- wheels for different Python versions
- source distributions
- environment markers
```

So `uv.lock` is long because it is precise.

Mental model:

```text
pyproject.toml = what you want
uv.lock        = the exact solved answer
.venv          = where packages are actually installed
```

You should commit `uv.lock` to GitHub.

Do not manually edit it.

---

# 12. Jupyter Kernel and VS Code

A Jupyter kernel is the Python environment that runs code in a notebook.

Mental model:

```text
.ipynb notebook = the file where you write code
kernel          = the Python environment running the code
.venv           = the folder containing Python and packages
```

If you run:

```python
import pandas as pd
```

the kernel decides which pandas installation is used.

Correct IBM kernel should point to:

```text
...\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

Correct MIT/RMIT kernel should point to:

```text
...\Machine Learning at MIT\.venv\Scripts\python.exe
```

If you choose the wrong kernel, you may get:

```text
ModuleNotFoundError
wrong package version
unexpected behavior
```

---

# 13. How to Select the Correct Kernel in VS Code

Open a notebook `.ipynb`.

At the top-right, click:

```text
Select Kernel
```

Then choose the correct project environment.

For IBM, choose one of these:

```text
Python (IBM ML)
python-for-machine-learning-ibm (Python 3.12)
...\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

Avoid:

```text
Conda base
global Python
uv base Python
Python 3.14 global
.venv from another course
```

## If the kernel does not appear

Check that the environment exists:

```powershell
Test-Path .venv\Scripts\python.exe
```

If it returns:

```text
True
```

get the full path:

```powershell
Resolve-Path .venv\Scripts\python.exe
```

Then in VS Code:

```text
Select Kernel
→ Select Another Kernel...
→ Python Environments...
→ Enter interpreter path...
```

Paste the path:

```text
C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

If needed, reload VS Code:

```text
Ctrl + Shift + P
Developer: Reload Window
```

---

# 14. Terminal Environment vs Notebook Kernel

The terminal environment and notebook kernel are related but different.

If the terminal shows:

```powershell
(.venv) PS C:\...\Python For Machine Learning IBM>
```

that means the terminal currently has a `.venv` activated.

But a notebook uses the selected Jupyter kernel.

Important:

```text
deactivate in terminal does not automatically change the notebook kernel.
```

Always check inside a notebook:

```python
import sys
print(sys.executable)
```

Correct IBM output:

```text
C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

---

# 15. Switching Between Courses

Suppose you are studying IBM first:

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM"
.venv\Scripts\activate
```

When finished:

```powershell
deactivate
```

Then move to MIT/RMIT:

```powershell
cd "../Machine Learning at MIT"
.venv\Scripts\activate
```

This switches the terminal to the MIT/RMIT environment.

## With `uv`, you can avoid manual activation

IBM:

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM"
uv run python main.py
```

MIT/RMIT:

```powershell
cd "../Machine Learning at MIT"
uv run python main.py
```

`uv run` uses the environment for the current project folder.

Important:

```text
deactivate does not delete .venv.
It only exits the current environment in the terminal.
```

---

# 16. Git and `.gitignore`

`.gitignore` tells Git what not to track.

You should not commit `.venv` because:

```text
- it is large
- it is machine-specific
- it can be rebuilt from pyproject.toml and uv.lock
```

Good root `.gitignore`:

```gitignore
**/.venv/
__pycache__/
.ipynb_checkpoints/
.env
.DS_Store
```

Important line:

```gitignore
**/.venv/
```

It ignores all `.venv` folders in all subfolders.

Example:

```text
Machine Learning at MIT/.venv/
Python For Machine Learning IBM/.venv/
```

---

# 17. One `.gitignore` or Many `.gitignore` Files?

This depends on your Git repo design.

## Case A: One big Git repo

If `MACHINE_LEARNING` is one GitHub repo, recommended:

```text
MACHINE_LEARNING/
├── .git/
├── .gitignore
├── README.md
├── Machine Learning at MIT/
└── Python For Machine Learning IBM/
```

Then one root `.gitignore` is enough.

Use:

```gitignore
**/.venv/
__pycache__/
.ipynb_checkpoints/
.env
.DS_Store
```

You do not need a separate `.gitignore` inside each course folder.

## Case B: Each course is its own Git repo

If each course folder has its own `.git` folder:

```text
Machine Learning at MIT/
├── .git/
├── .gitignore
└── .venv/

Python For Machine Learning IBM/
├── .git/
├── .gitignore
└── .venv/
```

Then each course needs its own `.gitignore`.

## Your recommended setup

For your current learning system, use one big repo:

```text
MACHINE_LEARNING/
├── .gitignore
├── Machine Learning at MIT/
└── Python For Machine Learning IBM/
```

That is simpler.

## What about `.venv/.gitignore`?

You may see:

```text
.venv/.gitignore
```

This is created automatically inside the virtual environment.

Do not rely on it as the main project Git ignore file.

Do not edit it.

Use the root `.gitignore` instead.

---

# 18. What to Commit to GitHub

Commit these:

```text
README.md
pyproject.toml
uv.lock
.python-version
.ipynb notebooks
small .csv files
source code files
```

Do not commit these:

```text
.venv/
__pycache__/
.ipynb_checkpoints/
.env
large datasets
temporary files
```

Before committing:

```powershell
git status
```

If `.venv/` appears, your `.gitignore` is not working correctly.

---

# 19. Should You Use `jupyter` or Only `ipykernel`?

If you use notebooks mainly inside VS Code, you often only need:

```powershell
uv add ipykernel
```

You may not need:

```powershell
uv add jupyter
```

because full `jupyter` pulls many dependencies and makes `uv.lock` much longer.

Lightweight VS Code notebook setup:

```powershell
uv add numpy pandas matplotlib scikit-learn ipykernel
```

If you already installed `jupyter` and do not need it:

```powershell
uv remove jupyter
```

Keep `ipykernel`.

---

# 20. Do Not Mix `uv add` and `!pip install` Carelessly

Inside IBM notebooks, there may be cells like:

```python
!pip install numpy==2.2.0
!pip install pandas==2.2.3
!pip install scikit-learn==1.6.0
!pip install matplotlib==3.9.3
```

If you are using `uv`, avoid running these cells.

Use terminal:

```powershell
uv add numpy==2.2.0 pandas==2.2.3 scikit-learn==1.6.0 matplotlib==3.9.3 ipykernel
```

Then select the correct kernel.

You can comment out the notebook install cells:

```python
# !pip install numpy==2.2.0
# !pip install pandas==2.2.3
# !pip install scikit-learn==1.6.0
# !pip install matplotlib==3.9.3
```

Reason:

```text
uv manages dependencies with pyproject.toml and uv.lock.
!pip install inside a notebook can make the environment inconsistent.
```

---

# 21. Useful Commands

## Create a new uv project

```powershell
uv init
```

## Install Python 3.12 through uv

```powershell
uv python install 3.12
```

## Pin project to Python 3.12

```powershell
uv python pin 3.12
```

## Add packages

```powershell
uv add numpy pandas matplotlib scikit-learn ipykernel
```

## Add exact package versions

```powershell
uv add numpy==2.2.0 pandas==2.2.3 scikit-learn==1.6.0 matplotlib==3.9.3 ipykernel
```

## Remove a package

```powershell
uv remove jupyter
```

## Run Python through uv

```powershell
uv run python main.py
```

## Check Python version

```powershell
uv run python --version
```

## Check the Python executable used by uv

```powershell
uv run python -c "import sys; print(sys.executable)"
```

## Create a Jupyter kernel

```powershell
uv run python -m ipykernel install --user --name ibm-ml --display-name "Python (IBM ML)"
```

## Check if `.venv` Python exists

```powershell
Test-Path .venv\Scripts\python.exe
```

## Get full path to `.venv` Python

```powershell
Resolve-Path .venv\Scripts\python.exe
```

## List Python versions known by Windows Python Launcher

```powershell
py -0p
```

This usually works from any folder if `py.exe` is installed and available.

It lists Python versions known by the Windows Python Launcher, not necessarily every Python executable on the whole computer.

## See what `python` command points to

```powershell
where python
```

## See where uv stores its Python versions

```powershell
uv python dir
```

## Deactivate current virtual environment

```powershell
deactivate
```

---

# 22. Recommended Workflow for Your Current Setup

## IBM course setup

Go to the IBM folder:

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM"
```

Pin Python 3.12:

```powershell
uv python install 3.12
uv python pin 3.12
```

Install packages:

```powershell
uv add numpy==2.2.0 pandas==2.2.3 scikit-learn==1.6.0 matplotlib==3.9.3 ipykernel
```

Create kernel:

```powershell
uv run python -m ipykernel install --user --name ibm-ml --display-name "Python (IBM ML)"
```

In VS Code notebook, select:

```text
Python (IBM ML)
```

or the path:

```text
...\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

Check inside notebook:

```python
import sys
print(sys.executable)
```

## MIT/RMIT course setup

Go to the MIT/RMIT folder:

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at MIT"
```

Pin Python 3.12:

```powershell
uv python pin 3.12
```

Install packages:

```powershell
uv add numpy pandas matplotlib scikit-learn ipykernel
```

Create kernel:

```powershell
uv run python -m ipykernel install --user --name mit-ml --display-name "Python (MIT ML)"
```

Select this kernel in notebooks for that course.

---

# 23. Common Mistakes and Fixes

## Mistake 1: Using one `.venv` for every course

Bad:

```text
MACHINE_LEARNING/
├── .venv/
├── Machine Learning at MIT/
└── Python For Machine Learning IBM/
```

Better:

```text
MACHINE_LEARNING/
├── Machine Learning at MIT/
│   └── .venv/
└── Python For Machine Learning IBM/
    └── .venv/
```

## Mistake 2: Choosing global Python as notebook kernel

Wrong kernel examples:

```text
Python 3.14 global
Conda base
uv base Python
```

Correct:

```text
...\Current Course Folder\.venv\Scripts\python.exe
```

## Mistake 3: Running `!pip install` after using `uv add`

Avoid this because it can make the environment messy.

Use:

```powershell
uv add package-name
```

## Mistake 4: Pushing `.venv` to GitHub

Fix root `.gitignore`:

```gitignore
**/.venv/
__pycache__/
.ipynb_checkpoints/
.env
.DS_Store
```

## Mistake 5: Confusing `.venv/.gitignore` with root `.gitignore`

`.venv/.gitignore` is internal.

You still want:

```text
MACHINE_LEARNING/.gitignore
```

## Mistake 6: Thinking `deactivate` deletes the environment

It does not.

It only exits the active environment in the current terminal.

---

# 24. Quick Summary

```text
uv
= modern Python project/environment manager

.venv
= private Python environment for one project

pip
= traditional Python package installer

pyproject.toml
= direct dependencies and project metadata

uv.lock
= exact resolved dependency graph

.python-version
= Python version selected for the project

kernel
= Python environment used by Jupyter/VS Code notebook

.gitignore
= prevents .venv and cache files from being committed
```

Final rule:

```text
One course = one project folder = one .venv = one pyproject.toml = one uv.lock = one notebook kernel.
```

Recommended for your ML repo:

```text
MACHINE_LEARNING/
├── .gitignore
├── README.md
├── Machine Learning at MIT/
│   ├── .venv/
│   ├── pyproject.toml
│   ├── uv.lock
│   └── notebooks
└── Python For Machine Learning IBM/
    ├── .venv/
    ├── pyproject.toml
    ├── uv.lock
    └── notebooks
```

Best habits:

```text
Use Python 3.12 for ML.
Use uv add instead of !pip install.
Do not commit .venv.
Commit pyproject.toml, uv.lock, and .python-version.
Always check the notebook kernel with sys.executable.
```
