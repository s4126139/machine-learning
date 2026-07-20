# Model Lifecycle and Recommendation Case Study

## 1. The machine learning lifecycle

An ML product is created through a lifecycle, not a single training command.

![Machine learning process lifecycle](assets/05_machine_learning_lifecycle.png)

The five high-level stages are:

1. Problem definition.
2. Data collection.
3. Data preparation.
4. Model development and evaluation.
5. Model deployment.

Monitoring and continuous improvement follow deployment and may send the team back to any earlier stage.

## 2. Why the lifecycle is iterative

The lifecycle is often presented as a sequence for clarity, but real projects move backward and forward.

Examples:

- Exploratory analysis reveals that the original problem cannot be answered with available data.
- Evaluation reveals label leakage, so the team revises features and data preparation.
- A deployed model performs poorly for a user subgroup, so the team collects better data.
- Business requirements change, so the target, metric, or decision threshold must change.
- Production data drifts, requiring retraining or a different modeling approach.

Iteration is normal. A project should make the feedback loops explicit instead of treating rework as failure.

## 3. Stage-by-stage responsibilities

### Stage 1: Problem definition

Translate a broad request into a measurable ML problem.

Clarify:

- Who will use the output?
- What action will the prediction support?
- What exactly is the target event or value?
- What is the prediction unit: user, transaction, product, image, or time interval?
- How far into the future should the prediction apply?
- What types of errors matter most?
- Which business metric determines success?
- Is ML necessary, or would a rule or analytical report solve the problem more safely?

A technically accurate model can still fail if it solves the wrong problem.

### Stage 2: Data collection

Identify, acquire, and consolidate relevant data. Sources may include:

- Transactional databases.
- Product catalogs.
- Application and web event logs.
- Surveys, ratings, or feedback.
- External datasets.
- Labels created by people or operational outcomes.

Check availability, permissions, history, granularity, freshness, coverage, and possible bias. The collected population should resemble the population where the model will be used.

### Stage 3: Data preparation

Transform raw sources into a modeling dataset.

Typical work includes:

- Joining and reshaping tables.
- Removing duplicates and irrelevant records.
- Correcting data types and inconsistent formats.
- Investigating missing values and choosing an appropriate treatment.
- Detecting and handling extreme values.
- Encoding categorical variables.
- Scaling numerical features where appropriate.
- Creating derived features.
- Performing exploratory data analysis.
- Designing leakage-safe training, validation, and test splits.

Data collection and preparation frequently overlap. Discovering a missing field during preparation can trigger additional collection.

### ETL

**ETL** means **Extract, Transform, Load**:

1. Extract data from one or more sources.
2. Transform it through cleaning, standardization, joining, and derivation.
3. Load the result into a central location where analysts and engineers can use it.

ETL reduces repeated querying across disconnected systems and can improve consistency. In modern architectures, transformations may also occur after loading, commonly called ELT, but the course emphasizes ETL.

### Stage 4: Model development and evaluation

Model development includes:

- Selecting a baseline.
- Choosing candidate algorithms.
- Fitting models on training data.
- Tuning hyperparameters without using the final test set.
- Comparing candidates with appropriate metrics.
- Examining subgroup performance and important error cases.
- Checking whether the model meets technical and business requirements.

Evaluation must use data not used to fit the model. A high score is insufficient if the split does not represent real deployment conditions.

### Stage 5: Deployment

Deployment integrates the selected model into a production process, such as:

- A batch-scoring pipeline.
- A web or mobile application.
- A real-time API.
- A recommendation service.
- An internal decision-support tool.

The production system must reproduce preprocessing, handle invalid inputs, meet latency and reliability needs, log enough information for diagnosis, and provide a safe fallback.

### Monitoring and improvement

After deployment, monitor:

- Input quality and schema validity.
- Feature-distribution drift.
- Prediction distributions.
- Latency, throughput, failures, and resource use.
- Delayed ground-truth performance when labels become available.
- Business outcomes and user behavior.
- Fairness or subgroup performance where relevant.

Monitoring can trigger investigation, threshold changes, retraining, rollback, or problem redefinition.

## 4. Where most effort goes

The beauty-product case emphasizes that data collection and preparation consume extensive time. These stages involve sourcing, access, consolidation, cleaning, formatting, feature engineering, domain validation, EDA, and split design. They often determine the ceiling on model quality.

The practical lesson is: allocate project time to data and validation, not only to algorithm selection.

## 5. Case study: beauty-product recommendation system

### Business and user problem

- **Business goal:** increase company revenue.
- **User need:** receive useful product recommendations based on purchase history and skincare needs.
- **Technical goal:** build and deploy a model that ranks relevant products for each customer.

This framing connects the user problem, business outcome, and model output.

### Available data

#### User and transaction data

- Demographics.
- Purchase history.
- Completed transaction details.

#### Product data

- Inventory.
- Purpose or function.
- Ingredients.
- Popularity.
- Customer ratings.

#### Behavioral data

- Saved and liked products.
- Search history.
- Frequently visited product pages.
- Other interactions that indicate preference or avoidance.

### Consolidation

The team wrangles, aggregates, joins, merges, and maps records into a central source. Centralization prevents every modeling task from repeatedly querying many separate databases.

### Cleaning and validation

The team investigates:

- Errors and incompatible formats.
- Missing fields.
- Irrelevant records.
- Extreme values.
- Incorrect date, text, or numerical types.

Missingness must be interpreted. Removing a missing value, imputing it, or preserving a missing indicator can imply different assumptions.

### Feature engineering

Candidate features include:

- Average time between a customer's transactions.
- Products a customer purchases most often.
- Skincare issues targeted by each product.
- Skincare needs associated with each user.
- Ingredients a user appears to avoid.
- Product popularity, ratings, and interaction frequency.

Feature engineering converts raw events into signals a model can use. Every feature should be computable at prediction time and should not reveal future information.

### Exploratory analysis and domain review

The team:

- Plots distributions and relationships.
- Performs correlation analysis.
- Looks for signals related to buying behavior and skincare needs.
- Validates interpretations with a beauty-product subject-matter expert.

Domain review is valuable because a statistical relationship may be misleading, unsafe, or inconsistent with how products are actually used.

### Time-aware train/test design

The case considers random splitting but chooses a temporal strategy:

- Each user's most recent transaction goes into the test set.
- The same user must have at least one earlier transaction in training.

This better simulates the intended question: can past behavior predict a future purchase? Randomly mixing past and future transactions could give an unrealistically optimistic result.

## 6. Recommendation approaches

### Content-based filtering

Content-based filtering recommends items similar to items a user already liked or purchased.

Possible process:

1. Represent products using ingredients, purpose, category, and other content features.
2. Calculate similarity between previously purchased and candidate products.
3. Apply constraints, such as excluding unwanted ingredients.
4. Rank the remaining candidates.

Strength: it can explain recommendations through item characteristics. Limitation: it may over-specialize and recommend items too similar to known preferences.

### Collaborative filtering

Collaborative filtering uses patterns across users and interactions.

Possible process:

1. Represent users using ratings, purchases, or other interactions.
2. Find users or latent profiles with similar behavior.
3. Identify products preferred by similar users.
4. Rank those products for the target user.

Strength: it can discover preferences beyond explicit product metadata. Limitations include sparse interaction data and the cold-start problem for new users or items.

### Hybrid recommendation

The case combines content-based and collaborative filtering. A hybrid can use both item meaning and collective behavior, then apply user constraints and business rules.

## 7. Evaluation strategy

### Offline evaluation

Use the held-out test data to check whether recommendations match later behavior. The precise metric should reflect ranking quality and the product goal. Examples of useful recommendation metrics include precision@k, recall@k, hit rate, mean reciprocal rank, or NDCG, although the source lesson discusses evaluation at a high level rather than prescribing one metric.

### User-based evaluation

After offline results are acceptable, test with users and collect:

- Explicit ratings of recommendations.
- Click-through rate.
- Add-to-cart or save rate.
- Purchase or conversion rate.
- Longer-term retention or satisfaction signals.

Offline accuracy and online impact are related but not identical. An A/B test can determine whether the deployed recommendation experience improves the intended outcome.

## 8. Deployment and continuous learning

The selected model is integrated into the company's mobile application and website. Production operation includes:

- Serving recommendations reliably.
- Logging inputs, outputs, and user interactions.
- Tracking model and business performance.
- Detecting changing customer behavior or inventory.
- Retraining with new interactions when appropriate.
- Expanding capabilities through later lifecycle iterations.

Deployment is therefore the beginning of a feedback loop, not the end of the project.

## 9. Lifecycle checklist

- [ ] The user and business problem are explicit.
- [ ] The target, prediction unit, and time horizon are defined.
- [ ] Data is relevant, representative, permitted, and versioned.
- [ ] Preparation is reproducible and leakage-safe.
- [ ] Split strategy matches how predictions will be made in reality.
- [ ] A simple baseline exists.
- [ ] Metrics reflect the cost of errors and the decision objective.
- [ ] Important failure cases and subgroups have been inspected.
- [ ] Preprocessing and model artifacts can be reproduced in production.
- [ ] Monitoring, fallback, retraining, and ownership are defined.

## Source pages

- [Machine Learning Model Lifecycle](https://app.notion.com/p/3810060838be801eb476fad6fcb2b594)
- [A Day in the Life of a Machine Learning Engineer](https://app.notion.com/p/3840060838be80429e37e434c2284b29)
