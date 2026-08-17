# Privacy-Preserving Machine Learning

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay adds an explicit privacy threat model, technical mechanism, privacy/utility evidence, and lifecycle accounting. It does not replace applicable law, regulation, contracts, consent, or organisational privacy governance.

## Use this guide when

Use it when training data, labels, prompts, feedback, model outputs, gradients, embeddings, checkpoints, logs, or linked identities are sensitive, or when the project claims a formal/technical privacy property such as differential privacy, secure aggregation, confidential computation, multi-party computation, or homomorphic encryption.

Also use it when a model may expose membership, attributes, memorised records, or proprietary client information even though raw data is access-controlled or distributed.

## Do not confuse it with

- **Security:** confidentiality, integrity, and availability controls are necessary, but privacy also concerns adverse effects on people arising from data processing and disclosure.
- **De-identification/pseudonymisation:** removing direct identifiers can reduce exposure but linkage and inference may remain possible; it is not automatically anonymous.
- **Federated learning:** raw records remain client-held, but gradients/updates, telemetry, the coordinator, clients, and released model may still leak information. Add [federated learning](federated_learning.md) for the distributed protocol.
- **Differential privacy (DP):** a formal framework that quantifies privacy loss under a defined neighbouring relation and mechanism. DP does not mean zero risk or zero information use.
- **Secure aggregation:** limits what an aggregator learns about individual submitted values under stated assumptions; it does not by itself protect the released aggregate/model, compromised endpoints, or all metadata.
- **Encryption in transit/at rest:** protects storage/transport, not computation-time access or model output. It is distinct from homomorphic encryption, MPC, and trusted execution.
- **Synthetic data:** synthetic records can memorise or reveal training data; generation alone is not a privacy guarantee.
- **Model unlearning:** deleting or updating model influence is a separate capability and does not retroactively erase already released outputs or privacy loss.

## Scope and major variants

- minimisation, purpose limitation, access control, retention limits, and privacy-aware telemetry;
- record/example-level, user-level, client-level, event-level, or group-level neighbouring units;
- central, local, shuffled, or federated differential privacy;
- secure aggregation and threshold protocols;
- secure multi-party computation, homomorphic encryption, private set operations, and trusted execution environments;
- split learning or distributed/federated combinations;
- privacy auditing against membership inference, attribute inference, reconstruction/inversion, extraction, memorisation, linkage, and side channels;
- privacy-evaluated synthetic data and model unlearning/deletion workflows.

Mechanisms compose only when their assumptions and interfaces compose. Name each mechanism, protected channel, trusted party, adversary, leakage surface, and residual risk.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Identify sensitive entity/unit, privacy harms, intended claims, adversaries/capabilities, trust boundaries, outputs, and acceptable privacy–utility trade-off | Approved privacy threat model and claim statement |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Minimise collection/retention/access; map identities, linkage, consent/purpose, secrets, telemetry, derived artefacts, and deletion obligations | Data-flow/retention map and privacy impact/risk assessment |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md) | Isolate evaluation identities/entities; govern analyst access and repeated queries; align privacy unit with grouped splits | Privacy-unit split manifest and evaluation access log |
| [05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Treat fitted transforms, embeddings, caches, indexes, statistics, and synthetic outputs as potentially sensitive artefacts | Artefact sensitivity inventory and sanitisation rules |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare minimised/non-private reference where lawful; tune within privacy/query budget; account for all data-dependent searches/releases | Privacy/utility baseline, mechanism config, and accounting ledger |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Report privacy parameters with semantics/assumptions, utility by relevant slices, leakage/adversarial audits, and uncertainty without exposing small groups | Locked privacy–utility report and red-team/audit evidence |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[13](../../machine_learning_lifecycle_phases/13_deployment.md) | Package claim/parameters/accountant, trust boundaries, key/secret management references, release filters, access/query controls, logging, and incident response | Privacy manifest and rehearsed release/incident runbook |
| [14](../../machine_learning_lifecycle_phases/14_monitoring.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Monitor budget/query use, access, disclosures, attacks, configuration drift and retention; stop releases at limits; delete/revoke all dependent artefacts | Ongoing privacy ledger, breach drill, deletion and retirement evidence |

## Problem and data contract

Begin with a written threat model, not a preferred privacy tool. Define:

- the protected entity/unit: record, person, household, client, organisation, trajectory, conversation, or another group;
- secrets/attributes to protect and plausible harms from processing or disclosure;
- adversaries: external querier, authorised user, analyst, server/coordinator, client, colluding parties, model recipient, or infrastructure operator;
- their auxiliary knowledge, query access, code/control access, collusion threshold, and compute;
- trust boundaries and compromise assumptions;
- all observable channels: outputs, scores, gradients, updates, embeddings, timing, sizes, logs, caches, checkpoints, metrics, error messages, and metadata;
- claim scope, non-goals, lifetime, and affected populations.

Map the full data flow from collection through labels, features, training, tuning, human review, packaging, deployment, monitoring, backup, sharing, and destruction. Apply minimisation and purpose limitation before adding a technical mechanism; privacy technology does not justify unnecessary data collection.

For DP, define the neighbouring relation and contribution bounds before choosing epsilon/noise. State whether protection is example-, user-, or client-level; the sampling model; clipping; mechanism; accountant; delta rationale; total composition; and what outputs the guarantee covers. Epsilon values are not meaningfully comparable across different units, adjacency definitions, sampling assumptions, accountants, or release scopes.

## Split and evaluation protocol

Align splits with the privacy unit. If the claim is user-level protection, the same user must not straddle partitions merely because records do. Evaluation data remains sensitive: restrict analyst access, small-group reporting, exports, and repeated adaptive queries.

Use development data or privacy-preserving/synthetic surrogates for mechanism selection where justified; keep a query/release ledger for protected validation and test evidence. Hyperparameter tuning, early stopping, clipping selection, thresholding, metric release, and failed experiments may consume privacy or disclosure budget when they depend on protected data.

For attack audits, separate auditor knowledge from target/training evidence and report the threat assumptions. An attack that fails under one configuration does not prove privacy; it only supplies empirical evidence against that named attacker.

When evaluating encrypted/MPC/TEE protocols, preserve real party placement, collusion/dropout assumptions, key boundaries, data sizes, network conditions, and failure paths. A functional single-process simulation is insufficient security or performance evidence.

## Baselines and model-family choices

Use relevant comparisons:

- a minimised-data baseline, exposing whether sensitive features or long retention are necessary;
- a lawful non-private model as a utility reference, clearly marked non-deployable when applicable;
- the simplest approved mechanism/configuration at several predeclared privacy points;
- rules, aggregation-only, local-only, or no-release alternatives;
- for cryptographic computation, the same workflow without protected computation as a performance reference under controlled non-sensitive data.

Choose model families for data memorisation/release risk, contribution bounding, gradient/update sensitivity, output surface, ability to calibrate/limit confidence, inference query pattern, state/artefact size, and compatibility with the privacy mechanism—not predictive accuracy alone.

## Training and validation adaptations

- Bound each protected unit's contribution before training; validate clipping/truncation and reject malformed contributions.
- For DP training, version noise mechanism, clipping norm, sampling, accountant implementation/version, epsilon/delta target, realised steps, and spent budget. Stop before exceeding the approved budget.
- Include preprocessing, selection, tuning, calibration, explanations, embeddings/indexing, and released diagnostics in the privacy analysis; a private optimiser does not sanitise arbitrary upstream/downstream releases.
- Keep keys, credentials, attestation material, and salts outside model artefacts and source control; define rotation, revocation, recovery, and separation of duties.
- For secure aggregation/MPC, specify threshold, participant authentication, dropout recovery, collusion assumptions, overflow/range checks, and malicious versus semi-honest security.
- For HE, record security parameters, supported operations/precision, ciphertext expansion, key ownership, noise/error growth, and performance envelope.
- For TEEs, document attestation evidence, the trusted computing base and its update/patch state. State explicitly whether side-channel, rollback/replay, physical and privileged-host threats are covered or residual, and define behaviour when attestation or the protected path fails.
- Treat privacy accounting and audit configuration as immutable experiment lineage, subject to independent review.

## Metrics and uncertainty

Report utility and privacy/system cost together. The exact set depends on the mechanism:

- task utility overall and by predeclared groups, with uncertainty;
- privacy unit/adjacency, epsilon, delta, contribution bounds, sampling, mechanism, accountant, composition scope, and number of releases for DP;
- empirical membership/attribute/reconstruction/extraction audit performance against named attackers and access assumptions;
- aggregation threshold, collusion/dropout tolerance, and revealed metadata for secure protocols;
- security parameters and precision/error for cryptographic computation;
- latency, throughput, memory, communication, ciphertext/update expansion, energy proxy, and failure rate;
- abstention/coverage and information exposed per response for inference controls.

Do not present an empirical privacy attack score as a formal guarantee, or a formal DP guarantee as evidence against software bugs, compromised endpoints, unauthorised raw-data access, poisoning, fairness harms, or side channels outside its model.

Small-cell suppression and private metric release can limit diagnostics. Record what could not be measured, use coarser approved aggregation, and preserve independent privacy-safe oversight rather than silently claiming all subgroup risks were evaluated.

## Error analysis, safety, and robustness

Test the named threat and common implementation failures:

- contribution-bound violations, incorrect clipping order, sampling mismatch, accountant misconfiguration, and repeated untracked releases;
- memorised rare strings/records, confidence leakage, adaptive querying, membership/attribute inference, reconstruction/inversion, extraction, and linkage;
- malicious or colluding clients/servers, Sybil participants, poisoned updates, and denial-of-service against privacy thresholds;
- secure-aggregation dropout and small cohorts, MPC threshold failure, HE precision/overflow, TEE attestation/rollback/side-channel assumptions;
- secrets in logs, traces, crash dumps, caches, checkpoints, model registries, prompts, embeddings, monitoring examples, and backups;
- privacy mechanism degrading utility unevenly across small or underrepresented groups;
- deletion request, key compromise, budget exhaustion, and incident-notification drills.

Red-team findings bound only the tested adversary and configuration. Retest when data, model, output API, query limits, privacy parameters, accountant, protocol, dependencies, or trust boundaries change.

## Packaging, deployment, monitoring, and maintenance

The release package must include a privacy manifest containing the threat model/version, protected unit, claims and non-goals, data-flow/retention map, mechanism/configuration, accounting ledger, release/query controls, permitted outputs, audit results, system requirements, incident owner, and deletion/retirement obligations.

Deploy with least privilege, authenticated endpoints, rate/query/output limits where justified, safe error messages, encrypted transport/storage, approved logging/redaction, secret/key management, dependency attestation, and denial-of-service handling. These security controls complement rather than substitute for the privacy mechanism.

Monitor authorised access, export/release/query counts, privacy budget, cohort/threshold health, configuration and accountant drift, unexpected confidence/verbatim outputs, attack/abuse signals, sensitive logging, key/attestation status, retention deadlines, and deletion completion. Monitoring itself must minimise sensitive examples.

Changing the model, clipping, sampling, number of steps, output, query policy, client cohort, accountant, crypto parameter, TEE, or protocol can invalidate the evidence; require privacy re-review.

Retirement must stop releases, revoke API and key access, destroy sensitive caches/checkpoints/backups under policy, close federated/secure-compute participants, retain only required accounting/audit evidence, and record residual copies or already released models. Deletion or unlearning does not reverse information already disclosed or a privacy budget already spent.

## Minimum completion checklist

- [ ] Protected entity/unit, secrets, harms, adversaries, knowledge, channels, trust boundaries, claims, and non-goals are explicit.
- [ ] Full data/artefact flow, purpose, access, retention, and deletion obligations are mapped.
- [ ] Privacy is separated from security, de-identification, federation, secure aggregation, synthetic data, and unlearning.
- [ ] Splits and reporting respect the protected unit and evaluation access is logged.
- [ ] Minimised-data, no-release/local/rules, and lawful non-private utility references are compared where relevant.
- [ ] DP adjacency, contribution, mechanism, accountant, epsilon/delta, composition, and releases are reproducible, if used.
- [ ] Crypto/secure-compute trust, collusion/dropout, keys, parameters, performance, and failures are evidenced, if used.
- [ ] Utility, system cost, and named attack audits are reported without turning empirical tests into guarantees.
- [ ] Budget exhaustion, key compromise, sensitive logging, deletion, incident response, and rollback are rehearsed.
- [ ] The privacy manifest and accounting/audit record remain tied to the exact released system.

## Related guides

- [Federated learning](federated_learning.md)
- [Active learning and human-in-the-loop systems](active_learning_and_human_in_the_loop.md)
- [Online, incremental, and continual learning](online_incremental_and_continual_learning.md)
- [Generative modelling](../task_families/generative_modelling_and_content_generation.md)
- [NLP, documents, and LLM applications](../data_modalities_and_structures/nlp_documents_and_llms.md)
- [Deep learning, transfer, and multitask learning](../paradigms_and_methods/deep_learning_transfer_and_multitask.md)

## Official and primary references

- [NIST SP 800-226, Guidelines for Evaluating Differential Privacy Guarantees](https://csrc.nist.gov/pubs/sp/800/226/final) — final official guidance on privacy-loss semantics and implementation hazards.
- [NIST Privacy Framework](https://www.nist.gov/privacy-framework/privacy-framework) — official enterprise privacy-risk management across the data lifecycle.
- [Bonawitz et al., Practical Secure Aggregation for Privacy-Preserving Machine Learning](https://research.google/pubs/practical-secure-aggregation-for-privacy-preserving-machine-learning/) — primary secure-aggregation protocol and dropout/communication analysis.
- [TensorFlow Federated: Federated Learning with Differential Privacy](https://www.tensorflow.org/federated/tutorials/federated_learning_with_differential_privacy) — official user-level DP training and accounting example, showing DP as an added mechanism rather than an automatic result of federation.
- [NIST Privacy-Enhancing Cryptography project](https://csrc.nist.gov/projects/pec) — official NIST programme covering cryptographic techniques for protected computation, including threshold and privacy-enhancing cryptography.
- [Gilad-Bachrach et al., CryptoNets](https://proceedings.mlr.press/v48/gilad-bachrach16.html) — primary homomorphic-encryption work demonstrating neural inference over encrypted data and its accuracy/performance trade-offs.
- [Mohassel and Zhang, SecureML](https://eprint.iacr.org/2016/442) — primary secure multi-party computation protocol for privacy-preserving ML with explicit security and efficiency assumptions.
- [Shokri et al., Membership Inference Attacks Against Machine Learning Models](https://www.cs.cornell.edu/~shmat/shmat_oak17.pdf) — foundational empirical model-privacy attack and threat model.
- [Bourtoule et al., Machine Unlearning](https://www.usenix.org/conference/usenixsecurity21/presentation/bourtoule) — primary work on deletion-oriented machine-unlearning design and evaluation.
- [NIST IR 8320B, Hardware-Enabled Security: Policy-Based Governance in Trusted Container Platforms](https://csrc.nist.gov/pubs/ir/8320/b/final) — official guidance on hardware-rooted trust, attestation evidence, trusted-component policy and lifecycle governance; it does not by itself make every host, side channel or rollback threat safe.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
