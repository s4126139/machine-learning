# Collaborative Filtering vs. Content-Based Filtering

The two approaches can recommend the same items, but they learn from different
signals.

| Approach | Main signal | Strength | Common limitation |
| --- | --- | --- | --- |
| Collaborative filtering | Patterns across user-item interactions | Can discover relationships not described by metadata | Cold start for new users/items; sparse interactions |
| Content-based filtering | User and item attributes | Can score a new item when its features are known | Needs useful features and can over-specialize |

Collaborative filtering may learn that people who liked one item also liked
another. Content-based filtering may learn that a user prefers items with
particular attributes, such as a genre, language, or product category.

A practical system can combine both: use content for new items, interaction
patterns after data accumulates, and other signals such as popularity or
context where appropriate. Evaluate the combination on the actual use case;
there is no universal winner.

## Cold start is a data problem

For a new item, collaborative filtering has no interaction history. A
content-based model can still produce a score from item attributes, but only
if those attributes are available and informative. A new user is harder for
both approaches; onboarding preferences or a safe non-personalized fallback
can help until the user has interacted with the catalogue.
