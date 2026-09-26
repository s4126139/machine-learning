# Mars Rover Example

Imagine a rover moving among six locations, numbered 1 through 6. It can move
left or right. Location 1 contains the most valuable science target and gives
reward 100; location 6 has a less valuable target and gives reward 40. The
middle locations give reward 0. Reaching either end ends the mission for that
day, so those locations are **terminal states**.

At each step, the formal interaction is:

$$
\text{current state }s \;\longrightarrow\; \text{action }a
\;\longrightarrow\; \text{reward }r\text{ and next state }s'.
$$

From state 4, moving left eventually reaches the reward of 100. Moving right
reaches 40 sooner. The rover's objective depends on how future rewards are
valued, which is captured by the return in the next lesson.

The simple example separates the pieces of a real RL problem:

| Element | Rover example |
| --- | --- |
| State | Current location |
| Actions | Move left or right |
| Reward | Science value at the current location |
| Transition | The location reached after moving |
| Terminal state | A location where the episode ends |

This is a small model of the same feedback loop used for robotics, games, and
other sequential decisions. The reward says what is valuable; the policy must
decide how to reach it.
