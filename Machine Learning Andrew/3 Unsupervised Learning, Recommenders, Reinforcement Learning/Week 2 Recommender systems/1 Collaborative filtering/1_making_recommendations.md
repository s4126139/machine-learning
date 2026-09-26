# Making Recommendations

A recommender predicts which items a user may like. The input is often a sparse
user-item matrix: rows are users, columns are items, and most entries are
missing because each person has interacted with only a small part of the
catalogue.

For example, a movie service may have a rating $y_{ui}$ only when user $u$ has
rated movie $i$. A missing entry does **not** mean a zero-star rating; it means
the system has no explicit rating for that pair.

The system learns patterns across the known entries and predicts scores for
the missing ones. For each user, it can then rank items they have not already
seen and recommend the highest-scoring candidates.

~~~mermaid
flowchart LR
  A[Known ratings or interactions] --> B[Learn user and item representations]
  B --> C[Score unseen user-item pairs]
  C --> D[Filter seen items]
  D --> E[Rank and recommend candidates]
~~~

Two broad approaches are used in the course. **Collaborative filtering** learns
from patterns in user-item interactions: people with similar histories may
like similar items. **Content-based filtering** uses descriptive features of
users and items, such as genre or product category. Both can be combined in a
production system.

## Evaluation caution

Ratings reflect what users had a chance to see, not every item they would
like. Exposure and position affect the data. A good recommender therefore needs
careful offline evaluation and monitoring after deployment, not only a low
training error.
