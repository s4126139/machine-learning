# The Return in Reinforcement Learning

The **return** summarizes the rewards from a sequence of actions. Future
rewards are discounted so an agent can value a reward received sooner more
than the same reward received much later:

$$
G_t=R_t+\gamma R_{t+1}+\gamma^2R_{t+2}+\cdots,
\qquad 0\leq\gamma<1.
$$

$\gamma$ is the discount factor. A value close to 1 makes the agent more
far-sighted; a smaller value places more weight on immediate outcomes. It also
helps keep an infinite stream of future rewards finite.

## Rover example

Use the six-state rover and set $\gamma=0.5$. Starting in state 4 and moving
left yields rewards $0,0,0,100$ before the terminal state. The return is

$$
0+0.5(0)+0.5^2(0)+0.5^3(100)=12.5.
$$

Moving right yields $0,0,40$, so

$$
0+0.5(0)+0.5^2(40)=10.
$$

Although the left target pays more, discounting makes its delayed reward worth
only slightly more in this example. Changing $\gamma$ changes this trade-off.

The return depends on both the rewards and the actions that produced them.
When rewards can be negative, discounting may also encourage an agent to delay
penalties. That may or may not match the real task, so inspect the reward and
discount design rather than treating $\gamma$ as a harmless tuning constant.
