# State-Action Value Function

The state-action value function, usually written as \(Q(s,a)\), answers this question:

> If the agent is in state \(s\), takes action \(a\) once, and then follows the best policy it can, what return should it expect?

The state describes the situation. The action describes the immediate choice. The Q-value scores that choice by including the rewards that may follow later.

## From Q-values to a policy

For a given state, compare the Q-values of all available actions:

$$
\pi^*(s)=\arg\max_a Q^*(s,a).
$$

The largest value identifies the action with the highest expected return. A policy can therefore be recovered from a learned Q-function.

~~~mermaid
flowchart LR
    S[Current state s] --> Q[Estimate Q s a for each action]
    Q --> M[Choose the action with the largest value]
    M --> A[Action a]
    A --> R[Immediate and future rewards]
    R --> S2[Next state]
    S2 --> Q
~~~

## A subtle point about the definition

The definition refers to acting optimally after the first action. At the beginning, the optimal policy is not known. This sounds circular, but it becomes useful once Bellman's equation expresses a Q-value in terms of the best Q-value available from the next state. An algorithm can improve these estimates repeatedly until the policy they imply becomes good.

For a stochastic environment, \(Q(s,a)\) is an expected return: the same action may lead to different next states and rewards on different attempts.

## Keep these ideas distinct

- The reward function describes which outcomes are desirable.
- The Q-function estimates the long-term value of a state-action choice.
- The policy chooses an action for each state.

A reward is local feedback. A Q-value includes the consequences after that feedback.
