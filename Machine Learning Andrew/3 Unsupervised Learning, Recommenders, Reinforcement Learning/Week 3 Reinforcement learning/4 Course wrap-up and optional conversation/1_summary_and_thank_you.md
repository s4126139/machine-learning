# Course and Specialization Summary

The specialization builds from prediction to richer learning settings:

| Course | Main ideas |
| --- | --- |
| Supervised Machine Learning: Regression and Classification | Linear and logistic regression, cost functions, gradient descent |
| Advanced Learning Algorithms | Neural networks, decision trees and ensembles, bias and variance, model evaluation |
| Unsupervised Learning, Recommenders, Reinforcement Learning | Clustering, anomaly detection, recommendation systems, reinforcement learning |

Together, these methods give a broad foundation for building machine-learning applications. The final lesson also emphasizes that the material is a starting point: practical skill grows by applying the ideas to problems and learning what changes in real settings.

## A compact course map

~~~mermaid
flowchart LR
    SUP[Supervised learning<br/>predict labels or values] --> ADV[Advanced models<br/>neural networks and trees]
    ADV --> UNSUP[Unsupervised learning<br/>find structure]
    UNSUP --> REC[Recommenders<br/>rank useful items]
    REC --> RL[Reinforcement learning<br/>choose actions over time]
~~~

The unifying task is to match the learning setup to the problem: prediction, discovering structure, ranking items, or choosing actions under delayed rewards.
