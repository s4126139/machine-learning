# Learning the Q-Function with a Neural Network

The Lunar Lander state has many possible combinations. A table of values for every state and action is not practical, so a neural network approximates \(Q(s,a)\).

## Build training examples from experience

One simulator step produces a tuple:

$$
(s,a,r,s'),
$$

meaning the lander was in state \(s\), took action \(a\), received reward \(r\), and reached \(s'\). Bellman's equation supplies a training target:

$$
y=r+\gamma\max_{a'}Q(s',a').
$$

The network receives the state-action pair and learns to predict \(y\). At first, Q-values are only rough estimates; as the network improves, later targets become more useful.

## DQN learning cycle

The algorithm stores recent experience in a replay buffer. The lesson uses the 10,000 most recent transitions to keep memory bounded. It periodically samples stored experience, forms Bellman targets, trains the network, and uses the updated network to collect more experience.

~~~mermaid
flowchart TD
    INIT[Initialize Q network] --> ACT[Act in simulator]
    ACT --> STORE[Store s, a, r, s' in replay buffer]
    STORE --> SAMPLE[Sample recent experience]
    SAMPLE --> TARGET[Compute r plus discounted best next Q]
    TARGET --> TRAIN[Train network to predict target]
    TRAIN --> UPDATE[Replace current Q estimate]
    UPDATE --> ACT
~~~

This family of methods is called a Deep Q-Network (DQN): a neural network estimates the Q-function, and the policy chooses the action with the largest estimate.

## Terminal transitions in implementation

When an episode ends, there is no next action to value. A robust implementation masks the future-value term for terminal transitions:

$$
y=r+\gamma(1-d)\max_{a'}Q(s',a'),
$$

where \(d=1\) when the transition ends the episode and \(d=0\) otherwise. This prevents the model from inventing reward beyond a terminal state.

The first network design can take the concatenated state and one-hot action as input and return a single Q-value. The next lesson introduces a faster architecture for the four Lunar Lander actions.
