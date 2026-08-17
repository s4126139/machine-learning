# Scientific and Physics-Informed Machine Learning

> This is an overlay on the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md), not a scientific-domain substitute. Apply it when governing equations, simulators, numerical solvers, conservation laws, geometries, boundary/initial conditions, or scientific surrogate objectives materially shape training and validation.

## Use this guide when

Use it for physics-informed neural networks, neural operators, surrogate/emulator models, hybrid mechanistic-ML systems, inverse problems and parameter estimation, scientific simulation learning, and data-driven models constrained by known equations. Add modality, probabilistic, deep, temporal, spatial and domain-standard overlays as applicable.

## Do not confuse it with

- Any ML used in science is not automatically physics-informed; this guide applies when scientific structure changes lifecycle evidence.
- A low equation residual does not prove accurate state prediction, parameter identification or real-world validity.
- Simulator data are generated evidence with a fidelity/domain boundary, not interchangeable with observations.
- Physical plausibility is not the same as safety, causality or regulatory validation.

## Scope and major variants

Covered variants include residual/constraint-informed learning, neural differential equations/operators, simulation surrogate modelling, inverse/parameter problems, hybrid solver-model pipelines and multi-fidelity data. Domain-specific verification, validation and uncertainty-quantification standards remain additional.

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Define physical quantity/units, domain/geometry, equations, assumptions, boundary/initial conditions, parameters, solver/measurement provenance and intended regime. | Scientific problem specification and model-form/data provenance audit. |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md)–[05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Split geometries, parameter regimes, simulations/experiments, times and meshes before sampling/collocation; preserve dimensional consistency and discretisation lineage. | Regime/geometry split and nondimensionalisation/mesh manifest. |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare numerical solver, empirical/analytical, data-only and constraint-only baselines; budget solver calls and tune loss/constraint weights without final regimes. | Accuracy-cost baseline and constraint/solver selection report. |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Report field/quantity error plus physical residual/conservation, stability, uncertainty and extrapolation across locked regimes/geometries/resolutions. | Scientific validation matrix with solver/measurement uncertainty. |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Package equations, units, geometry/mesh, solver and tolerances; monitor regime/constraint violations and preserve a solver/fallback; retire generated/derived scientific data. | Scientific model card, runtime/fallback and retirement plan. |

## Problem and data contract

Specify dependent/independent variables and units, coordinate/frame, spatial-temporal domain, governing equations and model-form assumptions, parameters, boundary/initial conditions, source terms, observation operators, geometry/mesh, solver/version/tolerances, experimental calibration and noise. Label every record as observed, simulated, assimilated or synthetic and preserve the chain from inputs and discretisation to outputs. Define intended interpolation and extrapolation regimes.

## Split and evaluation protocol

Split at the deployment-generalisation unit: complete geometry, parameter range, initial/boundary condition, experiment/site, trajectory/time regime or simulator configuration. Do this before collocation/patch/window generation so nearby points and shared trajectories do not leak. Use locked higher-resolution, independent-solver and real-observation evidence when relevant. Evaluate both interpolation and declared extrapolation, and distinguish discretisation/solver error from learned-model error.

## Baselines and model-family choices

Include the trusted numerical/analytical method at matched accuracy and cost; a data-only model; a simple reduced-order/emulator baseline; and an incumbent. When solver cost motivates ML, compare wall time, memory, energy and error across realistic batches and hardware. A physics-informed model must demonstrate value beyond adding more observed/simulated data or using a simpler surrogate.

## Training and validation adaptations

Version equations, units/nondimensionalisation, domains/geometries, mesh/discretisation, solver/tolerances, collocation/sampling, losses and constraint weights, automatic-differentiation precision, boundary enforcement, curricula, seeds and compute. Check loss-scale sensitivity and optimisation imbalance across data, residual and boundary terms. Validate conservation/stability independently of the loss used for selection and test across resolutions.

## Metrics and uncertainty

Report error in original scientific units and normalised field/function norms as appropriate, plus boundary/initial-condition error, equation residual, conservation/constraint violation, stability and runtime/resource cost. Report by geometry, parameter, time/horizon, resolution and regime with uncertainty from measurement, simulator/model form and stochastic training where relevant. Residual and data error are complementary; neither alone establishes scientific validity.

## Error analysis, safety, and robustness

Inspect boundary layers, shocks/discontinuities, stiff/chaotic regimes, sparse observations, geometry changes, extrapolation, mesh/resolution changes, solver disagreement, noisy/miscalibrated sensors and violated model assumptions. Test dimensional/unit errors, constraint conflict, non-physical outputs and numerical instability. Define validity bounds, uncertainty or abstention and solver/human fallback for unsupported regimes.

## Packaging, deployment, monitoring, and maintenance

Package model with units, scaling/nondimensionalisation, coordinate/geometry/mesh representation, equation/constraint implementation, solver and tolerances, parameter ranges, processor, validity envelope and fallback. Monitor regime/parameter/geometry/resolution, physical residuals and constraints, solver/model disagreement, uncertainty, latency and downstream decision effect. An equation, solver, mesh, calibration or validity-envelope change requires scientific requalification. Retirement includes generated simulations, collocation caches and derived fields under provenance/retention policy.

## Minimum completion checklist

- [ ] Quantities, units, equations, assumptions, domain and boundary/initial conditions are explicit.
- [ ] Observed, simulated and derived data plus solver/discretisation provenance are separated.
- [ ] Geometry/parameter/time/regime splits precede point, patch or collocation sampling.
- [ ] Solver, data-only and simple surrogate baselines are accuracy/cost matched.
- [ ] Equations, meshes, solvers, losses, constraint weights and precision are versioned.
- [ ] Scientific error, residual/constraints, uncertainty, cost and extrapolation are all evaluated.
- [ ] Validity limits, solver/human fallback, monitoring, requalification and retirement are defined.

## Related guides

- [Deep learning, transfer, and multitask learning](deep_learning_transfer_and_multitask.md)
- [Probabilistic and Bayesian learning](probabilistic_and_bayesian_learning.md)
- [Time-series and temporal-sequence data](../data_modalities_and_structures/time_series_and_temporal_sequences.md)
- [Geospatial and spatiotemporal ML](../data_modalities_and_structures/geospatial_and_spatiotemporal_ml.md)
- [Graph, network, and relational ML](../data_modalities_and_structures/graph_network_and_relational_ml.md)
- [Specialisation index](../README.md)

## Official and primary references

- [Raissi, Perdikaris, and Karniadakis, Physics-informed neural networks](https://doi.org/10.1016/j.jcp.2018.10.045) — foundational formulation for incorporating governing equations into neural learning.
- [PDEBench](https://arxiv.org/abs/2210.07182) — primary benchmark work for scientific ML across PDEs, resolutions and model families.
- [NVIDIA PhysicsNeMo documentation](https://docs.nvidia.com/physicsnemo/) — official framework documentation for physics-informed and data-driven scientific ML workflows.
- [DeepXDE documentation](https://deepxde.readthedocs.io/en/latest/) — official library guidance for PINNs, operators, inverse problems and multiple backends.

Checked: 2026-08-14.

[Back to the specialisation index](../README.md)
