# Ôn tập cuối và ma trận truy dấu (trace matrix)

Đây là bản kiểm tra cuối. Đọc các bảng từ trên xuống và thử che cột bên phải để tự trace.

**Trace matrix** là bảng nối một câu khẳng định với nơi tạo ra và nơi kiểm tra nó.
Hãy tưởng tượng đây là bản đồ truy dấu: từ câu trong report, ta lần về quan sát EDA,
config, code, test, run, artifact và commit. Bảng không tự tạo bằng chứng mới. Nó chỉ
giúp tìm đúng bằng chứng đã có và phát hiện claim nào đang thiếu mắt xích.

**Producer** là thứ tạo dữ liệu hoặc artifact. **Consumer** là thứ đọc kết quả đó.
**Interface** là hình dạng hoặc luật ở giữa hai bên, ví dụ thứ tự cột hay kiểu tensor.
Nếu producer đổi mà consumer không biết, code có thể vẫn chạy nhưng hiểu sai dữ liệu.

## Ma trận truy dấu claim (Claim trace matrix)

**Cách đọc bảng:** “Claim” là câu được phép nói. “EDA input” là quan sát ban đầu dẫn
tới câu hỏi, không tự chứng minh claim. “Config” khóa điều định chạy. “Code” là nơi
thực hiện cơ chế. “Test” kiểm contract hoặc lỗi hồi quy, không đo khả năng tổng quát
hóa. “Run ID” chỉ lần chạy vật lý. “Artifact” là file chứa số hoặc bằng chứng đã xuất.
“Commit” chỉ mốc lịch sử code. “Limitation” là điều không được suy ra. Các metric
F1/accuracy dùng thang 0–1 và cao hơn là tốt hơn; chênh lệch có dấu được đọc theo
<code>treatment − control</code>. Thời gian và bộ nhớ là chi phí nên thấp hơn thường
tốt hơn. Không lấy hash, test pass hay commit count làm bằng chứng model chính xác hơn.
Ký hiệu <code>n/a</code> nghĩa là “không áp dụng”, nên hàng đó không cần run ID.
<code>f0…f4</code> là năm validation fold, không phải năm phiên bản model nối tiếp.
<code>CI</code> là khoảng tin cậy. <code>P*</code> là benchmark pretrained không đủ
điều kiện làm model cuối. <code>λ_aux</code> là trọng số của loss ArticleType phụ trong
I2. Dấu âm ở result nghĩa treatment thấp hơn control; <code>1.992× runtime</code> nghĩa
thời gian gần gấp đôi. Tên config ngắn nằm dưới <code>configs/task2/</code>; tên module
Task 2 ngắn nằm dưới <code>src/fashion/task2/</code>; tên test ngắn nằm dưới
<code>tests/task2/</code>; tên artifact ngắn nằm dưới <code>results/evidence/task2/</code>.

| Kết luận cần bảo vệ (Claim) | Quan sát EDA | Cấu hình | Code | Test | Run ID | Artifact | Commit | Giới hạn |
|---|---|---|---|---|---|---|---|---|
| Population có 32,753 valid Season rows | 32,773 development, 20 missing | canonical split contract | <code>src/fashion/data/dataset.py</code> | dataset/OOF tests | n/a | <code>eda_handoff.csv</code>, <code>oof_contract.json</code> | e9ed2c2 | development only |
| B0 cho thấy accuracy đánh lừa | Summer 49.57% | <code>b0_majority.json</code> | <code>baselines.py</code> | <code>test_majority_baseline.py</code> | B0 f0…f4 | <code>b0_majority/pooled_metrics.json</code> | c83f06f; evidence 2b2bf2d | image-blind, no generalization claim |
| B1 chứng minh visual handcrafted signal | shape/colour hypothesis | <code>b1_hog_hsv_svm.json</code> | <code>classical.py</code> | <code>test_classical_baseline.py</code> | B1 f0…f4 | <code>b1_hog_hsv_svm/</code> | cacd68a; 7d9f049 | scores uncalibrated; HOG/HSV not separated |
| C1/C2 shortlist, C3 stop | small 60×80 image | G1 configs | <code>src/fashion/models/season.py</code>, experiments | model + G1 tests | each 5 folds | <code>g1_family_screen/leaderboard.csv</code> | a547f4b…623afdd | 8-epoch one-seed screen |
| P1 reject | possible resolution detail | <code>g2_p1_c2_resnet18.json</code> | experiments/evidence | input-size tests | P1 f0…f4 | <code>g2_input_size_ablation/decision.json</code> | c0563fe…ca6b849 | one larger size; runtime machine-specific |
| A1 reject | colour may be signal/shortcut | <code>g2_a1_c2_resnet18.json</code> | experiments/evidence | augmentation tests | A1 f0…f4 | <code>g2_augmentation_ablation/decision.json</code> | 7f7b7f0…16f0902 | one jitter recipe |
| C1 T1 pass; C2 T0 retained | optimization unknown | compact tuning configs | engine/evidence | tuning tests | four treatment ranges + controls | <code>g2_compact_tuning/decision.json</code> | 51364b7…538e24b | small predeclared grid |
| Corrected G3 near tie | screen may undertrain | two G3 configs | engine/evidence | G3 + reproducibility tests | C1/C2 five folds | <code>g3_full_budget/leaderboard.csv</code> | 63ae24a…ff4b4c3 | primary seed before stability |
| I1 fails despite recall gain | Spring 4.06% | <code>g4_i1_effective_number_c1.json</code> | <code>losses.py</code>, class_balance | I1 tests | I1 f0…f4 | <code>i1_class_balance/decision.json</code> | 10d2cad…2f53834 | one beta/weighting method |
| I2 λ_aux=0.3 selected | ArticleType association/shortcut | two I2 configs | multitask model/train/runner | multitask/evidence tests | 10 folds | <code>i2_multitask/decision.json</code> | df8e0bf…ac4fdd6 | association, not causation |
| P* gives +0.023024 ceiling | possible representation gap | P0S/P* configs | benchmark builder | pretraining tests | 5+5 runs | <code>pretraining_benchmark/</code> | 37825d4…c05bd8d | one seed; both final-ineligible |
| I2 lead repeats at seed 2026 | random optimization | G5 configs | stability runner | stability tests | C2/I2 f0…f4 at 2026 | <code>seed_stability/seed_stability.csv</code> | 1341254…a68c89a | two seeds only |
| Slice gains are not uniform | shortcut/year/file/mode risks | G6 slice config | <code>slices.py</code> | slice tests | four candidate-seed pairs | <code>shortcut_error_slices/</code> | 36a6fff…7717a7b | low support and sign reversals |
| Brightness 0.85 is severe | acquisition risk | robustness config | <code>robustness.py</code> | robustness/cache tests | frozen fold checkpoints | <code>robustness_cost/candidate_comparison.csv</code> | a749f02…e7d5bcb | synthetic shift |
| Calibration improves probability quality | confidence risk | calibration config | metrics/calibration | calibration tests | frozen OOF logits | <code>calibration/calibration_summary.csv</code> | 3567880…b845414 | development OOF; no threshold |
| Both overall grouped CIs >0 | family dependence | bootstrap config | paired group metric | bootstrap tests | two fitted seed pairs | <code>paired_bootstrap/interval_summary.csv</code> | 97533b5…d81161d | group proxy; not all seeds |
| Grad-CAM is diagnostic only | shortcut/failure hypotheses | Grad-CAM config | <code>gradcam.py</code> | Grad-CAM tests | fixed primary-seed checkpoints | <code>gradcam_failure_review/</code> | fc4bb92…37cd8f7 | selected subset; non-causal |
| G7 selects I2 | all closed evidence | G7 config | <code>ultimate_judgement.py</code> | judgement tests | frozen run sets | <code>decision.json</code>, <code>selection_freeze.json</code> | f441f22…1464f0d | development evidence only |
| G8 bundle is verified | frozen I2 | <code>results/evidence/task2/selection_freeze.json</code> | <code>src/fashion/task2/refit.py</code> | <code>tests/task2/test_refit.py</code> | <code>task2-season-i2-refit-fall-s2753-637dd6378be9</code> | <code>models/task2_season.pt</code>; <code>models/task2_season.manifest.json</code>; <code>results/evidence/task2/development_refit/training_history.csv</code>; <code>results/evidence/task2/development_refit/runtime.json</code> | 073082c…a7b31e7 | train metrics not independent |
| Handoff ready, Notebook 06 locked | holdout rule | <code>results/evidence/task2/final_handoff/manifest.json</code> | <code>src/fashion/task2/inference.py</code>; <code>src/fashion/task2/handoff.py</code> | <code>tests/task2/test_inference.py</code>; <code>tests/task2/test_handoff.py</code> | exact refit row above | <code>results/evidence/task2/final_handoff/artifact_audit.csv</code>; <code>results/evidence/task2/final_handoff/inference_smoke.json</code>; <code>results/evidence/task2/final_handoff/manifest.json</code> | a51a924…4c6642f | no holdout/app/CSV evidence |

## Ma trận ảnh hưởng giữa các file (File impact matrix)

**Cách đọc bảng:** “Producer” là file hoặc module tạo thông tin. “Artifact/interface”
là dữ liệu hoặc hợp đồng nó xuất ra. “Consumer” là code, notebook hay người đọc dùng
đầu ra đó. “Consequence if changed” nói rủi ro khi producer đổi mà phần sau chưa được
kiểm lại. Bảng này là bản đồ phụ thuộc, không phải log lỗi đã xảy ra và không cho biết
thay đổi chắc chắn làm metric tăng hay giảm. Không có đơn vị số trong bảng này.

| Bên tạo (Producer) | Artifact hoặc luật giao tiếp | Bên dùng (Consumer) | Hậu quả nếu thay đổi |
|---|---|---|---|
| <code>data/processed/splits.csv</code> | canonical partitions/cv_fold | all loaders, OOF, refit | invalidates cross-model comparison; hash must change |
| <code>data/processed/label_maps.json</code> | class order/encoding | models, metrics, bundle, CSV | probability columns/labels can silently permute |
| <code>fashion.data.dataset</code> | redacted DataFrames/CV views | loaders and experiments | leakage or population drift |
| <code>fashion.data.torch/multitask</code> | [C,H,W] samples, masks, stats | train engine | shape, padding, fold-fit or missing-label semantics change |
| Task 2 JSON configs | immutable experiment intent | runner/cache/evidence | new semantic hash; old artifacts not reusable |
| <code>src/fashion/models/season.py</code> | logits/embedding/boundary | engine, I2, Grad-CAM, inference | implementation hash/checkpoint compatibility changes |
| <code>train.engine/multitask</code> | checkpoint/history/OOF | registry/evidence | selection and artifact schema can change |
| <code>train.registry</code> | append-only run rows | cache/evidence/handoff | provenance trust breaks if terminal rows mutate |
| <code>train.cache</code> | verified reuse decision | runners | stale or wrong artifacts may be accepted |
| <code>task2.evidence</code> modules | tables/decisions/manifests | Notebook/report/G7 | measured claims can drift if inputs unverified |
| G6 diagnostics | slice/robustness/calibration/bootstrap/Grad-CAM manifests | G7 | guard/limitation evidence incomplete |
| <code>selection_freeze.json</code> | immutable winner/refit rule | refit/handoff | post-hoc model/epoch change |
| <code>refit.py</code> | bundle/model manifest/registry row | inference/handoff | published final bytes/provenance change |
| <code>inference.py</code> | SeasonPrediction contract | CLI/app/handoff smoke | label/probability/transform semantics change |
| <code>handoff.py</code> | locked component manifest | group evaluation owner | Notebook 06 could consume unverified component |
| Notebook 03/report | presentation of verified evidence | human reviewer | stale narrative; should never redefine source truth |

## Bậc thang chọn model (Model-selection ladder)

**Cách đọc bảng:** “Step” là mã model hoặc cổng thí nghiệm, không phải thứ hạng.
“Question” là câu hỏi cần trả lời. “Controlled change” là phần được phép đổi; các
phần khác phải giữ cố định để so sánh công bằng. “Result” là số đo hoặc kết quả
qua/rớt. “Limitation” chặn suy luận quá xa. “Next decision” là việc làm tiếp theo,
không phải dự đoán rằng metric chắc chắn sẽ tăng. Macro-F1 dùng thang 0–1 và cao hơn
tốt hơn. Với Δ, dấu luôn là treatment trừ control: số dương tốt hơn khi đo F1, số âm
tệ hơn. Với runtime ratio, nhỏ hơn là nhanh hơn và <code>1.992×</code> nghĩa gần gấp
đôi thời gian. Không so trực tiếp metric giữa các hàng nếu protocol hoặc budget khác nhau.

| Bước | Câu hỏi | Phần được đổi có kiểm soát | Kết quả | Giới hạn | Quyết định tiếp theo |
|---|---|---|---|---|---|
| B0 | Imbalance lower bound? | no image | 0.165704 macro-F1 | trivial | add visual B1 |
| B1 | Shape+colour signal? | HOG+HSV+LinearSVC | 0.609561 | fixed, uncalibrated | learned features |
| G1 C1/C2/C3 | family screen? | architecture only, 8 epochs | C2>C1≫C3 | short/one seed | shortlist C1/C2 |
| P1 | more pixels help? | 80×60→128×96 | −0.001787, 1.992× runtime | one size | keep P0 |
| A1 | jitter helps? | add colour jitter | −0.010438 | one recipe | keep A0 |
| T | optimizer pair? | lr/weight decay | C1 T1 +0.008173; C2 best +0.001146 | small grid | C1-T1/C2-T0 |
| corrected G3 | full budget? | max 30/patience 5 | C1 0.737661; C2 0.735036 | seed 2753 | provisional C1 |
| I1 | rare-class reweight? | effective-number loss | overall/Spring F1 worse | one beta | reject |
| I2 | auxiliary representation? | two-head, λ_aux 0.1/0.3 | both pass; 0.3 best overall | association | retain I2 |
| P* | transfer ceiling? | ImageNet init matched control | +0.023024 | ineligible | limitation only |
| G5 | seed direction? | seed 2026 | I2 lead +0.011607 | two seeds | close search |
| G6 | failure/safety/uncertainty? | diagnostics only | guards pass; brightness severe | development/synthetic | G7 |
| G7 | ultimate winner? | frozen scorecard | direct rule selects I2 | no holdout | immutable freeze |
| G8 | final package? | all-development 24 epochs | verified bundle/handoff | no independent metric | wait group freeze |

## Checklist bảo vệ vấn đáp cuối (Final oral-defence checklist)

### Problem và data

- [ ] Tôi nói image-only input, four labels, product unit và 32,753-row population.
- [ ] Tôi giải thích canonical grouped folds, OOF và holdout seal.
- [ ] Tôi phân biệt observation, association, experiment và causation.

### Code

- [ ] Tôi trace Dataset → DataLoader → tensor → logits → loss → optimizer → OOF.
- [ ] Tôi giải thích train/eval, autograd, AMP, accumulation, clipping, checkpoint.
- [ ] Tôi giải thích registry, cache, manifest, SHA-256 và provenance.
- [ ] Tôi chỉ được exact final image-only method và scratch boundary.

### Models/experiments

- [ ] Tôi bảo vệ B0/B1/C1/C2/C3.
- [ ] Tôi kể P1/A1/C3/I1 negative results.
- [ ] Tôi giải thích corrected G3 và Red–Green corrections.
- [ ] Tôi giải thích I2 mask/shared representation/lambda.
- [ ] Tôi giữ P* ngoài eligible table.

### Evaluation/diagnostics

- [ ] Tôi tính precision, recall, F1, macro-F1 và đọc confusion matrix.
- [ ] Tôi phân biệt fold mean và pooled OOF.
- [ ] Tôi giải thích NLL, Brier, ECE, temperature và risk–coverage.
- [ ] Tôi luôn đọc slice cùng support và seed.
- [ ] Tôi giải thích robustness absolute vs relative, machine latency và units.
- [ ] Tôi giải thích paired grouped bootstrap và CI boundary.
- [ ] Tôi mô tả Grad-CAM mà không gọi causal.

### Finalization

- [ ] Tôi kể six G7 checks và lý do tie-break không dùng.
- [ ] Tôi giải thích 24-epoch refit không có validation metric.
- [ ] Tôi trace bundle/manifest/inference/10-check handoff.
- [ ] Tôi kể invalidated packages mà không dùng lại chúng.
- [ ] Tôi nói rõ handoff không phải holdout evidence.

## Audit facts cần nhớ

- Exact branch range có 337 commits và ledger audit phải PASS.
- Pre-replay registry snapshot tại <code>45c1d40</code>, trước các local rerun về sau, có 130 unique Task 2 rows: 122 completed, 2 failed, 6 interrupted; report chứa older 123-row snapshot. Live local registry có thể tăng và không tự thay đổi historical selection evidence.
- Bundle SHA-256: <code>5927eff73130acedc8015199e1df5a6c6edf64c0b45023ebd91c48d7ed40f93c</code>.
- Model manifest SHA-256: <code>25d918061dbd9b46501de9aa3671adabf951649862ce9613317983dadbac55d9</code>.
- Freeze SHA-256: <code>51475a6e83c3e49e904633e1fa8a7e86bcc5e2f592c81f981561dac9f7cff995</code>.
- Final handoff manifest SHA-256: <code>ccf5eb5e36a6b160e2b70e04f2f8b3daabea9fe863f00c567e4b2cbeb81b8eab</code>.
- Holdout opened: false. Notebook 06 unlocked: false.

Next: **Kết thúc curriculum.**
