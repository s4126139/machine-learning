# Continuous-Valued Features in Decision Trees

A decision tree can also split on a feature that may take any numerical value. In the cat-classification example, add the animal's weight as a continuous input feature. Cats are lighter than dogs on average, although some cats are heavier than some dogs, so weight may help the classifier.

## Threshold-based splits

For a continuous feature $x$, a candidate decision compares it with a threshold $t$:

$$
x\le t.
$$

Examples satisfying the condition go to one child; the remaining examples go to the other. The learning algorithm must choose both:

- whether the continuous feature is better than the other available features;
- which threshold produces the best split.

As with categorical features, “best” means **highest information gain**.

## Weight example

At the root there are 10 animals: five cats and five non-cats. Thus,

$$
p_1^{\text{root}}=0.5.
$$

### Candidate threshold: weight $\le 8$

The split produces:

- left: 2 examples, both cats;
- right: 8 examples, including 3 cats.

$$
\operatorname{IG}(t=8)
=H(0.5)
-\left[
\frac{2}{10}H\!\left(\frac22\right)
+\frac{8}{10}H\!\left(\frac38\right)
\right]
\approx 0.24.
$$

### Candidate threshold: weight $\le 9$

The split produces:

- left: 4 examples, all cats;
- right: 6 examples, including 1 cat.

$$
\operatorname{IG}(t=9)
=H(0.5)
-\left[
\frac{4}{10}H\!\left(\frac44\right)
+\frac{6}{10}H\!\left(\frac16\right)
\right]
\approx 0.61.
$$

### Candidate threshold: weight $\le 13$

The corresponding information gain is approximately

$$
\operatorname{IG}(t=13)\approx 0.40.
$$

Among these candidates, $t=9$ gives the largest information gain.

## Choosing candidate thresholds

A general procedure is:

1. sort the training examples by the continuous feature;
2. use the midpoints between adjacent sorted values as candidate thresholds;
3. compute information gain for every candidate;
4. retain the threshold with the highest information gain for that feature;
5. compare that score with the best scores from all other candidate features.

With 10 distinct sorted training values, this convention tests 9 midpoint thresholds.

If the weight split at $t=9$ has higher information gain than every split available from ear shape, face shape, and whiskers, choose the decision

$$
\text{weight}\le 9.
$$

The two resulting subsets then become inputs to the same recursive tree-building process.

## Key takeaway

Continuous features do not require a different impurity measure. The algorithm searches across possible numerical thresholds, evaluates each with the usual information-gain formula, and selects the feature–threshold pair with the greatest gain.
