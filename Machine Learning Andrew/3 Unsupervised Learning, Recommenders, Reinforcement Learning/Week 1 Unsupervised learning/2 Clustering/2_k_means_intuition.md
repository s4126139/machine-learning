# K-Means: The Intuition

K-means tries to place $K$ centers among the examples so that each example is
close to one center. The number $K$ is supplied by the user.

Imagine points on a map. Start with one center near each proposed neighborhood.
Assign every point to its nearest center. Then move each center to the average
location of the points assigned to it. Repeating these two steps makes the
centers follow the data.

~~~mermaid
flowchart LR
  A[Choose K starting centers] --> B[Assign each point to nearest center]
  B --> C[Move each center to its group's mean]
  C --> D{Assignments changed?}
  D -- Yes --> B
  D -- No --> E[Return the groups and centers]
~~~

The intuition depends on a distance measure. With ordinary Euclidean distance,
two points are considered similar when their feature coordinates are close.
The algorithm treats all dimensions according to that geometry, so features
with much larger numeric ranges can dominate unless they are scaled.

The process usually improves the grouping at each iteration, but the starting
centers matter. A poor initialization can settle on a mediocre grouping. Later
notes cover the objective and why it is common to try several random starts.

**Remember:** K-means discovers groups in the chosen feature space. It does
not decide what the groups mean or guarantee that the application has exactly
$K$ natural categories.
