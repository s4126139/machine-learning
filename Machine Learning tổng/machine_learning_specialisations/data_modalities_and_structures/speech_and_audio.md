# Speech and Audio

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay documents only the additional controls required for waveforms, acoustic scenes, speech, speakers, music, and other time-indexed audio.

## Use this guide when

Use this overlay when the primary observation or output is a waveform, audio stream, spectrogram or acoustic event: speech recognition, speaker/language identification, verification, audio tagging, sound-event detection, keyword spotting, enhancement, separation, synthesis, music/audio retrieval, or acoustic generation.

## Do not confuse it with

- [Video and temporal media](video_and_temporal_media.md), which owns frame/clip/track timing and audiovisual container concerns.
- [Time series and forecasting](../task_families/time_series_and_forecasting.md), which owns future-value evaluation rather than acoustic signal interpretation.
- [NLP, documents, and LLM applications](nlp_documents_and_llms.md), which owns transcripts as language, text normalisation and language-output evaluation.
- [Multimodal learning](multimodal_learning.md), which owns aligned audio-text, audio-video or sensor fusion.
- [Generative modelling](../task_families/generative_modelling_and_content_generation.md), which owns open-ended speech/music generation and its safety evidence.

An ASR system normally composes speech/audio with NLP: this guide owns the signal and speaker/session split; the NLP guide owns transcript-language conventions beyond the locked scoring normalisation.

## Scope and major variants

| Variant | Output unit | Distinct lifecycle concern |
|---|---|---|
| ASR and speech translation | transcript or translated sequence | transcript normalisation, speaker/accent and streaming latency |
| Speaker/language/vocal-affect tasks | label, embedding or verification score | speaker/session independence, threshold calibration and construct validity for inferred affect |
| Keyword spotting/audio tagging | clip-level labels | rare events, background duration and operating false alarms |
| Sound-event detection | labelled time intervals | event boundaries, polyphony and time matching |
| Enhancement/source separation | waveform or sources | reference alignment and perceptual/task utility |
| Music/audio retrieval | embedding or ranked items | identity/version leakage and candidate-pool design |
| Speech/music/audio generation | waveform or acoustic tokens | intelligibility, identity/consent, provenance and misuse |

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Define recording/segment/speaker/event unit, streaming context, latency and abstention/false-alarm costs | Acoustic task, operating-point and latency contract |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Preserve signal, speaker/session/device/environment and annotation provenance; validate waveform/timestamp/transcript integrity | Audio manifest, signal-quality report and annotation/transcription guide |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md) | Group by original recording and repeated speaker/session/source; respect chronology and acoustic environment | Group/time split manifest and overlap/duplicate audit |
| [05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Version decoding, channel mix, resampling, segmentation/VAD, features, normalisation and train-only augmentation | Train/evaluation signal-processing specification and alignment tests |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare signal heuristics, conventional features and frozen encoders; tune acoustic/stream thresholds on development data | Baseline table, audio-hours/compute budget and selection log |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Use task-specific sequence/event/verification metrics, speaker/session aggregation and acoustic-condition slices | Locked scorer/normalisation, slice report and group-aware uncertainty |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[15](../../machine_learning_lifecycle_phases/15_retraining_and_maintenance.md) | Package decoder, signal processor, state and output normaliser; monitor channel/device/environment, latency and spoof risk | Streaming/batch inference contract, golden audio suite and update plan |
| [16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Retire recordings, voice embeddings, transcripts, caches and stream credentials under consent/retention rules | Audio/biometric data disposition record |

## Problem and data contract

Define the canonical observation as a recording, utterance, channel, segment, rolling window, speaker turn, event or mixture. Record container/codec, sample rate, bit depth/sample format, channel count/layout, duration, timestamps, gain/normalisation history, capture device, environment, source licence and transformations from the original media.

Record speaker/session/household/site identifiers where permitted, language/locale/accent, speaking style, microphone distance, noise/reverberation, overlapping speech and whether identity attributes are observed, self-reported or inferred. Voice can be biometric and highly identifying; define consent, access, retention and prohibited re-identification explicitly.

For transcripts, version orthography, casing, punctuation, numbers, hesitations, partial words, non-speech events, speaker turns, overlap and timestamps. Keep raw and scoring-normalised references distinct. For acoustic events, define onset/offset tolerance, hierarchy, polyphony and weak versus strong labels.

For emotion or vocal-affect inference, define the construct and permitted interpretation before labelling. Record whether labels are posed, induced, self-reported, observer-rated or inferred; the rater population, language/culture/context, rubric, disagreement and reliability; and whether the task predicts perceived vocal expression rather than an unobservable internal mental state. Do not relabel a convenient corpus category as verified emotion.

Validate decode errors, clipping, saturation, DC offset, silence, corrupt/truncated files, sample-rate/channel mismatch, duration/timestamp mismatch, duplicate audio and transformed duplicates, transcript alignment, invalid event intervals and unexpected synthetic speech. Do not discard difficult audio merely because a signal-quality proxy is low unless the deployment contract excludes it.

## Split and evaluation protocol

Split by the original recording before chunking or augmentation. Group all segments from the same speaker, conversation, session, call, household, programme, song/recording, device capture or source file when deployment requires independence from it. Decide explicitly whether speakers, devices, environments or languages are seen or unseen at evaluation.

Use acoustic fingerprints and metadata to detect re-encoded, clipped, speed/pitch-shifted or mixed duplicates. Music covers, repeated broadcasts and shared background tracks may require domain-specific grouping rather than file hashes.

For streaming tasks, evaluation must reproduce causal windows, buffering, endpointing, partial/final outputs and state resets. For future or changing acoustic environments, use forward temporal/site/device holdouts. Keep external language models, lexicons, speaker enrolment utterances and calibration data inside their permitted partitions.

Lock decoder, resampling, channel selection, VAD/segmentation, transcript normalisation, scorer, collar/tolerance, threshold and streaming endpoint rules before final evaluation. Estimate uncertainty across speakers, sessions or recordings—not frames or audio windows.

## Baselines and model-family choices

Use baselines suited to the acoustic task:

- majority/no-event, random or energy/voice-activity rules;
- conventional spectral features with a linear, tree or nearest-neighbour estimator;
- a simple keyword/template matcher or n-gram language baseline where appropriate;
- frozen pretrained audio/speech embeddings with a simple head;
- mixture/pass-through or classical signal-processing baselines for enhancement/separation;
- incumbent batch/streaming system at its deployed threshold.

Compare with the same segmentation, external language resources, enrolment data and latency budget. A larger look-ahead window or external language model is a system change, not merely a better acoustic architecture.

## Training and validation adaptations

Version decoding, dithering, channel mixing, resampling/filtering, amplitude normalisation, pre-emphasis if used, VAD, segment length/stride, time-frequency features and padding. Fit normalisation statistics on training data only. Preserve sufficient raw metadata to reproduce transformations.

Apply noise, reverberation/room impulse responses, gain, codec, masking, speed/pitch and mixture augmentation only to training data and only when label semantics remain valid. Track augmentation sources and licences. Synthetic voices or generated noise require provenance and separate slice reporting.

Sample by recording/speaker/event as well as duration so prolific speakers and long background files do not dominate unnoticed. Report unique speakers, recordings and hours actually seen. For streaming models, reproduce chunk/state schedules during validation and checkpoint selection.

## Metrics and uncertainty

Lock the scorer and all normalisation/matching rules:

- ASR: word error rate and, where linguistically justified, character error rate; report substitutions, deletions and insertions plus language/accent/condition slices. NIST SCTK is a reference scorer, not a guarantee that one text normalisation fits every language;
- speaker verification/detection: DET/ROC-derived measures such as EER and application-cost metrics at a calibrated threshold; report enrolment/test conditions and impostor construction;
- tagging/keyword spotting: precision-recall metrics and false alarms/misses at the deployed operating point, accounting for background duration;
- sound-event detection: segment- or event-based precision/recall/F1 with declared collars and polyphony rules;
- enhancement/separation: signal/distortion metrics plus intelligibility, perceptual or downstream-task evidence as appropriate;
- retrieval/generation: use the retrieval or generative guide and keep acoustic fidelity separate from semantic/human quality.

Report end-to-end latency, real-time factor, memory/energy and partial-to-final stability for streaming/on-device systems. Aggregate by independent speaker/session/recording and bootstrap groups. Include performance by duration, SNR/noise, reverberation, device, codec, overlap, language/accent and demographic context where legitimate and ethically collected.

For vocal-affect tasks, add speaker-, language-, culture-, context- and corpus-held evaluation; report rater disagreement and uncertainty rather than a single presumed ground truth. Performance on posed or observer-rated speech does not establish recognition of an individual's internal state.

## Error analysis, safety, and robustness

Listen to sampled failures under controlled privacy access and inspect aligned waveforms/spectrograms/transcripts. Separate endpoint/VAD, acoustic, language, speaker-attribution, event-boundary, threshold and formatting failures.

Stress realistic noise, reverberation, echo, clipping, gain, silence, overlap, microphone/device changes, codec/packet loss, resampling, speed variation, far-field speech, accented/code-switched speech and streaming gaps. Test recovery after state interruption and channel changes.

Threats include replay and synthetic-voice spoofing, adversarial audio, hidden/ultrasonic commands where physically relevant, training-data extraction, speaker re-identification, unauthorised recording and cloned-voice misuse. Define liveness/spoof controls, human confirmation and safe fallbacks for authentication or command systems. Do not claim speaker recognition is secure from ordinary accuracy alone.

Restrict vocal-affect outputs to the validated construct and context. Employment, education, healthcare, policing, authentication and surveillance uses require application-specific ethical, legal and domain review; a vocal-affect score must not be presented as a verified mental state or intent.

## Packaging, deployment, monitoring, and maintenance

Package the decoder/codec contract, channel mapping, resampler, VAD/segmenter, feature extractor, normalisation, model, state/cache, language model/lexicon if used, tokenizer, endpointing, calibration/thresholds and transcript/output normaliser. Golden audio should cover silence, clipping, variable duration, multiple sample rates/channels, noise, overlap, corrupted packets and state resets.

Monitor decode/stream errors, sample rate/channel/codec, duration and silence, clipping/noise/reverberation proxies, device/environment/language mix, VAD/event/prediction rates, confidence/abstention, spoof signals, latency, real-time factor, memory and partial/final stability. With labels, monitor by speaker/session/condition; signal drift alone does not prove task degradation.

Treat a change to resampling, VAD, transcript normalisation, vocabulary, language model, enrolment policy, threshold or streaming state as a compatibility change. Maintain component-level rollback and purge retired recordings, transcripts, embeddings and caches according to consent and biometric-retention requirements.

## Minimum completion checklist

- [ ] Recording/segment/speaker/event and streaming-context contracts are explicit.
- [ ] Codec, sample rate, channels, timestamps, device/environment and consent provenance are recorded.
- [ ] Waveform, duplicate, transcript/alignment and event-interval integrity checks pass.
- [ ] Split grouping prevents recording, speaker/session and derivative-segment leakage.
- [ ] Signal processing and augmentation are versioned, train-bounded and label-consistent.
- [ ] Conventional/frozen and incumbent baselines use equal context and external resources.
- [ ] Scorer, normalisation, matching, operating threshold and group uncertainty are locked.
- [ ] Noise/device/language/streaming and spoof/privacy threats were evaluated.
- [ ] Vocal-affect tasks document the construct, label/rater provenance, disagreement, held-out populations/contexts and prohibited interpretations.
- [ ] Full batch/streaming processing and state are packaged with golden audio tests.
- [ ] Monitoring/retirement cover voice embeddings, audio, transcripts and generated caches.

## Related guides

- [NLP, documents, and LLM applications](nlp_documents_and_llms.md)
- [Video and temporal media](video_and_temporal_media.md)
- [Multimodal learning](multimodal_learning.md)
- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md)
- [Anomaly, novelty, and OOD detection](../task_families/anomaly_novelty_and_ood_detection.md)
- [Generative modelling](../task_families/generative_modelling_and_content_generation.md)

## Official and primary references

- [NIST Speech Recognition Scoring Toolkit (SCTK)](https://github.com/usnistgov/SCTK) and [SCLITE documentation](https://github.com/usnistgov/SCTK/blob/master/doc/sclite.htm) — official scoring implementation and conventions for speech-recognition errors.
- [AudioSet ontology and dataset](https://research.google.com/audioset/) and [Audio Set: An ontology and human-labeled dataset for audio events](https://research.google/pubs/audio-set-an-ontology-and-human-labeled-dataset-for-audio-events/) — primary source for hierarchical acoustic-event labels and weak clip-level annotation.
- [Torchaudio documentation](https://docs.pytorch.org/audio/stable/index.html) — official reference for waveform I/O, transforms, datasets and speech/audio pipelines; tool capability, not universal best practice.
- [ASVspoof](https://www.asvspoof.org/) — official challenge programme for replay, synthetic and converted-speech spoofing of automatic speaker verification.
- [Ethics Sheet for Automatic Emotion Recognition and Sentiment Analysis](https://aclanthology.org/2022.cl-2.1/) — peer-reviewed framework for construct, annotation, population, generalisation and harm documentation in affect-related inference.

Checked: 2026-08-14. Framework/API versions and challenge protocols must be rechecked before implementation.

[Back to the specialisation index](../README.md)
