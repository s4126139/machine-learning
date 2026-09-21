# Phase 04 — Ba model train từ đầu C1, C2 và C3

### 1. Bạn đang ở đâu?

B1 cho thấy pixel có tín hiệu. Commit 027–085, từ <code>a547f4b...</code> đến <code>623afdd...</code>, xây ba cấu trúc model, chạy G0 kiểm tra pipeline và G1 sàng lọc bằng cùng ngân sách ngắn.

**Train từ đầu (training from scratch)** nghĩa là weights bắt đầu ngẫu nhiên. Repo có thể dùng code cấu trúc ResNet/MobileNet từ TorchVision, nhưng phải gọi `weights=None`. Dùng code thư viện không đồng nghĩa với dùng weights pretrained.

Mã cần biết:

- `C1`: SmallCNN nhỏ do dự án định nghĩa.
- `C2`: ResNet18 với phần đầu nhỏ hơn để hợp ảnh 60×80.
- `C3`: MobileNetV3-Small, hướng tới model gọn.
- `G0`: kiểm tra máy có chạy đúng từ đầu đến cuối; không dùng để so chất lượng.
- `G1`: cho C1/C2/C3 cùng 8 epoch, cùng fold và seed 2753 để sàng lọc.
- `P0`: ảnh cao 80, rộng 60. `A0`: biến đổi hình học nhẹ, không đổi màu.

### 2. Vì sao cần phase này?

C1 hỏi đặc trưng tự học đơn giản có vượt đặc trưng làm bằng tay của B1 không. C2 hỏi cấu trúc residual lớn hơn có đáng chi phí không. C3 hỏi cấu trúc gọn có giữ đủ chất lượng không. Cả ba đều bắt đầu ngẫu nhiên và không tải weights bên ngoài.

**Cách đọc bảng:** “Mã” là tên ngắn của model. “Cấu trúc” là tên kỹ thuật. “Hình dung đơn giản” nói điểm chính bằng ngôn ngữ thường. “Khác biệt cần kiểm tra” là lý do model được đưa vào G1, chưa phải kết luận rằng nó sẽ thắng.

| Mã | Cấu trúc | Hình dung đơn giản | Khác biệt cần kiểm tra |
|---|---|---|---|
| C1 | SmallCNN | Bốn khối convolution học từ cạnh đơn giản tới đặc trưng cao hơn. | Model nhỏ có đủ mạnh hơn B1 không? |
| C2 | ResNet18 small-stem | Nhiều lớp hơn và có đường tắt để gradient đi qua dễ hơn. | Chất lượng tăng có đáng số parameter và thời gian không? |
| C3 | MobileNetV3-Small | Tách convolution để giảm phép tính và dung lượng. | Model gọn có giữ được chất lượng không? |

### 3. Nối EDA với ba model

- **Quan sát:** ảnh nhỏ 60×80, hình dáng/màu hữu ích và lớp mất cân bằng mạnh.
- **Giả thuyết:** đặc trưng cục bộ tự học vượt HOG/HSV; stem cho ảnh nhỏ giữ chi tiết; khối mobile tạo cân bằng tốt giữa chi phí và chất lượng.
- **Phép thử:** cùng P0/A0, cùng fold, seed 2753 và cùng 8 epoch.
- **Kết quả:** C1 0.699902, C2 0.707099, C3 0.638495 pooled macro-F1.
- **Kết luận:** đặc trưng tự học được ủng hộ; giữ C1+C2 vào danh sách ngắn; dừng C3.
- **Giới hạn:** ngân sách ngắn có thể cho thứ tự khác với lúc train đầy đủ.

### 4. Từ cần hiểu trước khi đọc code

**Convolution** dùng một bộ lọc nhỏ (kernel) tại mọi vị trí của ảnh. Đầu vào có shape `[N,C,H,W]`: số ảnh, số kênh, chiều cao, chiều rộng. Tensor này có **rank 4**, tức bốn trục; “rank” ở đây không phải thứ hạng model. Mỗi kênh đầu ra kết hợp thông tin từ các kênh đầu vào. Feature map là lưới đầu ra; không nên tự gọi nó là “bộ dò vật thể” nếu chưa có bằng chứng.

**Pooling** giảm chiều cao/rộng và làm vùng ảnh có thể ảnh hưởng tới một activation rộng hơn. BatchNorm chuẩn hóa activation bằng thống kê đang được theo dõi. ReLU đổi giá trị âm thành 0. Dropout ngẫu nhiên tắt một phần activation khi train để giảm phụ thuộc quá mức.

**SmallCNN C1:** có bốn block, số kênh 32→64→128→256. Mỗi block có hai convolution 3×3, BatchNorm, ReLU và max-pool 2×2. Adaptive average pooling gom lưới thành vector đại diện (embedding) 256 chiều; Dropout và lớp Linear tạo bốn logit.

**Đường tắt residual trong C2:** thay vì chỉ học phép biến đổi trực tiếp \(H(x)\), block học phần cần sửa \(F(x)=H(x)-x\), rồi cộng lại thành \(y=F(x)+x\). Đường identity giúp gradient đi qua mạng sâu hơn. “Giúp tối ưu” không đồng nghĩa “luôn cho accuracy cao hơn”.

**Convolution tách chiều trong C3 (depthwise separable convolution):** kernel depthwise xử lý từng kênh riêng; convolution pointwise 1×1 trộn các kênh. Chi phí chuẩn gần \(K^2C_{in}C_{out}\); chi phí tách gần \(K^2C_{in}+C_{in}C_{out}\). MobileNetV3 còn có inverted residual, linear bottleneck, squeeze-and-excitation và h-swish. Bạn chỉ cần nhớ ở lần đầu: các khối này cố giảm chi phí mà vẫn giữ khả năng biểu diễn.

**Ranh giới scratch:** code kiểm tra cả <code>weights=None</code>, metadata <code>training_origin=scratch</code>, <code>benchmark_only=False</code> và <code>final_eligible=True</code>. Một dòng đúng chưa đủ nếu ba phần còn lại nói khác.

### 5. File và tài liệu cần mở

**PyTorch convolution contract**

- **Vì sao đọc lúc này:** hiểu <code>_conv_block</code>.
- **Đọc đúng phần nào:** công thức đầu trang, Parameters, Shape và groups của [Conv2d](https://docs.pytorch.org/docs/stable/generated/torch.nn.Conv2d.html); định nghĩa/shape đầu ra của [MaxPool2d](https://docs.pytorch.org/docs/stable/generated/torch.nn.MaxPool2d.html).
- **Cần lấy ý gì:** `[N,C,H,W]`, cross-correlation, trộn kênh và giảm kích thước không gian.
- **Tạm bỏ qua gì:** kiểu số phức và các padding mode ít dùng.
- **Nối với repository:** <code>season.py:57–128</code>.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** một đặc trưng cạnh dọc có thể phản ứng mạnh với đường viền áo khoác. Classifier vẫn cần kết hợp nhiều đặc trưng để tạo bốn logit; không được kết luận cạnh dọc gây ra nhãn Winter.

**ResNet**

- **Vì sao đọc lúc này:** hiểu C2.
- **Đọc đúng phần nào:** §3.1–3.3 trang 771–773; §4.2 trang 775–777; Figure 2; Table 1.
- **Cần lấy ý gì:** \(y=F(x)+x\), đường tắt identity và ví dụ trên ảnh nhỏ.
- **Tạm bỏ qua gì:** phần object detection.
- **Nối với repository:** <code>ScratchSmallStemResNet18</code> gọi <code>resnet18(weights=None)</code>, thay conv1 bằng 3×3 stride 1 và thay maxpool đầu bằng Identity.
- **Nguồn trực tiếp:** [He et al., 2016 — Deep Residual Learning for Image Recognition](https://doi.org/10.1109/CVPR.2016.90), [TorchVision resnet18](https://docs.pytorch.org/vision/stable/models/generated/torchvision.models.resnet18.html).
- **Ranh giới kết luận:** repo dùng ảnh thời trang 60×80 và nhãn bốn mùa; score ImageNet/CIFAR trong paper không dự đoán score Task 2.

**MobileNetV3**

- **Vì sao đọc lúc này:** hiểu C3.
- **Đọc đúng phần nào:** §3 trang 1316–1317; §5 trang 1318–1320; bảng MobileNetV3-Small.
- **Cần lấy ý gì:** khối tiết kiệm phép tính và cách cùng cân nhắc độ trễ/chất lượng.
- **Tạm bỏ qua gì:** quy trình NAS và decoder segmentation.
- **Nối với repository:** <code>mobilenet_v3_small(weights=None)</code>, classifier được thay để tạo bốn logit.
- **Nguồn trực tiếp:** [Howard et al., 2019 — Searching for MobileNetV3](https://doi.org/10.1109/ICCV.2019.00140), [TorchVision implementation](https://docs.pytorch.org/vision/stable/models/mobilenetv3.html).

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** filter depthwise có thể tách texture từng kênh rồi lớp 1×1 trộn chúng thành đặc trưng dùng cho bốn logit. Ít phép nhân hơn không bảo đảm nhanh hơn trên mọi CPU.

### 6. Thứ tự đọc code

1. <code>SeasonModelSpec.validate</code>.
2. <code>_conv_block</code> và <code>SmallSeasonCNN</code>.
3. <code>ScratchSmallStemResNet18</code>.
4. <code>ScratchMobileNetV3Small</code>.
5. <code>model_boundary_audit</code>, <code>assert_final_model</code>, <code>build_season_model</code>.
6. Model tests, G0 smoke, experiment runner.
7. G0 manifest; G1 leaderboard/shortlist/manifests.
8. Notebook 03 model and screen consumers.

### 7. Đi xuyên qua cách chạy

Kiểm tra đầu vào yêu cầu tensor có bốn trục và số kênh đúng. Mỗi lần forward trả logit shape `[N,4]`, tức bốn điểm cho mỗi ảnh. <code>forward_features</code> giữ lưới đặc trưng cho Grad-CAM; <code>forward_embedding</code> gom lưới thành vector; <code>classify_embedding</code> tạo logit. Tách ba bước giúp I2 dùng chung encoder về sau.

Đường shape của C1 với P0:

~~~text
[N, 3, 80, 60]       batch ảnh RGB
  → bốn conv block    học đặc trưng và giảm dần H, W
  → [N, 256, h, w]    lưới đặc trưng cuối
  → average pool      [N, 256, 1, 1]
  → flatten           [N, 256]
  → Linear            [N, 4] logit
  → argmax            một nhãn Season cho mỗi ảnh
~~~

`h` và `w` là kích thước không gian còn lại sau pooling. Bạn không cần tự tính chúng để hiểu contract vì adaptive average pooling luôn đưa về 1×1.

G0 giống như bật máy và kiểm tra dây điện trước khi đem máy đi thi. Học thuộc 64 sản phẩm chứng minh nhãn, gradient và optimizer nối đúng; nó không chứng minh model dự đoán tốt cho ảnh chưa gặp.

G0 có hai phần:

~~~text
64 products, 100 steps:
    cần accuracy >= 0.95
    final_loss / initial_loss <= 0.20
512 train + 128 validation, 2 epochs:
    phải tạo checkpoint, OOF, history, registry và hash
~~~

Kết quả thật G0: tiny accuracy 1.0; tỉ lệ loss cuối/đầu 0.0000145; gradient hữu hạn; integration run <code>g0-pipeline-smoke-f0-s2753-3d13703c9c4a</code>; <code>comparison_eligible=false</code>, nghĩa là lần chạy này bị cấm dùng để xếp hạng model.

### 8. Test và luật được bảo vệ

- Model shape tests chạy cả P0 và P1.
- Scratch tests monkeypatch weight download và yêu cầu <code>weights=None</code>.
- Backprop tests xác minh gradient tới stem và classifier.
- Boundary tests chặn benchmark/pretrained model khỏi final path.
- G0 tests kiểm tra threshold, artifacts và registry.
- Figure tests phát hiện absolute paths, interactive backend và clipped labels.

Luồng Red–Green điển hình: **Red** là test tái hiện lỗi và đang thất bại; **Green** là sau khi sửa, test đã đạt. Green không tự chứng minh chất lượng model.

~~~mermaid
flowchart LR
    B[Bug được quan sát] --> T[Regression test tái hiện và đỏ]
    T --> R[Root cause được cô lập]
    R --> F[Fix nhỏ]
    F --> G[Regression + suite xanh]
    G --> L[Giữ test làm guard]
~~~

Ví dụ <code>3cbe0c1</code> tái hiện cached stats tuple mất fields; <code>f854db5</code> sửa và giữ regression.

### 9. Câu chuyện thay đổi theo thời gian

Câu chuyện theo thời gian không được rút gọn thành “viết model rồi có score”:

- 027–033: C1, target Grad-CAM layer/parameter assertion correction, C2, C3, scratch/benchmark/multitask boundaries và MobileNet embedding fix. <code>1fb1107</code> được tạo sau một PowerShell chain tiếp tục qua assertion fail; <code>577cabc</code> sửa expected C1 parameter count.
- 034–051: config runner, source/figure flow và notebook wiring. Red–Green pairs: <code>2c211f5→dff0c80</code> portable paths; <code>84f3faf→9d2a827</code> headless Matplotlib; <code>63bd722→4cc89b3</code> pandas table; <code>757e600→5f83da9</code> real padding mask.
- 052–066: G0, B0/B1 evidence và caches. <code>3cbe0c1→f854db5</code> bảo toàn tuple fields.
- 067–085: G1 declaration/runs/evidence/shortlist. <code>1dd96c3→b12e38e</code> figure label; <code>9d4e8e7→ba6c0f1</code> handoff question; <code>60264b9→6fc6568</code> không giả execution counts; <code>11dda77→7d70e3f→9d18996→4407755</code> giữ dirty G0 row rồi chọn clean rerun.

### 10. Bằng chứng và số đo thật

**Cách đọc bảng:** “Model” là mã C1/C2/C3. “Dải Run ID” từ `f0` đến `f4` là năm validation fold. “Macro-F1” và “Spring F1” là pooled OOF trên 32,753 sản phẩm, thang 0–1 và càng cao càng tốt. “Params” là số weight có thể học. “5-fold runtime” là tổng thời gian năm fold trên máy đã ghi môi trường, càng thấp càng rẻ nhưng không chắc lặp đúng trên máy khác. “Peak VRAM” là bộ nhớ GPU đỉnh theo MiB, càng thấp càng nhẹ. “Quyết định” là kết quả của cổng G1, không phải winner cuối.

| Model | Dải Run ID | Pooled OOF macro-F1 | Spring F1 | Params | Runtime 5 fold | Peak VRAM | Quyết định G1 |
|---|---|---:|---:|---:|---:|---:|---|
| C1 | <code>g1-c1-smallcnn-f0...84ff427deca5</code> → <code>...f4...56720f02f317</code> | 0.699902 | 0.726168 | 1,174,244 | 19.11 phút | 191.36 MiB | Giữ vào shortlist |
| C2 | <code>g1-c2-resnet18-f0...b91662d47026</code> → <code>...f4...2449eed2ce12</code> | 0.707099 | 0.738433 | 11,170,884 | 29.21 phút | 606.39 MiB | Giữ vào shortlist và cho chạy ablation |
| C3 | <code>g1-c3-mobilenetv3-f0...9e07fe2a3158</code> → <code>...f4...bf6c9229b22b</code> | 0.638495 | 0.668816 | 1,521,956 | 16.66 phút | 74.25 MiB | Dừng sau G1 |

Đường truy vết: <code>results/evidence/task2/g1_family_screen/leaderboard.csv</code>, <code>shortlist.json</code>, manifest và bằng chứng OOF của từng ứng viên. Tất cả dùng 32,753 sản phẩm.

### 11. Cách hiểu kết quả

C1 và C2 vượt B1 khoảng 0.090–0.098 macro-F1: learned representation có ích trong protocol này. C2 dẫn C1 0.00720 ở short screen nhưng tốn 9.51× parameters. C3 rẻ nhất theo VRAM/runtime đã đo nhưng quality gap 0.0686 với C2 quá lớn.

### 12. Quyết định

Giữ C2 và C1 trong danh sách ngắn. Dừng C3. C2 đang dẫn nên được dùng cho phép thử P/A; C1 vẫn được chạy với ngân sách đầy đủ vì model nhỏ và score còn gần C2.

### 13. Bài học của senior

Ngân sách sàng lọc dùng để loại phương án yếu, không để tuyên bố model thắng cuối. Phải đo chi phí trên phần cứng thật; không được suy thời gian chạy chỉ từ số tham số.

### 14. Hiểu lầm hay gặp

- <code>weights=None</code> không có nghĩa architecture tự viết từ số 0.
- G0 accuracy 1.0 không phải validation achievement.
- Residual connection không bảo đảm C2 thắng.
- MobileNetV3 “mobile” không bảo đảm nhanh trên mọi backend.
- Peak VRAM và model bytes là hai đại lượng khác.
- G1 score chưa phải ultimate judgement.

### 15. Câu hỏi tự luyện

<details>
<summary><strong>Nhớ lại 1:</strong> Convolution tạo feature map bằng cách nào?</summary>

**Gợi ý trả lời**

- Kernel trượt trên input, tính weighted local combination ở mỗi vị trí và tạo channel output.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

<details>
<summary><strong>Nhớ lại 2:</strong> Khối residual tính công thức gì?</summary>

**Gợi ý trả lời**

- Output y = F(x) + x khi shape khớp; shortcut mang identity path.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

<details>
<summary><strong>Nhớ lại 3:</strong> Luật train từ đầu trong metadata của model gồm gì?</summary>

**Gợi ý trả lời**

- training_origin=scratch, benchmark_only=False, final_eligible=True và weights=None.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

<details>
<summary><strong>Vì sao 4:</strong> Vì sao C2 đổi phần đầu thành 3×3 stride 1 và bỏ max-pool đầu?</summary>

**Gợi ý trả lời**

- Ảnh chỉ 60×80; stem ImageNet 7×7 stride 2 + maxpool có thể giảm spatial detail quá sớm.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

<details>
<summary><strong>Vì sao 5:</strong> Vì sao C3 không được chọn dù có ít tham số và dùng ít VRAM?</summary>

**Gợi ý trả lời**

- Screen macro-F1 0.638495 thấp hơn C1/C2 nhiều; efficiency không bù quality gap theo gate.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

<details>
<summary><strong>Vì sao 6:</strong> Vì sao việc học thuộc batch nhỏ chỉ kiểm pipeline, không đo khả năng áp dụng cho ảnh mới?</summary>

**Gợi ý trả lời**

- Nó cố ý memorize 64 products để xác minh labels, gradient và optimizer; không dùng held-out population.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

<details>
<summary><strong>Lần theo code 7:</strong> Lần theo tensor P0 qua SmallCNN.</summary>

**Gợi ý trả lời**

- [N,3,80,60] → bốn conv blocks và pooling → spatial map → adaptive average [N,256,1,1] → flatten/dropout/linear → [N,4] logits.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

<details>
<summary><strong>Lần theo code 8:</strong> assert_final_model chặn weights pretrained thế nào?</summary>

**Gợi ý trả lời**

- Nó audit bốn metadata fields và fail closed nếu origin, benchmark flag, eligibility hoặc weights sai.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

<details>
<summary><strong>Tìm lỗi 9:</strong> Nếu forward nhận [N,80,60,3], lỗi ở đâu?</summary>

**Gợi ý trả lời**

- Model kiểm tra ndim/channel ở dimension 1 và raise ValueError; loader phải permute HWC thành CHW.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

<details>
<summary><strong>Tìm lỗi 10:</strong> Nếu checkpoint G0 đạt test nhưng provenance ghi git_dirty=true, xử lý sao?</summary>

**Gợi ý trả lời**

- Giữ row cũ làm trace, chạy clean run ID mới, và evidence chọn clean row; không rewrite history.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

<details>
<summary><strong>Bảo vệ miệng 11:</strong> C2 hơn C1 ở G1 có đủ để gọi C2 là model thắng chưa?</summary>

**Gợi ý trả lời**

- Không. G1 là short screen; full budget, stability, robustness, cost và uncertainty chưa đóng.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

<details>
<summary><strong>Bảo vệ miệng 12:</strong> Số tham số nói được và không nói được gì?</summary>

**Gợi ý trả lời**

- Nó đo số trainable parameters/storage proxy; không tự quyết latency, VRAM, quality hay energy trên máy khác.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và g1_c1/c2/c3 JSON
- Code: src/fashion/models/season.py; src/fashion/train/engine.py; src/fashion/task2/experiments.py
- Test: tests/models/test_smallcnn.py, test_resnet18.py, test_mobilenet.py; tests/task2/test_smoke.py
- Run/artifact: results/evidence/task2/g0/ và g1_family_screen/
- Commit: dải a547f4b... → 623afdd...
- Limitation: G1 chỉ là 8-epoch screen ở seed 2753; runtime phụ thuộc máy.

</details>

### 16. Checklist trước khi đi tiếp

- [ ] Tôi vẽ được data shapes của C1.
- [ ] Tôi giải thích residual và depthwise separable convolution.
- [ ] Tôi chứng minh ba candidate là scratch.
- [ ] Tôi phân biệt G0 smoke với G1 comparison.
- [ ] Tôi bảo vệ shortlist và lý do dừng C3.

### 17. Bước tiếp theo

Next: [Ablations, tuning và learning curves](05_ABLATIONS_TUNING_AND_LEARNING_CURVES.md)
