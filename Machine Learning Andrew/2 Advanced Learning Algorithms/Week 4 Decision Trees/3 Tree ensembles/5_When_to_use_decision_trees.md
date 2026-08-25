# When to Use Decision Trees

Decision trees, tree ensembles, and neural networks are all powerful learning algorithms. The choice depends strongly on the form of the data and the practical needs of the project.

## Decision trees and tree ensembles

### Strong fit: tabular or structured data

Tree-based methods often work well when the dataset resembles a spreadsheet. The columns may contain categorical or continuous-valued features, and the task may be either classification or regression.

The housing-price example is structured data: its columns describe house size, number of bedrooms, number of floors, and age of the home.

### Weak fit: unstructured data

Decision trees and tree ensembles are not recommended here for unstructured inputs such as:

- images;
- video;
- audio;
- text.

Neural networks tend to work better for these data types.

### Training speed

Decision trees and tree ensembles are often fast to train. Faster training shortens the iterative machine-learning development loop, allowing a practitioner to train, evaluate, diagnose, and improve a model more quickly.

### Interpretability

A small, single decision tree with only a few dozen nodes may be human-interpretable: it can be printed and inspected to see which feature decisions lead to each prediction.

This advantage is sometimes overstated. An ensemble with 100 trees and hundreds of nodes per tree is difficult to understand directly and may require separate visualization techniques.

### Single tree or ensemble?

A tree ensemble costs more computationally than one decision tree. If computation is very constrained, a single tree may be appropriate. Otherwise, the lesson recommends using an ensemble for most tree-based applications and, in particular, generally choosing XGBoost.

## Neural networks

Neural networks can work on:

- structured or tabular data;
- unstructured data;
- mixed inputs containing both structured and unstructured components.

On structured data, neural networks and tree-based methods can both be competitive. On unstructured data—images, video, audio, and text—a neural network is the preferred choice in this comparison.

### Trade-offs and advantages

- A large neural network may train much more slowly than a decision tree.
- Neural networks support transfer learning, which can be crucial when the target task has only a small dataset but pretraining can use a much larger one.
- In a system containing multiple machine-learning models, it may be easier to connect and jointly train multiple neural networks because gradient descent can train the complete chain. Decision trees are trained one tree at a time.

## Comparison

| Consideration | Decision tree / tree ensemble | Neural network |
|---|---|---|
| Tabular, structured data | often strong | can also be competitive |
| Images, video, audio, text | not recommended in this comparison | preferred |
| Mixed structured and unstructured data | not highlighted as a strength | works well |
| Training speed | often fast | large networks may be slow |
| Human interpretability | possible for a small single tree | not presented as an advantage here |
| Transfer learning | not presented as an advantage here | supported and valuable with small target datasets |
| Joint training of multiple models | trees are trained one at a time | connected networks can be trained together with gradient descent |

## Broader course perspective

This course covered supervised learning with neural networks and decision trees, together with practical guidance for making them work well. Supervised algorithms require labeled training examples containing $Y$. Unsupervised learning, introduced in the next course of the specialization, seeks useful patterns without requiring those labels.

## Key takeaway

For structured, spreadsheet-like data, tree ensembles are strong candidates and are often fast to iterate on. For unstructured data or applications that benefit from transfer learning and jointly trained model components, neural networks are usually the better choice described in the lesson.
