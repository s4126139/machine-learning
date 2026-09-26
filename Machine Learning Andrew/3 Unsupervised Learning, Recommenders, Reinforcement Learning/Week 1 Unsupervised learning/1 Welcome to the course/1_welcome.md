# Welcome to Course 3

This course adds three tools that answer different questions:

| Method | Question it answers | Typical signal |
| --- | --- | --- |
| Clustering | Which examples resemble each other? | Similarity among unlabeled examples |
| Anomaly detection | Does this example look unlike normal data? | Low probability under a model of normal examples |
| Recommender systems | Which items may this user prefer? | Ratings, clicks, or item features |
| Reinforcement learning | Which action should an agent take next? | Rewards received over time |

The first week focuses on clustering and anomaly detection. Both can learn
without a target label for every example, but they solve different problems:
clustering organizes a collection into groups, while anomaly detection looks
for a small number of unusual cases.

The later weeks move from user-item preferences to agents that act in an
environment. The shared theme is to choose a representation and objective that
match the problem, then check the result with suitable evidence rather than
assuming a model is useful because it runs.

## How to use these notes

Each topic folder follows the course order. The transcript copies are kept
locally and ignored by Git; the Markdown files here are rewritten study notes.
When a formula feels abstract, first identify what each index represents, then
work through a small numeric example. The lab notebooks are organized by week
in the adjacent `Labs` folders.
