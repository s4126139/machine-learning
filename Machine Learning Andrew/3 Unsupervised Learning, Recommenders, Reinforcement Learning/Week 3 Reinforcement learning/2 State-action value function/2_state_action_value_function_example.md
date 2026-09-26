# State-Action Values: Mars Rover Example

Use the six-position rover from the introduction. The rover can move left or right. Reaching state 1 gives a reward of 100, reaching state 6 gives 40, and the intermediate states give 0. The end states are terminal. Let the discount factor be \(\gamma=0.5\).

Suppose the best policy after the first action is to go left from states 2, 3, and 4, and right from state 5. \(Q(s,a)\) evaluates the first action, then assumes this policy is followed.

## Compare actions from state 2

If the rover goes left, it reaches the reward of 100 after one step:

$$
Q(2,\text{left})=0+\gamma(100)=50.
$$

If it goes right, then its best continuation turns around and heads left:

$$
Q(2,\text{right})
=0+\gamma(0)+\gamma^2(0)+\gamma^3(100)
=12.5.
$$

Going right is not forbidden; its lower value reflects the extra delay before the reward.

## Compare actions from state 4

Going left takes three moves before reaching state 1:

$$
Q(4,\text{left})=\gamma^3(100)=12.5.
$$

Going right reaches state 5, where the best continuation goes to the terminal reward of 40:

$$
Q(4,\text{right})=\gamma^2(40)=10.
$$

The left route is slightly more valuable under this discount factor, even though the other terminal reward is closer.

| State and first action | Reward sequence after that choice | Return |
| --- | --- | ---: |
| \(Q(2,\text{left})\) | \(100\) after one move | \(50\) |
| \(Q(2,\text{right})\) | \(100\) after three moves | \(12.5\) |
| \(Q(4,\text{left})\) | \(100\) after three moves | \(12.5\) |
| \(Q(4,\text{right})\) | \(40\) after two moves | \(10\) |

## What the table tells us

The largest Q-value at a state picks the best action there. The discount factor changes how strongly delayed rewards count, so changing \(\gamma\) can change which route is preferred. \(Q(s,a)\) reports the return for the chosen first action; it does not label an action as universally good or bad.
