# Multimodal Learning

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay documents only requirements introduced by aligning, fusing, translating, retrieving, or generating across two or more modalities.

## Use this guide when

Use this overlay when a prediction depends on multiple modalities—such as image-text, audio-video, document-layout-text, sensor-language, or vision-language-action—or when the task maps or retrieves across modalities. Apply every relevant single-modality guide as well; this page owns cross-modal alignment and interaction.

## Do not confuse it with

- Merely storing separate modalities that are modelled independently. Use each single-modality guide without this overlay unless their alignment or joint use changes the decision.
- [Generative modelling](../task_families/generative_modelling_and_content_generation.md), which owns open-ended generation; the separate foundation-model guide owns broadly pretrained dependencies and system composition.
- [Recommendation, ranking, and retrieval](../task_families/recommendation_ranking_and_retrieval.md), which owns candidate-pool and ranking evaluation for cross-modal search.
- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md), which owns pretrained encoders, joint/frozen training stages and multitask optimisation.
- [Semi-, weakly, and self-supervised learning](../paradigms_and_methods/semi_weak_and_self_supervised_learning.md), which owns contrastive/self-supervised objectives, stage transitions and pseudo-target controls.
- [Privacy-preserving machine learning](../operational_settings/privacy_preserving_machine_learning.md), which owns threat models and formal privacy mechanisms when any linked or privileged modality is sensitive.
- [NLP, documents, and LLM applications](nlp_documents_and_llms.md), [computer vision](computer_vision.md), [speech/audio](speech_and_audio.md), or [video](video_and_temporal_media.md), each of which owns its modality-specific integrity controls.

## Scope and major variants

| Variant | Relationship | Distinct lifecycle concern |
|---|---|---|
| Early/intermediate/late fusion | combine modalities for one prediction | alignment, dominance and missing-modality behaviour |
| Cross-modal retrieval | query in one modality, candidates in another | positive-pair semantics, negatives and candidate pool |
| Translation/generation | one modality generates another | semantic alignment plus output-modality quality and safety |
| Grounded QA/captioning | language tied to visual/audio/video evidence | grounding, evidence coverage and confabulation |
| Contrastive representation learning | learn matched versus unmatched pairs | cross-modal pair provenance/semantics and false negatives; the self-supervised guide owns the learning objective/stage |
| Multisensor perception | synchronised sensors/coordinate frames | calibration, timing and sensor failure fallback |
| Co-learning with privileged modality | modality present only during training | train-serving contract and distillation leakage |

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Define each modality's role, alignment unit, availability/latency, missingness, permitted evidence and fallback | Multimodal observation/availability and decision contract |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Preserve provenance/licence/consent per modality and for pairings; validate synchronisation, identity and cross-modal consistency | Paired-data manifest, alignment quality report and modality-specific governance matrix |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md) | Split by the joint entity/event/source and duplicate cluster across every modality | Joint group/split manifest and cross-modal contamination audit |
| [05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Version modality processors, temporal/spatial alignment, pairing, missingness representation and cross-modal pair constraints | End-to-end alignment/preprocessing specification and invariance tests |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare each unimodal input and simple fusion; control paired-data, candidate/negative constraints and per-modality compute budgets | Unimodal/fusion/ablation table and staged selection log |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Evaluate joint task, alignment, incremental fusion value, missing/conflicting modalities and cross-modal slices | Frozen evaluator/candidate set, modality-ablation report and locked evaluation |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[15](../../machine_learning_lifecycle_phases/15_retraining_and_maintenance.md) | Package all processors/alignment/fusion and fallback paths; monitor availability, skew, agreement and component drift | Multimodal system manifest, golden paired cases and coordinated update plan |
| [16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Retire paired records, modality embeddings/indexes, alignment maps, caches and credentials consistently | Cross-modal dependency and data disposition record |

## Problem and data contract

Define the atomic aligned unit: entity, event, session, time window, page/region, utterance, item-caption pair, query-candidate pair or sensor frame. For every modality record its raw format, acquisition time/source, identifier, processor, availability, latency, expected quality and whether it is optional, substitutable or mandatory.

Define what makes a positive pair. Co-occurrence, shared URL or approximate timestamp may not imply semantic correspondence. Record alignment method and confidence, temporal tolerance, spatial/coordinate calibration, many-to-one relationships, weak versus verified pairs, negative-pair construction and annotation adjudication.

Preserve provenance, licence, consent, retention and access rights for each component and the pairing itself. Linking previously separate text, images, voices, locations or identifiers can increase re-identification and sensitivity; governance must evaluate the joined record, not only each source in isolation.

Validate missing/corrupt modalities, identifier mismatches, timestamp/coordinate skew, duplicate pairs, one item repeated across many pairs, contradictory content, unexpected language/channel/type and imbalance in modality combinations. Report the natural missingness pattern rather than silently dropping incomplete cases.

## Split and evaluation protocol

Split by the joint originating entity/event/session/source before deriving clips, crops, captions, transcripts, chunks or augmented views. All representations of one item—including translated captions, OCR, ASR, thumbnails, audio excerpts and generated descriptions—stay together unless deployment explicitly permits prior exposure.

Audit duplicates within and across modalities. A test image may leak through its caption, a test utterance through its transcript, or a test video through sampled frames. Pretrained encoders and web-scale paired data may make full contamination auditing impossible; disclose the limitation and use external/time/source-held evidence where possible.

For cross-modal retrieval, lock query/candidate partitioning, candidate pool, positives, false-negative policy and whether multiple valid matches exist. For time-aligned sensors, respect causal availability and actual per-modality delay. Do not fill a missing test modality using a model trained on test-linked paired data.

Construct validation and locked sets with realistic modality-availability combinations. Aggregate uncertainty by joint entity/session/source, not individual pairs produced from it.

## Baselines and model-family choices

Every multimodal claim requires unimodal and simple-fusion baselines:

- one baseline for each individual modality under the same examples;
- metadata/prior baseline to expose collection shortcuts;
- score/feature concatenation or late-fusion baseline;
- frozen pretrained encoders with a small fusion/projection head;
- missing-modality and random/mismatched-pair diagnostics;
- incumbent pipeline and an oracle-modality diagnostic where useful.

Report the incremental value of adding each modality, not only the best joint score. Equalise candidate pools, data eligibility, context, external pretraining and compute where a causal comparison is claimed. A multimodal model evaluated only on complete examples may be worse operationally than a robust unimodal fallback.

## Training and validation adaptations

Version every modality processor and the alignment/fusion layer. Apply stochastic transformations consistently when they share coordinates or time; independently augment only when semantics permit. For contrastive/self-supervised stages, apply the semi/weak/self-supervised guide. This overlay additionally requires cross-modal positives and negatives to be constructed from training entities only and to account for multiple true matches or related items that would become false negatives.

Record fusion stage, modality-specific encoders, frozen/unfrozen stages, projection spaces, loss weights/temperatures, batch composition, paired/unpaired sampling and modality dropout. Track gradient/loss scale and representation quality per modality so a dominant shortcut does not masquerade as fusion.

Train with realistic missingness and latency if fallbacks are required, but do not invent missingness patterns without field evidence. For a privileged training-only modality, verify that the serving graph does not accept that modality and that evaluation uses the true serving contract. Excluding the input is not a privacy guarantee: when the privileged data are sensitive, declare a threat model and test the student weights/outputs for membership, attribute, inversion or extraction leakage as applicable. Apply the privacy overlay when a formal guarantee is required.

## Metrics and uncertainty

The joint task determines the primary metric; each modality/task guide defines its component metrics. In addition, report:

- every unimodal baseline and modality-addition ablation on the same cases;
- performance for each availability combination and corrupted/missing modality;
- for cross-modal retrieval, use the retrieval guide's candidate construction and ranking metrics; additionally lock cross-modal positive-pair semantics, multiple-positive handling and false-negative policy;
- alignment/localisation or grounding measures when the output claims evidence in another modality;
- cross-modal calibration/consistency and performance under contradictory evidence;
- end-to-end latency and cost, including the slowest/optional modality and alignment stage.

For generated outputs, separate input-grounding and cross-modal consistency from perceptual/linguistic quality and human utility; add the generative guide. Report by source, language, sensor/device, content type, alignment confidence and affected group. Bootstrap the joint entity/session.

## Error analysis, safety, and robustness

Classify failures as acquisition, alignment, single-modality representation, fusion, candidate/retrieval, generation, fallback or output errors. Review the complete aligned bundle; looking at only one modality hides contradictions and spurious correlations.

Test one modality missing, blank, delayed, low-quality, corrupted or adversarial; temporal/spatial desynchronisation; contradictory modalities; novel modality combinations; modality-specific domain shifts; and shortcut removal. Measure both graceful degradation and whether an unreliable modality harms an otherwise correct prediction.

Threats can cross modalities: prompt injection embedded in an image/audio/document, adversarial content targeting one encoder, malicious sensor spoofing, unsafe generated media, paired-data poisoning and privacy inference from linked records. Apply access control and sanitisation before fusion. Define which modality is trusted when evidence conflicts and when the system must abstain or request human review.

## Packaging, deployment, monitoring, and maintenance

Package each decoder/processor/tokeniser, identifier mapping, synchronisation/calibration, alignment/pairing, encoders, fusion/projection, missingness representation, model, candidate index, postprocessing, safety controls and fallback/routing policy. Golden bundles must cover complete, missing, delayed, contradictory and misaligned inputs plus independent component-version failures.

Declare timeouts and late-arrival behaviour for every modality. Budget acquisition, preprocessing, transfer, inference, fusion and postprocessing latency separately. Make fallback outputs distinguishable so downstream users know which evidence was used.

Monitor per-modality availability, decode/quality, source mix, latency, timestamp/coordinate skew, alignment confidence, embedding and prediction drift, cross-modal agreement, fallback rates, modality-specific contributions, task/safety outcomes and cost. Version modality components independently but release them through compatibility-tested bundles. Retiring or deleting one source must propagate to paired records, embeddings, indexes, caches and derived captions/transcripts.

## Minimum completion checklist

- [ ] Atomic alignment unit, positive-pair semantics, modality roles and availability are explicit.
- [ ] Provenance, licence, consent, retention and sensitivity are assessed per source and joined record.
- [ ] Identity/time/coordinate alignment, duplicates, contradictions and natural missingness are audited.
- [ ] Joint entity/source grouping prevents leakage through any derived modality.
- [ ] All modality processors, alignment and contrastive pair/negative construction are train-bounded.
- [ ] Every unimodal baseline, simple fusion and modality ablation was evaluated on comparable cases.
- [ ] Joint task, grounding/retrieval, availability and group-aware uncertainty protocols are locked.
- [ ] Missing, corrupt, delayed, contradictory and cross-modal adversarial cases were tested.
- [ ] Any privileged modality is absent from the serving graph; sensitive-information leakage is threat-modelled and tested, with the privacy overlay added when required.
- [ ] Complete processors/alignment/fusion/fallback system is packaged with golden bundles.
- [ ] Monitoring and retirement propagate across paired records, embeddings, indexes and caches.

## Related guides

- [Computer vision](computer_vision.md)
- [NLP, documents, and LLM applications](nlp_documents_and_llms.md)
- [Speech and audio](speech_and_audio.md)
- [Recommendation, ranking, and retrieval](../task_families/recommendation_ranking_and_retrieval.md)
- [Generative modelling](../task_families/generative_modelling_and_content_generation.md)
- [Semi-, weakly, and self-supervised learning](../paradigms_and_methods/semi_weak_and_self_supervised_learning.md)

## Official and primary references

- [Multimodal Machine Learning: A Survey and Taxonomy](https://doi.org/10.1109/TPAMI.2018.2798607) — primary taxonomy covering representation, translation, alignment, fusion and co-learning.
- [Learning Transferable Visual Models From Natural Language Supervision (CLIP)](https://arxiv.org/abs/2103.00020) — primary image-text contrastive learning and zero-shot transfer study.
- [Learning Using Privileged Information: Similarity Control and Knowledge Transfer](https://jmlr.org/papers/v16/vapnik15b.html) — primary LUPI reference distinguishing privileged training information from serving inputs.
- [OpenAI CLIP model card](https://github.com/openai/CLIP/blob/main/model-card.md) — official intended-use, out-of-scope and deployment-limitation documentation; explicitly does not establish general deployment readiness.
- [Hugging Face task summary](https://huggingface.co/docs/transformers/main/en/task_summary) — official evolving catalogue distinguishing multimodal tasks such as image captioning and document question answering.
- [NIST AI 600-1: Generative AI Profile](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf) — official risk guidance relevant to multimodal generative content, provenance, privacy and human evaluation.
- [NIST AI 100-2e2025: Adversarial Machine Learning taxonomy and terminology](https://csrc.nist.gov/pubs/ai/100/2/e2025/final) — normative terminology for privacy compromise, poisoning, evasion and misuse threats that can cross modalities.

Checked: 2026-08-14. Hosted model behaviour and framework task catalogues must be rechecked for the version used by a project.

[Back to the specialisation index](../README.md)
