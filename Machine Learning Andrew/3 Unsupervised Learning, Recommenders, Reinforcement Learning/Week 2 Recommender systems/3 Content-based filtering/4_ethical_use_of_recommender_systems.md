# Ethical Use of Recommender Systems

A recommender changes what people see, so its effects go beyond prediction
accuracy. A system can be technically accurate on historical clicks and still
amplify a narrow set of items or disadvantage groups that were under-exposed in
the data.

## Questions to ask before deployment

- **What is being optimized?** Clicks, time spent, satisfaction, learning, or
  another goal? A convenient proxy may not match the user's interests.
- **Who is represented?** Check whether some creators, products, or user groups
  are missing or poorly covered.
- **Can users understand and control recommendations?** Provide useful
  explanations, preference controls, and ways to reset or correct signals.
- **What data is collected?** Minimize sensitive information, protect it, and
  make its use clear.
- **What feedback loop may form?** Showing an item increases the chance of a
  click, and those clicks may cause the item to be shown even more.

Evaluate more than average ranking quality. Inspect exposure across groups,
novelty, diversity, complaint patterns, and effects over time. Use human review
for high-impact decisions and create a way to investigate harmful or
unexpected recommendations.

Ethical review is an ongoing part of product and model monitoring because user
behavior and the catalogue change after release.
