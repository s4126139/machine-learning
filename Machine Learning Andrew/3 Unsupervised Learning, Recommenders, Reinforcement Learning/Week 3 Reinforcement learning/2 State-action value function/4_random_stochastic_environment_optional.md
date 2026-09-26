# Random (Stochastic) Environments

In a deterministic rover world, moving right always changes the state in the same way. A stochastic world adds uncertainty: the rover may fail to move as commanded.

In the lesson's example, the rover follows the requested direction 90% of the time and makes a misstep 10% of the time. It must score an action by considering every possible outcome, weighted by its probability.

## Expected Bellman value

For each possible next state \(s'\), combine the immediate reward and the best continuation, then average over the transition distribution:

$$
Q(s,a)
=R(s)+\gamma\sum_{s'}P(s'\mid s,a)
\max_{a'}Q(s',a').
$$

The transition probability \(P(s'\mid s,a)\) describes how likely the environment is to reach \(s'\) after action \(a\).

## Why uncertainty can lower a value

If a valuable destination can be missed, the agent cannot count on receiving its reward. In the example, increasing the misstep probability lowers the expected return. The rover has less control, so even its best action is less valuable.

This is still a Markov decision process: the current state contains the information needed to model the next-state probabilities and rewards. The agent chooses an action, but the environment determines which allowed transition occurs.
