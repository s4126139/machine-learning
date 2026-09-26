# Refinement: One Network Pass for All Actions

The first DQN design feeds the state and a one-hot action into a network and predicts one value \(Q(s,a)\). To compare four actions, the network must run four times for the same state.

## Predict every action value together

For Lunar Lander, use the eight state values as input and produce four outputs:

$$
f_\theta(s)=
\begin{bmatrix}
Q(s,\text{nothing})\\
Q(s,\text{left})\\
Q(s,\text{main})\\
Q(s,\text{right})
\end{bmatrix}.
$$

The lesson's example uses two hidden layers with 64 units each. One forward pass gives all four estimates, so choosing the greedy action is simply

$$
a^*=\arg\max_a f_\theta(s)_a.
$$

This architecture also speeds up the Bellman target: one evaluation of the next state gives every \(Q(s',a')\), and the maximum is easy to select.

~~~mermaid
flowchart LR
    S[8 state features] --> H1[Hidden layer<br/>64 units]
    H1 --> H2[Hidden layer<br/>64 units]
    H2 --> OUT[4 Q-values]
    OUT --> PICK[Select largest Q-value]
~~~

The network estimates values, not actions directly. The action is selected afterward by comparing those estimates.
