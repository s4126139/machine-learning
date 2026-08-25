# Error Analysis

## Purpose

After bias–variance analysis, **error analysis** is one of the most important diagnostics for choosing what to try next. It consists of manually inspecting examples that the model misclassified, looking for common themes or traits, and counting how often those themes occur.

Suppose

$$
m_{\text{cv}}=500
$$

and the spam classifier misclassifies 100 of those cross-validation examples. Inspect those 100 errors and assign them to meaningful categories.

## Worked spam-classifier analysis

The example counts are:

| Error category | Count among 100 misclassified examples | Implication |
|---|---:|---|
| Pharmaceutical spam | 21 | A major source of error |
| Deliberate misspellings | 3 | Real, but relatively small |
| Unusual email routing | 7 | A possible but smaller direction |
| Phishing / password theft | 18 | Another major source of error |
| Spam text embedded in images | Count during review | The body text may be hidden from a text-based recognizer |

These counts help estimate the potential impact of a proposed change. Even a sophisticated misspelling detector could directly solve at most three of the 100 examined errors, so it may deserve lower priority than work on pharmaceutical spam or phishing.

This lesson reflects a real development mistake: substantial effort was once spent detecting deliberate misspellings before careful error analysis showed that their total impact was small.

## Categories may overlap

The categories are not mutually exclusive. One email may:

- advertise pharmaceuticals;
- contain deliberate misspellings;
- use unusual routing; and
- attempt a phishing attack.

It is therefore valid to count the same example in multiple rows. The goal is to understand recurring properties, not to partition the errors into disjoint classes.

## How many errors to inspect

When the number of errors is manageable, inspect all of them. If a larger CV set contains 1,000 misclassified examples, a full review may take too long. In that case:

1. Randomly sample roughly 100 or perhaps a couple hundred errors.
2. Inspect that sample manually.
3. Use the resulting counts to estimate the most common failure types.

A sample of this size is often small enough to review in a reasonable time while still providing useful evidence about where to focus.

## Turn findings into actions

If pharmaceutical spam is a large category, possible next steps include:

- collect more examples specifically of pharmaceutical spam rather than more email of every kind; or
- create features based on drug names and pharmaceutical product names.

If phishing is common, possible next steps include:

- inspect URLs and create features that identify suspicious links; or
- collect more examples of phishing email.

Thus, error analysis can inspire targeted improvements to either the data or the features. It can also show that an apparently interesting problem is too rare to justify much work.

## Combine with bias–variance analysis

The diagnostics answer complementary questions:

- **Bias–variance analysis:** Is more data likely to help at all?
- **Error analysis:** Which kinds of data, features, or errors deserve attention?

For the spam example, bias–variance analysis can judge whether more data is promising. Error analysis suggests that features or data targeting pharmaceutical spam and phishing could help much more than a misspelling detector.

## Limitation

Manual error analysis works best on tasks where people can understand the examples and recognize why a prediction is wrong. A person can inspect an email and reason about why it is spam. The method is harder for tasks humans themselves cannot predict well, such as determining which advertisement a person will click.

When it is applicable, error analysis can prevent months of low-impact work by focusing the team on the largest and most actionable sources of error.
