# Week 4 Lecture Notes - Evaluating Hypotheses

> These notes follow the Week 5 note-taking style: each relevant slide is shown first,
> followed by an explanation that goes beyond the text on the slide. For slides 14-28,
> `Lecture additions` records ideas explained in the available lecture source. The
> remaining deck was not taught in detail in that source, so slides 29-47 use
> `Study additions` and should not be misattributed to the lecturer. Timestamps,
> section-divider slides, and the final thank-you slide are omitted.

## Learning objectives

By the end of this lecture, you should be able to:

1. distinguish model parameters from hyperparameters;
2. explain the separate roles of training, validation, and test data;
3. prevent test-set and preprocessing leakage;
4. perform and interpret $K$-fold cross-validation;
5. describe the model-selection method taught in this lecture;
6. distinguish a training loss from an evaluation metric;
7. choose among MAE, MSE, and RMSE for a regression problem;
8. calculate classification metrics from a confusion matrix;
9. explain class imbalance and interpret an ROC curve;
10. diagnose under-fitting and over-fitting with training and validation error.

---

## 1. Model development and hyperparameter tuning

### 1.1 Parameters $\theta$ and hyperparameter $\lambda$

![Machine-learning process and hyperparameter tuning](<lecture_image/slide-14-machine-learning-process.png>)

*Slide 14: the three stages of training, hyperparameter selection, and final testing.*

### Lecture additions

The optimization algorithm learns the model parameters
$\theta_0,\theta_1,\ldots,\theta_n$. The regularization value $\lambda$ is a
hyperparameter, so it is not learned by the basic gradient-descent loop shown in the
lecture.

For each candidate $\lambda$, training can produce a different fitted model:

$$
\theta^*(\lambda)
=
\arg\min_{\theta}J(\theta;\lambda).
$$

The complete development process therefore contains two different decisions:

1. for one fixed $\lambda$, learn the best $\theta$;
2. compare the models produced by different $\lambda$ values and choose one model.

For example:

$$
\lambda_1 \rightarrow \theta^*(\lambda_1) \rightarrow E_1,
\qquad
\lambda_2 \rightarrow \theta^*(\lambda_2) \rightarrow E_2,
\qquad
\lambda_3 \rightarrow \theta^*(\lambda_3) \rightarrow E_3.
$$

Here, $E_i$ is an evaluation result for the model trained with $\lambda_i$.

Training error alone is not reliable for selecting $\lambda$. The same training data
has already influenced $\theta$, so its error is normally optimistic.

> A low training error does not guarantee a low error on unseen data.

Model selection needs labelled data that is not used to update $\theta$. This is the
role of validation data.

### 1.2 Why the test set must remain independent

![Why test data must remain independent](<lecture_image/slide-15-hyperparameter-tuning.png>)

*Slide 15: independent test data should simulate genuinely unseen data.*

### Lecture additions

The final test set represents the situation after deployment, when future inputs are
unknown. If its contents or results influence modelling decisions, it no longer gives
an honest estimate of generalization.

The lecturer extended the exam analogy:

- training data is the material used to study;
- validation data is a practice exam that can guide improvement;
- test data is the real exam.

Looking at the real exam while studying may improve that particular exam result without
improving general understanding. In the same way, repeatedly checking the test score
and modifying the model can overfit the development process to that test set.

$$
\text{test data used for model selection}
\Rightarrow
\text{test data has become validation data}.
$$

An honest final evaluation would then require a new untouched test set.

---

## 2. Training, validation, and test data

### 2.1 Where validation belongs in the workflow

![Validation data in the machine-learning process](<lecture_image/slide-16-validation-in-the-ml-process.png>)

*Slide 16: validation data supplies the evidence needed in Stage 1.2.*

### Lecture additions

The three data subsets answer different questions:

| Data subset | Question it answers |
|---|---|
| Training | Which parameter values $\theta$ fit this model configuration? |
| Validation | Which hyperparameters, features, preprocessing steps, and model configuration should be selected? |
| Test | How well does the final frozen pipeline perform on independent data? |

Validation data has ground-truth labels, so it can produce an evaluation metric.
However, it must not be used to update the parameters of the model being evaluated.

### 2.2 Three-way splitting

![Typical train-validation-test split](<lecture_image/slide-17-train-validation-test-split.png>)

*Slide 17: a typical 60/20/20 split.*

### Lecture additions

The 60/20/20 proportion is a useful example, not a universal rule. The appropriate
ratio depends on the amount of available data and the modelling problem. Keeping the
roles of the three subsets separate is more important than using one exact percentage.

For Assignment 1, the lecturer described this workflow:

1. keep the provided test set untouched;
2. split the provided labelled training data into a training subset and a validation
   subset;
3. fit candidate models on the training subset;
4. compare them using validation results;
5. freeze the complete pipeline;
6. generate predictions for the provided test inputs only at the end.

The provided test targets are hidden, so test MSE cannot legitimately be calculated or
used for tuning.

### 2.3 Preprocessing leakage

Validation data should be processed as if it were unseen:

- fit scalers using statistics from the training subset only;
- learn imputation values from the training subset only;
- fit encoders and feature selectors on the training subset only;
- apply the already-fitted transformations to validation and test data.

For $K$-fold cross-validation, this rule must be repeated inside every fold. A
preprocessing step fitted on all development data before cross-validation leaks
information from the current validation fold into its training folds.

### 2.4 The `country` feature example

The class discussed noticing that the countries in the test set differed from those in
the training data and then changing or removing the `country` feature. The lecturer
said this reasoning is invalid because test-set information has influenced model
development.

Keeping or removing the feature can still be justified with:

- domain knowledge;
- evidence from the training data;
- validation or cross-validation performance;
- a training-only ablation study;
- an encoding strategy that safely handles unknown categories.

It cannot be justified by inspecting the test-set categories.

> During model development, the test set must not influence features, preprocessing,
> hyperparameters, or model selection.

---

## 3. $K$-fold cross-validation

### 3.1 Procedure

![K-fold cross-validation procedure](<lecture_image/slide-19-k-fold-cross-validation.png>)

*Slide 19: rotate the validation fold while keeping the final test set separate.*

### Lecture additions

Cross-validation is performed only on the training or development data. The independent
test set is not one of the folds.

Let the development data be divided into $K$ folds:

$$
D_{\text{dev}}=F_1\cup F_2\cup\cdots\cup F_K.
$$

In iteration $i$:

- $F_i$ is the validation fold;
- the other $K-1$ folds are the training data;
- one model $M_i$ is fitted;
- its validation metric $E_i$ is calculated on $F_i$.

Every example is used for validation once and for training $K-1$ times. The average
validation result is

$$
\bar{E}=\frac{1}{K}\sum_{i=1}^{K}E_i.
$$

This average is an estimate of expected performance across several different
train-validation partitions. It is normally more stable than relying on one hold-out
split.

### 3.2 Choosing $K$

There is no universally best value of $K$. The lecturer connected $K$ to the size of
the validation fold:

| $K$ | Validation in each iteration | Training in each iteration |
|---:|---:|---:|
| 3 | about 33% | about 67% |
| 4 | 25% | 75% |
| 5 | 20% | 80% |

The trade-off is:

- a smaller $K$ needs fewer training runs but leaves less data for training in each run;
- a larger $K$ trains on more data per run but costs more and may produce very small
  validation folds;
- $K=5$ is popular because it gives an 80/20 split in every iteration at a manageable
  computational cost;
- $K=5$ is a convention, not a law.

When comparing hyperparameters, use the same folds and evaluation procedure for every
candidate. Otherwise the comparison may reflect different data partitions rather than
the hyperparameter change.

### 3.3 Why the best single fold is not automatically the model to keep

![Question raised after K-fold cross-validation](<lecture_image/slide-20-choosing-one-model-question.png>)

*Slide 20: cross-validation estimates average error but still leaves a model-selection
question.*

![Representative-model selection method](<lecture_image/slide-21-choosing-one-model-method.png>)

*Slide 21: the representative-model method taught in this lecture.*

### Lecture additions

After $K$ iterations, there are $K$ models and $K$ validation results. The lecturer
warned against automatically choosing the model with the lowest single-fold error. Its
validation fold may simply have been unusually easy.

The course method shown in the lecture is:

1. calculate the average validation error $\bar{E}$;
2. choose the model whose error is closest to that average.

$$
j=\arg\min_i\left|E_i-\bar{E}\right|.
$$

The goal is to choose a representative model rather than an extreme result. The slide
also warns that this model may still be biased. For assessed work, follow the course
specification and rubric if they prescribe this selection rule.

The symbol $E$ means a general evaluation metric, not necessarily MSE. A suitable
metric depends on whether the task is regression or classification and on the meaning
of different errors.

---

## 4. Loss functions and evaluation metrics

![Loss function compared with evaluation metric](<lecture_image/slide-23-loss-vs-evaluation-metric.png>)

*Slide 23: optimization convenience and evaluation meaning are different goals.*

### Lecture additions

A loss function is mainly chosen to make training possible and efficient. It should
provide useful mathematical behaviour for an optimizer such as gradient descent.

An evaluation metric is chosen to assess and communicate model quality. It should match
the practical objective and be understandable to the people using the result.

Therefore, the training loss and reported metric do not have to be identical:

$$
\text{training loss}\neq\text{evaluation metric}
$$

is a valid design choice.

For example, a regression model can:

- train with MSE because its squared form is smooth and convenient to differentiate;
- report RMSE because it has the same unit as the target;
- also report MAE because it is easy to interpret and less sensitive to outliers.

Reducing a loss often improves related metrics, but the loss and metric still serve
different purposes.

---

## 5. Regression evaluation metrics

### 5.1 The three metrics

![MAE, MSE, and RMSE formulas](<lecture_image/slide-25-regression-metric-formulas.png>)

*Slide 25: the formulas for MAE, MSE, and RMSE.*

![Comparison of MAE, MSE, and RMSE](<lecture_image/slide-26-regression-metric-comparison.png>)

*Slide 26: squared errors amplify outliers, while absolute errors dilute the influence
of a single instance as the data set grows.*

### Lecture additions

The lecturer used a prediction error of 10 to make the difference concrete:

- its contribution to absolute error is $10$;
- its contribution to squared error is $10^2=100$.

Therefore, a few large errors can dominate MSE and RMSE much more strongly than MAE.

### 5.2 Interpretation and units

| Metric | Sensitivity to large errors | Unit | Main interpretation |
|---|---|---|---|
| MAE | Lower | Same as the target | Average absolute size of an error |
| MSE | High | Target unit squared | Average squared error |
| RMSE | High | Same as the target | Square root of the average squared error |

The lecturer used gold price as an example. If the target is measured in million VND:

- MSE is measured in $(\text{million VND})^2$, which is difficult to explain;
- RMSE is measured in million VND, so it can be communicated as a typical prediction
  error in the original unit.

Because the square-root function is increasing for non-negative values, MSE and RMSE
rank models in the same order when they are calculated on the same data:

$$
\arg\min \operatorname{MSE}
=
\arg\min \operatorname{RMSE}.
$$

They still have different numerical values and different units.

### 5.3 Which metric should be used?

There is no single best metric for every regression problem:

| Situation | Metric to consider | Reason |
|---|---|---|
| Large errors must receive a strong penalty | MSE or RMSE | Squaring gives large errors more influence |
| The result must use the target's original unit | MAE or RMSE | Easier to communicate |
| Outliers are meaningful and should affect the score | MSE or RMSE | Sensitive to extreme errors |
| Outliers are noise and robustness is preferred | MAE | Less dominated by extreme errors |
| A smooth gradient-based loss is needed | MSE | Convenient derivative |

Do not choose a metric because its raw number looks smaller. MAE, MSE, and RMSE operate
on different scales, and MSE can even use a different unit.

### 5.4 Can MAE or RMSE be a training loss?

Yes, but the optimization behaviour differs:

- MSE is smooth and straightforward to differentiate;
- MAE is not differentiable at zero error and has a piecewise gradient;
- RMSE adds a square root, which makes its derivative less convenient.

Specialized problems may still need MAE, RMSE, or a custom loss that better represents
the real cost of prediction errors.

---

## 6. Classification evaluation metrics

![Classification metrics preview](<lecture_image/slide-28-classification-metrics-preview.png>)

*Slide 28: classification metrics introduced at the end of the recorded technical
lecture.*

### Lecture additions

The lecturer introduced the names:

- confusion matrix;
- accuracy;
- precision;
- recall;
- F1-score;
- ROC and ROC-AUC.

These measures were not explained in detail in the available lecture source. The
lecturer said they were not required for Assignment 1 and would be revisited for
Assignment 2. The rest of this section is therefore a deck-based study extension, not
a reconstruction of missing spoken content.

---

### 6.1 COVID-19 screening: classification errors have different costs

![COVID-19 screening setup](<lecture_image/slide-29-covid-screening-example.png>)

*Slide 29: an airport test sends a positive prediction to quarantine and a negative
prediction to no action.*

![False positive and false negative screening outcomes](<lecture_image/slide-30-false-positive-false-negative.png>)

*Slide 30: two classifiers can make different kinds of mistakes.*

![Labelled COVID-19 screening outcomes](<lecture_image/slide-31-covid-screening-outcomes.png>)

*Slide 31: true positive, false positive, true negative, and false negative outcomes.*

![Type I and Type II classification errors](<lecture_image/slide-32-type-one-type-two-errors.png>)

*Slide 32: a false positive is a Type I error and a false negative is a Type II error
under the positive-class convention used in the example.*

### Study additions

In this example:

- positive class: the traveller has COVID-19;
- negative class: the traveller does not have COVID-19;
- positive prediction: send the traveller to quarantine;
- negative prediction: take no action.

The two error types have different consequences:

| Error | Meaning in the screening example | Possible consequence |
|---|---|---|
| False positive | A non-COVID traveller is predicted as COVID | Unnecessary quarantine and further testing |
| False negative | A COVID-positive traveller is predicted as non-COVID | An infected traveller is missed and may expose others |

For a safety screening system, a false negative can be much more costly than a false
positive. This means that model selection should not only count the total number of
mistakes. It should distinguish which mistake was made and how costly it is.

Changing a classifier's decision threshold normally changes the balance:

- a lower threshold predicts more positive cases, often increasing recall but also
  increasing false positives;
- a higher threshold predicts fewer positive cases, often increasing specificity but
  also increasing false negatives.

The best threshold depends on the real cost of the two errors.

### 6.2 Classification outputs and the confusion matrix

![Four types of classification output](<lecture_image/slide-33-classification-output-types.png>)

*Slide 33: definitions of TP, FP, TN, and FN.*

### Study additions

For a binary classifier:

| Actual class | Predicted positive | Predicted negative |
|---|---|---|
| Positive | True positive (TP) | False negative (FN) |
| Negative | False positive (FP) | True negative (TN) |

The total number of evaluated instances is

$$
m=TP+FP+TN+FN.
$$

The words `positive` and `negative` are chosen by the modeller. Before calculating any
metric, state which class is positive. Reversing the positive class changes precision,
recall, and specificity.

![Worked confusion-matrix example](<lecture_image/slide-34-confusion-matrix-example.png>)

*Slide 34: the example contains $TP=3$, $TN=3$, $FN=1$, and $FP=2$.*

### Study additions

The slide uses actual classes as rows and predicted classes as columns. Some software
and textbooks display the axes differently, so always read the row and column labels
instead of relying on position alone.

For the example:

$$
m=3+3+1+2=9.
$$

All of the following metrics can be calculated from the same four counts:

| Metric | Calculation | Result |
|---|---:|---:|
| Accuracy | $(TP+TN)/m=(3+3)/9$ | $0.6667$ |
| Precision | $TP/(TP+FP)=3/5$ | $0.60$ |
| Recall | $TP/(TP+FN)=3/4$ | $0.75$ |
| Specificity | $TN/(TN+FP)=3/5$ | $0.60$ |
| F1 | $2TP/(2TP+FP+FN)=6/9$ | $0.6667$ |

Each result answers a different question. There is no universally best classification
metric without knowing the problem's error costs.

### 6.3 Accuracy

![Accuracy definition](<lecture_image/slide-35-accuracy.png>)

*Slide 35: accuracy is the proportion of all predictions that are correct.*

$$
\operatorname{Accuracy}
=
\frac{TP+TN}{TP+FP+FN+TN}.
$$

### Study additions

Accuracy treats false positives and false negatives as equally important. It is most
informative when:

- the classes are reasonably balanced;
- both kinds of mistake have similar costs;
- the test or validation sample represents the deployment distribution.

Accuracy can hide complete failure on a small but important class, as shown later in
the class-imbalance example.

### 6.4 Precision

![Precision definition](<lecture_image/slide-36-precision.png>)

*Slide 36: precision asks how many predicted positives are actually positive.*

$$
\operatorname{Precision}
=
\frac{TP}{TP+FP}.
$$

### Study additions

Precision focuses on the reliability of positive predictions. High precision means
that when the model raises a positive alert, it is usually correct.

Precision is important when false positives are costly, for example:

- marking legitimate email as spam;
- incorrectly flagging a financial transaction as fraud;
- sending a healthy person to an invasive follow-up procedure.

Precision says nothing about how many real positive cases were missed. A model can
achieve high precision by making only a few very confident positive predictions.

### 6.5 Recall

![Recall definition](<lecture_image/slide-37-recall.png>)

*Slide 37: recall is also called sensitivity or the true positive rate.*

$$
\operatorname{Recall}
=
\operatorname{TPR}
=
\frac{TP}{TP+FN}.
$$

### Study additions

Recall focuses on coverage of the actual positive class. High recall means that few
real positive cases are missed.

Recall is important when false negatives are costly, for example:

- disease screening;
- detecting a dangerous fault;
- identifying fraudulent activity before money is transferred.

A model can obtain high recall by predicting many cases as positive, but this may
create many false positives and reduce precision.

### 6.6 Specificity

![Specificity definition](<lecture_image/slide-38-specificity.png>)

*Slide 38: specificity is the true negative rate.*

$$
\operatorname{Specificity}
=
\operatorname{TNR}
=
\frac{TN}{TN+FP}.
$$

### Study additions

Specificity measures how well the classifier rejects actual negative cases. Its
complement is the false positive rate:

$$
\operatorname{FPR}
=
\frac{FP}{FP+TN}
=
1-\operatorname{Specificity}.
$$

Recall and specificity look at different actual classes:

- recall asks what fraction of actual positives were found;
- specificity asks what fraction of actual negatives were rejected correctly.

### 6.7 F1-score

![F1-score definition](<lecture_image/slide-39-f1-score.png>)

*Slide 39: F1 is the harmonic mean of precision and recall.*

$$
\operatorname{F1}
=
2\frac{\operatorname{Precision}\times\operatorname{Recall}}
{\operatorname{Precision}+\operatorname{Recall}}
=
\frac{2TP}{2TP+FP+FN}.
$$

### Study additions

The harmonic mean becomes low when either precision or recall is low. Therefore, a
high F1-score requires both:

- positive predictions that are usually correct;
- good coverage of the actual positive cases.

F1 is useful when the positive class matters and the class distribution is skewed. It
does not use true negatives, so it is not a complete summary when correct rejection of
the negative class is also important.

### 6.8 Class imbalance

![Accuracy under severe class imbalance](<lecture_image/slide-40-class-imbalance.png>)

*Slide 40: a trivial always-healthy classifier appears to achieve high accuracy.*

### Study additions

The example contains:

- 1000 healthy cases;
- 25 cancer cases.

If the model always predicts `healthy`, then

$$
TN=1000,\qquad FN=25,\qquad TP=0,\qquad FP=0.
$$

Its accuracy is

$$
\frac{1000}{1025}\approx 97.56\%.
$$

However, its cancer recall is

$$
\frac{0}{0+25}=0.
$$

The model misses every cancer case, so the apparently excellent accuracy is
misleading. Its precision has a zero denominator because it never predicts cancer;
many libraries report this as zero when configured to handle zero division. Its F1
score is also zero.

For imbalanced data:

- inspect the confusion matrix;
- report precision, recall, and F1 for the important class;
- use stratified data splitting;
- consider threshold tuning and class weighting;
- consider balanced accuracy when performance on both classes matters.

Balanced accuracy averages recall for the positive class and specificity for the
negative class:

$$
\operatorname{BalancedAccuracy}
=
\frac{\operatorname{Recall}+\operatorname{Specificity}}{2}.
$$

For the always-healthy classifier, balanced accuracy is $(0+1)/2=0.5$, which exposes
its chance-level performance across the two classes.

### 6.9 ROC curve

![ROC curve introduction](<lecture_image/slide-41-roc-curve.png>)

*Slide 41: an ROC curve plots true positive rate against false positive rate.*

### Study additions

A classifier often produces a probability or score before that score is converted into
a class label. Every possible decision threshold produces a pair:

$$
\left(
\operatorname{FPR},
\operatorname{TPR}
\right)
=
\left(
\frac{FP}{FP+TN},
\frac{TP}{TP+FN}
\right).
$$

The ROC curve plots these pairs:

- horizontal axis: false positive rate;
- vertical axis: true positive rate, which is recall;
- top-left corner: high recall with few false positives;
- diagonal line: behaviour comparable to random ranking.

The area under the curve, ROC-AUC, summarizes ranking performance across all
thresholds:

- AUC $=1$: perfect ranking;
- AUC $=0.5$: random ranking;
- AUC below $0.5$: the ranking is systematically reversed.

ROC-AUC does not choose the deployment threshold. The threshold must still be selected
using validation data and the relative costs of false positives and false negatives.
For a very rare positive class, a precision-recall curve can be more informative about
positive predictions than ROC alone.

---

## 7. Under-fitting, over-fitting, and hyperparameter tuning

### 7.1 Model complexity

![Under-fitting, appropriate fit, and over-fitting](<lecture_image/slide-43-overfitting-underfitting.png>)

*Slide 43: increasing model flexibility can move from under-fitting to a useful fit and
then to over-fitting.*

![Causes and consequences of model fit problems](<lecture_image/slide-44-model-complexity.png>)

*Slide 44: too little flexibility can under-fit, while too much flexibility can
over-fit.*

### Study additions

The goal is not to reproduce every training observation. The goal is to learn a pattern
that generalizes to unseen data.

| Condition | Training error | Validation error | Typical interpretation |
|---|---|---|---|
| Under-fitting | High | High | Model is too restricted to capture the real pattern |
| Appropriate fit | Low enough | Low | Model captures useful structure without learning noise |
| Over-fitting | Very low | Much higher | Model has learned training-specific noise or accidents |

Under-fitting is associated with high bias. Over-fitting is associated with high
variance: the learned model can change substantially when the training sample changes.

The number of features is only one source of complexity. Complexity can also be changed
through:

- polynomial degree;
- tree depth and minimum leaf size;
- the number of training iterations;
- neural-network size;
- regularization strength $\lambda$.

### 7.2 Identifying the problem with training and validation error

![Training and validation error across model complexity](<lecture_image/slide-45-identify-over-underfitting.png>)

*Slide 45: training error normally falls with complexity, while validation error often
falls and then rises.*

### Study additions

Use the same loss or metric definition to calculate:

$$
J_{\text{train}}
=
\frac{1}{m_{\text{train}}}
\sum_{i\in\text{train}}
L\left(h(x^{(i)}),y^{(i)}\right),
$$

$$
J_{\text{valid}}
=
\frac{1}{m_{\text{valid}}}
\sum_{i\in\text{valid}}
L\left(h(x^{(i)}),y^{(i)}\right).
$$

Read the validation curve from left to right:

1. low complexity: both errors are high, indicating under-fitting;
2. intermediate complexity: validation error reaches its minimum;
3. high complexity: training error keeps falling but validation error rises,
   indicating over-fitting.

The gap alone is not sufficient. A severely under-fitted model may have a small gap
because both errors are high. The main goal is strong validation performance with a
reasonable training-validation gap.

### 7.3 Selecting $\lambda$

![Selecting regularization strength with validation error](<lecture_image/slide-46-tune-lambda.png>)

*Slide 46: change $\lambda$, observe training and validation error, and never use test
data for this decision.*

### Study additions

For the regularized models used in this course:

- very small $\lambda$: weak regularization, more flexibility, greater risk of
  over-fitting;
- very large $\lambda$: strong regularization, less flexibility, greater risk of
  under-fitting;
- intermediate $\lambda$: may provide the best validation performance.

A safe tuning procedure is:

1. choose candidate values such as
   $\lambda\in\{0,0.001,0.01,0.1,1,10,100\}$;
2. train each candidate using the same training-validation split or the same
   cross-validation folds;
3. compare their average validation metrics;
4. select $\lambda^*$ using validation evidence;
5. freeze the pipeline;
6. evaluate once on the independent test set.

$$
\lambda^*
=
\arg\min_{\lambda}
J_{\text{valid}}(\lambda)
$$

when lower validation error is better.

Do not select the smallest training-validation gap without checking the validation
error. An under-fitted model can have a small gap but poor performance on both subsets.

---

## 8. Deck revision and $R^2$

![Week 4 revision topics](<lecture_image/slide-47-revision.png>)

*Slide 47: regression metrics, classification metrics, validation, and hyperparameter
tuning.*

### Study additions

The revision slide also lists $R^2$, which was not developed on the earlier regression
metric slides. For targets $y^{(i)}$, predictions $\hat{y}^{(i)}$, and the mean target
$\bar{y}$:

$$
R^2
=
1-
\frac{
\sum_{i=1}^{m}\left(y^{(i)}-\hat{y}^{(i)}\right)^2
}{
\sum_{i=1}^{m}\left(y^{(i)}-\bar{y}\right)^2
}.
$$

Interpretation:

- $R^2=1$: perfect predictions;
- $R^2=0$: no better than predicting the evaluation set's mean target;
- $R^2<0$: worse than that mean-prediction baseline.

$R^2$ is unitless and useful for describing variance explained, but it does not show
the typical error in the target's original unit. It is often reported together with
MAE or RMSE.

The complete Week 4 evaluation workflow is:

$$
\text{choose validation method}
\rightarrow
\text{tune hyperparameters}
\rightarrow
\text{select metric and threshold}
\rightarrow
\text{freeze the pipeline}
\rightarrow
\text{test once}.
$$

---

## 9. Assignment 1 checklist

- [ ] Keep the provided test set untouched during model development.
- [ ] Do not inspect test categories or distributions to make feature decisions.
- [ ] Split the provided labelled data into training and validation subsets, or use
  cross-validation.
- [ ] Fit preprocessing separately inside each training subset or training fold.
- [ ] Apply the fitted preprocessing to its validation subset.
- [ ] Compare all $\lambda$ values with the same validation protocol.
- [ ] Choose a metric that matches the practical cost and interpretation of errors.
- [ ] Explain the chosen hold-out ratio or value of $K$.
- [ ] Freeze the model and preprocessing pipeline before generating test predictions.
- [ ] Do not call validation data "test data" in the report.

---

## 10. Key takeaways

1. Parameters $\theta$ are learned from training data; hyperparameters such as
   $\lambda$ are selected with validation evidence.
2. Validation data guides model-development decisions. Test data evaluates the final
   frozen pipeline.
3. Looking at the test set during development makes the final test score less
   trustworthy.
4. Preprocessing must be fitted only on the current training data, including inside
   every cross-validation fold.
5. $K$-fold cross-validation rotates the validation fold and averages the resulting
   metrics while leaving the final test set outside the folds.
6. The lecture's representative-model method selects the fold model whose validation
   error is closest to the average error.
7. Loss functions support optimization; evaluation metrics support assessment and
   communication.
8. MAE is more robust to outliers, MSE strongly penalizes large errors, and RMSE keeps
   that penalty while returning to the target's original unit.
9. Accuracy alone can be misleading on imbalanced classification data.
10. Precision measures the reliability of positive predictions; recall measures how
    many actual positives were found; specificity measures how many actual negatives
    were rejected.
11. ROC curves show the trade-off between true positive rate and false positive rate
    across thresholds.
12. Under-fitting produces high training and validation error. Over-fitting produces a
    low training error but a substantially worse validation error.
13. Tune $\lambda$ with validation data or cross-validation, then use the test set only
    for the final evaluation.
