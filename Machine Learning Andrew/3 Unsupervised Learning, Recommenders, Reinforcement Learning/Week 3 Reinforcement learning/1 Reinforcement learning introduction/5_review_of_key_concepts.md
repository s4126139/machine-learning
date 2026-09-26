# Review of Reinforcement Learning Concepts

An RL problem is often formalized as a **Markov decision process (MDP)**. It
contains states, actions, rewards, state transitions, and a discount factor.
An agent follows a policy to choose actions, observes the results, and aims to
maximize return.

| Concept | Meaning |
| --- | --- |
| State $s$ | Information needed to choose the next action |
| Action $a$ | A choice available to the agent |
| Reward $R$ | Immediate feedback about the outcome |
| Transition | How the environment reaches the next state $s'$ |
| Discount $\gamma$ | How strongly future rewards are weighted |
| Return $G_t$ | Discounted sum of future rewards |
| Policy $\pi$ | Rule for choosing actions from states |

The Markov assumption says that the current state contains the information
needed to predict the future; the entire history is not needed once the state
is known. A chess state, for example, must encode enough information to make
legal decisions. A rover state may simply be its current location in the
simplified six-location example.

The same framework can describe a helicopter whose state includes position,
orientation, and speed, or a game where the state is the board. The actions,
reward design, and state representation change, but the decision loop remains
the same.
