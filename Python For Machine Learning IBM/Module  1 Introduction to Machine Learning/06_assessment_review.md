# Assessment Review

## 1. One-page concept map

```text
Data quality
    ↓
Problem type ──→ classification / regression / clustering / other technique
    ↓
Lifecycle ──→ define → collect → prepare → develop/evaluate → deploy
    ↓                                                       ↓
Python ecosystem                                    MLOps and monitoring
NumPy → Pandas/SciPy/Matplotlib → Scikit-learn      package → API → container
                                                     → deploy → monitor → retrain
```

## 2. High-yield facts

- AI is the broad field; ML is a subset of AI; deep learning is a neural-network-based subset of ML.
- Supervised learning uses labeled data; unsupervised learning finds patterns without target labels.
- Semi-supervised learning combines a small labeled set with a larger unlabeled set.
- Reinforcement learning learns actions through environmental feedback.
- Classification predicts a class; regression predicts a continuous value; clustering discovers similar groups.
- Technique choice depends on the problem, available data, resources, and desired outcome.
- The ML lifecycle is problem definition, data collection, data preparation, model development/evaluation, and deployment.
- The lifecycle is iterative, and monitoring can trigger a return to earlier stages.
- ETL means Extract, Transform, Load.
- Data collection and preparation are frequently the most time-intensive parts of an ML project.
- Scikit-learn supports preprocessing, splitting, fitting, tuning, prediction, evaluation, and model export.
- A data scientist tends to emphasize the what and why; an ML engineer emphasizes reliable implementation and production; an AI engineer often composes foundation models into AI systems.
- Evaluation measures a model before deployment; monitoring tracks the production system afterward.
- Deployment can include serialization, an API, a container, scalable infrastructure, observability, and retraining.

## 3. Technique recognition drills

| Scenario | Likely technique | Reason |
|---|---|---|
| Predict whether a customer will leave | Classification | Target is churn/stay |
| Predict monthly revenue | Regression | Target is continuous |
| Segment customers without known segment labels | Clustering | Goal is to discover groups |
| Flag unusual transactions | Anomaly detection | Goal is to find rare abnormal cases |
| Find products commonly purchased together | Association | Goal is co-occurrence |
| Predict the next page in a browsing session | Sequence mining | Order and next event matter |
| Compress hundreds of correlated features | Dimensionality reduction | Goal is a lower-dimensional representation |
| Rank products for a user | Recommendation | Goal is personalized relevance |

## 4. Lifecycle scenario: customer churn

### Problem definition

Define churn precisely. Examples include account cancellation, contract non-renewal, or a period of inactivity. Specify the prediction horizon and the action the company will take.

### Data collection

Possible sources:

- Customer demographics.
- Contract and billing details.
- Product or service usage.
- Support interactions.
- Complaints and satisfaction measures.
- Historical churn outcomes.

### Data preparation

- Join sources by customer and prediction date.
- Clean invalid values and investigate missingness.
- Create behavior trends and recency/frequency features.
- Prevent future events from leaking into past training rows.
- Split data in a way that represents future deployment.

### Development and evaluation

- Start with a simple baseline.
- Train a classifier with Scikit-learn.
- Consider class imbalance and error cost.
- Evaluate with a confusion matrix and metrics such as precision, recall, F1, or ROC-AUC as appropriate.
- Select a decision threshold based on the retention action and its cost.

### Deployment

- Package preprocessing and model together.
- Expose batch scoring or an API for new customers.
- Containerize if required for consistent deployment.
- Log inputs, outputs, decisions, and model versions.

### Monitoring

- Input validity and drift.
- Churn rate and prediction distribution.
- Performance after outcomes become known.
- Retention campaign conversion and cost.
- Differences across relevant customer groups.

## 5. Role comparison drill

| Question | Data scientist | ML engineer | AI engineer |
|---|---|---|---|
| Main focus | Insight and predictive modeling | Reliable, scalable ML production | Foundation-model-based applications and workflows |
| Typical starting point | Business question and dataset | Prototype/model plus production requirements | Use case and pre-trained model |
| Strong emphasis | EDA, statistics, experiments, modeling | Pipelines, serving, monitoring, reliability | Prompting, RAG, adaptation, agents, integration |
| Typical output | Analysis, experiment, or predictive model | Production ML service or pipeline | Generative assistant, agent, or AI-enabled workflow |

Remember that actual teams often share these responsibilities.

## 6. Active recall questions

Try to answer before expanding the answer mentally.

1. **What is machine learning?**

   A data-driven subset of AI in which algorithms learn patterns from examples and apply them to new data.

2. **Why does data quality matter?**

   The model can learn only from the information and biases present in its data; poor input creates unreliable output.

3. **What distinguishes supervised from unsupervised learning?**

   Supervised learning has target labels; unsupervised learning does not.

4. **What is the difference between classification and regression?**

   Classification predicts a category or class probability; regression predicts a continuous numerical value.

5. **How is clustering different from classification?**

   Clustering discovers groups without known labels, while classification learns predefined classes from labeled data.

6. **What four factors guide technique selection?**

   The problem, available data, available resources, and desired outcome.

7. **What are the five lifecycle stages?**

   Problem definition, data collection, data preparation, model development/evaluation, and deployment.

8. **Why is problem definition critical?**

   A model can be technically correct yet useless if it predicts the wrong target or supports no meaningful decision.

9. **What does ETL stand for?**

   Extract, Transform, Load.

10. **Why do projects revisit earlier lifecycle stages?**

    Data limitations, evaluation failures, production drift, or changing requirements may invalidate earlier assumptions.

11. **What is feature engineering?**

    Creating informative model inputs from raw data and domain knowledge.

12. **Why split training and test data?**

    To fit the model on one subset and estimate generalization on data not used during fitting.

13. **Why might a time-based split be better than a random split?**

    It can reproduce the real task of using past data to predict future outcomes and avoid mixing future information into training.

14. **What is content-based recommendation?**

    Ranking candidate items by similarity to item characteristics a user previously preferred.

15. **What is collaborative filtering?**

    Recommending from interaction patterns of similar users or items.

16. **What is a hybrid recommender?**

    A system combining content-based and collaborative evidence, often with additional constraints.

17. **What does Scikit-learn provide?**

    Classical ML algorithms and tools for preprocessing, model selection, fitting, tuning, prediction, and evaluation.

18. **What does `fit` do?**

    It learns model or transformer parameters from training data.

19. **What does `predict` do?**

    It applies a fitted model to new feature rows and returns estimated outputs.

20. **What does a confusion matrix show?**

    Counts of actual versus predicted classification outcomes.

21. **Why use a Pipeline?**

    It keeps preprocessing and modeling together, applies transformations consistently, and helps prevent leakage during validation.

22. **How do evaluation and monitoring differ?**

    Evaluation tests a candidate model before release; monitoring observes the deployed system, real inputs, and later outcomes.

23. **What is MLOps?**

    Practices for packaging, deploying, operating, observing, governing, and updating ML systems reliably.

24. **What deployment steps are named in the source dialogue?**

    Save the model, create an API, containerize it, deploy/orchestrate it, monitor it, and retrain when necessary.

25. **What is the clearest difference between a data scientist and an ML engineer in the assessment dialogue?**

    The ML engineer has a stronger focus on production robustness, scalability, efficiency, and deployment.

26. **How does an AI engineer commonly use a foundation model?**

    By adapting and composing a pre-trained model with prompts, retrieval, fine-tuning, tools, and application logic.

## 7. Common traps

- Treating all numerical targets as classification because their values happen to be integers.
- Treating discovered clusters as inherently meaningful without domain validation.
- Scaling or imputing the full dataset before splitting, which leaks test information.
- Tuning hyperparameters on the final test set.
- Using accuracy alone for a highly imbalanced classification problem.
- Confusing model evaluation with business impact.
- Assuming deployment ends the lifecycle.
- Loading untrusted pickle artifacts.
- Believing a more complex model automatically creates a better product.
- Ignoring the cost, fairness, and explainability of errors in high-impact decisions.

## 8. Assessment mastery checklist

- [ ] I can define AI, ML, and deep learning and show their relationship.
- [ ] I can distinguish all four learning paradigms.
- [ ] I can match each major technique to its output type and example.
- [ ] I can list and explain every lifecycle stage.
- [ ] I can explain why the lifecycle is iterative.
- [ ] I can describe ETL and major preparation tasks.
- [ ] I can walk through the recommendation case study.
- [ ] I can distinguish content-based, collaborative, and hybrid recommendation.
- [ ] I can compare data scientist, ML engineer, and AI engineer responsibilities.
- [ ] I can map NumPy, Pandas, SciPy, Matplotlib, and Scikit-learn to their roles.
- [ ] I can reproduce the Scikit-learn sequence: split, preprocess, fit, predict, evaluate, save.
- [ ] I can explain why preprocessing should be fitted only on training data.
- [ ] I can describe packaging, API serving, containerization, orchestration, monitoring, and retraining.
- [ ] I can apply the lifecycle to a customer churn scenario.

## Source pages

- [Module 1 Summary and Highlights](https://app.notion.com/p/3960060838be8049bcade6d36e3d2962)
- [Connecting the Dots: Prepare for Your Assessment](https://app.notion.com/p/3960060838be80f2a66aef8c76bd5b2d)

