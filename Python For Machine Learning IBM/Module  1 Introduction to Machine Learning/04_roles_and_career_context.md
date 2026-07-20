# Roles and Career Context

Job boundaries vary by organization. The comparisons below describe common emphases, not rigid definitions.

## 1. Three complementary perspectives

### Data scientist

A data scientist is often a **data storyteller and modeler**. The role emphasizes the *what* and *why*:

- Understand the business or research question.
- Explore and explain messy real-world data.
- Perform statistical analysis and experimentation.
- Engineer features and build predictive models.
- Communicate findings, uncertainty, and implications.

Common use cases are descriptive and predictive:

- Descriptive: what happened and how is the data structured?
- Predictive: what is likely to happen next?

### Machine learning engineer

A machine learning engineer is often a **production ML system builder**. The role emphasizes the *how*:

- Make data and model pipelines reproducible.
- Turn prototypes into reliable software.
- Optimize inference performance and resource use.
- Package, deploy, scale, monitor, and retrain models.
- Bridge model development and real applications.

Data scientists and ML engineers can overlap throughout problem definition, collection, preparation, training, and evaluation. Deployment and production reliability are especially prominent in ML engineering.

### AI engineer

In the course comparison, an AI engineer is an **AI system builder** who frequently starts with a pre-trained foundation model and composes it into a larger workflow.

Typical responsibilities include:

- Select a suitable foundation model.
- Design prompts and prompt chains.
- Ground generation with retrieval-augmented generation (RAG).
- Adapt models with PEFT, LoRA, QLoRA, or other fine-tuning methods.
- Combine models with tools, agents, data sources, and application logic.
- Evaluate safety, quality, latency, cost, and task performance.
- Embed the result in assistants, virtual agents, applications, or business workflows.

## 2. Data scientist versus AI engineer

The source material compares the roles across use cases, data, models, and development process.

| Dimension | Data scientist | AI engineer |
|---|---|---|
| Primary metaphor | Data storyteller | AI system builder |
| Common use cases | Descriptive and predictive | Prescriptive and generative |
| Typical data emphasis | Structured or tabular data; sometimes unstructured | Primarily text, images, audio, and video |
| Typical data scale in the lesson | Hundreds to hundreds of thousands of observations | Foundation-model pretraining can use billions to trillions of tokens |
| Models | Many task-specific statistical and ML algorithms | General-purpose foundation models |
| Scope | Usually narrow and optimized for one task | Wider task coverage from one pre-trained model |
| Training cost | Commonly smaller and faster | Often extremely compute-intensive at pretraining time |
| Starting point | Select data and train a task-specific model | Select and adapt a pre-trained model |
| Final product | Analysis, prediction service, experiment, or decision support | Assistant, agent, generative application, or automated workflow |

These are tendencies. A data scientist may build prescriptive systems; an AI engineer may use structured data; and either may deploy models.

## 3. Use-case progression

### Descriptive analytics

Explains historical data using visualization, summary statistics, statistical inference, and exploratory analysis. Clustering may reveal groups such as customer segments.

### Predictive analytics

Estimates unknown or future outcomes:

- Regression predicts numbers such as revenue or temperature.
- Classification predicts categories such as success/failure or churn/stay.

### Prescriptive systems

Recommend or optimize an action. Examples include decision optimization and targeted recommendations.

### Generative systems

Create or transform content and support open-ended interaction. Examples include coding assistants, digital advisors, conversational search, retrieval, and summarization.

## 4. Traditional ML models versus foundation models

### Traditional ML

- Many algorithms exist, each with assumptions and appropriate problem types.
- A new use case often requires a specific dataset and a separately trained model.
- Models are generally narrower in scope.
- Training commonly takes seconds to hours, although scale can vary greatly.
- Training and inference are often less computationally expensive than foundation-model pretraining.

### Foundation models

- A large model is pre-trained on broad data and can support many downstream tasks.
- The same base model may perform classification, extraction, question answering, generation, and other tasks.
- Models commonly contain billions of parameters and require substantial computation to pretrain.
- Developers often use an existing model rather than pretraining one from scratch.
- Adaptation can use prompting, retrieval, fine-tuning, or tool integration.

The cost comparison must distinguish **pretraining** from **application development**: although pretraining a foundation model is expensive, using an existing model can make a prototype accessible to a smaller team.

## 5. Development workflows

### Typical data science workflow

1. Identify the use case.
2. Select and understand relevant data.
3. Clean, join, filter, and engineer features.
4. Split data appropriately.
5. Train and validate models.
6. Use cross-validation and hyperparameter tuning.
7. Select a model based on technical and business criteria.
8. Deploy to batch or real-time inference when required.

### Typical generative AI engineering workflow

1. Identify the task, users, risks, and success criteria.
2. Select a pre-trained foundation model.
3. Establish a baseline using direct prompting.
4. Add structured prompts, few-shot examples, or prompt chains.
5. Add retrieval when trusted or current external knowledge is required.
6. Fine-tune when prompting and retrieval cannot meet task requirements efficiently.
7. Add tools or agents for multi-step actions.
8. Integrate the model into a larger system.
9. Evaluate quality, grounding, safety, latency, and cost continuously.

## 6. Key generative AI building blocks

- **Prompt engineering:** design natural-language instructions and examples that guide model behavior.
- **Prompt chaining:** connect multiple model calls in a controlled sequence.
- **PEFT:** adapt a model by training a relatively small subset or additional parameters.
- **RAG:** retrieve relevant information and provide it as context to ground the answer.
- **Autonomous or semi-autonomous agents:** let a model plan and use tools across multiple steps, with controls appropriate to the risk.

Open-source model communities such as Hugging Face make pre-trained models more accessible, contributing to the democratization of AI development.

## 7. Skills map

| Skill area | Data scientist | ML engineer | AI engineer |
|---|---:|---:|---:|
| Statistics and experimental reasoning | High | Medium | Medium |
| Data cleaning and feature engineering | High | High | Medium–High |
| Classical ML modeling | High | High | Medium |
| Software engineering | Medium | High | High |
| Deployment and observability | Medium | High | High |
| Distributed systems and scaling | Medium | High | High |
| Foundation models and prompting | Medium | Medium | High |
| Retrieval and vector search | Medium | Medium | High |
| Communication and domain understanding | High | High | High |

The strongest professionals usually understand neighboring disciplines well enough to collaborate, even when one area is their specialty.

## 8. Career-development lesson

Existing Python, data analysis, and classical ML skills transfer directly into both ML engineering and AI engineering. A sensible progression is:

1. Become reliable at data preparation and evaluation.
2. Build classical models and understand their failure modes.
3. Learn packaging, APIs, containers, monitoring, and reproducibility.
4. Add neural-network and foundation-model concepts.
5. Build end-to-end systems with retrieval, evaluation, and production controls.

## Source pages

- [IBM AI Engineering PC Overview](https://app.notion.com/p/3810060838be808db142ec27c617afef)
- [A Day in the Life of a Machine Learning Engineer](https://app.notion.com/p/3840060838be80429e37e434c2284b29)
- [Data Scientist vs AI Engineer](https://app.notion.com/p/3840060838be80138b38d1339fca6f41)
- [Connecting the Dots: Prepare for Your Assessment](https://app.notion.com/p/3960060838be80f2a66aef8c76bd5b2d)
