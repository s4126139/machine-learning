# Recommending from a Large Catalogue

Scoring every item for every active user can be too expensive when the
catalogue contains millions of items. A common architecture separates
candidate retrieval from ranking.

~~~mermaid
flowchart LR
  A[User and context] --> B[Retrieve a few hundred candidates]
  B --> C[Apply eligibility and availability rules]
  C --> D[Rank candidates with a richer model]
  D --> E[Return a small diverse list]
~~~

**Retrieval** quickly finds a manageable set, often using embeddings, search
indexes, or multiple candidate generators. **Ranking** applies a more
expensive model to order those candidates using user, item, and context
features. Filtering removes items that cannot or should not be shown.

The retrieval stage must have enough recall: if a good item is never retrieved,
the ranking model cannot recover it. Ranking quality alone is not enough. Measure
candidate recall, ranking performance, latency, and the quality of the final
displayed list.

In a two-tower recommender, item vectors can be indexed ahead of time. At
request time, a user vector can retrieve nearby item vectors using approximate
nearest-neighbor search, then a ranking model can refine the shortlist.

Large-catalogue systems also need safeguards for availability, region, age
rating, diversity, and repeated exposure. Those constraints belong in the
serving design, not only in the model's training loss.
