# Week 1 labs — Neural Networks

This folder contains the four Week 1 lab notebooks that appear in the
Advanced Learning Algorithms course outline:

| Course item | Local notebook |
| --- | --- |
| Optional Lab — Neurons and Layers | `C2_W1_Lab01_Neurons_and_Layers.ipynb` |
| Optional Lab — Coffee Roasting in TensorFlow | `C2_W1_Lab02_CoffeeRoasting_TF.ipynb` |
| Optional Lab — Coffee Roasting in NumPy | `C2_W1_Lab03_CoffeeRoasting_Numpy.ipynb` |
| Practice Lab — Neural Networks for Handwritten Digit Recognition, Binary | `C2_W1_Assignment.ipynb` |

The notebooks are kept together with their helpers, style sheet, images, and
data so that relative imports such as `lab_coffee_utils` and paths such as
`data/X.npy` work when Jupyter is started from this directory.

## Run locally

Start Jupyter with this directory as the working directory:

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning Andrew\2 Advanced Learning Algorithms\Week 1 Neural Networks\Labs"
python -m jupyter lab
```

The TensorFlow notebooks and the binary practice lab require a TensorFlow-
compatible Python environment. The parent project currently targets Python
3.14, while the available Windows TensorFlow wheels support older Python
versions. Use a separate Python 3.10–3.13 environment for those notebooks;
the NumPy coffee lab is kept independent of TensorFlow and can run in the
parent environment. A starter dependency file for that companion environment
is available at `../../requirements-course2-tensorflow.txt`.

## Local compatibility adjustments

- `C2_W1_Lab03_CoffeeRoasting_Numpy.ipynb` uses NumPy mean/std normalization
  instead of TensorFlow's `Normalization` layer.
- `lab_coffee_utils.py` uses a small NumPy sigmoid helper, so the NumPy lab
  does not import TensorFlow just to draw its plots.
- Scalar conversions are explicit in the NumPy lab and its plotting helper;
  this avoids the removed implicit one-element-array conversion in NumPy 2.x.

The practice-lab notebook contains completed exercise solutions from a public
reference mirror. Use it for personal study and do not submit the completed
solutions as your own coursework.

The extra `autils.load_weights()` helper is retained from the reference
notebook set but is not used by these notebooks; it expects optional weight
files (`data/w1.npy`, `b1.npy`, `w2.npy`, and `b2.npy`) that are not included
in the public mirror.

The notebooks are sourced for personal study from the public reference
repository [harishmuh/Machine-Learning-Specialization-Coursera](https://github.com/harishmuh/Machine-Learning-Specialization-Coursera).
The course structure was checked against the signed-in
[Advanced Learning Algorithms course page](https://www.coursera.org/learn/advanced-learning-algorithms)
and the requested [Improved implementation of softmax lecture](https://www.coursera.org/learn/advanced-learning-algorithms/lecture/Tyil1/improved-implementation-of-softmax).
