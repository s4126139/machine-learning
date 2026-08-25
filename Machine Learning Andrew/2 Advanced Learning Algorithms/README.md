# Course 2: Advanced Learning Algorithms

This folder contains the lecture notes and local lab notebooks for Course 2 of
the Machine Learning Specialization. The material follows the four-week course
sequence: neural-network inference, neural-network training, practical model
development, and decision trees.

## Course map

| Week | Topic | Local material |
| --- | --- | --- |
| 1 | Neural Networks | [Lecture notes](<Week 1 Neural Networks>) · [Labs](<Week 1 Neural Networks/Labs/README.md>) |
| 2 | Neural network training | [Lecture notes](<Week 2 Neural network training>) · [Labs](<Week 2 Neural network training/Labs/README.md>) |
| 3 | Advice for applying machine learning | [Lecture notes](<Week 3 Advice for applying machine learning>) · [Labs](<Week 3 Advice for applying machine learning/Labs/README.md>) |
| 4 | Decision Trees | [Lecture notes](<Week 4 Decision Trees>) · [Labs](<Week 4 Decision Trees/Labs/README.md>) |

The lecture notes are arranged in numbered subfolders that mirror the lesson
order. Each week's `Labs` folder keeps its notebooks, helper modules, data, and
assets together so that the original relative imports and paths continue to
work locally.

## Run the labs locally

From the parent project directory, install the main environment with:

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning Andrew"
uv sync --locked
```

Then start Jupyter from the specific week's `Labs` directory. The individual
lab READMEs contain the exact command and the notebook list for that week.
Starting Jupyter there is important because the notebooks use relative imports
and paths such as `data/`.

Most Week 1–3 TensorFlow notebooks need a Python 3.10–3.13 environment with a
matching TensorFlow wheel. The parent project targets Python 3.14, so use the
starter dependency file [requirements-course2-tensorflow.txt](<requirements-course2-tensorflow.txt>)
for a separate companion environment. Week 1's NumPy coffee-roasting lab and
Week 3's scikit-learn labs can run without TensorFlow.

## Course and source notes

The course outline is available on the official
[Advanced Learning Algorithms course page](https://www.coursera.org/learn/advanced-learning-algorithms).
The Week 2 softmax notes correspond to the requested
[Improved implementation of softmax lecture](https://www.coursera.org/learn/advanced-learning-algorithms/lecture/Tyil1/improved-implementation-of-softmax).

The local notebooks were adapted for study from public reference mirrors. See
[THIRD_PARTY_NOTICES.md](<THIRD_PARTY_NOTICES.md>) for provenance, attribution,
and the distinction between course material and completed practice-lab
solutions.
