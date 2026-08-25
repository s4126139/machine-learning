# The Full Cycle of a Machine Learning Project

## Training is only part of the system

A valuable machine learning system requires more than fitting a model. Using speech recognition for mobile voice search as the running example, the full project cycle includes scoping, data collection, iterative model development, deployment, monitoring, and maintenance.

## 1. Scope the project

Define what to build and what problem it should solve. In the example, the project is speech recognition for voice search: users speak to a mobile phone instead of typing a web query.

## 2. Collect data

Determine what data the project needs, then obtain it. For speech recognition, this includes:

- audio recordings as inputs; and
- transcripts as labels.

The initial collection is rarely the final one. Later diagnostics may reveal that additional data of a particular kind is needed.

## 3. Train and improve the model

Train the first speech-recognition model, perform error analysis and bias–variance analysis, and iteratively improve it. The diagnostic results may send the project back to data collection:

- collect more examples generally; or
- collect or create more examples from a specific failure category.

For example, if the model performs poorly on speech recorded with car noise, data augmentation can create more speech clips that sound as though they were recorded in a car.

The development loop is:

**collect data → train the model → analyze errors → collect targeted data or change the model → train again**

Repeat until the model is good enough for production.

## 4. Deploy in production

Deployment makes the model available to users. A common architecture contains:

1. a mobile or other client application;
2. an API call carrying an input $\mathbf{x}$, such as an audio clip;
3. an **inference server** that invokes the trained model; and
4. a returned prediction $\hat y$, such as the recognized text transcript.

In abstract form:

$$
\text{client input }\mathbf{x}
\longrightarrow
\text{inference server and model}
\longrightarrow
\text{prediction }\hat y.
$$

Software engineering is needed to connect these parts and make predictions reliable and efficient.

## 5. Match engineering effort to scale

A system serving a handful of users may run on a laptop or one or two servers. A system serving millions or hundreds of millions of users requires much more engineering and data-center capacity.

At large scale, the team may need to address:

- reliable, efficient inference;
- acceptable computational cost;
- scaling to many users;
- optimized implementations;
- data logging; and
- mechanisms for monitoring and updating the model.

The team that develops the learning model may be different from the team that deploys it.

## 6. Monitor and maintain

Deployment is not the end of the project. If user privacy and consent permit it, the system may log:

- received inputs $\mathbf{x}$; and
- model predictions $\hat y$.

These records can help monitor performance and detect changes in the data. A speech recognizer trained before a new celebrity becomes famous or a new politician is elected may perform poorly when users begin searching for unfamiliar names. Monitoring can expose this shift.

Once a problem is detected, the team can:

1. collect or use new data;
2. retrain the model;
3. replace the old model with an updated one; and
4. continue monitoring.

Data from the production system may also support continued improvement when permission exists to use it.

## MLOps

**Machine Learning Operations (MLOps)** is the practice of systematically building, deploying, and maintaining machine learning systems. It includes ensuring that the production model:

- is reliable;
- scales appropriately;
- has useful logs;
- is monitored; and
- can be updated when performance changes.

## End-to-end view

The complete cycle is not strictly linear:

**scope → collect data → train and analyze → deploy → monitor → return to data/model development when needed**

The modeling stage remains critical, but a production system must also account for the software, scale, feedback, monitoring, and maintenance needed to keep its predictions useful over time.
