# Bellman's Equation for Q

Bellman's equation breaks a long-term value into the reward now and the value that can be reached next:

$$
Q(s,a)=R(s)+\gamma\max_{a'}Q(s',a').
$$

Here \(s'\) is the state reached after taking action \(a\) in state \(s\). In the course's rover notation, \(R(s)\) is the reward for the current state. The maximum chooses the best next action, and \(\gamma\) discounts its value.

## A numeric calculation

If the current state has reward 0, \(\gamma=0.5\), and the best Q-value in the next state is 25, then

$$
Q(s,a)=0+0.5(25)=12.5.
$$

For the Mars rover, going left from state 4 leads through states with reward 0 before state 1's reward of 100:

$$
Q(4,\text{left})
=0+0.5\max_{a'}Q(3,a')
=0.5(25)
=12.5.
$$

At a terminal state there is no future decision, so its continuation value is zero. The value comes from the terminal reward only.

## Why this equation is useful

The equation provides a target for learning Q-values. If we already have an estimate of the next state's Q-values, we can estimate the current state's value. Repeating this update propagates information about distant rewards back toward earlier states.

~~~mermaid
flowchart LR
    SA[State s and chosen action a] --> R[Reward R s]
    SA --> NEXT[Next state s']
    NEXT --> BEST[Evaluate every next action]
    BEST --> MAX[Keep max Q s' a']
    R --> SUM[Add reward and discounted future value]
    MAX --> DISC[Multiply by gamma]
    DISC --> SUM
    SUM --> TARGET[Bellman target for Q s a]
~~~

## Stochastic transitions

If the environment can move to several possible next states, use the expected continuation value:

$$
Q(s,a)
=R(s)+\gamma\mathbb{E}_{s'\mid s,a}
\left[\max_{a'}Q(s',a')\right].
$$

The expectation accounts for the transition probabilities. An action can be unreliable even when its intended destination is valuable.
