# Course 3: Unsupervised Learning, Recommenders, Reinforcement Learning

This workspace follows the three-week Coursera syllabus. All 46 videos have an
original study note in the ordered topic folders shown in
[COURSE_MAP.md](<COURSE_MAP.md>). All seven runnable study notebooks and their
supporting assets are organized by week in the `Labs` folders. The notebooks
include saved output for GitHub.

## Course map

| Week | Topic | Local material |
| --- | --- | --- |
| 1 | Unsupervised learning | [Week notes](<Week 1 Unsupervised learning/README.md>) · [Labs](<Week 1 Unsupervised learning/Labs/README.md>) |
| 2 | Recommender systems, including PCA | [Week notes](<Week 2 Recommender systems/README.md>) · [Labs](<Week 2 Recommender systems/Labs/README.md>) |
| 3 | Reinforcement learning | [Week notes](<Week 3 Reinforcement learning/README.md>) · [Labs](<Week 3 Reinforcement learning/Labs/README.md>) |

## Local source files

Raw transcripts and the original downloaded lab files are stored under
`.local-only/`. Git ignores that directory so the source copies stay on this
machine. Each week’s `Labs/README.md` lists its runnable notebooks, required
environment, launch command, and local source folder. See
[THIRD_PARTY_NOTICES.md](<THIRD_PARTY_NOTICES.md>) for source attribution and
license details.

Only original notes and lab files whose source and redistribution terms are
clear should be added to the public repository. The notes explain the ideas in
new wording, with equations and locally created visualizations where they
help.

## Run the labs locally

From the parent Machine Learning Andrew directory, create the shared Course 3
environment and register its Jupyter kernel:

~~~powershell
uv venv --no-project --python 3.12 .venv-course3
uv pip install --python .\.venv-course3\Scripts\python.exe -r '3 Unsupervised Learning, Recommenders, Reinforcement Learning\requirements-course3.txt'
.\.venv-course3\Scripts\python.exe -m ipykernel install --user --name ml-andrew-course3 --display-name "ML Andrew Course 3 (Python 3.12)"
~~~

From any Labs folder, open Jupyter with the shared environment:

~~~powershell
& ..\..\..\..\.venv-course3\Scripts\python.exe -m jupyter lab
~~~

The notebooks store their executed output for reading on GitHub. The Lunar
Lander lab uses Gymnasium’s current environment API and generates its demo under
`.local-only/generated/`.
