# Week 2 labs — Neural network training

These notebooks follow the Week 2 lab items in the Advanced Learning
Algorithms course outline:

| Course item | Local notebook |
| --- | --- |
| Optional Lab — ReLU activation | `C2_W2_Relu.ipynb` |
| Optional Lab — Softmax | `C2_W2_SoftMax.ipynb` |
| Optional Lab — Multiclass classification | `C2_W2_Multiclass_TF.ipynb` |
| Optional Lab — Derivatives | `C2_W2_Derivatives.ipynb` |
| Optional Lab — Back propagation | `C2_W2_Backprop.ipynb` |
| Practice Lab — Neural Networks for Handwritten Digit Recognition, Multiclass | `C2_W2_Assignment.ipynb` |

The helper modules, style sheet, images, and `data/` directory are colocated
with the notebooks. Start Jupyter from this folder so imports and relative
paths resolve as they do in the course environment.

```powershell
cd "C:\Users\Khoai\RMIT\Machine_Learning\Machine Learning Andrew\2 Advanced Learning Algorithms\Week 2 Neural network training\Labs"
python -m jupyter lab
```

The notebooks use TensorFlow/Keras. Use a Python 3.10–3.13 environment with a
matching TensorFlow wheel; the parent project is currently pinned to Python
3.14, for which the standard Windows TensorFlow wheel is not available. A
starter dependency file is available at
`../../requirements-course2-tensorflow.txt`.

The notebooks are sourced for personal study from the public reference
repository [harishmuh/Machine-Learning-Specialization-Coursera](https://github.com/harishmuh/Machine-Learning-Specialization-Coursera).
The Week 2 practice-lab test helper is included from the corresponding public
`greyhatguy007` course mirror because the first reference mirror does not
ship that helper alongside `C2_W2_Assignment.ipynb`.

The practice-lab notebook contains completed exercise solutions from a public
reference mirror. Use it for personal study and do not submit the completed
solutions as your own coursework.

The course outline and the requested lecture are available at the official
[Advanced Learning Algorithms course page](https://www.coursera.org/learn/advanced-learning-algorithms)
and [Improved implementation of softmax](https://www.coursera.org/learn/advanced-learning-algorithms/lecture/Tyil1/improved-implementation-of-softmax).
