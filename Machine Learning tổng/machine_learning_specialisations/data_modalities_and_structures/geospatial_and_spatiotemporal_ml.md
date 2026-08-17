# Geospatial and Spatiotemporal Machine Learning

> Follow all requirements in the [shared 16-phase lifecycle](../../machine_learning_lifecycle_phases/README.md). This overlay documents only the additional controls created by location, spatial support/dependence, coordinate systems, geographic transfer, and joint space-time structure.

## Use this guide when

Use this overlay when coordinates, regions, geometries, maps, rasters, trajectories, point clouds, Earth-observation scenes, spatial neighbourhoods, or geographic transfer are part of the input, target, split, evaluation, or deployment. Apply it even when coordinates are not model features if nearby observations remain dependent.

This guide also owns 3D/point-cloud integrity when coordinates use a local sensor/robotics/indoor frame rather than an Earth CRS. In that case replace geographic-transfer requirements with frame, scene/site, sensor-pose and registration requirements; add the relevant vision, graph, temporal or robotics/domain controls.

## Do not confuse it with

- [Time series and forecasting](../task_families/time_series_and_forecasting.md), which owns forecast origins, horizons and temporal backtesting; add both for spatiotemporal forecasts.
- [Computer vision](computer_vision.md), which owns per-image decoding, visual annotations and vision transforms; add both for aerial/satellite imagery.
- [Graph, network, and relational ML](graph_network_and_relational_ml.md), which owns explicit nodes/edges and message-passing leakage; spatial adjacency alone does not require graph ML.
- [Anomaly, novelty, and OOD detection](../task_families/anomaly_novelty_and_ood_detection.md), which owns formal novelty/OOD tasks rather than geographic slice evaluation.
- [Online, incremental, and continual learning](../operational_settings/online_incremental_and_continual_learning.md), which owns state changes as new spatial observations arrive.

Remote sensing, environmental science, mobility, logistics, agriculture and urban analytics are domains, not new learning signals. Compose their modality/task guides and add applicable sector standards and regulation.

## Scope and major variants

| Variant | Observation/output support | Distinct lifecycle concern |
|---|---|---|
| Point and vector prediction | point, line, polygon or administrative unit | CRS, geometry validity, spatial dependence and support |
| Raster/gridded modelling | pixel, cell, tile, scene or mosaic | grid alignment, resolution, nodata, resampling and overlap |
| Earth observation/remote sensing | multispectral/SAR/LiDAR acquisition | sensor/platform, processing level, cloud/quality and geographic shift |
| Spatial interpolation/downscaling | unsampled location or finer support | distance/extrapolation and change of support |
| Trajectory/mobility learning | ordered positions, trips or agents | identity/session/time leakage and map matching |
| Spatiotemporal events/forecasting | location-time event or field | joint spatial and temporal blocking plus delayed data |
| 3D geospatial/point clouds | georeferenced points/voxels/surfaces | coordinate frame, density, occlusion and registration |

## Lifecycle delta map

| Core phase(s) | Additional decisions and controls | Required evidence or deliverable |
|---|---|---|
| [01](../../machine_learning_lifecycle_phases/01_problem_definition.md) | Define geographic target population, spatial/temporal support, prediction grid/region, transfer distance and coverage/abstention boundary | Spatial prediction and area-of-applicability contract |
| [02](../../machine_learning_lifecycle_phases/02_data_collection_and_governance.md)–[03](../../machine_learning_lifecycle_phases/03_data_understanding_and_validation.md) | Preserve CRS, datum, extent, resolution, acquisition/processing, geometry and sampling provenance; validate spatial alignment/quality | Geospatial asset catalogue, schema/CRS report and coverage/quality audit |
| [04](../../machine_learning_lifecycle_phases/04_data_splitting.md) | Use spatial/group/time blocking and buffers that match deployment; prevent tile/scene/trajectory overlap | Mapped split manifest, distance/overlap diagnostics and locked geographic holdout |
| [05](../../machine_learning_lifecycle_phases/05_preprocessing_and_feature_engineering.md) | Version reprojection, resampling, rasterisation, tiling, mosaicking, geocoding and spatial feature construction within split boundaries | Grid/geometry processing specification and alignment tests |
| [06](../../machine_learning_lifecycle_phases/06_baseline_development.md)–[08](../../machine_learning_lifecycle_phases/08_validation_and_hyperparameter_tuning.md) | Compare non-spatial, local/interpolation and persistence baselines; tune with spatial/temporal folds | Spatial baseline table and blocked-selection record |
| [09](../../machine_learning_lifecycle_phases/09_evaluation_metrics.md)–[11](../../machine_learning_lifecycle_phases/11_final_evaluation.md) | Report mapped errors, region/distance/support slices, area/population weighting and block-aware uncertainty | Frozen spatial evaluator, extrapolation/slice maps and geographic final report |
| [12](../../machine_learning_lifecycle_phases/12_model_finalisation_and_packaging.md)–[15](../../machine_learning_lifecycle_phases/15_retraining_and_maintenance.md) | Package CRS/grid/coverage and asset versions; monitor geographic/sensor/seasonal coverage, latency and map shifts | Geospatial system manifest, golden-location tests and catalogue/update plan |
| [16](../../machine_learning_lifecycle_phases/16_model_retirement.md) | Retire source assets, tiles, mosaics, location histories, derived layers and caches under rights/retention constraints | Spatial asset and sensitive-location disposition record |

## Problem and data contract

Define the prediction support, not just coordinates: sampled point, pixel/cell, patch/tile, line segment, polygon, administrative aggregate, trajectory, 3D volume or location-time window. State target geographic population, extent, resolution/scale, temporal validity, intended transfer to unsampled regions and where the system must abstain.

For every asset/layer record coordinate reference system (CRS), horizontal and vertical datum, axis order, units, coordinate precision, spatial/temporal extent, resolution/scale, acquisition sensor/platform, timestamp/timezone, processing level, lineage, licence and quality flags. For rasters record bands, grid transform, nodata, masks, resampling history, cloud/coverage; for vectors record geometry type/validity, topology and aggregation boundaries; for trajectories record identity/session, sampling and map-matching lineage.

For point clouds/3D data, record Earth or local coordinate frame, sensor pose/trajectory, intrinsic/extrinsic calibration, registration and transformation chain, acquisition mode, return number, intensity, classification/semantic labels, colour, point density, scan pattern and occlusion. Version duplicate/outlier rules and distinguish measured points from interpolated, reconstructed or synthetically densified geometry.

Validate missing/invalid coordinates, swapped axes, incorrect CRS/datum, invalid/self-intersecting geometries, duplicate locations/points, topology errors, misaligned grids or 3D registrations, inconsistent resolution/point density, nodata/cloud/quality masks, scene/tile/scan overlaps, timestamp mismatch and spatial coverage gaps. Visual maps and 3D views are necessary diagnostics but do not replace machine-checkable validation.

Document the observation/sampling process. Convenience sensors and volunteered geographic data may overrepresent accessible, wealthy or populated areas. Administrative aggregation can change associations and must not be interpreted as individual effects. Sensitive sites, homes, mobility trails and protected/Indigenous locations require minimisation, access control and possibly spatial obfuscation under domain guidance.

## Split and evaluation protocol

Choose the holdout design from deployment:

- interpolation among nearby observed locations may use spatial blocks sized beyond the relevant dependence/range;
- transfer to new sites/regions requires leave-site/region or buffered geographic holdouts;
- future mapping requires forward temporal splits, often nested with spatial blocks;
- new people/vehicles/trajectories require entity/session grouping in addition to geography;
- raster/vision work must keep overlapping or neighbouring tiles from the same scene/mosaic in one partition.

Random points or pixels can yield optimistic evidence when nearby observations share environment, target surface, sensor artefacts or labels. Record block construction, buffer distance, boundary treatment, fold maps and train-to-evaluation distance distributions. Determine scales from domain/dependence evidence without tuning on the locked test.

Split original scenes, surveys, trajectories and spatial units before tiling, resampling, augmentation, interpolation, feature smoothing or neighbour construction. Spatial joins, target encodings, interpolation surfaces, normalisation and learned embeddings must use only information available within the training boundary and at the prediction timestamp.

For point clouds, assign complete scans/scenes and overlapping captures to blocks before cropping, downsampling, voxelisation, registration, fusion or synthetic densification. Group repeated passes and shared mapped areas when deployment requires new-scene or new-site transfer.

Maintain a locked external geographic/temporal holdout when broad transfer is claimed. Report the model's area of applicability or extrapolation indicators, not just average performance inside well-sampled regions. Bootstrap or resample spatial blocks/sites rather than treating adjacent pixels as independent.

## Baselines and model-family choices

Use baselines that separate covariate prediction from spatial memorisation:

- global and region/season priors;
- non-spatial feature-only model excluding coordinates/neighbour targets;
- nearest-neighbour, local mean or simple interpolation/geostatistical baseline where valid;
- coordinate-only/spatial-smoother diagnostic to reveal location shortcuts;
- persistence, seasonal climatology or last valid map for spatiotemporal tasks;
- incumbent operational map/model at its published resolution.

For Earth observation, add image/point-cloud baselines appropriate to the raw modality. Compare at the same spatial support, coverage mask, resolution and temporal cutoff. A finer-looking map is not more accurate evidence if reference support is coarser.

## Training and validation adaptations

Version reprojection, axis order, geometry repair, geocoding, rasterisation/vectorisation, resampling/interpolation kernel, grid origin, pixel-is-area/point convention, tiling size/stride/overlap, mosaic priority, nodata masking and spatial feature construction. For point clouds also version registration, deduplication, outlier removal, ground filtering, cropping, subsampling, normal/feature estimation, voxelisation and frame transforms. Reprojection, registration and resampling can change values and boundaries; verify against golden geometries/locations/scans.

Create tiles/patches only after group/block assignment. Apply spatial augmentation only when orientation, scale, hemisphere, sensor physics, text/map labels and target geometry remain valid. Update all masks, vectors, coordinates and transforms consistently.

Train and tune with the same spatial/temporal fold logic used to estimate deployment transfer. Record samples/area by region, sensor, season and quality; prevent dense regions from dominating unnoticed. Coordinate, distance-to-feature, neighbourhood aggregate and remotely sensed covariates can encode location or future information—document availability time and ablate coordinate shortcuts.

## Metrics and uncertainty

Use the task's primary metric at the declared spatial support and add spatial evidence:

- map errors and calibration by region/site, distance to training data, density, sensor, resolution, season/time, land-cover/context and extrapolation status;
- macro per-region/site results so large/dense areas do not hide weak geographic transfer;
- area-, population-, exposure- or decision-weighted aggregates chosen from the use contract, with unweighted results alongside;
- boundary/geometry or pixel metrics from the vision guide for spatial detection/segmentation;
- 3D detection/segmentation, registration or reconstruction metrics under a named evaluator, coordinate frame, range, class/IoU thresholds, correspondence/overlap and valid-region rules; report performance by range, density, occlusion and scene/site;
- horizon/origin metrics from the forecasting guide for spatiotemporal prediction.

Report coverage: the area/population/events for which predictions are produced after masks and abstention. Visualise errors and uncertainty with shared scales and boundaries, while also publishing reproducible tables. Compute uncertainty from independent sites/regions/blocks or an explicitly modelled spatial dependence structure; pixel-level standard errors are usually invalid.

## Error analysis, safety, and robustness

Map residuals, missingness, uncertainty and abstentions. Inspect boundary effects, seams, coastal/edge cells, rare regions, sparse areas, cross-border schema changes, high train distance and locations outside the covariate domain. Separate geocoding/alignment, sensor/input, spatial-support, model and postprocessing errors.

Stress plausible CRS/axis/datum mistakes, coordinate jitter/geocoding uncertainty, resolution/resampling changes, missing tiles/bands, clouds/occlusion, sensor/platform changes, seasonal/weather shifts, map-boundary updates, trajectory gaps and late observations. For 3D data, test pose/calibration and registration error, density/range change, scan dropout, moving-object ghosts and local-frame mistakes. Evaluate new geography and time jointly when both can shift.

Safety risks include exposing precise locations or trajectories, re-identification from mobility, surveillance, inequitable service coverage, biased sampling/maps, feedback loops that divert future observations, unsafe routing/dispatch and false precision outside sampled areas. Define uncertainty/coverage communication, abstention and human/domain review. Domain regulation and physical validation may require stronger controls than this general overlay.

## Packaging, deployment, monitoring, and maintenance

Package CRS/datum/axis order, grid/transform/extent, expected resolution/scale, geometry schema, asset/catalogue snapshot, quality/nodata/cloud masks, reprojection/resampling, geocoding, spatial joins/features, tiler/mosaicker, model, calibration, postprocessing, output coverage and uncertainty. Golden tests must use known coordinates, boundaries, nodata, overlapping tiles and cross-CRS cases.

Define behaviour outside trained extent/support, under missing layers and when sources arrive late. Serve coverage and validity time with predictions; never silently extrapolate or return a stale map as current. Budget geospatial I/O, reprojection, tiling and mosaicking latency separately from inference.

Monitor asset/version availability, CRS/grid/resolution, sensor/platform, acquisition latency, cloud/nodata/coverage, geographic/seasonal mix, train-distance/extrapolation, feature/prediction drift, seam/boundary artefacts, coverage/abstention and performance by region/site. Revalidate whenever a sensor, basemap, boundary, geocoder, processing level, grid or catalogue changes. Propagate deletion/licence changes through tiles, mosaics, features and caches.

## Minimum completion checklist

- [ ] Target geography, spatial/temporal support, resolution and transfer/abstention boundary are explicit.
- [ ] CRS/datum/axis, acquisition, sensor, processing, grid/geometry and licence lineage are versioned.
- [ ] Coordinate, geometry, topology, alignment, overlap, nodata/quality and coverage checks pass.
- [ ] Mapped spatial/group/time splits and buffers match deployment independence.
- [ ] Scenes/surveys/trajectories are split before tiling, interpolation and spatial feature fitting.
- [ ] For 3D data, frames/datums, poses/calibration, registration, point attributes/density and split-safe point processing are versioned.
- [ ] Global, non-spatial, local/spatial and persistence baselines were compared where applicable.
- [ ] Metric support, weighting, coverage, geographic slices and block/site uncertainty are locked.
- [ ] New-region/sensor/season, CRS/resolution, missing-layer and location-privacy risks were tested.
- [ ] CRS/grid/catalogue, all spatial processing and output coverage are packaged with golden locations.
- [ ] Monitoring/retirement cover assets, catalogues, tiles, trajectories, derived layers and caches.

## Related guides

- [Time series and forecasting](../task_families/time_series_and_forecasting.md)
- [Computer vision](computer_vision.md)
- [Video and temporal media](video_and_temporal_media.md)
- [Graph, network, and relational ML](graph_network_and_relational_ml.md)
- [Anomaly, novelty, and OOD detection](../task_families/anomaly_novelty_and_ood_detection.md)
- [Online, incremental, and continual learning](../operational_settings/online_incremental_and_continual_learning.md)

## Official and primary references

- [OGC SpatioTemporal Asset Catalog (STAC)](https://www.ogc.org/standards/stac/) — official community standard for metadata and discovery of geospatial assets across Earth-observation, LiDAR, point-cloud, raster, vector and related data.
- [OGC standards catalogue](https://www.ogc.org/standards/) — official entry point for CRS, features, coverages, GeoPackage and other geospatial interoperability specifications.
- [GDAL raster data model](https://gdal.org/en/stable/user/raster_data_model.html) and [geotransform tutorial](https://gdal.org/en/stable/tutorials/geotransforms_tut.html) — official definitions for bands, affine grid-to-geographic coordinates and raster metadata.
- [ASPRS LAS Specification 1.4-R15](https://www.asprs.org/wp-content/uploads/2019/07/LAS_1_4_r15.pdf) — official exchange specification for point coordinates, returns, intensity, classification, GPS time and related LiDAR attributes.
- [nuScenes: A multimodal dataset for autonomous driving](https://arxiv.org/abs/1903.11027) — primary 3D sensor dataset/evaluation reference covering calibrated sensor poses, point clouds and detection/tracking metrics.
- [Cross-validation strategies for data with temporal, spatial, hierarchical, or phylogenetic structure](https://doi.org/10.1111/ecog.02881) — primary review and guidance explaining why dependence-aware blocking must match prediction objectives.
- [Area of Applicability of Spatial Prediction Models](https://doi.org/10.1111/2041-210X.13650) — primary method and evidence for distinguishing interpolation-like predictions from spatial extrapolation.

Checked: 2026-08-14. OGC/STAC and GDAL versions must be pinned and rechecked for a project's interchange contract.

[Back to the specialisation index](../README.md)
