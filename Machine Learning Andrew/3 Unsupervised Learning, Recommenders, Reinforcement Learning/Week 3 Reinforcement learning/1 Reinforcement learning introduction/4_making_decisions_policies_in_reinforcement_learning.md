# Policies in Reinforcement Learning

A **policy** $\pi$ maps a state to an action. It describes the agent's
decision rule:

$$
a=\pi(s).
$$

In the rover example, a policy could say “move left in states 2, 3, and 4;
move right in state 5.” A different policy may prefer the nearer science
target or the more valuable one. The policy determines the sequence of states
and rewards, and therefore the return.

The goal of reinforcement learning is to find a policy that maximizes expected
return. A deterministic policy selects one action for each state. A stochastic
policy instead gives probabilities for possible actions, which can be useful
when exploration or unpredictable environments matter.

The policy is not necessarily a list of hand-written rules. It may be
represented by a table for a small problem or by a neural network for a large
continuous state space. The representation should be able to distinguish
states that need different actions.

**Key separation:** the reward function defines which outcomes are good; the
policy defines what the agent does to pursue them.
