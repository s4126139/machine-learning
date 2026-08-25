# Adding Data

## Different applications need different techniques

Machine learning applications vary: humans can label some types of data easily, some applications allow more data to be collected, and others do not. Consequently, no single data strategy applies everywhere. The lesson presents several techniques that are useful in different settings:

1. targeted data collection;
2. data augmentation; and
3. data synthesis.

## Target data collection using error analysis

It is tempting to gather more examples of every type, but that can be slow and expensive. Error analysis can identify a subset on which the model performs especially poorly, allowing a focused collection effort.

For the spam-classification example, if pharmaceutical spam is a major source of errors, obtain more pharmaceutical-spam examples rather than indiscriminately gathering email. If a large store of unlabeled email already exists, labelers can quickly skim it to find the desired category.

The broader pattern is:

- Gathering more data of all kinds is acceptable when it is easy.
- When analysis reveals a specific weakness, gathering examples of that type can produce a larger performance gain at lower cost.
- The same logic applies to phishing spam or any other important error category.

## Data augmentation

**Data augmentation** creates new training examples by transforming an existing input while keeping its label unchanged:

$$
(\mathbf{x},y)\longrightarrow(\widetilde{\mathbf{x}},y).
$$

The transformation teaches the model that the modified input still represents the same target.

### Image example: letter recognition

For optical character recognition of letters A–Z, one image of the letter A can be transformed by:

- rotating it slightly;
- enlarging it;
- shrinking it;
- changing its contrast;
- taking a mirror image when that transformation preserves the letter; or
- applying random warping through a grid placed over the image.

These transformations turn one labeled image into several examples and help the algorithm recognize the same letter under realistic variations. Mirroring is appropriate only for letters whose identity is preserved by the reflection.

### Audio example: speech recognition

Start with an audio clip such as “What is today's weather?” New training clips can be created by combining it with:

- crowd noise;
- car noise; or
- the distortion of a poor cell-phone connection.

Each result has the same transcript but sounds as though it was recorded in a different environment. This technique was described as critical in the development of accurate speech-recognition systems because it artificially increased the available training set.

### Choose useful transformations

Augmentations should resemble the noise or distortions expected in the test set. Warped letters are useful if similar shape variations appear in real inputs. Crowd noise, car noise, and bad connections are useful when users will submit speech under those conditions.

Purely random, meaningless changes are usually less helpful. If $x_i$ is the brightness of pixel $i$, adding independent noise to every pixel may create an image unlike anything found in the test set. The important question is whether the transformed examples remain representative of the data on which the system must ultimately perform.

## Data synthesis

Where augmentation modifies an existing example, **data synthesis** creates a brand-new labeled example from scratch.

### Photo OCR example

Photo OCR must read text appearing in real photographs. A key subproblem is recognizing a letter at the center of a small image patch, such as T, L, or C.

Synthetic examples can be generated with a computer text editor:

1. type random text;
2. render it using many different fonts;
3. vary colors and contrast; and
4. capture the rendered characters as labeled images.

The resulting examples can look similar to character patches extracted from real photographs. Once code for realistic synthesis has been written, it can generate a very large training set and substantially improve the model.

Creating a realistic generator may require significant effort. The lesson notes that synthetic data has been used most often for computer-vision tasks and less for audio and other applications.

## Model-centric and data-centric development

A machine learning system contains both:

- code implementing the algorithm or model; and
- the data used to train it.

Historically, much machine learning research followed a **model-centric** approach: hold a downloaded dataset fixed and focus on improving the model or algorithm. This work has produced strong algorithms, including linear regression, logistic regression, neural networks, and decision trees.

For many applications, it can now be more fruitful to take a **data-centric** approach and engineer the training data. That may mean:

- collecting examples from a category exposed by error analysis;
- augmenting image or audio examples; or
- synthesizing new training examples.

The choice is not that data always matters more than the model. Rather, improvements to the data can sometimes be the most efficient next step when strong learning algorithms are already available.

## Summary of the three approaches

| Approach | Starting point | Result |
|---|---|---|
| Targeted collection | Existing source of real, often unlabeled examples | More real data from a specific weak category |
| Data augmentation | A labeled example $(\mathbf{x},y)$ | A realistically transformed example $(\widetilde{\mathbf{x}},y)$ |
| Data synthesis | A generation process | A brand-new labeled example created from scratch |

When additional real data is very difficult to obtain, transfer learning provides another way to use data from a different but related input domain.
