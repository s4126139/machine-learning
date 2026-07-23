# Week 4 - Evaluating Hypotheses

## Lecture information

- Course: COSC2753 Machine Learning
- Topic: Evaluating Hypotheses
- Lecturer in the transcript: Bao Nguyen Thien
- Referenced deck: w4_ML_Viet2026B_EvaluatingHypotheses.pdf
- Transcript duration: approximately 1 hour 7 minutes
- Important: the recording begins in the middle of the lecture, not at slide 1. The slide numbers below were identified by matching the lecturer's explanation with the text, diagrams, and formulas in the PDF.

## Slides actually covered in this transcript

| Transcript time | Slide(s) | What the lecturer covered |
|---|---:|---|
| 00:00-10:42 | 14-15 | The machine-learning process, parameters $\theta$, hyperparameter $\lambda$, and why the test set must not be used to select $\lambda$ |
| 10:43-26:30 | 16-17 | Train/validation/test splitting, the role of validation data, Assignment 1, data leakage, and the rule against looking at test data |
| 26:31-29:29 | 19 | How $K$-fold cross-validation works |
| 29:30-39:53 | 20-21 | How to select one model from the $K$ models; the lecture's method selects a model whose error is close to the average error |
| 39:54-43:44 | 19, revisited | How to choose $K$; comparison of $K=3,4,5$ and their train/validation proportions |
| 43:45-44:24 | 23 | The difference between a loss function and an evaluation metric |
| 44:25-59:51 | 25-26 | MAE, MSE, RMSE, outliers, units, metric selection, and the relationship between loss and metrics |
| 59:52-1:00:17 | 28, preview only | Names of classification metrics; detailed teaching was postponed until Assignment 2 |
| 1:04:13-1:06:56 | Administrative, no lecture slide | Assignment 1 deadline announcement |

Slides 18, 22, 24, and 27 are section-divider slides and contain no separate technical explanation. There is no evidence in this transcript that slides 29-48 were taught in detail. In particular, the detailed material on confusion matrices, accuracy, precision, recall, F1, ROC, and overfitting/underfitting was not taught in this recording.

---

## 1. The overall process: train a model, then evaluate it

### Slides 14-15 - approximately 00:00-10:42

The lecture begins with the question: how should we determine a good value for the regularization parameter $\lambda$?

The machine-learning process contains two main stages.

### Stage 1: training and model development

- Use training data to find a good hypothesis/model.
- At the beginning, the model parameters may be randomly initialized.
- Calculate the loss function.
- Use an optimization algorithm such as gradient descent to repeatedly update the parameters $\theta_0,\theta_1,\ldots,\theta_n$.
- Continue updating the parameters until the loss converges to a sufficiently small value.
- The optimized parameter values define the best hypothesis for the current hyperparameter configuration.

The basic process is:

$$
\text{Training data}
\xrightarrow[\text{gradient descent}]{\text{minimize loss}}
\theta^*
\Rightarrow h_{\theta^*}(x)
$$

### Stage 2: final testing

- After model development has finished, provide the test data to the selected model.
- Generate predictions $\hat{y}$.
- Compare the predictions with the ground truth using an evaluation metric.
- The purpose is to estimate performance on unseen data.

$$
\text{Test data}
\xrightarrow{h_{\theta^*}}
\hat{y}
\xrightarrow{\text{compare with }y}
\text{evaluation metric}
$$

### Parameters $\theta$ versus hyperparameter $\lambda$

| Symbol | Role |
|---|---|
| $\theta_0,\theta_1,\ldots,\theta_n$ | Trainable parameters learned during optimization, for example by gradient descent |
| $\lambda$ | A hyperparameter controlling regularization strength; it is not automatically learned by the basic gradient-descent process described here |

For every fixed value of $\lambda$, training may produce a different optimal parameter vector:

$$
\theta^*(\lambda)
=
\arg\min_{\theta} J(\theta;\lambda)
$$

Therefore, model development has two related optimization problems:

1. Find the best $\theta$ for one fixed $\lambda$.
2. Compare the hypotheses produced by different $\lambda$ values and select a suitable $\lambda$.

### Stage 1.1 and Stage 1.2 on slide 14

- Stage 1.1: for one given $\lambda$, find the optimal hypothesis in the hypothesis space.
- Stage 1.2: repeat Stage 1.1 for several $\lambda$ values and compare the resulting hypotheses.
- Stage 2: evaluate the final selected hypothesis on independent test data.

An example search is:

$$
\lambda_1 \rightarrow \theta^*(\lambda_1) \rightarrow E_1
$$

$$
\lambda_2 \rightarrow \theta^*(\lambda_2) \rightarrow E_2
$$

$$
\lambda_3 \rightarrow \theta^*(\lambda_3) \rightarrow E_3
$$

Here, $E_i$ is an evaluation metric for the model associated with $\lambda_i$.

### Why training MSE cannot be used to select $\lambda$

At approximately 08:43, the lecturer emphasizes the following:

- MSE calculated on the training data primarily measures how well the model fits the same data used to learn $\theta$.
- Because the training data has already influenced the parameter estimates, training MSE is usually optimistic.
- A model with very low training MSE may still generalize poorly to new data.
- Therefore, a value of $\lambda$ cannot be judged reliably using only the MSE from the data used to fit the model.

The main warning is:

$$
\text{Low training error}
\nRightarrow
\text{Low generalization error}
$$

To choose $\lambda$, we need data that:

- is not used to update $\theta$;
- still has ground-truth $y$, so that a metric can be calculated;
- may be used during model selection.

That dataset is the validation set.

---

## 2. Why we need training, validation, and test sets

### Slides 15-17 - approximately 10:43-26:30

The lecturer corrects the simplified idea that machine learning only needs a training set and a test set.

- Training set: used to learn the model parameters.
- Validation set: used during development to compare models, select features, choose preprocessing decisions, and tune hyperparameters such as $\lambda$.
- Test set: used only for the final evaluation after all modeling decisions are complete.

| Dataset | Main purpose | Can it influence model-development decisions? |
|---|---|---|
| Training set | Fit the model, optimize $\theta$, and calculate training loss | Yes |
| Validation set | Select $\lambda$, preprocessing, features, and model configuration | Yes, for selection, but it must not be treated as training data |
| Test set | Final evaluation on data that simulates unseen real-world data | No |

Slide 17 gives a typical three-way split:

$$
60\% \text{ training}
\; / \;
20\% \text{ validation}
\; / \;
20\% \text{ testing}
$$

The exact proportions may change according to dataset size and the problem. The essential requirement is to keep the roles of the three subsets separate.

### The study and examination analogy

The lecturer uses an examination analogy:

- Training data is like the material and exercises used for studying.
- Validation data is like a practice exam or sample paper. It helps a student judge readiness and make improvements.
- Test data is like the real final exam.

If a student sees the real examination questions while studying and learns only those answers, the examination no longer measures general understanding. Similarly, when test data influences model development, the final test score no longer gives an honest estimate of generalization.

### Test data must simulate genuinely unseen data

After a model is deployed:

- the developer usually does not know which new inputs users will provide;
- real-world data may differ from the training examples;
- the model is expected to work on data it has never seen.

The test set must simulate this situation. Decisions based on test-set contents weaken its independence and make the final evaluation less trustworthy.

---

## 3. Direct connection to Assignment 1

### Slide 17 - approximately 13:47-17:10

For Assignment 1, the lecturer explains that students receive:

- Training data containing both $X$ and the ground-truth target $y$.
- Test data containing $X$, but not $y$.

Because the test targets are not provided, students cannot legitimately calculate test MSE or use test data to tune the model.

The correct workflow is:

1. Leave the provided test set untouched during model development.
2. Split the provided training data into:
   - a training subset;
   - a validation subset.
3. Fit the model on the training subset.
4. calculate the evaluation metric on the validation subset.
5. Compare candidate models and hyperparameters using validation results.
6. After the complete pipeline has been selected, generate predictions for the provided test set.

$$
\text{Provided training data}
\rightarrow
\begin{cases}
\text{Training subset}\\
\text{Validation subset}
\end{cases}
$$

$$
\text{Provided test data}
\rightarrow
\text{Keep independent until the final step}
$$

### How preprocessing must handle validation data

The validation set should be treated like unseen test data:

- Split the data before fitting data-dependent preprocessing.
- Fit a scaler, imputer, encoder, feature selector, or other learned transformation only on the training subset.
- Apply the already-fitted transformation to the validation subset.
- Do not allow validation statistics to flow back into the training pipeline.

Examples:

- Calculate the training mean and standard deviation, then use those values to scale validation data.
- Learn imputation values from training data only.
- Learn category mappings from training data and define a safe strategy for previously unseen categories.
- Select features using training data and validation evidence, not test data.

This prevents data leakage during validation.

---

## 4. Data leakage: do not look at the test set when making decisions

### Slides 15-17 - approximately 17:27-25:29

This is one of the most repeated and important messages in the lecture.

> During training and model development, no information from the test set should be used to choose features, preprocessing, hyperparameters, or the model.

### The "country" feature example

A class question considers this situation:

- someone notices that the countries in the test set differ from those in the training set;
- based on that observation, they decide to remove or change the country feature.

The lecturer says this justification is invalid because the decision was made after looking at the test set.

It may still be reasonable to keep or remove the country feature, but the justification must be independent of test-set contents. Valid evidence could include:

- domain knowledge;
- missingness, cardinality, or distribution observed in the training data;
- validation performance;
- a cross-validation or ablation study conducted only on training data;
- whether the encoding pipeline can safely handle unknown categories.

An invalid justification is:

> "I saw that the test set contains different countries, so I removed the country feature."

This allows test information to influence training and model selection.

### What happens if test data is repeatedly used for tuning?

If the model is evaluated on the test set and then adjusted according to the result:

- the test set is no longer independent;
- the model can gradually overfit to that particular test set;
- the test score becomes optimistically biased;
- performance on genuinely new data remains unknown.

In effect:

$$
\text{Using test data to select a model}
\Rightarrow
\text{the test set has become a validation set}
$$

A new, untouched test set would then be required for a valid final evaluation.

---

## 5. Hold-out validation

### Slides 16-17 - approximately 10:43-26:30

Hold-out validation divides the data into fixed subsets.

Complete procedure:

1. Hold out an independent test set from the full dataset.
2. Divide the remaining development data into training and validation subsets.
3. Fit candidate models on the training subset.
4. Tune and select models using the validation subset.
5. Evaluate the final selected model on the test set.

Advantages:

- simple;
- fast;
- easy to implement and explain.

Limitations:

- the result depends on one random split;
- a small dataset may leave too few validation examples;
- an unusually easy or difficult split may distort the metric.

Cross-validation can provide a more stable estimate when the available development data is limited.

---

## 6. $K$-fold cross-validation

### Slide 19 - approximately 26:31-29:29

First, keep the test set completely separate. Cross-validation is performed only on the training/development data.

Divide the training data into $K$ folds:

$$
D_{\text{train}}
=
F_1 \cup F_2 \cup \cdots \cup F_K
$$

During iteration $i$:

- $F_i$ is the validation fold;
- the other $K-1$ folds form the training data;
- train a model $M_i$;
- calculate validation metric $E_i$ on $F_i$.

Example for $K=5$:

| Iteration | Training folds | Validation fold | Output |
|---:|---|---|---|
| 1 | $F_2,F_3,F_4,F_5$ | $F_1$ | $M_1,E_1$ |
| 2 | $F_1,F_3,F_4,F_5$ | $F_2$ | $M_2,E_2$ |
| 3 | $F_1,F_2,F_4,F_5$ | $F_3$ | $M_3,E_3$ |
| 4 | $F_1,F_2,F_3,F_5$ | $F_4$ | $M_4,E_4$ |
| 5 | $F_1,F_2,F_3,F_4$ | $F_5$ | $M_5,E_5$ |

Each data point:

- is used for validation exactly once;
- is used for training $K-1$ times.

The average validation error is:

$$
\bar{E}
=
\frac{1}{K}\sum_{i=1}^{K}E_i
$$

This average provides an estimate of expected performance across several different train/validation partitions.

### Cross-validation does not include the test set

$$
\boxed{\text{Never place test examples inside the cross-validation folds}}
$$

If cross-validation is used to tune $\lambda$, every comparison between $\lambda$ values must occur inside the training/validation folds. The test set remains untouched until the model configuration is final.

---

## 7. Which model should be selected after $K$-fold cross-validation?

### Slides 20-21 - approximately 29:30-39:53

After $K$ iterations, there are:

- $K$ trained models $M_1,\ldots,M_K$;
- $K$ validation metrics $E_1,\ldots,E_K$.

The lecturer explains that the model should not be selected only because it achieved the lowest error on one fold:

- that result may occur because the fold was unusually easy;
- the model may not perform equally well on other folds or unseen data;
- selecting the most extreme good result may introduce bias.

According to the method explicitly presented in the lecture and on slide 21:

1. Calculate the average validation metric $\bar{E}$.
2. Select the model whose metric is closest to the average:

$$
j
=
\arg\min_i
\left|E_i-\bar{E}\right|
$$

The intention is to choose a representative model rather than the model associated with the best or worst single fold.

Important course note: this is the selection rule taught in the transcript and shown on slide 21. For Assignment 1, follow the course specification and rubric if they prescribe this method.

### The metric need not be MSE

The lecturer deliberately uses the general word "metric":

- regression can use MAE, MSE, RMSE, and other measures;
- classification can use accuracy, precision, recall, F1, ROC/AUC, and other measures;
- the correct metric depends on the problem and the intended interpretation.

---

## 8. How to choose $K$

### Slide 19 revisited - approximately 39:54-43:44

There is no universally optimal value of $K$.

Trade-offs:

- Smaller $K$:
  - a larger validation fold;
  - fewer model-training runs;
  - lower computational cost;
  - the estimate may depend more strongly on the particular partitions.
- Larger $K$:
  - a smaller validation fold;
  - each model trains on a larger proportion of the data;
  - more repeated training and higher computational cost;
  - a validation fold may become too small to represent the data well.

The lecturer connects $K$ with the proportion used for validation:

| $K$ | Validation proportion per iteration | Training proportion per iteration |
|---:|---:|---:|
| 3 | approximately 33% | approximately 67% |
| 4 | 25% | 75% |
| 5 | 20% | 80% |

$K=5$ is popular because each iteration produces the familiar 80/20 train/validation ratio without requiring too many repeated training runs.

Main conclusions:

- $K=5$ is a practical convention, not a universal law.
- $K=3,4,5,10,\ldots$ may be appropriate depending on dataset size and computational cost.
- The lecturer suggests thinking about a validation portion of roughly 20%-40% of the available training data.
- When comparing hyperparameters, use the same cross-validation setup for every candidate so that the comparison is fair.

---

## 9. Loss functions and evaluation metrics are different

### Slide 23 - approximately 43:45-44:24, revisited around 54:54-56:35

### Loss function

A loss function mainly supports optimization during training:

$$
\theta^*
=
\arg\min_{\theta}J(\theta)
$$

A useful training loss usually:

- represents the learning objective;
- has mathematical properties that support optimization;
- provides a practical derivative or gradient;
- allows algorithms such as gradient descent to update parameters effectively.

### Evaluation metric

An evaluation metric is selected to assess and communicate model quality:

- it should be intuitive;
- it should fit the actual goal of the problem;
- it should have meaning for a stakeholder or customer;
- it does not have to be identical to the training loss.

Therefore:

$$
\text{Training loss}
\neq
\text{Evaluation metric}
\quad\text{is completely valid}
$$

For example:

- train with MSE because it is mathematically convenient;
- report RMSE because it has the same units as the target;
- also report MAE because it is easy to interpret and less sensitive to outliers.

Training attempts to reduce the loss. This will often improve related evaluation metrics, but loss and metric serve different purposes.

---

## 10. Regression evaluation metrics

### Slides 25-26 - approximately 44:25-59:51

Notation:

- $m$: number of observations.
- $y^{(i)}$: ground-truth target for observation $i$.
- $\hat{y}^{(i)}=h_\theta(x^{(i)})$: prediction for observation $i$.
- $e_i=\hat{y}^{(i)}-y^{(i)}$: prediction error.

### 10.1 Mean Absolute Error - MAE

$$
\operatorname{MAE}
=
\frac{1}{m}
\sum_{i=1}^{m}
\left|\hat{y}^{(i)}-y^{(i)}\right|
$$

Interpretation:

- calculate the absolute size of every error;
- average those absolute errors;
- the result has the same unit as the target;
- it is easy to explain;
- it is less sensitive to outliers than MSE.

If one prediction differs from the truth by 10 units, its contribution to the absolute-error sum is 10.

Point from slide 26:

- as the dataset becomes larger, the relative influence of one single extreme instance is diluted in MAE;
- MAE is often useful when robustness to outliers is important.

### 10.2 Mean Squared Error - MSE

$$
\operatorname{MSE}
=
\frac{1}{m}
\sum_{i=1}^{m}
\left(\hat{y}^{(i)}-y^{(i)}\right)^2
$$

Interpretation:

- square every error before averaging;
- large errors receive a much stronger penalty;
- the metric is sensitive to outliers;
- the squared form is convenient for differentiation and gradient-based optimization.

The lecturer's numerical example:

- prediction error $=10$;
- its MAE contribution $=10$;
- its squared-error contribution $=10^2=100$.

MSE therefore amplifies large errors. A few unusual observations can dominate the final MSE.

Units:

- if the target is measured in million VND, MSE is measured in $(\text{million VND})^2$;
- a squared unit can be difficult to explain to a customer.

### 10.3 Root Mean Squared Error - RMSE

$$
\operatorname{RMSE}
=
\sqrt{
\frac{1}{m}
\sum_{i=1}^{m}
\left(\hat{y}^{(i)}-y^{(i)}\right)^2
}
=
\sqrt{\operatorname{MSE}}
$$

The lecturer emphasizes two benefits:

1. Because RMSE begins with squared errors, it remains sensitive to large errors and outliers.
2. The square root returns the result to the original target unit, which makes interpretation easier.

### Gold-price example

Suppose gold price is measured in million VND:

- MSE is measured in million-VND squared and is difficult for a customer to interpret.
- RMSE is measured in million VND.

It is natural to say:

> "The model's typical prediction error is approximately 7 million VND."

It is much less meaningful to say:

> "The model's error is 49 million-VND squared."

### Relationship between MSE and RMSE

The square-root function is monotonically increasing for non-negative values:

$$
\arg\min \operatorname{MSE}
=
\arg\min \operatorname{RMSE}
$$

MSE and RMSE have different numerical scales, but on the same evaluation data they normally rank candidate models in the same order.

---

## 11. Should we use MAE, MSE, or RMSE?

### Slides 25-26 - approximately 47:31-59:43

There is no single best regression metric for every problem. The correct choice depends on the data, the business objective, and the meaning of large errors.

| Situation | Metric to consider | Reason |
|---|---|---|
| Large errors must receive a strong penalty | MSE or RMSE | Squaring gives large errors more influence |
| The result must use the same units as the target | MAE or RMSE | Easier for stakeholders to interpret |
| Outliers are important signals that should affect the score | MSE or RMSE | Sensitive to extreme errors |
| Outliers are noise or have already been handled, and robustness is desired | MAE | Less dominated by extreme values |
| A gradient-based training loss should be simple to differentiate | MSE is often convenient | Smooth squared form and straightforward derivatives |

Do not select a metric simply because its numerical value looks smaller. MAE, MSE, and RMSE use different scales and sometimes different units, so their raw magnitudes should not be directly compared as if they were the same quantity.

### Can MAE or RMSE be used as a loss?

Yes. The lecturer does not say that MAE or RMSE is impossible as a loss. However:

- MSE is common because it is smooth and easy to differentiate.
- MAE is not differentiable at an error of zero and has a piecewise gradient.
- RMSE adds a square-root operation, making its derivative less convenient.
- In specialized applications, the loss function can and should be modified to reflect the real problem.

An important advanced idea is that no single loss function is appropriate for every machine-learning task.

---

## 12. Classification metrics - preview only

### Slide 28 - approximately 59:52-1:00:17

The lecturer only names:

- confusion matrix;
- accuracy;
- precision;
- recall;
- F1-score;
- ROC/ROC-AUC.

He states that this material is not required for Assignment 1 and will be revisited when the class begins Assignment 2. The transcript does not contain a detailed explanation of these classification metrics.

Slides 29-41 should therefore not be marked as taught merely because they are present in the PDF.

---

## 13. Key questions students should be able to answer

1. What is the difference between $\theta$ and $\lambda$?
   - $\theta$ is learned during training.
   - $\lambda$ is a hyperparameter selected using validation evidence.

2. Why is training MSE insufficient for choosing $\lambda$?
   - The same training data has already influenced $\theta$, so its error does not objectively estimate unseen performance.

3. Why must the test set not be used for tuning?
   - It loses independence, and the final result becomes optimistically biased.

4. What is the purpose of a validation set?
   - To select hyperparameters, preprocessing, features, and model configurations during development.

5. How does $K$-fold cross-validation work?
   - Split training data into $K$ folds, use each fold once for validation, and average the resulting metrics.

6. According to this lecture, which model is selected from the $K$ models?
   - The model whose validation error is closest to the average validation error.

7. Why is $K=5$ popular?
   - Each iteration uses approximately 80% for training and 20% for validation while keeping computation manageable.

8. What is the main difference between MSE and MAE?
   - MSE squares errors and is more sensitive to outliers; MAE uses absolute errors and is more robust.

9. Why use RMSE if MSE already exists?
   - RMSE preserves sensitivity to large errors but returns the result to the same unit as the target.

10. Must the training loss and evaluation metric be identical?
    - No. Loss supports optimization; metrics support evaluation and communication.

---

## 14. Assignment 1 implementation checklist

- [ ] Keep the provided test set untouched during model development.
- [ ] Do not use the distribution or categories in test data to decide whether to keep or remove features.
- [ ] Split the provided training data into training and validation subsets, or use cross-validation.
- [ ] Fit preprocessing only on each training subset/fold.
- [ ] Apply the fitted preprocessing to the corresponding validation subset/fold.
- [ ] Compare $\lambda$ values using the same validation protocol.
- [ ] Choose a regression metric that matches the problem.
- [ ] Explain why MAE, MSE, or RMSE was selected.
- [ ] Explain the chosen value of $K$ or the hold-out ratio.
- [ ] Generate test predictions only after the complete model and pipeline have been selected.
- [ ] Do not call validation data "test data" in the report.
- [ ] Base feature and preprocessing justifications on training/validation evidence or domain knowledge, never on inspecting test data.

---

## 15. One-page summary

Correct workflow:

$$
\text{Full data}
\rightarrow
\begin{cases}
\text{Development data}\\
\text{Independent test data}
\end{cases}
$$

$$
\text{Development data}
\rightarrow
\text{hold-out or }K\text{-fold validation}
\rightarrow
\text{select }\lambda\text{ and the model}
$$

$$
\text{Final selected model}
\rightarrow
\text{test once}
\rightarrow
\text{final evaluation}
$$

The most important points:

- Parameters $\theta$ are learned; hyperparameter $\lambda$ is tuned.
- Validation data is used to make model-development decisions.
- Test data must not influence those decisions.
- Cross-validation estimates average expected performance across several partitions.
- According to the lecture, a representative model has an error close to the average fold error.
- MAE is easy to interpret and less sensitive to outliers.
- MSE strongly penalizes large errors and is convenient for gradient descent.
- RMSE strongly penalizes large errors while using the target's original units.
- Loss functions support optimization; evaluation metrics support assessment and communication.

---

## 16. Administrative announcement

### Approximately 1:04:13-1:06:56

After discussing and correcting several dates during the conversation, the lecturer's final statement was:

- The Assignment 1 deadline was extended to midnight on Sunday, 9 August 2026.
- The lecturer indicated that the deadline/announcement would be updated to avoid confusion.

Check Canvas or the official assignment page as the final source of truth if it differs from this transcript. Before the final decision, the conversation mentioned 7, 8, 9, and 12 August, but the last confirmed date in the recording was Sunday, 9 August.
