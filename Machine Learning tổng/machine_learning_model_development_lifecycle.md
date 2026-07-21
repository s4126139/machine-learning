# Machine Learning Model Development Lifecycle

## Verification scope

- Verified against the installed `scikit-learn 1.9.0` environment and the
  official stable documentation on 2026-07-21.
- Native scikit-learn items are shown with their exact class or function names.
- Collection, governance, deployment, monitoring, and retirement are broader
  MLOps stages; scikit-learn does not provide a complete MLOps platform.
- APIs can change between releases; check `sklearn.__version__` and the matching
  documentation before implementation.

## Official references

- [Scikit-learn User Guide](https://scikit-learn.org/stable/user_guide.html)
- [Scikit-learn API Reference](https://scikit-learn.org/stable/api/index.html)
- [Model selection and evaluation](https://scikit-learn.org/stable/model_selection.html)
- [Metrics and scoring](https://scikit-learn.org/stable/modules/model_evaluation.html)
- [Preprocessing API](https://scikit-learn.org/stable/api/sklearn.preprocessing.html)
- [Common pitfalls and data leakage](https://scikit-learn.org/stable/common_pitfalls.html)
- [Model persistence](https://scikit-learn.org/stable/model_persistence.html)

## High-level lifecycle

```text
1. Problem Definition
        ↓
2. Data Collection and Governance
        ↓
3. Data Understanding and Validation
        ↓
4. Data Splitting
        ↓
5. Preprocessing and Feature Engineering
        ↓
6. Baseline Development
        ↓
7. Model Training
        ↓
8. Validation and Hyperparameter Tuning
        ↓
9. Final Evaluation
        ↓
10. Model Finalisation and Packaging
        ↓
11. Deployment
        ↓
12. Monitoring
        ↓
13. Retraining and Maintenance
        ↓
14. Retirement
```

## Core principles

- Split the data before fitting data-dependent preprocessing.
- Fit imputers, encoders, scalers, feature selectors, and models on training data only.
- Apply the fitted transformations unchanged to validation, test, and production data.
- Use validation data or cross-validation for model and hyperparameter selection.
- Keep the test set untouched until final evaluation.
- Put preprocessing and the model in one reproducible pipeline.
- Track data, code, configuration, experiments, and model versions.
- Monitor the deployed model and retrain only through a controlled process.

# 1. Problem Definition

## Function

Define the business objective, prediction target, users, constraints, and success criteria.

## Key terms

- business objective;
- target variable;
- features;
- prediction unit;
- prediction horizon;
- regression;
- classification;
- clustering;
- ranking;
- forecasting;
- anomaly detection;
- offline metric;
- business KPI;
- cost of errors;
- latency;
- interpretability;
- fairness;
- privacy;
- acceptance criteria.

## Main outputs

- problem statement;
- target definition;
- task type;
- baseline expectation;
- evaluation metric;
- deployment requirements;
- risk and constraint list.

# 2. Data Collection and Governance

## Function

Acquire relevant, representative, authorised, and traceable data.

## Data sources

- databases;
- CSV/Excel files;
- APIs;
- sensors and IoT;
- application logs;
- surveys;
- third-party datasets;
- images, audio, text, and video;
- data warehouses and data lakes.

## Key terms

- sampling;
- population;
- labels;
- annotation;
- data lineage;
- schema;
- metadata;
- consent;
- personally identifiable information (PII);
- access control;
- licensing;
- retention policy;
- data versioning;
- source reliability;
- representativeness.

## Main checks

- correct target availability;
- sufficient sample size;
- coverage of important groups and time periods;
- label quality;
- duplicate observations;
- privacy and legal permission;
- train–production consistency.

# 3. Data Understanding and Validation

## Function

Understand the dataset and identify quality problems before modelling.

## Exploratory data analysis

- dataset shape;
- column types;
- summary statistics;
- distributions;
- class balance;
- correlations and associations;
- missing values;
- duplicate rows;
- outliers;
- rare categories;
- target distribution;
- time trends;
- group differences;
- possible leakage.

## Data-quality indicators

| Indicator | Function |
|---|---|
| Missing-value rate | Measure data completeness |
| Duplicate rate | Detect repeated observations |
| Unique-value count | Identify identifiers, constants, and categories |
| Class distribution | Detect class imbalance |
| Range and constraint violations | Detect invalid values |
| Label disagreement/error rate | Assess target quality |
| Freshness | Measure how current the data is |
| Coverage | Measure representation of important segments |

## Key terms

- data profiling;
- schema validation;
- data integrity;
- data leakage;
- target leakage;
- selection bias;
- sampling bias;
- label noise;
- covariate shift;
- concept drift.

# 4. Data Splitting

## Function

Create independent datasets for learning, model selection, and final evaluation.

## Dataset roles

| Dataset | Function |
|---|---|
| Training set | Learn model parameters such as weights and coefficients |
| Validation set | Select models, features, thresholds, and hyperparameters |
| Test set | Perform one final unbiased evaluation |

## Common proportions

- Illustrative rules of thumb: 70/15/15 or 80/20 with cross-validation inside
  the training portion.
- Scikit-learn does not prescribe a universal ratio; choose it from dataset
  size, task risk, group structure, and time constraints.

## Split strategies

| Strategy | Scikit-learn keyword | Use case |
|---|---|---|
| Random holdout | `train_test_split`, `ShuffleSplit` | Independent observations |
| Stratified holdout/CV | `stratify=`, `StratifiedShuffleSplit`, `StratifiedKFold` | Preserve class proportions |
| Group holdout/CV | `GroupShuffleSplit`, `GroupKFold` | Keep each person/device/patient in one partition |
| Stratified group CV | `StratifiedGroupKFold` | Preserve classes without overlapping groups |
| Time-aware CV | `TimeSeriesSplit` | Preserve temporal order |
| Standard K-fold | `KFold`, `RepeatedKFold` | General cross-validation |
| Leave-one-out | `LeaveOneOut` | Very small datasets; high computation |
| Spatial split | Group-based or custom splitter | Geographic generalisation; no dedicated spatial splitter |
| Nested CV | Inner and outer CV loops | Separate tuning from performance estimation |

Official module: [`sklearn.model_selection`](https://scikit-learn.org/stable/api/sklearn.model_selection.html).

## Leakage prevention

- split before normalization or standardization;
- keep related groups in the same split;
- place duplicate or near-duplicate records in the same split;
- preserve time order for temporal problems;
- do not use test performance to change the model;
- fit preprocessing separately inside every cross-validation training fold.

# 5. Preprocessing and Feature Engineering

## Function

Convert raw inputs into consistent, model-ready features.

## Preprocessing operations

| Purpose | Native scikit-learn keyword/API | Function |
|---|---|---|
| Simple imputation | `sklearn.impute.SimpleImputer` | Mean, median, most-frequent, or constant fill |
| Neighbour imputation | `sklearn.impute.KNNImputer` | Impute from nearest samples |
| Multivariate imputation | `sklearn.impute.IterativeImputer` | Estimate each incomplete feature from other features; experimental API |
| Missingness features | `MissingIndicator`, `add_indicator=True` | Record which values were missing |
| Standardisation | `sklearn.preprocessing.StandardScaler` | Feature-wise centring and variance scaling |
| Range scaling | `MinMaxScaler`, `MaxAbsScaler` | Feature-wise scaling to a learned range |
| Robust scaling | `RobustScaler` | Scale using outlier-robust statistics |
| Row normalisation | `Normalizer` | Scale each sample to unit norm; different from `MinMaxScaler` |
| Categorical encoding | `OneHotEncoder`, `OrdinalEncoder` | Convert categorical features to numeric features |
| Supervised encoding | `TargetEncoder` | Target-based encoding with internal cross-fitting during `fit_transform` |
| Mixed column types | `sklearn.compose.ColumnTransformer` | Apply different transformations to selected columns |
| End-to-end workflow | `sklearn.pipeline.Pipeline`, `make_pipeline` | Chain transformations and final estimator |
| Custom transformation | `FunctionTransformer` | Wrap a user-defined transformation |
| Distribution transformation | `PowerTransformer`, `QuantileTransformer` | Apply Yeo–Johnson/Box–Cox or quantile mapping |
| Nonlinear features | `PolynomialFeatures`, `SplineTransformer` | Generate powers, interactions, or spline bases |
| Text features | `CountVectorizer`, `TfidfVectorizer`, `HashingVectorizer` | Bag-of-words, TF–IDF, or hashing |
| Dense reduction | `sklearn.decomposition.PCA` | Reduce dense centred features; does not scale them |
| Sparse reduction | `sklearn.decomposition.TruncatedSVD` | Reduce sparse matrices such as TF–IDF without centring |
| Date/time features | pandas or `FunctionTransformer` | Custom calendar, lag, and rolling features |
| Image preprocessing/embeddings | External libraries | Resize, augmentation, and learned embeddings are outside core scikit-learn |

## Feature-selection methods

| Category | Native scikit-learn keyword/API |
|---|---|
| Low-variance filter | `VarianceThreshold` |
| Univariate filter | `SelectKBest`, `SelectPercentile`, `GenericUnivariateSelect` |
| Classification scores | `chi2`, `f_classif`, `mutual_info_classif` |
| Regression scores | `r_regression`, `f_regression`, `mutual_info_regression` |
| Recursive wrapper | `RFE`, `RFECV` |
| Sequential wrapper | `SequentialFeatureSelector` |
| Embedded/model-based | `SelectFromModel` with L1 or tree-based estimator |
| Model inspection, not a selector | `sklearn.inspection.permutation_importance` |
| Correlation filtering | Custom/pandas; no generic native selector |

Official guide: [Feature selection](https://scikit-learn.org/stable/modules/feature_selection.html).

## Class-imbalance keywords

| Method | Scope |
|---|---|
| Estimator `class_weight` | Native scikit-learn where supported |
| `sklearn.utils.class_weight.compute_class_weight` | Native class-weight calculation |
| `sample_weight` | Native per-sample weighting where supported |
| `SMOTE`, `RandomOverSampler`, `RandomUnderSampler` | External `imbalanced-learn`, not scikit-learn |

## Important rules

- Fit all learned preprocessing on training data only.
- Reuse the fitted preprocessing for validation, test, and new data.
- Do not fit a scaler, imputer, encoder, PCA, or feature selector on the test set.
- Use a `Pipeline`, often containing a `ColumnTransformer`, so preprocessing is
  fitted independently inside each training fold.
- For `TargetEncoder`, use `fit_transform(X_train, y_train)` on training data;
  transform held-out data with the fitted encoder.
- `IterativeImputer` requires `sklearn.experimental.enable_iterative_imputer`.
- `chi2` feature selection requires non-negative features.
- If using external resampling, split first and resample training folds only;
  keep validation and test sets in their natural distribution.

# 6. Baseline Development

## Function

Create a simple reference that advanced models must outperform.

## Baseline examples

| Task | Keyword/API | Function |
|---|---|---|
| Regression | `sklearn.dummy.DummyRegressor` | Mean, median, quantile, or constant baseline |
| Classification | `sklearn.dummy.DummyClassifier` | Prior, most-frequent, stratified, uniform, or constant baseline |
| Simple model | `LinearRegression`, `LogisticRegression` | Interpretable trained benchmark |
| Forecasting | Custom last-value or seasonal-naive rule | No dedicated scikit-learn forecasting baseline |
| Ranking | Custom popularity rule | No dedicated scikit-learn recommender baseline |
| Clustering | `KMeans` or domain grouping | Simple unsupervised reference |

## Key terms

- dummy model;
- naive baseline;
- benchmark;
- minimum acceptable performance;
- sanity check.

# 7. Model Training

## Function

Learn model parameters from the training data.

## Regression algorithms

| Keyword | Native scikit-learn estimator/transformer |
|---|---|
| Ordinary least squares | `sklearn.linear_model.LinearRegression` |
| Polynomial regression | `PolynomialFeatures` → `LinearRegression` or `Ridge`; not a standalone estimator |
| Ridge/L2 | `sklearn.linear_model.Ridge` |
| Lasso/L1 | `sklearn.linear_model.Lasso` |
| Elastic Net/L1+L2 | `sklearn.linear_model.ElasticNet` |
| Stochastic linear model | `sklearn.linear_model.SGDRegressor` |
| Robust linear models | `HuberRegressor`, `RANSACRegressor`, `TheilSenRegressor` |
| Quantile regression | `sklearn.linear_model.QuantileRegressor` |
| Generalised linear models | `PoissonRegressor`, `GammaRegressor`, `TweedieRegressor` |
| Decision tree | `sklearn.tree.DecisionTreeRegressor` |
| Random forest/Extra Trees | `RandomForestRegressor`, `ExtraTreesRegressor` |
| Gradient boosting | `GradientBoostingRegressor`, `HistGradientBoostingRegressor` |
| Support-vector regression | `sklearn.svm.SVR`, `LinearSVR` |
| Nearest neighbours | `sklearn.neighbors.KNeighborsRegressor` |
| Kernel Ridge | `sklearn.kernel_ridge.KernelRidge` |
| Gaussian process | `sklearn.gaussian_process.GaussianProcessRegressor` |
| Neural network/MLP | `sklearn.neural_network.MLPRegressor` |

## Classification algorithms

| Keyword | Native scikit-learn estimator |
|---|---|
| Logistic regression | `sklearn.linear_model.LogisticRegression` |
| Linear classifiers | `RidgeClassifier`, `SGDClassifier`, `Perceptron`, `PassiveAggressiveClassifier` |
| Gaussian Naive Bayes | `sklearn.naive_bayes.GaussianNB` |
| Count/binary/categorical Naive Bayes | `MultinomialNB`, `ComplementNB`, `BernoulliNB`, `CategoricalNB` |
| Nearest neighbours | `sklearn.neighbors.KNeighborsClassifier`, `NearestCentroid` |
| Kernel SVM | `sklearn.svm.SVC`, `NuSVC` |
| Linear SVM | `sklearn.svm.LinearSVC` |
| Decision tree | `sklearn.tree.DecisionTreeClassifier` |
| Random forest/Extra Trees | `RandomForestClassifier`, `ExtraTreesClassifier` |
| Gradient boosting | `GradientBoostingClassifier`, `HistGradientBoostingClassifier` |
| AdaBoost/bagging | `AdaBoostClassifier`, `BaggingClassifier` |
| Voting/stacking | `VotingClassifier`, `StackingClassifier` |
| Discriminant analysis | `LinearDiscriminantAnalysis`, `QuadraticDiscriminantAnalysis` |
| Gaussian process | `sklearn.gaussian_process.GaussianProcessClassifier` |
| Neural network/MLP | `sklearn.neural_network.MLPClassifier` |

## Clustering algorithms

| Keyword | Native scikit-learn estimator |
|---|---|
| K-Means | `sklearn.cluster.KMeans`, `MiniBatchKMeans`, `BisectingKMeans` |
| Hierarchical/agglomerative | `sklearn.cluster.AgglomerativeClustering` |
| Density-based | `DBSCAN`, `HDBSCAN`, `OPTICS` |
| Spectral | `SpectralClustering` |
| Other clustering | `MeanShift`, `Birch`, `AffinityPropagation` |
| Probabilistic mixture | `sklearn.mixture.GaussianMixture` |

`HDBSCAN` is native in scikit-learn 1.3 and later. `GaussianMixture` is a
probabilistic mixture model that can also produce component labels.

## Dimensionality-reduction algorithms

| Keyword | Native scikit-learn transformer |
|---|---|
| Principal components | `sklearn.decomposition.PCA`, `IncrementalPCA`, `KernelPCA` |
| Sparse/LSA | `sklearn.decomposition.TruncatedSVD` |
| Non-negative factors | `sklearn.decomposition.NMF` |
| Independent components | `sklearn.decomposition.FastICA` |
| Manifold visualisation | `sklearn.manifold.TSNE`, `Isomap`, `SpectralEmbedding` |

## Semi-supervised classification

| Keyword | Native scikit-learn estimator |
|---|---|
| Label propagation | `sklearn.semi_supervised.LabelPropagation` |
| Label spreading | `sklearn.semi_supervised.LabelSpreading` |
| Self-training/pseudo-labelling | `sklearn.semi_supervised.SelfTrainingClassifier` |

## Forecasting algorithms

- Scikit-learn has no dedicated ARIMA, SARIMA, exponential-smoothing, Prophet,
  RNN/LSTM, or temporal-transformer estimator.
- Native approach: create lag/rolling/calendar features, use
  `TimeSeriesSplit`, then fit a standard regressor such as
  `HistGradientBoostingRegressor`.
- Official example: [Lagged features for time-series forecasting](https://scikit-learn.org/stable/auto_examples/applications/plot_time_series_lagged_features.html).

## Anomaly-detection algorithms

| Keyword | Native scikit-learn estimator |
|---|---|
| Isolation Forest | `sklearn.ensemble.IsolationForest` |
| Local Outlier Factor | `sklearn.neighbors.LocalOutlierFactor` |
| Kernel One-Class SVM | `sklearn.svm.OneClassSVM` |
| Linear One-Class SVM | `sklearn.linear_model.SGDOneClassSVM` |
| Robust covariance | `sklearn.covariance.EllipticEnvelope` |

`LocalOutlierFactor(novelty=False)` identifies training-set outliers. Use
`novelty=True` only when predicting novelty on unseen observations.

## Recommendation and ranking algorithms

- Scikit-learn has no dedicated collaborative-filtering, recommender-system, or
  learning-to-rank estimator.
- `NearestNeighbors`, `NMF`, classifiers, and regressors can be building blocks,
  but production recommenders normally require custom or specialist libraries.

## Common external libraries—not native scikit-learn

| Keyword | External package |
|---|---|
| XGBoost | `xgboost` |
| LightGBM | `lightgbm` |
| CatBoost | `catboost` |
| SMOTE/resampling | `imbalanced-learn` |
| ARIMA/SARIMA/exponential smoothing | `statsmodels` or forecasting libraries |
| Prophet | `prophet` |
| Deep learning, RNN/LSTM/transformers/autoencoders | PyTorch, TensorFlow, or Keras |
| SHAP/LIME | `shap`, `lime` |
| Fairness metrics/mitigation | `fairlearn` or other fairness libraries |
| Optuna/Bayesian optimisation | `optuna` or other optimisation libraries |

Official model references:

- [Linear models](https://scikit-learn.org/stable/modules/linear_model.html)
- [Support-vector machines](https://scikit-learn.org/stable/modules/svm.html)
- [Nearest neighbours](https://scikit-learn.org/stable/modules/neighbors.html)
- [Decision trees](https://scikit-learn.org/stable/modules/tree.html)
- [Ensemble methods](https://scikit-learn.org/stable/modules/ensemble.html)
- [Clustering](https://scikit-learn.org/stable/modules/clustering.html)
- [Novelty and outlier detection](https://scikit-learn.org/stable/modules/outlier_detection.html)
- [Decomposition](https://scikit-learn.org/stable/modules/decomposition.html)
- [Neural-network models](https://scikit-learn.org/stable/modules/neural_networks_supervised.html)

## Training concepts

- parameters;
- loss function;
- objective function;
- optimiser;
- gradient descent;
- batch size;
- epoch;
- learning rate;
- regularisation;
- early stopping;
- class weights;
- random seed;
- convergence;
- reproducibility.

# 8. Validation and Hyperparameter Tuning

## Function

Choose the model configuration that generalises best.

## Validation methods

| Keyword | Native scikit-learn API |
|---|---|
| Single-metric CV | `cross_val_score` |
| Multi-metric CV | `cross_validate` |
| Out-of-fold predictions | `cross_val_predict`; diagnostic predictions, not always a valid performance estimate |
| Learning curve | `learning_curve`, `LearningCurveDisplay` |
| Validation curve | `validation_curve`, `ValidationCurveDisplay` |
| Predefined validation folds | `PredefinedSplit` |
| Nested CV | Inner search plus outer `cross_validate`; workflow, not one estimator |
| Probability calibration | `sklearn.calibration.CalibratedClassifierCV` |
| Decision-threshold tuning | `TunedThresholdClassifierCV` |

## Common hyperparameters

| Model family | Example hyperparameters |
|---|---|
| Polynomial model | Degree, interaction terms |
| Ridge/Lasso/Elastic Net | Regularisation strength, L1/L2 ratio |
| Decision tree | Maximum depth, minimum samples per leaf, split criterion |
| Random forest | Number of trees, maximum features, depth |
| Gradient boosting | Learning rate, number of estimators, depth, subsampling |
| KNN | Number of neighbours, distance metric, weighting |
| SVM | Kernel, `C`, `gamma` |
| Logistic regression | `C` (inverse strength), `l1_ratio`, solver |
| Neural network/MLP | Hidden layers, activation, `alpha`, learning rate, batch size, early stopping |

## Search algorithms

| Keyword | Native scikit-learn API | Function |
|---|---|---|
| Exhaustive grid | `GridSearchCV` | Evaluate every specified combination |
| Random search | `RandomizedSearchCV` | Sample a fixed number of configurations |
| Successive halving grid | `HalvingGridSearchCV` | Allocate more resources to promising candidates |
| Successive halving random | `HalvingRandomSearchCV` | Random search with successive resource allocation |
| Custom scorer | `sklearn.metrics.make_scorer` | Adapt a metric for CV/search |

Successive-halving search remains experimental in scikit-learn 1.9 and requires
`sklearn.experimental.enable_halving_search_cv`. Bayesian optimisation,
Hyperband, and Optuna are not core scikit-learn search utilities.

## Correct tuning order

1. Define candidate hyperparameters.
2. Train a new model for each candidate configuration.
3. Evaluate with validation data or cross-validation.
4. Select the best configuration.
5. Refit the selected pipeline on all development data.
6. Evaluate once on the untouched test set.

# 9. Evaluation Metrics

Official modules: [`sklearn.metrics`](https://scikit-learn.org/stable/api/sklearn.metrics.html)
and [metrics/scoring guide](https://scikit-learn.org/stable/modules/model_evaluation.html).
Metric functions evaluate predictions; scorer strings are used in `scoring=` for
cross-validation and hyperparameter search. Scorer strings always follow the
“higher is better” convention, so loss scorers are commonly prefixed with `neg_`.

## Regression metrics

| Keyword | `sklearn.metrics` function | CV/search scorer | Function |
|---|---|---|---|
| MAE | `mean_absolute_error` | `neg_mean_absolute_error` | Mean absolute error |
| MSE | `mean_squared_error` | `neg_mean_squared_error` | Squared-error loss |
| RMSE | `root_mean_squared_error` | `neg_root_mean_squared_error` | Error in target units |
| Median AE | `median_absolute_error` | `neg_median_absolute_error` | Outlier-robust absolute error |
| $R^2$ | `r2_score` | `r2` | Performance versus a constant-mean baseline; can be negative |
| MAPE | `mean_absolute_percentage_error` | `neg_mean_absolute_percentage_error` | Relative absolute error; unstable near zero |
| RMSLE | `root_mean_squared_log_error` | `neg_root_mean_squared_log_error` | Log-scale error for non-negative targets |
| Pinball loss | `mean_pinball_loss` | Custom `make_scorer` | Quantile-prediction error |

Adjusted $R^2$, sMAPE, WAPE, and MASE are not built-in scikit-learn metrics;
implement them as custom metrics when required.

## Classification metrics

| Keyword | `sklearn.metrics` function | Typical scorer |
|---|---|---|
| Accuracy | `accuracy_score` | `accuracy` |
| Balanced accuracy | `balanced_accuracy_score` | `balanced_accuracy` |
| Precision | `precision_score` | `precision`, `precision_macro`, `precision_weighted` |
| Recall/sensitivity | `recall_score` | `recall`, `recall_macro`, `recall_weighted` |
| Specificity/TNR | `recall_score(..., pos_label=negative_label)` | Custom `make_scorer` |
| F1 | `f1_score` | `f1`, `f1_macro`, `f1_weighted` |
| F-beta | `fbeta_score` | Custom `make_scorer` |
| ROC-AUC | `roc_auc_score` | `roc_auc`, `roc_auc_ovr`, `roc_auc_ovo` |
| Average Precision (AP) | `average_precision_score` | `average_precision` |
| Log loss | `log_loss` | `neg_log_loss` |
| Brier loss | `brier_score_loss` | `neg_brier_score` |
| MCC | `matthews_corrcoef` | `matthews_corrcoef` |
| Cohen's kappa | `cohen_kappa_score` | Custom `make_scorer` |
| Top-k accuracy | `top_k_accuracy_score` | `top_k_accuracy` |
| Confusion matrix | `confusion_matrix`, `multilabel_confusion_matrix` | Diagnostic output |
| Summary report | `classification_report` | Precision/recall/F1/support report |

Use “Average Precision (AP)” instead of the ambiguous label “PR-AUC”. Literal
trapezoidal PR area uses `precision_recall_curve` followed by `auc`; it is not
the same calculation as AP. Brier loss reflects overall probability error, not
calibration alone.

## Confusion-matrix terms

- true positive (TP);
- true negative (TN);
- false positive (FP);
- false negative (FN).

## Multiclass averaging

- `average="macro"`: unweighted mean across classes;
- `average="micro"`: aggregate all class decisions first;
- `average="weighted"`: weight each class by support;
- `average=None`: return per-class values where supported;
- `average="samples"`: multilabel sample-wise average where supported.

## Clustering metrics

| Keyword | `sklearn.metrics` function | Function |
|---|---|---|
| Silhouette | `silhouette_score` | Internal cohesion/separation; higher is better |
| Davies–Bouldin | `davies_bouldin_score` | Internal cluster similarity; lower is better |
| Calinski–Harabasz | `calinski_harabasz_score` | Between/within dispersion; higher is better |
| Adjusted Rand | `adjusted_rand_score` | Compare clusters with known labels |
| Normalised mutual information | `normalized_mutual_info_score` | Compare clusters with known labels |

## Forecasting metrics

- Native reuse: `mean_absolute_error`, `root_mean_squared_error`,
  `mean_absolute_percentage_error`, `mean_pinball_loss`.
- Custom: sMAPE, WAPE, MASE.
- Always evaluate with time-aware splits.

## Ranking and recommendation metrics

| Scope | Keyword/API |
|---|---|
| Native multilabel ranking | `ndcg_score`, `dcg_score`, `label_ranking_average_precision_score`, `label_ranking_loss`, `coverage_error` |
| Custom/external recommender metrics | Precision@K, Recall@K, Hit Rate@K, MAP@K, MRR, catalogue coverage, diversity, novelty |

`label_ranking_average_precision_score` is LRAP, not automatically recommender
MAP@K. `coverage_error` measures multilabel ranking depth, not catalogue coverage.

## Anomaly-detection metrics

- With labelled anomalies: reuse `precision_score`, `recall_score`, `f1_score`,
  `roc_auc_score`, and `average_precision_score`.
- Custom/domain-specific: precision@K, detection delay, operational false-alarm
  rate.

## Operational metrics

- Keywords: prediction latency, throughput, memory, CPU/GPU, model size,
  availability, service error rate, cost per prediction.
- These are production measurements, not dedicated `sklearn.metrics` functions.

## Fairness indicators

- Keywords: subgroup performance, demographic parity, equal opportunity,
  equalised odds, false-positive-rate parity, false-negative-rate parity.
- These are not dedicated core `sklearn.metrics` functions; use custom analysis
  or a specialist library such as Fairlearn.

# 10. Error Analysis and Robustness

## Function

Identify where, why, and for whom the model fails.

## Key activities

- inspect high-error examples;
- evaluate important data slices;
- compare training and validation performance;
- inspect confusion matrices;
- check class-specific errors;
- test missing and extreme values;
- test distribution shifts;
- check probability calibration;
- inspect fairness across subgroups;
- compare against the baseline;
- confirm that no leakage exists.

## Diagnostic concepts

| Pattern | Typical meaning |
|---|---|
| High training and validation error | Underfitting/high bias |
| Low training error, high validation error | Overfitting/high variance |
| Strong offline result, weak production result | Distribution mismatch, drift, leakage, or serving error |

## Interpretation tools

| Keyword | Native scikit-learn API/scope |
|---|---|
| Coefficients | Estimator-specific `.coef_` |
| Impurity importance | Tree-specific `.feature_importances_` |
| Permutation importance | `sklearn.inspection.permutation_importance` |
| PDP/ICE | `sklearn.inspection.PartialDependenceDisplay` |
| Residual/prediction error | `sklearn.metrics.PredictionErrorDisplay` |
| Confusion matrix | `ConfusionMatrixDisplay` |
| ROC/precision–recall/DET | `RocCurveDisplay`, `PrecisionRecallDisplay`, `DetCurveDisplay` |
| Reliability diagram | `sklearn.calibration.calibration_curve`, `CalibrationDisplay` |
| Probability calibration | `sklearn.calibration.CalibratedClassifierCV` |
| Learning/validation curves | `LearningCurveDisplay`, `ValidationCurveDisplay` |
| SHAP/LIME | External libraries, not scikit-learn APIs |

Threshold tuning and probability calibration are separate operations. Compute
permutation importance only after confirming held-out model performance;
correlated features can make importance values difficult to interpret.

# 11. Final Evaluation

## Function

Estimate final generalisation performance using untouched test data.

## Required outputs

- primary test metric;
- secondary metrics;
- confidence intervals where appropriate;
- per-class or subgroup results;
- baseline comparison;
- error analysis summary;
- latency and resource measurements;
- known limitations.

Scikit-learn has no universal evaluation-confidence-interval helper. Cross-
validation standard deviation is not automatically a confidence interval;
choose a statistically appropriate custom procedure when intervals are needed.

## Rules

- run after model selection is complete;
- do not tune using test results;
- use the same fitted preprocessing pipeline;
- report the metric selected during problem definition;
- document the exact test-data version.

# 12. Model Finalisation and Packaging

## Function

Create a reproducible, deployable model artefact.

## Items to version

- raw and processed data;
- split definitions;
- source code;
- feature definitions;
- preprocessing pipeline;
- model weights;
- hyperparameters;
- dependency versions;
- random seeds;
- evaluation results;
- model documentation.

## Common artefacts and tools

| Keyword | Scope/function |
|---|---|
| Fitted `Pipeline` | Persist preprocessing and estimator together |
| `joblib`, `pickle`, `cloudpickle` | Python/pickle-based persistence; load trusted artefacts only |
| `skops.io` | External safer persistence format with type inspection |
| ONNX + `skl2onnx` | External conversion/runtime path; not all estimators are supported |
| Dependency lock file | Pin Python, scikit-learn, NumPy, SciPy, and related versions |
| Immutable data reference | Reconstruct the exact training dataset |
| Git commit/training recipe | Reproduce code and configuration |
| Model registry/experiment tracker | External MLOps tooling |
| Docker image | External environment packaging |
| Model card/data sheet | Intended use, evaluation, risks, and limitations |

Official persistence guidance:
[Model persistence](https://scikit-learn.org/stable/model_persistence.html).
Pickle-based formats can execute arbitrary code when loaded. Loading a persisted
model under a different scikit-learn version is unsupported; preserve the full
environment and reproducible training recipe.

# 13. Deployment

## Function

Make the trained model available for real predictions.

Deployment frameworks, APIs, containers, registries, release strategies, and
production observability are outside core scikit-learn. Scikit-learn supplies
fitted estimators, pipelines, prediction APIs, offline evaluation, and
[computational-performance guidance](https://scikit-learn.org/stable/computing/computational_performance.html).

## Deployment patterns

| Pattern | Function |
|---|---|
| Batch prediction | Process large datasets on a schedule |
| Online API | Return predictions per request |
| Streaming inference | Process continuous event streams |
| Edge deployment | Run on a local device |
| Embedded model | Integrate directly into an application |

## Release strategies

- shadow deployment;
- canary release;
- blue–green deployment;
- A/B testing;
- champion–challenger testing;
- rollback plan.

## Serving requirements

- identical feature definitions;
- identical preprocessing;
- input schema validation;
- dependency management;
- authentication and authorisation;
- logging and tracing;
- latency and capacity planning;
- fallback behaviour;
- model-version tracking.

# 14. Monitoring

## Function

Detect data, model, business, fairness, and infrastructure problems after deployment.

## Monitoring categories

| Category | Examples |
|---|---|
| Data quality | Missing values, invalid values, schema changes, category changes |
| Data drift | Feature-distribution changes |
| Prediction drift | Changes in predicted values or class proportions |
| Concept drift | Changes in the relationship between inputs and target |
| Model performance | Accuracy, F1, MAE, RMSE, calibration |
| Business performance | Revenue, conversion, retention, operational savings |
| Fairness | Subgroup metrics and error-rate differences |
| Infrastructure | Latency, throughput, failures, CPU/GPU, memory, cost |

## Drift indicators

| Keyword | Implementation scope |
|---|---|
| Population Stability Index (PSI) | Custom or monitoring library |
| Kolmogorov–Smirnov two-sample test | `scipy.stats.ks_2samp` |
| Jensen–Shannon distance | `scipy.spatial.distance.jensenshannon` |
| Kullback–Leibler/relative entropy | `scipy.stats.entropy` |
| Wasserstein distance | `scipy.stats.wasserstein_distance` |
| Category-frequency change | Custom aggregation |
| Missing-value-rate change | Custom aggregation |

These are general MLOps/SciPy/custom indicators, not native scikit-learn
monitoring APIs. Scikit-learn does not continuously monitor deployed models.

## Key terms

- observability;
- alert threshold;
- service-level objective (SLO);
- feedback loop;
- delayed labels;
- production skew;
- training–serving skew;
- incident response.

# 15. Retraining and Maintenance

## Function

Update the model safely when data, behaviour, requirements, or performance change.

## Retraining triggers

- scheduled retraining;
- performance degradation;
- data drift;
- concept drift;
- new labelled data;
- new features;
- business-rule changes;
- fairness concerns;
- infrastructure or dependency changes.

## Retraining process

1. Collect and validate new data.
2. Create new versioned train, validation, and test datasets.
3. Refit preprocessing and candidate models.
4. Repeat tuning and evaluation.
5. Compare the candidate with the current production model.
6. Complete approval and risk checks.
7. Deploy gradually with rollback support.
8. Continue monitoring.

## Key terms

- champion model;
- challenger model;
- continuous training;
- automated retraining;
- human approval;
- regression testing;
- backward compatibility;
- rollback;
- audit trail.

# 16. Model Retirement

## Function

Remove models that are obsolete, unsafe, unsupported, or no longer useful.

## Retirement checklist

- identify all model consumers;
- replace or disable prediction endpoints;
- archive the model and documentation;
- preserve required audit records;
- revoke unused access and credentials;
- update dependent applications;
- stop monitoring and compute resources;
- communicate the change to stakeholders.

# End-to-end checklist

## Before training

- [ ] Define the target, task type, metric, and business objective.
- [ ] Validate data permission, quality, labels, and representativeness.
- [ ] Design the correct random, stratified, group, spatial, or time split.
- [ ] Lock the test set before data-dependent preprocessing.
- [ ] Establish a baseline.

## During development

- [ ] Fit preprocessing only on training folds.
- [ ] Use a pipeline to prevent leakage.
- [ ] Compare appropriate candidate algorithms.
- [ ] Tune hyperparameters using validation or cross-validation.
- [ ] Track experiments, code, data, seeds, and configurations.
- [ ] Perform error, robustness, calibration, and fairness analysis.

## Before deployment

- [ ] Refit the selected pipeline on approved development data.
- [ ] Evaluate once on untouched test data.
- [ ] Compare against the baseline and current production model.
- [ ] Document metrics, limitations, and intended use.
- [ ] Package preprocessing and model together.
- [ ] Define monitoring, alerting, rollback, and ownership.

## After deployment

- [ ] Monitor data quality, drift, performance, fairness, and infrastructure.
- [ ] Collect prediction outcomes and feedback where permitted.
- [ ] Investigate alerts and production errors.
- [ ] Retrain through the same controlled lifecycle.
- [ ] Retire obsolete model versions safely.
