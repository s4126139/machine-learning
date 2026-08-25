# Classification with Multiple Outputs

## Multiclass and multi-label are different problems

In **multiclass classification**, each input has one target label, even though that label can belong to one of many categories. Handwritten-digit recognition is an example: $y$ is a single number selected from ten possibilities.

In **multi-label classification**, one input can have several labels simultaneously.

| Problem type | Target form | Meaning |
|---|---|---|
| Multiclass | One value $y$ | Exactly one class is selected from several possible classes. |
| Multi-label | A vector $y$ | Each component independently indicates whether one label applies. |

## Driver-assistance example

Given an image from in front of a car, the system may need to answer three questions:

1. Is there at least one car?
2. Is there a bus?
3. Is there at least one pedestrian?

One image can contain more than one of these object types. Its target is therefore a three-component vector, for example:

- car present, no bus, pedestrian present: $y=[1,0,1]$;
- no car, no bus, pedestrian present: $y=[0,0,1]$;
- car present, bus present, no pedestrian: $y=[1,1,0]$.

## Two modeling approaches

### Separate networks

Treat the task as three independent binary-classification problems:

- one neural network detects cars;
- one detects buses;
- one detects pedestrians.

This is a reasonable approach.

### One network with three outputs

A single network can also detect all three labels simultaneously:

- input $x$ feeds the first hidden layer $a^{[1]}$;
- the next hidden layer produces $a^{[2]}$;
- the output layer has three units and produces

$$
a^{[3]}=
\begin{bmatrix}
a_1^{[3]}\\
a_2^{[3]}\\
a_3^{[3]}
\end{bmatrix}.
$$

The three output units correspond to car, bus, and pedestrian.

Because each component is a separate yes/no question, use a sigmoid activation for each output unit. Each activation then indicates whether the model predicts the corresponding object category is present.

## Choosing the correct formulation

- Use **multiclass classification** when each input belongs to exactly one of several categories.
- Use **multi-label classification** when several labels can be true for the same input.

The difference lies in the structure of the target and determines whether the network needs one categorical output or several binary outputs.

