# Refinement: Epsilon-Greedy Exploration

While a Q-network is learning, it may be wrong about which action is best. If the agent always follows its current highest Q-value, it can repeatedly avoid an action that it has not explored enough to value correctly.

An \(\epsilon\)-greedy policy balances trying and using what has been learned:

- With probability \(1-\epsilon\), choose the action with the largest estimated Q-value.
- With probability \(\epsilon\), choose an action at random.

~~~mermaid
flowchart TD
    S[Observe state s] --> RAND[Draw random number]
    RAND -->|less than epsilon| EXP[Choose random action<br/>explore]
    RAND -->|otherwise| Q[Evaluate Q s a]
    Q --> GREEDY[Choose action with largest Q<br/>exploit current estimate]
    EXP --> A[Take action]
    GREEDY --> A
~~~

Exploration gathers evidence about actions the current model might undervalue. Exploitation uses the best action according to the current estimate.

## Decay exploration over time

It is common to start with a large \(\epsilon\), sometimes 1, so early behavior explores broadly. Reduce it as learning progresses so the agent increasingly uses its improved Q-values. A small final value can preserve some exploration.

The balance is sensitive to tuning. Too little exploration can trap the agent in a poor behavior; too much exploration can keep it from using what it learned.
