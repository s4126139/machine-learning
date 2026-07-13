# Week 1: Foundations of Machine Learning

Course: COSC2753/COSC2812 Machine Learning, Semester 2, 2026  
Lecturer: Dr. Bao Nguyen  
Primary source: [Week 1 lecture slides](week01_lecture_slides.pdf)

> Source note: the supplied transcript contains the opening, then jumps from 1:51 to 1:47:40. Therefore, the technical explanations below are reconstructed mainly from the 52 lecture slides. The available transcript is used for the lecturer's course framing and assessment emphasis. Slide numbers and transcript timestamps are included where useful.

## The lecture in one minute

Machine learning is used when we want a computer to improve at a task through experience instead of encoding every decision rule by hand. A real task is represented by an unknown target function, $y=f(\mathbf{x})$. Because we do not know $f$, a learning algorithm uses a finite data set to select a hypothesis $h$ from a hypothesis space $\mathcal{H}$, hoping that $h(\mathbf{x}) \approx f(\mathbf{x})$.

The central difficulty is not simply obtaining a low training error. We must decide:

- what task we are solving;
- what data represents that task;
- how to split and use the data;
- what algorithm and hypothesis family are suitable;
- what performance measure represents success;
- whether performance generalizes to unseen examples; and
- whether the final choice is justified for the application.

The lecturer's key message is: **do not search for an abstract "best model"; search for the best model for the task that you can justify.** (Slides 47-49; transcript 1:47:40-1:51:29)

## 1. Course orientation

### Course goals

The course develops both conceptual and practical understanding. You are expected to apply open-source ML tools, but also to explain what algorithms do and analyze the data and outputs. Tool use is necessary; analysis and evaluation are the priority. (Slides 6, 47-49)

Helpful background includes Python, calculus and gradients, linear algebra, optimization, probability and statistics, and algorithms. These are desirable rather than strict prerequisites. (Slide 7)

### Weekly workload and assessment

- Lecture: 1.5 hours per week.
- Tutorial: 1.5 hours per week.
- Intro to Machine Learning, individual: 20%.
- Machine Learning Project, group: 40%.
- Presentation and Interview, individual: 40%.

Groups are formed in weeks 2-3. Work should be distributed fairly. Group problems should be raised early, with at least two weeks before the due date for resolution. Feedback is delivered through Canvas, and the stated grading target is within 14 business days after the due date. (Slides 8-10)

The lecturer normally uploads slides after class because some slides contain answers to questions asked during the session. (Transcript 1:53:31-1:54:01)

### Communication

- Use the Canvas discussion board for course questions, but do not post solutions.
- Book a consultation before visiting; no lunch-time consultations.
- Email is the preferred direct channel. Put `COSC2753`, `COSC2812`, or `ML` in the subject.
- The stated response target is two business days.
- Read course announcements regularly.

Lecturer contact from the slides: `bao.nguyenthien@rmit.edu.vn`, office 2.4.27 at the Saigon South campus. (Slides 4, 11-12)

## 2. What is machine learning?

### Intuitive definition

Arthur Samuel's definition says that machine learning gives computers the ability to learn without every behavior being explicitly programmed. (Slide 15)

This does **not** mean that no programming is involved. Humans still define the task, collect and prepare data, choose a model family and algorithm, select a performance measure, and implement the pipeline. What is learned from data is the model's decision rule or parameter values.

### Explicit programming versus learning

Consider predicting a house price from features such as:

- distance from the city;
- floor area;
- number of rooms;
- average local income; and
- school ranking.

An explicit program might contain hand-written rules such as:

```text
if distance > 500 m and floor area < 10 km:
    price = $100,000
```

The human has chosen the criteria, thresholds, and output. Such rules become brittle when many variables interact or when the relationship changes.

An ML program instead receives examples and adjusts tunable parameters. Its structure is:

```mermaid
flowchart LR
    X[House features x] --> A[Learning algorithm]
    D[Historical examples D] --> A
    A --> H[Learned hypothesis h]
    H --> Y[Predicted price h(x)]
    Y --> P[Evaluate with a suitable metric]
```

The resulting rule is learned from experience rather than completely specified by a programmer. (Slides 14-16)

### The formal T-E-P definition

Tom Mitchell's definition organizes learning around three ingredients:

- **Task $T$:** what the program must do.
- **Experience $E$:** the information from which it learns.
- **Performance measure $P$:** how improvement is judged.

A program learns if its performance at tasks in $T$, measured by $P$, improves with experience $E$. (Slide 17)

For house price prediction:

| Ingredient | Example |
|---|---|
| Task $T$ | Predict the price of a previously unseen house |
| Experience $E$ | Historical houses with features and known sale prices |
| Performance $P$ | An error measure such as MAE or RMSE on held-out houses |

This definition prevents vague statements like "the model learned well." Always ask: learned what task, from which experience, and according to which measure?

## 3. The general ML recipe

### 3.1 The unknown target function

The real relationship we want is represented as:

$$
y = f(\mathbf{x})
$$

where:

- $\mathbf{x}$ is an input or feature vector;
- $f$ is the unknown target function; and
- $y$ is the correct output or target.

For a house, $\mathbf{x}$ might contain floor area, distance, and room count, while $y$ is the sale price. We call $f$ unknown because we cannot write the complete, correct real-world rule mapping every possible house to its true price. (Slide 18)

### 3.2 Experience as data

In supervised learning, experience is commonly a data set of $n$ observed input-output pairs:

$$
D = \{(\mathbf{x}^{(i)}, y^{(i)})\}_{i=1}^{n},
\qquad y^{(i)} = f(\mathbf{x}^{(i)})
$$

Each pair $(\mathbf{x}^{(i)}, y^{(i)})$ is one instance, observation, example, or data point. In practice, measured targets can contain noise, so $y^{(i)}$ may be an imperfect observation of the underlying process. (Slide 19)

### 3.3 Hypothesis and hypothesis space

Since $f$ is unknown, ML learns a model called a **hypothesis**:

$$
h(\mathbf{x}) \approx f(\mathbf{x})
$$

The **hypothesis space** $\mathcal{H}$ is the set of hypotheses that the chosen representation and algorithm are capable of learning. Examples include:

- every straight line $h(x)=ax+b$;
- every quadratic $h(x)=ax^2+bx+c$;
- decision trees up to a chosen depth; or
- neural networks with a chosen architecture.

An algorithm searches within $\mathcal{H}$ and returns a selected model, often written $h^*$. Thus:

- $f$ is the unknown real relationship;
- $\mathcal{H}$ is the set of candidates we permit;
- $h$ is one candidate model; and
- $h^*$ is the candidate selected under the chosen data, objective, and algorithm.

$h^*$ is not automatically equal to $f$, and it is not universally optimal. It is only optimal according to the decisions and evidence used to select it. (Slides 18, 34-35)

### 3.4 Performance

Performance quantifies how well $h$ matches observed experience. If $L$ is a loss function, training performance can be summarized by empirical error:

$$
\widehat{R}_{train}(h)
= \frac{1}{n}\sum_{i=1}^{n}L(h(\mathbf{x}^{(i)}),y^{(i)})
$$

The important limitation is that performance is measured on finite observations, **not directly against the complete unknown function $f$**. Low error on observed examples does not prove that predictions will be correct elsewhere. (Slide 20)

### End-to-end mental model

```text
Real-world problem
      |
      v
Define T, E, and P
      |
      v
Collect representative data D
      |
      v
Choose features, hypothesis space H, algorithm, and loss
      |
      v
Learn h* from training data
      |
      v
Estimate generalization on separate data
      |
      v
Interpret, compare, justify, and report the final decision
```

Every arrow contains a decision that may affect the conclusion. That is why running code alone is not enough.

## 4. House price example worked through

Suppose we initially use only distance from the city $d$ and floor area $a$:

$$
\mathbf{x}=(d,a)
$$

The target might be a numeric price, or the simplified label "over $1 million" versus "not over $1 million." The former is regression; the latter is classification.

1. **Define the task.** Predict price, or predict the price category, for a new house.
2. **Collect experience.** Obtain past houses with $(d,a)$ and their sale price or category.
3. **Choose a hypothesis space.** For example, linear functions, quadratic functions, or nonlinear classifiers.
4. **Choose a performance measure.** A numeric price error and a category mistake are different notions of failure.
5. **Optimize.** Adjust model parameters to reduce the chosen training error.
6. **Test.** Evaluate the learned $h^*$ on houses not used for fitting.
7. **Judge suitability.** Consider whether the data, features, metric, and errors fit the intended application.

The slides initially illustrate counting errors, then warn that this may not be the best measure. The metric must match the task. A prediction off by $1,000 and one off by $500,000 are both one "wrong prediction" if we merely count mistakes, but their real-world consequences differ. (Slides 21-23)

## 5. Types of machine learning

### Supervised learning

In supervised learning, examples contain known outputs:

$$
(\mathbf{x},y)
$$

The learner estimates a mapping from inputs to desired outputs and then predicts outputs for unseen inputs. Performance compares predictions with known targets. (Slide 26)

The two main supervised tasks are:

| Type | Output | Example | Typical question |
|---|---|---|---|
| Classification | A discrete class or category | cat/dog; disease/no disease | "Which class is this?" |
| Regression | A continuous numeric value | house price; temperature | "What numeric value should this have?" |

The slides show image classification, driver-assistance object recognition, and medical-image analysis as supervised examples. (Slides 27-28)

**Important:** regression is supervised learning because training examples include target values. The lecturer explicitly checks this at the end of class. (Transcript 1:52:06-1:52:24)

### Unsupervised learning

In unsupervised learning, the data does not provide target labels $y$. We observe inputs $\mathbf{x}$ and ask the algorithm to discover a useful structure, representation, grouping, or distribution.

Typical goals include:

- clustering similar cases;
- finding patterns or lower-dimensional structure;
- detecting unusual observations; and
- learning a data-generating representation.

The slides illustrate clustering patients using blood glucose and weight, and a GAN-based smart paintbrush. (Slides 29-31)

> Correction to Slide 29: it says "the output is known" but writes $?=f(\mathbf{x})$. In unsupervised learning, the intended idea is that the target output is **unknown or not supplied**. The algorithm must construct a useful output from the input structure.

Performance is less straightforward than in supervised learning because there may be no single correct label. Evaluation must match the objective: cluster compactness, separation, reconstruction quality, usefulness to a downstream task, expert judgment, or another suitable criterion.

### Other learning settings

The slides name several extensions. These concise definitions provide context:

- **Semi-supervised learning:** learn from a small labeled set plus a larger unlabeled set.
- **Active learning:** the learner selects which examples would be most valuable for a human or system to label.
- **Transfer learning:** reuse knowledge learned in one task or domain to improve another.
- **Federated learning:** train across multiple devices or organizations while keeping raw data decentralized.

These settings do not replace the need to define $T$, $E$, and $P$; they change the form or location of experience. (Slide 32)

## 6. Model complexity and choosing a hypothesis

### Why multiple models can fit the same data

The observed data is finite. A straight line, a curved boundary, and a highly flexible boundary may all classify every training point correctly. The data alone may therefore leave multiple hypotheses consistent with experience. (Slides 35-37)

This creates the main model-selection question: **which hypothesis should be learned?**

### Ockham's Razor

Ockham's Razor prefers the simplest hypothesis that is reasonably consistent with the experience. If several models have equal training error, the simpler model is usually preferred because it makes fewer unsupported assumptions about behavior between or beyond observed points. (Slides 36-37)

But "choose the simplest" needs two qualifications:

1. Simplicity is relative to the representation. A short decision tree, a low-degree polynomial, and a small neural network express complexity differently.
2. The simplest possible model can underfit. We want sufficient complexity to capture meaningful structure, not minimum complexity at any cost.

In practice, complexity is selected using performance on separate validation data or cross-validation, combined with domain constraints such as interpretability, speed, memory, safety, and data availability.

## 7. True error and generalization

### Training error is not the final goal

Imagine that a classifier $h$ correctly labels all five supplied points. Its observed error is zero, but the true target boundary $f$ may disagree with $h$ in unobserved regions. Zero error on five examples therefore does not imply zero error in the real world. (Slide 39)

### True error

Conceptually, true error is the expected loss over future examples from the real data-generating distribution:

$$
R(h)=\mathbb{E}_{(\mathbf{x},y)\sim P_{data}}
[L(h(\mathbf{x}),y)]
$$

We cannot calculate this exactly because we do not know the full distribution or the target function. We estimate it using a separate test set sampled from the same intended population. (Slide 40)

### Generalization

**Generalization** is the ability to perform well on new, previously unseen inputs. The test error is an estimate of future performance, provided that:

- test examples were not used to fit or choose the model;
- the test set is large and representative enough; and
- future data resembles the population from which the test set came.

The **generalization gap** is the difference between training and held-out performance. For error measures, it is commonly written:

$$
\text{gap}=\widehat{R}_{test}(h)-\widehat{R}_{train}(h)
$$

A small gap is desirable, but it is not sufficient: a model can perform badly on both sets and still have a small gap. We want low held-out error and a controlled gap. (Slides 40-41)

### Underfitting, good fit, and overfitting

| Situation | Training error | Test error | Interpretation |
|---|---:|---:|---|
| Underfitting | High | High | Model or features are too limited, or learning is inadequate |
| Good fit | Low | Low and reasonably close | Useful patterns are learned and generalize |
| Overfitting | Very low | Noticeably higher | Model learned training-specific noise or accidents |

Increasing model capacity often reduces training error, but may eventually increase the generalization gap. This is why selecting the model with the best training score is unsafe.

### Correct data roles

For a basic workflow:

- **Training set:** fit model parameters.
- **Validation set or cross-validation:** choose algorithms, features, hyperparameters, and model complexity.
- **Test set:** estimate final performance after choices are fixed.

The Week 1 slides simplify this to training and test sets. The validation distinction matters whenever several choices are compared. Repeatedly checking the test set while tuning indirectly overfits the test set and makes its final estimate optimistic.

## 8. Choosing the performance measure

The metric defines what "good" means, so it must represent the application rather than merely produce a convenient number.

For regression:

- **MAE:** average absolute error; easy to interpret in target units and less dominated by extreme errors.
- **MSE/RMSE:** penalizes large errors more strongly; RMSE is in the target's units.

For classification:

- **Accuracy:** useful when classes and error costs are reasonably balanced.
- **Precision:** among predicted positives, how many are correct?
- **Recall:** among actual positives, how many are found?
- **F1:** balances precision and recall.

This is not a Week 1 metric catalogue to memorize. The principle is what matters: the right measure depends on the costs and goals of the task. In medical screening, missing a disease may matter more than a false alarm. In house-price estimation, a few very large errors may or may not deserve extra weight. (Slides 20, 23, 48; transcript 1:48:14-1:48:26)

## 9. The lecturer's assessment message

The available final section of the transcript strongly emphasizes that simply collecting data, running an algorithm, and reporting a high score covers only the basic work. Higher-quality submissions analyze and justify the whole ML design. (Transcript 1:47:40-1:51:29)

For assignments, be ready to justify:

1. **Task:** What exactly is predicted or discovered? Who will use the result?
2. **Data:** Why is this data relevant and representative? What are its limitations?
3. **Split:** How are training, validation, and test data separated? Is leakage prevented?
4. **Algorithm:** Why is the learning method suitable for the data and application?
5. **Hypothesis family:** Why is this degree of model complexity appropriate?
6. **Metric:** Why does the performance measure reflect practical success or failure?
7. **Evidence:** What do training and held-out results show? Is there underfitting or overfitting?
8. **Judgment:** Which model is preferred, under what assumptions, and why?
9. **Limitations:** Where could the conclusion fail, and what additional evidence would help?

Do not write only "Model A is best because accuracy is highest." A stronger conclusion is:

> Model A is preferred for this task because it improves the application-relevant metric on untouched data, has a smaller generalization gap than the more complex alternative, satisfies the runtime constraint, and its main failure cases are acceptable under the stated cost assumptions.

That is the difference between a leaderboard result and an evidence-based ML judgment.

## 10. Common misconceptions

### "ML means no one programs the system"

Incorrect. People program the learning procedure and make the design decisions. The fitted rule or parameters are learned from data.

### "The model with the lowest training error is best"

Incorrect. It may overfit. Unseen-data performance is the goal.

### "Zero test error proves that $h=f$"

Incorrect. A test set is finite. It estimates, but cannot reveal, performance over every possible input.

### "A small generalization gap means a good model"

Not necessarily. Training and test errors can both be high. Absolute held-out performance also matters.

### "The most complex model is most intelligent"

Incorrect. Extra capacity can learn noise. Complexity should be justified by better generalization or task requirements.

### "Unsupervised learning has known output labels"

Incorrect. The key feature is that target labels are not supplied. The learner discovers or constructs useful structure.

### "Regression is unsupervised because it predicts an unknown number"

Incorrect. During training, the target values are known, so regression is supervised.

### "One metric determines the universally best model"

Incorrect. Metrics encode priorities. Changing the application or error costs can change the preferred model.

## 11. Answers to the slide revision questions

### What are the key ingredients of a general ML recipe?

Define task $T$, experience $E$, and performance $P$; represent the unknown target as $f$; collect suitable data; choose a hypothesis space and learning algorithm; learn a hypothesis; estimate generalization on separate data; and justify the final choice in the application context.

### What is the difference between hypothesis space and optimal hypothesis?

The hypothesis space $\mathcal{H}$ is the complete set of models the chosen approach can learn. The selected or optimal hypothesis $h^*$ is one member chosen because it performs best under a specified objective and evidence. "Optimal" is conditional, not universal.

### What are the main types of ML?

- Supervised learning: labeled input-output pairs; includes classification and regression.
- Unsupervised learning: no supplied target labels; discover useful structure.
- Semi-supervised learning: combine limited labeled data with more unlabeled data.

### What comes next?

Week 2 begins regression, a supervised learning task and the focus of the first assignment. (Slides 50-51; transcript 1:52:06-1:52:24)

## 12. Compact glossary

| Term | Meaning |
|---|---|
| Feature / attribute | A measured input variable |
| $\mathbf{x}$ | Feature vector for one instance |
| Target / label $y$ | Desired output for one supervised example |
| Target function $f$ | Unknown real mapping from inputs to outputs |
| Data set $D$ | Collection of observed examples |
| Hypothesis $h$ | A candidate learned model approximating $f$ |
| Hypothesis space $\mathcal{H}$ | All hypotheses available to the learner |
| Learning algorithm | Procedure used to choose a hypothesis from data |
| Parameter | A value learned during fitting, such as a line's slope |
| Hyperparameter | A setting controlling learning or model capacity |
| Loss / error | Numerical penalty for a prediction |
| Training error | Error on data used for fitting |
| Test error | Error on untouched data used to estimate future performance |
| Generalization | Performance on new inputs |
| Generalization gap | Difference between held-out and training performance |
| Underfitting | Failure to capture important structure |
| Overfitting | Fitting training-specific detail that does not generalize |

## Final takeaway

The Week 1 foundation can be compressed into one statement:

$$
\boxed{\text{Learn } h \text{ from finite experience so that } h(\mathbf{x})
\text{ approximates } f(\mathbf{x}) \text{ on unseen data.}}
$$

Doing this well requires more than optimizing a score. The quality of an ML solution depends on the complete argument connecting the task, data, model family, algorithm, metric, experimental design, generalization evidence, and final judgment.
