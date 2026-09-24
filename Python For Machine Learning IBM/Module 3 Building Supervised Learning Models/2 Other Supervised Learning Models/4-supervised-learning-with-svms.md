# Support Vector Machines (SVMs)

## Core idea

An SVM separates classes by choosing a decision boundary with a wide margin. The **support vectors** are the training points closest to that boundary; they determine where it sits. A wider margin can improve generalization, but real data may overlap, so a useful classifier usually allows some training violations.

SVMs also support regression. Support Vector Regression (SVR) fits a function while treating errors inside an **epsilon tube** around that function as negligible; points outside the tube contribute to the loss.

## How it learns

For a linear classifier, the model learns a hyperplane in the original feature space. The penalty parameter `C` controls the balance between a wide margin and training errors:

- Smaller `C`: stronger regularization and a softer margin; more violations may be accepted.
- Larger `C`: stricter fit to training points; the boundary can become more sensitive to noise.

If a straight boundary is insufficient, a **kernel** computes similarities that let the SVM form a nonlinear boundary without explicitly constructing every higher-dimensional feature. Common choices are linear, polynomial, and radial basis function (RBF). For the RBF kernel, `gamma` controls how local each training point's influence is: high values can produce intricate boundaries; low values produce smoother ones. In SVR, `epsilon` sets the tube width.

## Scikit-learn pattern

SVMs depend on feature scale, so scale numeric features inside a pipeline to prevent data leakage. In scikit-learn, `SVC` defaults to an RBF kernel (`kernel="rbf"`), while `LinearSVC` is a separate linear estimator.

```python
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC

model = make_pipeline(
    StandardScaler(),
    SVC(kernel="rbf", C=1.0, gamma="scale")
)
model.fit(X_train, y_train)
predictions = model.predict(X_test)
```

For regression, use `SVR(kernel="rbf", C=1.0, epsilon=0.1)` in the same kind of pipeline. SVMs can classify multiple classes too; scikit-learn's `SVC` handles multiclass classification by combining pairwise classifiers. Setting `probability=True` enables probability estimates through additional calibration work and can increase fitting time.

## Example: handwriting recognition

Represent each handwritten image as a vector of pixel intensities. A linear SVM can work well when there are many input features and classes are separated by a useful margin. If shapes overlap in a curved pattern, an RBF kernel can model a nonlinear boundary. Compare kernels and `C`/`gamma` with cross-validation rather than assuming the more flexible option is better.

## When it works well

- There are many features relative to the number of examples, especially with a linear boundary.
- A margin-based classifier is suitable, including text, image, and handwriting tasks.
- A nonlinear boundary is needed and dataset size is moderate enough for a kernel SVM.
- For SVR, a tolerance band around predictions is meaningful and small deviations should be ignored.

## Assumptions and common pitfalls

- Features should be scaled; scale within the training fold, not before cross-validation.
- Kernel choice and `C`/`gamma` interact. Tune them systematically; high `C` plus high RBF `gamma` can overfit.
- Kernel SVM training and prediction can be expensive as the number of rows grows; linear estimators are often more practical for large sparse text data.
- Overlapping classes and mislabeled outliers can strongly affect the boundary.
- SVM scores are not automatically calibrated probabilities. If risk probabilities matter, calibrate and evaluate them separately.
- Multiclass `SVC` entails multiple pairwise models, so fit and inference cost can grow with the number of classes.

## Active recall

1. What are support vectors, and why do they matter to the boundary?
2. What tradeoff does `C` control? How does RBF `gamma` affect boundary complexity?
3. Why should scaling occur inside a cross-validation pipeline?
