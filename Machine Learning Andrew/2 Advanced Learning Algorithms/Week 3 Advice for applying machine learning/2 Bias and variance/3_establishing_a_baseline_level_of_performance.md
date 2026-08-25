# Establishing a Baseline Level of Performance

## Why “high error” needs context

The absolute value of $J_{\text{train}}$ is not always enough to decide whether a model has high bias. For some applications, zero error is unrealistic because some examples are intrinsically difficult or noisy. A **baseline level of performance** states the error level that it is reasonable to hope the learning algorithm can eventually reach.

The running example is speech recognition for mobile web search. The input may contain requests such as “What is today's weather?” or “Coffee shops near me,” and the model must output the complete transcript.

## Speech-recognition example

Suppose the measured errors are:

| Measurement | Error |
|---|---:|
| Human-level performance | 10.6% |
| Training error | 10.8% |
| Cross-validation error | 14.8% |

Training error here is the percentage of training audio clips that are not transcribed perfectly in their entirety.

At first, 10.8% training error may appear high and suggest high bias. However, fluent human speakers also make 10.6% error because many web-search audio clips contain noise so severe that nobody can accurately determine what was said.

Relative to this baseline:

$$
\text{bias gap}
=J_{\text{train}}-J_{\text{baseline}}
=10.8\%-10.6\%
=0.2\%,
$$

while

$$
\text{variance gap}
=J_{\text{cv}}-J_{\text{train}}
=14.8\%-10.8\%
=4.0\%.
$$

The model is only slightly worse than the attainable baseline on its training set, but performs substantially worse on the CV set. The dominant issue is therefore variance, not bias.

## Sources of a baseline

A baseline estimates either the error that can reasonably be achieved or the desired level the model should reach. It may come from:

- **Human-level performance**, especially for unstructured data such as audio, images, and text, where people often perform well.
- **A competing algorithm**, including a previous implementation or a competitor's system if its performance can be measured.
- **Prior experience**, used to estimate a realistic target.
- **Perfect performance**, in applications where zero error is a realistic objective; in this case the baseline is 0%.

## Diagnose using two gaps

Let $J_{\text{baseline}}$ be the baseline error. Compare:

$$
\underbrace{J_{\text{train}}-J_{\text{baseline}}}_{\text{bias gap}}
\qquad\text{and}\qquad
\underbrace{J_{\text{cv}}-J_{\text{train}}}_{\text{variance gap}}.
$$

| Pattern | Diagnosis |
|---|---|
| Large bias gap, small variance gap | High bias |
| Small bias gap, large variance gap | High variance |
| Large bias gap, large variance gap | High bias and high variance |
| Both gaps small | Neither problem is dominant |

For example, a 4.4% gap between the baseline and training error, followed by only a small CV–training gap, indicates high bias. If the first gap is 4.4% and the second is also large—4.7% in the example—then the algorithm has both high bias and high variance.

## Main conclusion

Instead of asking only whether training error looks numerically large, ask whether it is large relative to an attainable target. Then separately ask whether cross-validation error is much larger than training error. These comparisons provide a more accurate diagnosis when the data contains unavoidable noise and perfect performance is unrealistic.
