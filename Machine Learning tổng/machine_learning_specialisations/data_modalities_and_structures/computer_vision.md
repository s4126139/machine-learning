# Computer Vision

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay documents only the additional or changed requirements for image data and visual outputs; it is not an independent lifecycle.

## Use this guide when

Use this overlay when the prediction unit or output includes decoded images, pixels, regions, masks, keypoints, text regions, or visual embeddings. It applies whether the estimator is classical or neural and whether images are the sole input or one component of a larger system.

## Do not confuse it with

- [Video and temporal media](video_and_temporal_media.md), where ordering, timestamps, clips, and tracks change the independence unit.
- [Multimodal learning](multimodal_learning.md), when images must be aligned or fused with text, audio, or another modality.
- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md), which owns neural training stages, pretrained-weight provenance, and accelerator controls.
- [Recommendation, ranking, and retrieval](../task_families/recommendation_ranking_and_retrieval.md), which owns retrieval metrics and candidate-pool evaluation.
- [Generative modelling](../task_families/generative_modelling_and_content_generation.md), which owns open-ended image generation and its safety evaluation.

OCR usually composes this guide with [NLP, documents, and LLM applications](nlp_documents_and_llms.md): vision owns page/image integrity and regions; NLP owns language normalisation and semantic evaluation.

## Scope and major variants

| Variant | Prediction/output unit | Distinct lifecycle concern |
|---|---|---|
| Image classification and multilabel tagging | image or image-region labels | subject/source leakage, class co-occurrence, thresholding |
| Detection and instance segmentation | boxes, classes, masks, scores | annotation geometry, matching rules, operating thresholds |
| Semantic/panoptic segmentation | class per pixel or combined thing/stuff segments | void labels, class imbalance by area, boundary quality |
| Keypoints and pose | landmark sets and visibility | coordinate conventions, occlusion, scale-aware evaluation |
| OCR and document vision | text regions, reading order, transcription | scan quality, layout, language and page grouping |
| Visual retrieval and re-identification | embeddings or ranked candidates | identity leakage, gallery construction, open-set behaviour |
| Dense restoration or estimation | reconstructed image, depth, flow, disparity | alignment, valid regions, perceptual versus task utility |

A dedicated task overlay owns primary objectives and metrics when one exists. Otherwise, this page owns output-structure-specific evaluation as well as visual data integrity, annotations, visual grouping, image transformations and vision-specific operational controls.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Declare image/region/pixel output unit, capture context, abstention behaviour, and downstream use of visual evidence | Visual task contract and harm-sensitive operating conditions |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Preserve capture, consent, licence, transformation and annotation provenance; validate decodability and geometry | Dataset/annotation version, integrity report, label ontology and adjudication record |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md) | Group by the real repeated source and detect exact/near duplicates across partitions | Group/split manifest and duplicate audit |
| [05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Version decoding, colour, orientation, resize/pad/crop, normalisation and target-aware augmentation | Train/evaluation transform specifications and coordinate tests |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare heuristics, simple/frozen encoders and pretrained baselines; tune thresholds on development data only | Comparable baseline table, compute budget and selection record |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Use task-valid visual matching, per-source aggregation, image-condition slices and an independently processed locked set | Evaluation protocol, slice report, uncertainty and locked-test report |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[15](../../machine_learning_lifecycle_phases/15_retraining_and_maintenance.md) | Package the full visual processor and postprocessor; monitor capture/representation drift and annotation changes | Versioned inference contract, monitoring plan and compatibility-tested update plan |
| [16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Retire processors, label maps, image caches, thumbnails, embeddings and sensitive metadata with the model | Dependency/data disposition record |

## Problem and data contract

Define the raw observation before defining a tensor. Record file/container type, expected decoder behaviour, image dimensions, channels, bit depth, colour space/profile, alpha handling, orientation metadata, and whether lossless versus lossy encoding matters. The contract must state whether an image is an independent scene or a view of a repeated subject, event, item, slide, patient, camera, or burst. Dense geometry tasks must also define physical units, coordinate/frame convention, valid range, scale ambiguity/alignment, occlusion and invalid-reference masks; restoration must define reference alignment, dynamic range and whether fidelity, perceptual quality or downstream utility is the target.

For every annotation type, version:

- the class ontology, background/void/ignore semantics, and allowed multilabel combinations;
- coordinate origin, units, inclusive/exclusive bounds, polygon winding, mask encoding, and visibility/occlusion rules;
- minimum object/region size and treatment of truncated, crowded, ambiguous, or unlabelled objects;
- annotator instructions, quality sampling, disagreement/adjudication, and inter-annotator evidence where judgement is material;
- linkage from annotations to immutable media identifiers and hashes.

Integrity checks must include decode failures, truncation, unexpected dimensions/channels, blank or corrupt images, invalid geometry, boxes/masks outside bounds, empty targets, contradictory labels, exact duplicates, and perceptual near-duplicates. Inspect EXIF and other embedded metadata for privacy leakage and shortcut signals; remove it only through a documented, reproducible rule.

Licences and consent must cover both the pixels and annotations. Faces, documents, homes, licence plates, medical imagery, and location-bearing metadata may create privacy or domain-regulatory obligations beyond this general guide.

## Split and evaluation protocol

The independence unit is normally the originating entity or capture process, not a file. Split before augmentation and group all images from the same subject, patient, product, scene, camera burst, slide, source document, source video, or web origin when reuse would inflate generalisation.

Run exact and perceptual duplicate detection across candidate partitions, including resized, cropped, recompressed, watermarked, and thumbnail variants. Document the threshold and manual adjudication process; similarity alone is not proof of duplication.

When deployment targets a new camera, site, geography, time period, or content source, include that shift in validation and reserve a matching locked holdout or external set. For detection and segmentation, keep all annotations for one image in the same partition. For re-identification or open-set recognition, define whether identities may appear in both train and test and construct query/gallery sets to match the intended scenario.

Fit colour statistics, learned resize policies, embedding models, hard-negative mining, pseudo-labels, and augmentation choices using training/development data only. Aggregate confidence intervals at the independent source level rather than treating correlated objects or pixels as independent samples.

## Baselines and model-family choices

At minimum, compare against a task-appropriate trivial rule and a simple visual baseline:

- class priors or constant/background masks where meaningful;
- hand-engineered colour/texture/shape features with a simple estimator;
- a small model trained from scratch when compute and data permit;
- a frozen, documented pretrained encoder plus a linear or nearest-neighbour head;
- the incumbent production pipeline, including its processor and thresholds.

Pretrained performance is not a neutral baseline if pretraining data may overlap the evaluation set. Record checkpoint identity, licence, training-data disclosures, input contract, and known limitations. Choose model size only after defining accuracy, memory, latency, energy and device constraints.

## Training and validation adaptations

Apply stochastic augmentation only to training samples. A single deterministic evaluation transform must preserve the test protocol. Every spatial transform must update boxes, masks, keypoints, regions and validity flags consistently; unit-test coordinate round trips and visualise transformed targets.

Treat crop policy, interpolation, padding/letterboxing, channel order, normalisation statistics, input resolution, and multi-scale inference as model parameters. Tune them through the same development protocol as architecture and optimiser choices. If label-preserving assumptions are uncertain—for example flips that change text or anatomy—exclude the transform or validate it explicitly.

Record data sampling by image, class, object size and source; class-balanced sampling changes the effective training distribution. Log checkpoint selection, pretrained/frozen stages, progressive resizing, hard-example mining, random seeds and image counts actually seen. For large foundation encoders, add the deep-learning and transfer overlay rather than duplicating its controls here.

## Metrics and uncertainty

Select metrics from the output structure and application cost, not from modality alone. Report the exact evaluator, matching policy, ignore-region handling and aggregation:

- classification: per-class results, macro/micro averaging, calibration and the deployed threshold/abstention policy;
- detection/instance segmentation/keypoints: precision/recall across stated IoU or keypoint-similarity thresholds, object sizes and maximum detections; COCO-style AP is one protocol, not a universal synonym for mAP;
- semantic segmentation: per-class IoU or Dice plus boundary/rare-class diagnostics where consequences justify them;
- depth/disparity/flow and other dense geometry: lock units, valid/occluded regions, scale alignment and evaluator; report protocol-appropriate absolute/relative depth errors or flow endpoint/outlier errors, plus boundary and scene-condition slices;
- image restoration: pairwise fidelity only after locking alignment, colour/range and crop rules; combine error/structural diagnostics with perceptual, blinded-human or downstream-task evidence when those qualities are claimed;
- OCR: region detection separately from transcription and end-to-end reading; define language normalisation before CER/WER or exact-match scoring;
- retrieval/re-identification: use the retrieval guide and disclose gallery, identity and open-set construction.

Also report results by independent source, image size, object size, occlusion, illumination, capture device, compression and other deployment-relevant conditions. Bootstrap groups or use another dependence-aware uncertainty method. Large pixel or object counts do not justify narrow image-level confidence intervals when they come from few subjects or scenes.

## Error analysis, safety, and robustness

Review visual examples of false positives, false negatives, localisation errors, class confusion and calibration failures. Include difficult negatives and unlabelled-object audits so an apparent false positive is not merely a missing annotation.

Test plausible capture shifts: blur, noise, illumination, contrast, colour/white balance, compression, resize, crop, partial occlusion, glare, weather, camera/sensor change and background/context change. Perturbations must represent plausible operating conditions; a corruption leaderboard does not replace field data. Evaluate subgroup and context performance when people are represented or affected.

Threat modelling should cover adversarial patches/evasion where relevant, poisoned or mislabeled media, malicious metadata, unsafe file decoders, model extraction, biometric misuse, and sensitive visual memorisation. Define abstention, human review, restricted-use conditions and incident escalation for high-consequence decisions.

## Packaging, deployment, monitoring, and maintenance

Package the decoder assumptions, colour conversion, orientation rule, resize/pad/crop transform, normalisation, label map, model, postprocessing, non-maximum suppression or mask thresholding, calibration, output coordinate conversion, and supported shapes/formats as one versioned contract. Golden images must test end-to-end parity, including geometry and scores.

Monitor decode failure, resolution/aspect/channel distributions, blur/brightness/compression proxies, camera/source mix, embedding drift, prediction/abstention rates, object size/count, latency and memory. Where labels arrive, monitor task metrics by source and condition rather than relying on image-statistic drift alone.

An update to the ontology, annotation geometry, processor, pretrained encoder, postprocessing threshold or runtime can invalidate compatibility even if model weights are unchanged. Retest locked golden cases and the deployment slice matrix. Retain only images, thumbnails, embeddings and metadata permitted by the data-retention contract.

## Minimum completion checklist

- [ ] The visual observation, repeated-source unit and output geometry are explicit.
- [ ] Pixel and annotation provenance, licence/consent, ontology and adjudication are versioned.
- [ ] Decode, metadata, geometry, exact-duplicate and perceptual-duplicate checks pass.
- [ ] Split grouping represents deployment independence and all augmentations are train-only.
- [ ] Transform parity has been tested for pixels and every target type.
- [ ] Baselines include a simple/frozen alternative and disclose pretrained provenance.
- [ ] The evaluator, matching/ignore rules, aggregation unit and uncertainty method are locked.
- [ ] Relevant capture shifts, subgroups, difficult negatives and safety threats were evaluated.
- [ ] The complete processor/postprocessor is packaged and golden-image parity passes.
- [ ] Monitoring and retirement cover imagery, derived embeddings and embedded metadata.

## Related guides

- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md)
- [Semi-, weakly, and self-supervised learning](../paradigms_and_methods/semi_weak_and_self_supervised_learning.md)
- [Anomaly, novelty, and OOD detection](../task_families/anomaly_novelty_and_ood_detection.md)
- [Recommendation, ranking, and retrieval](../task_families/recommendation_ranking_and_retrieval.md)
- [Generative modelling](../task_families/generative_modelling_and_content_generation.md)
- [Multimodal learning](multimodal_learning.md)

## Official and primary references

- [Microsoft COCO: Common Objects in Context](https://arxiv.org/abs/1405.0312) — primary dataset paper defining instance-level visual annotations and detection/segmentation evaluation context.
- [CVAT supported dataset formats](https://docs.cvat.ai/docs/dataset_management/formats/) — official documentation for image/video annotation structures, including boxes, masks, keypoints and tracks.
- [Torchvision transforms documentation](https://docs.pytorch.org/vision/stable/transforms.html) — official reference for image and target transformations; tool capability, not a universal pipeline prescription.
- [KITTI optical-flow and scene-flow evaluation](https://www.cvlibs.net/datasets/kitti/eval_scene_flow.php?benchmark=flow) — official dense-motion evaluator illustrating valid-pixel, occlusion and outlier protocol requirements.
- [KITTI depth-prediction evaluation](https://www.cvlibs.net/datasets/kitti/eval_depth.php?benchmark=depth_prediction) — official depth protocol defining valid ranges and absolute-relative, squared-relative, RMSE and threshold measures.
- [Image quality assessment: from error visibility to structural similarity](https://doi.org/10.1109/TIP.2003.819861) — primary SSIM paper; one diagnostic for image fidelity, not proof of perceptual or downstream utility.
- [NIST AI 100-2e2025: Adversarial Machine Learning taxonomy and terminology](https://csrc.nist.gov/pubs/ai/100/2/e2025/final) — normative terminology for evasion, poisoning, privacy and misuse threats.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
