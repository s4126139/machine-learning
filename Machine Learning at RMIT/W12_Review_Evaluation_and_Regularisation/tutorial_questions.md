# Week 12 Tutorial Questions — Evaluation and Regularisation

Source: Canvas module item 8460590

Captured: 2026-09-24

## Objectives

- Revise evaluation metrics.
- Revise regularisation and the bias–variance trade-off.

## Questions

1. Given the following test-set results, compute `R²`, MAE, and MSE:

   | `y(i)` | `h(x)` |
   |---:|---:|
   | 1.8 | 1.8 |
   | 1.8 | 2.6 |
   | 2.5 | 3.4 |
   | 2.9 | 4.2 |
   | 6.0 | 5.0 |

2. Given the following binary classification results, draw the confusion matrix and
   compute accuracy, precision, recall, and F1 score:

   | `y(i)` | `h(x)` |
   |---:|---:|
   | 1 | 1 |
   | 1 | 0 |
   | 0 | 0 |
   | 1 | 1 |
   | 0 | 1 |
   | 0 | 1 |
   | 0 | 0 |
   | 1 | 1 |
   | 0 | 0 |
   | 1 | 0 |
   | 1 | 1 |
   | 0 | 1 |

3. Describe k-fold cross-validation. Why is it commonly used when evaluating
   prediction results?
4. Draw the bias–variance curve for model complexity. Explain each section,
   especially underfitting and overfitting.
5. Write the linear-regression regularisation loss function (Lasso regularisation).
   Explain each term and how different regularisation-parameter settings affect model
   complexity.
