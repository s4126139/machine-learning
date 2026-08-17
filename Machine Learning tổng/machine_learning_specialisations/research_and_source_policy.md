# Research and Source Policy

## Purpose

This policy keeps specialised lifecycle guidance traceable, current, and honest about evidence. It applies to every page under `machine_learning_specialisations/`.

## Source priority

Use the strongest suitable source in this order:

1. standards, government guidance, or normative specifications;
2. official framework, library, benchmark, or platform documentation for claims about that system;
3. original or foundational peer-reviewed papers for a method or empirical claim;
4. authoritative textbooks, systematic surveys, or major academic course material for synthesis;
5. reputable engineering reports for production lessons that are not covered by standards.

Do not use SEO summaries, uncited listicles, copied tutorials, or a vendor comparison to support claims outside that vendor's own system.

## Claim-to-source rules

- Put specialised references near the guide they support, not only in a global bibliography.
- A source must directly support the associated claim.
- A reference annotation that states exactly which definition, protocol, metric, risk, or tool behaviour it supports acts as a compact claim-to-source map. Use inline citations or a separate claim table when several non-adjacent claims depend on different sources.
- Distinguish a normative requirement, a recommended practice, an empirical observation, and a tool capability.
- Vendor documentation may establish what an API supports; it does not prove that the approach is universally best.
- A foundational paper may define a method; use newer official documentation for current API behaviour.
- Record the research/check date and version when a claim may change over time.
- Prefer stable landing pages over version-specific URLs unless version specificity is important.
- Preserve uncertainty or disagreement instead of presenting one research result as universal fact.
- If a guide recognises a variant but lacks direct protocol/evaluation sources, mark that variant out of scope rather than extrapolating from an adjacent method.

## Minimum source standard per guide

Each specialisation guide must have:

- at least two authoritative sources;
- at least one official, primary, normative, or foundational source;
- a source for specialised evaluation or risk claims;
- a checked date when APIs, benchmarks, or operational guidance may change;
- no broken placeholder links.

Shared lifecycle claims may cite the common sources below. Specialised claims still require specialised sources in their owning guide.

## Common lifecycle sources

- [NIST AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework) — lifecycle risk management, trustworthiness, and governance.
- [NIST AI RMF Core](https://airc.nist.gov/airmf-resources/airmf/5-sec-core/) — Govern, Map, Measure, and Manage outcomes; risk management is continuous and contextual.
- [NIST AI RMF Playbook](https://www.nist.gov/itl/ai-risk-management-framework/nist-ai-rmf-playbook) — tailoring risk practices to context and use case.
- [Google Rules of Machine Learning](https://developers.google.com/machine-learning/guides/rules-of-ml) — production-system design, instrumentation, simple baselines, and iteration.
- [Hidden Technical Debt in Machine Learning Systems](https://research.google/pubs/hidden-technical-debt-in-machine-learning-systems/) — system dependencies, feedback loops, and production debt.
- [The ML Test Score](https://research.google/pubs/the-ml-test-score-a-rubric-for-ml-production-readiness-and-technical-debt-reduction/) — data/model tests and production-readiness controls.
- [Model Cards for Model Reporting](https://research.google/pubs/model-cards-for-model-reporting/) — intended use, evaluation context, limitations, and subgroup reporting.
- [Datasheets for Datasets](https://arxiv.org/abs/1803.09010) — dataset motivation, composition, collection, use, distribution, and maintenance documentation.

## Research record

The expansion research was conducted on **2026-08-14**. Its methodology, source-to-claim map, architecture decision, and unresolved scope boundaries are recorded in the [research report](../research/ml_lifecycle_extension_research_2026-08-14.md).

## Maintenance process

When updating a guide:

1. identify claims affected by the change;
2. verify official or primary sources;
3. update the checked date if time-sensitive evidence changed;
4. check related guides for terminology conflicts;
5. validate local links and external reference targets;
6. document material scope changes in the research record or a dated successor report.

## Prohibited overclaims

Do not claim that:

- federated learning automatically guarantees privacy;
- differential privacy means zero privacy risk;
- feature importance establishes causality;
- drift automatically means performance loss, or no drift proves safety;
- a high offline recommender/RL metric proves online impact;
- a generative automatic metric fully measures human quality or safety;
- a benchmark score proves broad real-world generalisation;
- an untouched random-row test set is valid for grouped, temporal, graph, client, speaker, scene, or trajectory data;
- the handbook enumerates every possible ML algorithm or future research field.

[Back to the specialisation index](README.md)
