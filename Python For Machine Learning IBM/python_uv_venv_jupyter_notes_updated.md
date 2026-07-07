# Python Environment Notes: `uv`, `.venv`, `pip`, Kernels, and Project Structure

These notes summarize the Python environment questions from this conversation. The goal is to make it easy to review later when working on Machine Learning notebooks from multiple courses such as MIT/RMIT and IBM.

---

## 1. Big Picture

When learning Machine Learning from different sources, each source/course may require different Python package versions.

For example:

```text
MIT/RMIT course:
- numpy 1.x
- scikit-learn 1.4

IBM course:
- numpy 2.2.0
- pandas 2.2.3
- scikit-learn 1.6.0
```

If both courses use the same environment, packages may conflict.

The clean solution is:

```text
One big GitHub repository
    contains many course/project folders

Each course/project folder
    has its own Python environment
    has its own dependency files
    has its own notebook kernel
```

Recommended structure:

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

---

## 2. What Is `.venv`?

`.venv` is a **virtual environment folder**.

It is a private Python environment for one project.

It contains:

```text
- a Python interpreter
- installed packages
- scripts
- package metadata
```

Example:

```text
Python For Machine Learning IBM/
└── .venv/
    ├── Scripts/
    ├── Lib/
    ├── share/
    └── pyvenv.cfg
```

Mental model:

```text
.venv = a private room for one project
```

If IBM and MIT need different package versions, they should have separate `.venv` folders.

Do not use one `.venv` for all courses.

---

## 3. What Is `pip`?

`pip` is the traditional Python package installer.

Example:

```powershell
pip install numpy pandas scikit-learn
```

It installs Python packages into the currently active Python environment.

In older workflows, people often use:

```powershell
python -m venv .venv
.venv\Scripts\activate
pip install numpy pandas scikit-learn
```

This works, but it can become messy if packages are installed manually one by one without a lockfile.

---

## 4. What Is `uv`?

`uv` is a modern Python package and project manager.

It can replace a lot of manual workflow around:

```text
pip
venv
virtualenv
pip-tools
some parts of poetry
```

Mental model:

```text
.venv = the project room
pip   = someone who installs packages into the room
uv    = the manager who creates the room, installs packages, locks versions, and runs code
```

Important idea:

```text
uv does not replace .venv.
uv creates and manages .venv better.
```

With `uv`, a typical project workflow is:

```powershell
uv init
uv add numpy pandas matplotlib scikit-learn ipykernel
uv run python main.py
```

For notebooks:

```powershell
uv run python -m ipykernel install --user --name ibm-ml --display-name "Python (IBM ML)"
```

---

## 5. What Is `npm`?

`npm` is the package manager for JavaScript/Node.js.

Comparison:

```text
Python        JavaScript / Node.js
------        --------------------
pip / uv      npm
.venv         node_modules is somewhat similar, but not exactly
pyproject     package.json
uv.lock       package-lock.json
```

Example:

```powershell
npm install react
```

This is unrelated to Python environments, but useful for full-stack/web projects.

---

## 6. Where Should `uv` Be Installed?

`uv` is a global/user-level tool.

You install `uv` once for the whole machine.

It should not be placed inside your project folder manually.

Correct idea:

```text
uv      = installed once on your machine
.venv   = created separately inside each project
packages = installed into each project’s .venv
```

So you do **not** create folders like this:

```text
MACHINE_LEARNING/
├── uv/
├── pip/
└── venv/
```

That is the wrong mental model.

---

## 7. Where Does `uv python install 3.12` Install Python?

This command:

```powershell
uv python install 3.12
```

installs Python 3.12 into the Python storage managed by `uv`, not into the current project folder.

On Windows, it is usually somewhere under a user-level directory such as:

```text
C:\Users\<username>\AppData\Roaming\uv\python\
```

To see the actual directory:

```powershell
uv python dir
```

Then in a project folder, you can pin the project to Python 3.12:

```powershell
uv python pin 3.12
```

This creates:

```text
.python-version
```

That file tells `uv`:

```text
This project should use Python 3.12.
```

---

## 8. What Is “Python gốc” / Base Python?

“Base Python” means a Python interpreter installed at machine/user level, not inside a specific project.

Examples on Windows:

```text
C:\Users\Khoai\AppData\Local\Programs\Python\Python312\python.exe
C:\Users\Khoai\AppData\Local\Python\pythoncore-3.14-64\python.exe
C:\Users\Khoai\AppData\Roaming\uv\python\...
```

There are three important levels:

```text
1. Global/base Python
   - installed on the machine
   - can be used to create virtual environments

2. uv-managed Python
   - installed by uv with commands like `uv python install 3.12`

3. Project .venv Python
   - lives inside the project folder
   - this is what the notebook should use
```

Example project Python:

```text
C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

This is the one you want for IBM notebooks.

---

## 9. Useful Windows Python Commands

### List Python versions known by Windows Python Launcher

```powershell
py -0p
```

This usually works from any folder/path, as long as the Windows Python Launcher (`py.exe`) is installed and available in PATH.

It lists Python versions known to the Python Launcher.

It does **not** necessarily list every single `python.exe` on the whole disk.

It may miss:

```text
- portable Python copies
- Python inside .venv folders
- some tool-managed Python installations
```

### See what `python` command points to

```powershell
where python
```

This shows Python executables found in PATH.

### See where uv-managed Python versions are stored

```powershell
uv python dir
```

### See which Python the current uv project is using

Run this inside a project folder:

```powershell
uv run python -c "import sys; print(sys.executable)"
```

For IBM, you want output like:

```text
...\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

---

## 10. Why Did `pandas` Fail to Install?

The error happened because `uv` selected Python 3.14:

```text
Using CPython 3.14.3 interpreter
```

But `pandas==2.2.3` did not have a suitable prebuilt wheel for that Python version/environment, so `uv` tried to build pandas from source.

On Windows, building pandas from source requires Visual Studio Build Tools. The error included:

```text
ERROR: Could not find C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe
```

Meaning:

```text
uv selected Python 3.14
pandas did not install from a ready-made wheel
uv tried to build pandas manually
Windows did not have the required build tools
installation failed
```

Best fix for ML:

```text
Use Python 3.12, not Python 3.14.
```

Recommended commands:

```powershell
Remove-Item -Recurse -Force .venv
Remove-Item -Force uv.lock

uv python install 3.12
uv python pin 3.12

uv add numpy==2.2.0 pandas==2.2.3 scikit-learn==1.6.0 matplotlib==3.9.3 ipykernel
```

---

## 11. Why Does `uv.lock` Have So Many Lines?

You installed a few packages, for example:

```powershell
uv add numpy==2.2.0 pandas==2.2.3 scikit-learn==1.6.0 matplotlib==3.9.3 jupyter ipykernel
```

But those packages have many dependencies.

Example:

```text
jupyter
├── ipykernel
├── ipython
├── jupyter-client
├── jupyter-core
├── traitlets
├── pyzmq
├── tornado
├── prompt-toolkit
└── many more...
```

`uv.lock` records the full dependency graph:

```text
- package name
- exact version
- dependencies
- download URLs
- hashes
- wheels for different operating systems and Python versions
- source distributions
- Python version markers
```

So `uv.lock` is long because it is precise.

Mental model:

```text
pyproject.toml = what you asked for
uv.lock        = the exact solved answer
.venv          = where the packages are actually installed
```

You usually do **not** read or edit `uv.lock` manually.

You should commit `uv.lock` to GitHub.

---

## 12. Do You Need `jupyter` If You Use VS Code Notebooks?

Not always.

If you use notebooks mainly inside VS Code, you often only need:

```powershell
uv add ipykernel
```

You may not need full:

```powershell
uv add jupyter
```

Because `jupyter` pulls many dependencies and makes `uv.lock` much longer.

For a lightweight VS Code notebook setup:

```powershell
uv add numpy pandas matplotlib scikit-learn ipykernel
```

If you installed `jupyter` but do not need it:

```powershell
uv remove jupyter
```

Keep:

```powershell
uv add ipykernel
```

---

## 13. What Is a Jupyter Kernel?

A kernel is the Python environment that actually runs code inside a notebook.

Mental model:

```text
.ipynb notebook = the notebook file where you write code
kernel          = the Python environment that runs the code
.venv           = the folder containing Python + packages
```

If a notebook imports pandas:

```python
import pandas as pd
```

the kernel decides which pandas installation is used.

For IBM notebooks, the kernel should point to:

```text
...\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

For MIT notebooks, it should point to:

```text
...\Machine Learning at MIT\.venv\Scripts\python.exe
```

If you choose the wrong kernel, you may get:

```text
ModuleNotFoundError
wrong package version
unexpected errors
```

---

## 14. How to Create a Kernel for a Project

Inside the IBM project folder:

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM"

uv add ipykernel

uv run python -m ipykernel install --user --name ibm-ml --display-name "Python (IBM ML)"
```

This creates a Jupyter kernel named:

```text
Python (IBM ML)
```

For MIT:

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at MIT"

uv add ipykernel

uv run python -m ipykernel install --user --name mit-ml --display-name "Python (MIT ML)"
```

---

## 15. How to Select Kernel in VS Code

Open a `.ipynb` notebook.

At the top-right, click:

```text
Select Kernel
```

Then choose the right environment.

If you see many options, choose the one related to the current project.

For IBM, choose something like:

```text
python-for-machine-learning-ibm (Python 3.12)
```

or:

```text
Python (IBM ML)
```

or directly choose:

```text
...\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

Avoid choosing:

```text
Conda base
global Python
uv base Python
Python 3.14 global
.venv from another course folder
```

---

## 16. Why Does VS Code Show Many Python Environments?

VS Code lists many Python environments it finds on your machine.

Examples:

```text
python-for-machine-learning-ibm  -> project environment, good for IBM
base (Python 3.13)               -> Conda base, usually avoid
Python 3.12.13                   -> global Python
cpython-3.12...uv...             -> uv-managed base Python
Python 3.14.3                    -> global Python 3.14
.venv (3.14.3)                   -> old virtual environment
```

For notebooks, choose the environment belonging to the current project.

For IBM, do not choose the old `.venv` from the MIT/RMIT folder.

---

## 17. If VS Code Does Not Show the Kernel

First check if the `.venv` exists:

```powershell
Test-Path .venv\Scripts\python.exe
```

If it returns:

```text
True
```

then copy the path:

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

Paste:

```text
C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

If it still does not appear, reload VS Code:

```text
Ctrl + Shift + P
Developer: Reload Window
```

Then try selecting the kernel again.

---

## 18. How to Check If the Notebook Uses the Right Kernel

Run this in a notebook cell:

```python
import sys
print(sys.executable)
```

Correct IBM output should look like:

```text
C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

Then check versions:

```python
import numpy
import pandas
import sklearn
import matplotlib

print("numpy:", numpy.__version__)
print("pandas:", pandas.__version__)
print("sklearn:", sklearn.__version__)
print("matplotlib:", matplotlib.__version__)
```

Expected for the IBM setup:

```text
numpy: 2.2.0
pandas: 2.2.3
sklearn: 1.6.0
matplotlib: 3.9.3
```

---

## 19. Should You Run `!pip install` Inside Notebooks?

If you are using `uv`, avoid running package installation cells like:

```python
!pip install numpy==2.2.0
!pip install pandas==2.2.3
!pip install scikit-learn==1.6.0
!pip install matplotlib==3.9.3
```

Instead, install from the terminal:

```powershell
uv add numpy==2.2.0 pandas==2.2.3 scikit-learn==1.6.0 matplotlib==3.9.3 ipykernel
```

Then select the correct notebook kernel.

Reason:

```text
uv manages dependencies through pyproject.toml and uv.lock.
pip inside a notebook can make the environment messy or inconsistent.
```

You can comment out the old install cells:

```python
# !pip install numpy==2.2.0
# !pip install pandas==2.2.3
# !pip install scikit-learn==1.6.0
# !pip install matplotlib==3.9.3
```

---

## 20. What Is `pyproject.toml`?

`pyproject.toml` is the main project configuration file for modern Python projects.

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

You may read or edit this file if needed.

---

## 21. What Is `.python-version`?

`.python-version` tells `uv` which Python version this project should use.

Example content:

```text
3.12
```

It is created by:

```powershell
uv python pin 3.12
```

You should commit `.python-version` to GitHub.

---

## 22. What Is `main.py`?

`main.py` may be created automatically by:

```powershell
uv init
```

If your project is mainly notebooks, `main.py` is not important.

You can keep it or delete it.

It does not affect notebooks as long as your environment and kernel are correct.

---

## 23. Should There Be Many `README.md`, `pyproject.toml`, and `uv.lock` Files?

Yes, if each course folder is its own Python project.

Example:

```text
MACHINE_LEARNING/
├── README.md
│
├── Machine Learning at MIT/
│   ├── README.md
│   ├── pyproject.toml
│   └── uv.lock
│
└── Python For Machine Learning IBM/
    ├── README.md
    ├── pyproject.toml
    └── uv.lock
```

Meaning:

```text
Root README.md
    explains the whole learning repository

Course README.md
    explains that specific course

Course pyproject.toml
    stores dependencies for that course

Course uv.lock
    locks exact package versions for that course
```

This is normal.

---

## 24. What Is `.gitignore`?

`.gitignore` tells Git which files/folders should not be tracked.

You should not push `.venv` to GitHub because it is large and machine-specific.

Good root `.gitignore` for the big repository:

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

This ignores every `.venv` inside every subfolder.

---

## 25. Why Is There a `.gitignore` Inside `.venv`?

Some tools create this automatically:

```text
.venv/.gitignore
```

This is internal to the virtual environment.

Do not rely on it as your main Git ignore file.

You should still have a proper `.gitignore` at the repository root:

```text
MACHINE_LEARNING/.gitignore
```

Recommended:

```text
MACHINE_LEARNING/
├── .gitignore
├── Machine Learning at MIT/
│   └── .venv/
└── Python For Machine Learning IBM/
    └── .venv/
```

The `.gitignore` inside `.venv` can be ignored. Do not edit it.

---

## 26. What Should Be Committed to GitHub?

Commit:

```text
README.md
pyproject.toml
uv.lock
.python-version
.ipynb notebooks
small .csv files
source code files
```

Do not commit:

```text
.venv/
__pycache__/
.ipynb_checkpoints/
.env
large datasets
```

Before committing, check:

```powershell
git status
```

If `.venv/` appears in the list, your `.gitignore` is not set correctly.

---

## 27. What Happens When You `deactivate` a `.venv`?

`deactivate` only turns off the current virtual environment in the current terminal.

It does not delete `.venv`.

Example:

```powershell
(.venv) PS ...>
deactivate
PS ...>
```

Mental model:

```text
deactivate = leave the current project room
```

Then you can move to another folder:

```powershell
cd "../Machine Learning at MIT"
```

and activate that project’s environment:

```powershell
.venv\Scripts\activate
```

or use `uv run`.

---

## 28. Switching Between Courses

Suppose you are in IBM:

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM"
.venv\Scripts\activate
```

When finished:

```powershell
deactivate
```

Then switch to MIT:

```powershell
cd "../Machine Learning at MIT"
.venv\Scripts\activate
```

Now the terminal uses MIT’s environment.

With `uv`, you can avoid manual activation:

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM"
uv run python main.py
```

Then:

```powershell
cd "../Machine Learning at MIT"
uv run python main.py
```

`uv run` automatically uses the environment of the current project folder.

---

## 29. Important Difference: Terminal Environment vs Notebook Kernel

The terminal environment and notebook kernel are related, but not the same thing.

If you `deactivate` in the terminal, it does not automatically change the notebook kernel.

A notebook keeps using the kernel you selected.

So when switching notebooks:

```text
IBM notebook -> select IBM kernel
MIT notebook -> select MIT kernel
```

Always verify with:

```python
import sys
print(sys.executable)
```

---

## 30. Recommended Workflow for Your ML Learning Repository

### For IBM course

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Python For Machine Learning IBM"

uv python pin 3.12
uv add numpy==2.2.0 pandas==2.2.3 scikit-learn==1.6.0 matplotlib==3.9.3 ipykernel

uv run python -m ipykernel install --user --name ibm-ml --display-name "Python (IBM ML)"
```

Then open notebook and select:

```text
Python (IBM ML)
```

or:

```text
...\Python For Machine Learning IBM\.venv\Scripts\python.exe
```

### For MIT/RMIT course

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning at MIT"

uv python pin 3.12
uv add numpy pandas matplotlib scikit-learn ipykernel

uv run python -m ipykernel install --user --name mit-ml --display-name "Python (MIT ML)"
```

Then open notebook and select:

```text
Python (MIT ML)
```

or:

```text
...\Machine Learning at MIT\.venv\Scripts\python.exe
```

---

## 31. Quick Rules to Remember

```text
1. uv is installed once for the whole machine.
2. Each course/project should have its own .venv.
3. Each course/project can have its own pyproject.toml and uv.lock.
4. Use Python 3.12 for ML unless a course specifically requires another version.
5. Do not use Python 3.14 for ML packages unless you know they support it.
6. Do not push .venv to GitHub.
7. Commit pyproject.toml, uv.lock, and .python-version.
8. In VS Code notebooks, always select the correct kernel.
9. Check the active notebook Python with `import sys; print(sys.executable)`.
10. Use `uv add` instead of `!pip install` inside notebooks.
11. Use root .gitignore to ignore all `.venv` folders.
12. `deactivate` does not delete a venv; it only exits it in the terminal.
```

---

## 32. Simplest Mental Model

```text
MACHINE_LEARNING
= big cabinet for all ML learning

Each course folder
= one separate project

.venv
= private Python room for that project

pyproject.toml
= list of packages you want

uv.lock
= exact package versions uv solved

kernel
= the Python environment used by a notebook

.gitignore
= tells Git not to upload .venv and cache files
```

Recommended mindset:

```text
One course = one folder = one .venv = one kernel.
```
