# Week 3 labs

The course page lists these lab items:

| Assignment | Local source | Runnable notebook |
| --- | --- | --- |
| [State-action value function (optional lab)](https://www.coursera.org/learn/unsupervised-learning-recommenders-reinforcement-learning/ungradedLab/X09lt/state-action-value-function-optional-lab) | .local-only/original-labs/Week 3 Reinforcement learning/1 State-action value function/ | [State-action value function example.ipynb](<1 State-action value function/State-action value function example.ipynb>) |
| [Reinforcement Learning](https://www.coursera.org/learn/unsupervised-learning-recommenders-reinforcement-learning/programming/q5vKI/reinforcement-learning) | .local-only/original-labs/Week 3 Reinforcement learning/2 Lunar lander/ | [C3_W3_A1_Assignment.ipynb](<2 Lunar lander/C3_W3_A1_Assignment.ipynb>) |

Each runnable copy keeps its helper and data assets beside the notebook.
The Lunar Lander notebook uses Gymnasium v3 and saves a GIF demonstration under
.local-only/generated/; its executed output is embedded in the notebook.
Executed outputs are saved for GitHub.
The Lunar Lander run reached the 200-point target after 661 episodes and saved the learned checkpoint as `lunar_lander_model.h5`. Its generated GIF stays under `.local-only/generated/` and is embedded as an animated notebook output.

Create the shared environment using the
[Course 3 setup guide](<../../README.md>). From any lab folder, start Jupyter:

~~~powershell
& ..\..\..\..\.venv-course3\Scripts\python.exe -m jupyter lab
~~~
