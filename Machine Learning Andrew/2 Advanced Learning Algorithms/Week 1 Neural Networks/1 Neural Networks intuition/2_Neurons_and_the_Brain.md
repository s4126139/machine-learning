# Neurons and the Brain

## Biological motivation

Neural networks were originally motivated by the goal of writing software that could mimic how the biological brain learns and thinks. Modern artificial neural networks are now very different from any realistic account of how the brain works, but some biological terminology and intuition remain.

### Brief history

- Work on neural networks began in the **1950s**, then fell out of favor.
- Interest returned in the **1980s and early 1990s**, with applications such as handwritten digit recognition for postal codes and handwritten dollar amounts on checks.
- Neural networks declined in popularity again in the late 1990s.
- From about **2005**, they experienced a resurgence and were increasingly branded as **deep learning**.
- Modern deep learning first had a major impact on speech recognition, then computer vision, including the widely discussed ImageNet moment in 2012, and later text and natural language processing.
- Neural networks are now used in areas including climate change, medical imaging, online advertising, and product recommendations.

## From a biological neuron to an artificial neuron

A biological neuron:

- receives electrical impulses from other neurons through input structures called **dendrites**;
- carries out a computation in its cell body;
- sometimes sends an electrical impulse through an output structure called the **axon**;
- provides an output that can become an input to other neurons.

These biological names are not necessary for building artificial neural networks.

An artificial neuron is a deliberately simplified mathematical model:

1. It receives one or more numerical inputs.
2. It performs a computation.
3. It produces one numerical output.
4. That output may become an input to another artificial neuron.

Neural networks normally simulate many such neurons together rather than constructing one neuron at a time.

## Important limitation of the analogy

The connection between biological and artificial neurons is only a loose analogy. Current knowledge of how the human brain learns remains very limited, and neuroscience continues to make fundamental discoveries. Blindly mimicking today's incomplete understanding of the brain is therefore unlikely to be a direct route to general intelligence.

Even extremely simplified artificial-neuron models can nevertheless produce powerful deep learning algorithms. Modern deep learning research consequently relies more on engineering principles for building effective algorithms than on close biological imitation.

## Why neural networks took off

Consider a graph with:

- the **amount of available data** on the horizontal axis;
- the **performance or accuracy** of a learning algorithm on the vertical axis.

The rise of the internet, mobile phones, and broader digitization moved many applications toward much larger datasets. Records once stored on paper—such as orders and health records—became digital.

Traditional algorithms such as linear regression and logistic regression often struggled to keep improving as more data was supplied. In contrast:

- a small neural network could achieve better performance on more data;
- a medium network, containing more neurons, could perform better still;
- for some applications, a very large neural network could continue improving as the dataset grew.

This combination made previously unattainable performance possible in speech recognition, image recognition, natural language processing, and other applications:

1. **Large datasets** supplied more information to learn from.
2. **Large neural networks** could use that data more effectively.
3. **Faster processors**, especially GPUs originally designed for computer graphics, made training these networks practical.

The availability of data, scalable neural-network models, and powerful computation together drove the modern rise of deep learning.
