# What Is Reinforcement Learning?

Reinforcement learning (RL) trains an agent to choose actions by giving it
feedback about outcomes. The agent observes a **state** $s$, takes an
**action** $a$, and receives a **reward** that says whether the outcome was
helpful. Its goal is to learn behavior that earns high reward over time.

This differs from ordinary supervised learning. A helicopter controller, for
example, does not have one unambiguous “correct” joystick movement for every
position and velocity. Instead, the system can be rewarded for stable flight
and penalized for unsafe behavior; it must discover useful control actions.

~~~mermaid
flowchart LR
  A[Agent observes state s] --> B[Choose action a]
  B --> C[Environment changes]
  C --> D[Receive reward r and next state s']
  D --> A
~~~

The reward function is central. A controller might receive a small positive
reward for each second of safe flight and a large negative reward for a crash.
That tells the agent **what outcome to seek**, while leaving it to learn **how
to achieve it**. A poorly designed reward can still produce unintended
behavior, so reward design is part of the problem.

RL is useful when actions affect future states and rewards may arrive later:
robot control, navigation, games, and some scheduling problems. It is not
automatically the right method for every prediction task; it requires an
environment or simulator in which actions can be tried safely and measured.
