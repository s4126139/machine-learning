# Week 4 labs — Decision Trees

| Course item | Local notebook |
| --- | --- |
| Ungraded Lab — Decision Trees | `C2_W4_Lab_01_Decision_Trees.ipynb` |
| Ungraded Lab — Trees Ensemble | `C2_W4_Lab_02_Tree_Ensemble.ipynb` |
| Practice Lab — Decision Trees | `C2_W4_Decision_Tree_with_Markdown.ipynb` |

The notebooks share the local `utils.py`, `public_tests.py`, style sheet,
`heart.csv`, and figure assets in this directory. Start Jupyter here so the
relative imports and dataset path work:

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning Andrew\2 Advanced Learning Algorithms\Week 4 Decision Trees\Labs"
python -m jupyter lab
```

The tree-ensemble notebook uses XGBoost. The notebook no longer runs a
side-effecting `!pip install` cell; install the dependency in the project
environment before opening it. Its early-stopping call is written for the
current XGBoost API, where `early_stopping_rounds` is supplied to
`XGBClassifier`.

The notebooks are sourced for personal study from the public reference
repository [harishmuh/Machine-Learning-Specialization-Coursera](https://github.com/harishmuh/Machine-Learning-Specialization-Coursera).
The course structure was checked against the official
[Advanced Learning Algorithms course page](https://www.coursera.org/learn/advanced-learning-algorithms).

The practice-lab notebook contains completed exercise solutions from a public
reference mirror. Use it for personal study and do not submit the completed
solutions as your own coursework.
