# Video and Temporal Media

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay records only the extra controls introduced by ordered frames, timestamps, clips, tracks, and audiovisual streams.

## Use this guide when

Use this overlay when temporal order inside recorded media is part of the observation or output: video classification, temporal action localisation, event detection, tracking, anticipation, captioning, audiovisual analysis, or video generation. Apply it even when a model samples isolated frames, because the original recording usually remains the leakage and aggregation unit.

## Do not confuse it with

- [Computer vision](computer_vision.md), which owns per-frame decoding, image geometry and visual transforms.
- [Time series and forecasting](../task_families/time_series_and_forecasting.md), which owns future-value evaluation and forecasting origins for numeric/event series.
- [Speech and audio](speech_and_audio.md), which owns waveform/spectrogram integrity and speech/audio metrics.
- [Multimodal learning](multimodal_learning.md), which owns cross-stream alignment and fusion.
- [Generative modelling](../task_families/generative_modelling_and_content_generation.md), which owns open-ended media generation.

Frame ordering makes data temporal; it does not by itself make the task forecasting. Add the forecasting guide only when evaluation is about future information unavailable at the prediction origin.

## Scope and major variants

| Variant | Output unit | Distinct lifecycle concern |
|---|---|---|
| Clip/video classification | label per clip or recording | clip sampling and source-level aggregation |
| Temporal localisation/detection | labelled start/end segments | timestamp conventions and temporal overlap matching |
| Tracking/re-identification | trajectories and identities | continuity, identity switches, camera transitions |
| Spatiotemporal detection/segmentation | tubes or masks over frames | spatial plus temporal matching |
| Anticipation/early recognition | future event or early decision | strictly causal observation windows and latency |
| Captioning/question answering | text conditioned on temporal media | event coverage, grounding and multimodal evaluation |
| Video restoration/generation | frames or complete streams | temporal consistency, perceptual/task utility and safety |

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Define recording, clip, frame, segment, track, prediction time and allowed history/future context | Temporal task and latency contract |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Preserve container/stream metadata, timestamps, capture source and temporal annotations; validate decode continuity | Recording manifest, timestamp/stream audit and annotation protocol |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md) | Split by original recording and repeated entity/session/source, never by derived frames alone | Source-group split manifest and overlap/duplicate audit |
| [05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Version decoding, clip extraction, temporal sampling, frame-rate handling, alignment and sequence padding | Reproducible train/evaluation sampling specification |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare temporal models to single/sparse-frame and simple aggregation baselines; budget clips and frames | Baseline/ablation table and sampling-aware compute record |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Match predictions in time/space/identity, aggregate by recording and test delayed/causal operation | Locked evaluator, temporal slice report and source-level uncertainty |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[15](../../machine_learning_lifecycle_phases/15_retraining_and_maintenance.md) | Package decoder, sampler and state; monitor stream timing, continuity, latency and source drift | Stateful serving contract, replay/golden-stream tests and update plan |
| [16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Retire cached clips/frames, tracks, embeddings and stream credentials under retention rules | Media and state disposition record |

## Problem and data contract

Define whether the canonical observation is the full recording, a fixed-duration clip, an event-bounded segment, a rolling window, a camera stream, or a multi-camera session. Record the time coordinate system, start/end interval convention, timestamp precision, frame time base, nominal and actual frame rate, variable-frame-rate behaviour, duration, keyframes, codec/container, resolution, audio tracks and known edits or cuts.

The label contract must distinguish frame labels, segments, sparse keyframes, tracks, interpolated shapes, weak video-level tags and captions. For segments, define boundary tolerance and overlapping events. For tracks, define identity scope, occlusion, disappearance/re-entry, interpolation and cross-camera identity. Preserve which annotations were observed versus interpolated.

Validate corrupt packets/frames, non-monotonic or missing timestamps, frame drops/duplicates, duration mismatch, rotation/aspect changes, audio/video drift, variable frame rate, unexpected cuts, frozen streams, empty clips and annotation times outside media bounds. Maintain stable hashes for original recordings and derived-clip lineage.

Consent, licence and retention apply to the full recording and audio, not merely sampled frames. Temporal media can reveal behaviour, routines, bystanders and location; document redaction and access controls before extraction multiplies copies.

## Split and evaluation protocol

All frames, clips, tracks and augmentations derived from one source recording stay in one partition. Also group related captures by subject, event, episode, session, location, camera network, broadcaster/uploader or near-duplicate edit when those relationships would not be shared at deployment.

Detect overlap through source identifiers and content fingerprints. Re-encoding, trimming, subtitles, watermarks, mirrors and compilation videos can hide duplicate footage. When future deployment is expected, prefer forward temporal evaluation; for new cameras/sites or unseen actors, construct corresponding held-out groups.

For causal or streaming systems, define an evaluation clock. At timestamp t, the model may use only data and state available by t, including realistic buffering and processing delay. Do not let bidirectional clip construction, future track completion, shot-boundary knowledge or global normalisation leak future frames.

Lock clip length, stride, number of views, temporal crop policy, decoding backend and aggregation before final evaluation. Report uncertainty by independent recording/session, not by frame. For long streams, preserve event prevalence and negative/background duration representative of operation.

## Baselines and model-family choices

Use baselines that reveal whether temporal modelling adds value:

- majority/no-event and duration-aware heuristic baselines;
- single centre frame or uniformly sampled independent frames;
- frozen image encoder with mean/max/logit pooling;
- simple motion/change statistic or last-observation rule;
- incumbent detector plus a simple association rule for tracking;
- oracle-timing or oracle-detection diagnostic baselines when isolating pipeline stages.

Compare all models with the same decoded frames, temporal budget and view-aggregation protocol. A model using more frames, future context or external tracks is not a like-for-like architecture comparison.

## Training and validation adaptations

Sample clips only after the recording-level split. Version clip duration, stride, frame sampling, jitter, speed changes, shot handling, padding and positive/negative sampling. For sparse labels, document how supervision is propagated and avoid treating interpolated labels as equivalent to verified frames without evidence.

Temporal augmentations must preserve label semantics. Reversal may change actions, speed changes move boundaries, frame dropping changes motion, and spatial transformations must update every frame and track consistently. Apply cross-stream transformations with shared timing where audio or multiple cameras are aligned.

Track the number of unique recordings, decoded seconds and frames seen—not just batches. Validate checkpoint selection across multiple clips/views per recording without repeatedly tuning on a hidden test server. For stateful models, reset state at documented boundaries and reproduce warm-up behaviour.

## Metrics and uncertainty

Name the exact protocol and aggregation unit:

- video/clip classification: per-recording classification metrics after locked view aggregation;
- temporal localisation: AP/mAP at declared temporal-IoU thresholds, plus boundary and duration slices; ActivityNet's average mAP over tIoU 0.50–0.95 is a specific benchmark protocol;
- tracking: detection quality and association/identity quality; report HOTA or IDF1 with false positives, misses, identity switches and fragmentation as applicable;
- spatiotemporal tubes, masks and video instances: use a benchmark-specific frame/tube/mask matching evaluator with declared spatial-temporal overlap, identity, occlusion and absent-frame rules; report spatial accuracy and temporal/association consistency separately;
- early recognition/anticipation: accuracy/utility against observation percentage or time-to-event, with end-to-end latency;
- restoration: apply the computer-vision dense/restoration protocol per frame and additionally measure temporal consistency, motion/warping artefacts and blinded-human or downstream utility when claimed;
- dense frame tasks: per-recording/event aggregation so long videos do not dominate by frame count.

For audiovisual language outputs, add the relevant NLP, multimodal and generative guides. Never infer temporal consistency or useful event detection from a frame-level score alone. Bootstrap recordings/sessions and report variation across camera, duration, motion, event density and source.

## Error analysis, safety, and robustness

Review failures as timelines, not isolated frames. Slice by event duration, temporal position, motion speed, occlusion, crowding, camera motion, shot boundary, frame rate, compression, lighting, audio presence, actor/source and stream duration. Separate detection misses from boundary, association, classification and state-reset errors.

Stress realistic dropped/duplicated frames, timestamp jitter, variable frame rate, speed changes, packet loss, buffering, decoder changes, cuts, frozen frames, compression, resolution changes, occlusion and missing audio. Measure graceful degradation and recovery after disruption.

Safety review must consider delayed/stale alerts, surveillance misuse, identity persistence, bystander privacy, harmful generated media, adversarial patches/frames and operators over-trusting apparently continuous tracks. Define retention, redaction, human verification, escalation and fail-safe behaviour for high-consequence events.

## Packaging, deployment, monitoring, and maintenance

Package the approved decoder/container/codec assumptions, timestamp interpretation, frame/clip sampler, spatial processor, stream alignment, model, recurrent/track state, postprocessing, view aggregation and output time-coordinate conversion. Golden streams should include variable-frame-rate media, cuts, missing packets, long gaps and multi-track cases.

Declare state scope and reset rules by stream/session. Budget decode, transfer, inference, buffering and postprocessing latency separately; throughput in stored-video batches does not establish live-stream latency. Preserve deterministic replay inputs for incidents where permitted.

Monitor stream availability, decode errors, timestamp monotonicity, actual frame rate, dropped/duplicate/frozen frames, A/V skew, resolution/codec/source mix, buffer depth, state resets, event/track rates, latency and memory. When labels arrive, monitor by recording/camera and event duration. Any change to decoder, sampling, stream topology, label timing or tracker state requires compatibility and replay evaluation.

## Minimum completion checklist

- [ ] Recording, clip/window, timestamp and allowed-context contracts are explicit.
- [ ] Container, codec, frame-rate, stream and temporal-annotation integrity checks pass.
- [ ] Split grouping prevents source footage, entities, sessions and derivative clips crossing partitions.
- [ ] The evaluation clock prevents future-frame and future-state leakage.
- [ ] Clip sampling and temporal augmentation are versioned and label-consistent.
- [ ] Baselines show whether temporal context improves over single/sparse frames.
- [ ] Matching, aggregation, view count and source-level uncertainty are locked.
- [ ] Robustness covers timing, decoding, continuity and missing-stream failures.
- [ ] Stateful serving, reset, latency and golden-stream replay contracts are tested.
- [ ] Retention and retirement include original media, derived clips, tracks and embeddings.

## Related guides

- [Computer vision](computer_vision.md)
- [Speech and audio](speech_and_audio.md)
- [Multimodal learning](multimodal_learning.md)
- [Time series and forecasting](../task_families/time_series_and_forecasting.md)
- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md)
- [Generative modelling](../task_families/generative_modelling_and_content_generation.md)

## Official and primary references

- [FFmpeg documentation](https://ffmpeg.org/ffmpeg.html) — official definitions and controls for stream timestamps, time bases, seeking and variable-frame-rate handling.
- [ActivityNet temporal action localisation task](https://activity-net.org/challenges/2020/tasks/anet_localization.html) — official task/evaluator definition for temporal segments and mAP across tIoU thresholds.
- [MOTChallenge](https://motchallenge.net/) and its [primary benchmark paper](https://link.springer.com/article/10.1007/s11263-020-01393-0) — standardised multi-object tracking evaluation and association/trajectory metrics.
- [YouTube-VIS: A Video Instance Segmentation Benchmark](https://openaccess.thecvf.com/content_ICCV_2019/html/Yang_Video_Instance_Segmentation_ICCV_2019_paper.html) — primary benchmark/evaluator reference for detection, segmentation and tracking of video instances.
- [REDS: NTIRE 2019 Challenge on Video Deblurring and Super-Resolution](https://openaccess.thecvf.com/content_CVPRW_2019/html/NTIRE/Nah_NTIRE_2019_Challenge_on_Video_Deblurring_and_Super-Resolution_Dataset_and_CVPRW_2019_paper.html) — primary video-restoration benchmark reference; benchmark fidelity scores still require temporal visual/human or downstream evidence when temporal quality is claimed.
- [CVAT dataset formats](https://docs.cvat.ai/docs/dataset_management/formats/) — official image/video annotation-format capabilities, including video tracks and temporal shapes.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
