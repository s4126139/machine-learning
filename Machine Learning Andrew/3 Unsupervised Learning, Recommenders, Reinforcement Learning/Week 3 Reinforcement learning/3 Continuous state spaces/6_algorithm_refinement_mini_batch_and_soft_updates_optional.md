# Optional Refinements: Mini-Batches and Soft Updates

This optional lesson adds two refinements to make neural-network training more efficient and more stable.

## Mini-batch updates

Computing one gradient step over every stored transition can be slow. Instead, sample a smaller batch of \(m'\) transitions from the replay buffer and train on that batch:

$$
J_{\text{batch}}(\theta)
=\frac{1}{m'}\sum_{i=1}^{m'}\left(Q_\theta(s_i,a_i)-y_i\right)^2.
$$

Each step uses less computation than processing the full buffer. A different batch provides a new estimate of the gradient on the next step.

## Soft updates for a target network

DQN implementations often use a second, target network to calculate the next-state values in Bellman's equation. If the target changes at the same speed as the network being trained, the learning target can shift abruptly. A soft update moves the target network gradually toward the trained network:

$$
\theta_{\text{target}}
\leftarrow
\tau\theta_{\text{online}}
+(1-\tau)\theta_{\text{target}},
\qquad 0<\tau\ll1.
$$

Each update blends a small fraction of the newest parameters with the previous target parameters. This makes targets change more smoothly.

| Refinement | What it changes | Main benefit |
| --- | --- | --- |
| Mini-batch | Number of transitions used for one gradient step | Faster, practical updates |
| Soft target update | How target-network parameters are refreshed | More gradual learning targets |

These are refinements, not a change to the objective: the agent is still learning values that support a policy with high expected return.
