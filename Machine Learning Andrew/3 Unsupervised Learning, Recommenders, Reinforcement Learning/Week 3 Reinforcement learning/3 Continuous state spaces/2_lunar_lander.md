# Lunar Lander

The Lunar Lander exercise turns reinforcement learning into a control task. The agent repeatedly observes a simulated lander, chooses a thruster action, and receives a reward based on what happens.

## State and actions

The state has eight values:

$$
s=(x,y,\dot{x},\dot{y},\theta,\dot{\theta},L,R),
$$

where \(x,y\) describe position; \(\dot{x},\dot{y}\) are velocity; \(\theta,\dot{\theta}\) are angle and angular velocity; and \(L,R\) indicate whether each leg is touching the ground.

The four actions are:

| Action | Effect |
| --- | --- |
| Nothing | Let gravity and inertia act |
| Left | Fire the left side thruster |
| Main | Fire the downward main engine |
| Right | Fire the right side thruster |

The policy must use the measurements together. For example, the same position can need a different action when the lander is moving quickly than when it is nearly stationary.

## Reward design

The simulator rewards a safe landing, with a landing reward that can range from about 100 to 140 depending on the landing. A crash receives \(-100\). Touching down with each leg adds 10. Moving toward the pad helps; drifting away hurts. Firing the main engine costs \(0.3\) and firing a side thruster costs \(0.03\), which discourages unnecessary fuel use.

These smaller rewards shape the behavior on the way to the final outcome. The goal is still to learn a policy that maximizes discounted return. The lesson uses \(\gamma=0.985\), so future rewards remain important.

## The control loop

~~~mermaid
flowchart LR
    O[Observe 8 state values] --> P[Policy estimates action values]
    P --> A[Choose among 4 thruster actions]
    A --> L[Lander moves in simulator]
    L --> R[Receive reward and next state]
    R --> O
~~~

Learning in a simulator makes it possible to gather many attempts. A policy that works in a simulation still needs careful evaluation before it can be trusted on a physical vehicle.
