# Continuous State Spaces

A small grid world has a finite list of states. A physical system usually has measurements that can vary across a range, so it has a continuous state space.

## A vehicle's state is a vector

A ground vehicle may be described by

$$
s=(x,y,\theta,\dot{x},\dot{y},\dot{\theta}),
$$

where position, orientation, linear velocity, and turning speed all matter. A helicopter needs more measurements: three position values, orientation such as roll, pitch, and yaw, plus linear and angular velocities. In the lesson, this amounts to a 12-number state.

Each number can take many possible values. Even a six-dimensional vehicle state does not fit naturally into a table with one row for every situation. The number of possible combinations is enormous.

## What changes for learning

The decision problem is still state, action, transition, and reward. The representation changes: instead of memorizing one value per discrete state, a function approximator such as a neural network estimates values for a vector of measurements.

~~~mermaid
flowchart LR
    S[Continuous measurements<br/>position, velocity, orientation] --> F[Value or policy function]
    F --> A[Choose an action]
    A --> E[Physical system or simulator]
    E --> S
~~~

The quality of the state representation matters. If two situations need different actions, the input measurements must let the model distinguish them.
