# Phase 06 — Hai cách can thiệp I1/I2 và ranh giới pretrained

### 1. Bạn đang ở đâu?

P0, A0 và thông số học đã được chọn, nhưng bằng chứng G3 cần sửa để mọi lần chạy có thể truy ngược đúng. Commit 140–191, từ <code>10d2cad...</code> đến <code>c05bd8d...</code>, sửa phần nền đó rồi thử hai ý tưởng từ EDA: cho lớp ít mẫu nhiều trọng số hơn (I1), và cho model học thêm ArticleType trong lúc train (I2). P* đo mức tham khảo khi dùng trọng số pretrained, nhưng không được phép trở thành model cuối.

> **Đọc mã trước khi đọc số:** `G3` là cổng chạy đầy đủ hai model nền; `G4` là cổng thử I1, I2 và benchmark pretrained. `C1` là SmallCNN học từ đầu; `C2` là ResNet18 small-stem học từ đầu. `I1` dùng loss cân bằng lớp; `I2` thêm đầu dự đoán ArticleType lúc train. `P0` là kích thước ảnh 80×60 và `A0` là bộ biến đổi ảnh nhẹ không colour jitter. `T0` và `T1` là hai cặp thông số học đã chọn cho C2 và C1. `P0S` là **model benchmark** ResNet18 standard-stem khởi tạo ngẫu nhiên; nó không phải biến thể kích thước ảnh P0. `P*` là cùng model benchmark nhưng dùng trọng số ImageNet. Trong run ID, `f0`…`f4` là năm fold validation; `s2753` là seed 2753.

Ký hiệu `λ_aux` đọc là “lambda phụ”. Đây là số quyết định loss ArticleType ảnh hưởng mạnh đến tổng loss đến đâu. `λ_aux = 0.3` nghĩa là loss phụ được nhân với 0.3. Trong code, biến có thể được viết ngắn là `lambda`, nhưng ở phase này nó luôn là **trọng số loss phụ**, không phải `weight decay` đã chỉnh ở phase 05.

### 2. Vì sao cần phase này?

Việc tăng sức chứa model và chỉnh thông số chung đã gần hết lợi ích. EDA cho thấy hai vấn đề khác nhau: lớp Spring ít mẫu, còn ArticleType có liên hệ với Season.

- I1 đổi **mức phạt trong loss**: lỗi ở lớp ít mẫu được tính nặng hơn. Kiến trúc model không đổi.
- I2 thêm **tín hiệu học**: cùng phần rút đặc trưng phải hỗ trợ cả Season và ArticleType.
- P0S/P* chỉ đổi **trọng số ban đầu** trong cùng một model benchmark.

Nếu trộn ba thay đổi trong một lần chạy, ta sẽ không biết phần nào tạo ra chênh lệch.

### 3. Nối với EDA

- **Mất cân bằng lớp (imbalance) 12.22:1** nghĩa là lớp lớn có số mẫu gấp 12.22 lần lớp nhỏ. Điều này gợi ý thử I1. Kết quả thật cho thấy model gọi Spring nhiều hơn, nhưng cũng gọi nhầm Spring nhiều hơn.
- **NMI 0.174** và **agreement 65.05%** đo mức ArticleType và Season đi cùng nhau. Đây là liên hệ, không phải quan hệ nguyên nhân. Nó gợi ý thử I2. Conflict slice kiểm tra những trường hợp mối liên hệ quen thuộc đó không đúng.
- Đề bài yêu cầu model cuối học từ đầu, nên P* chỉ là **mức trần tham khảo (ceiling)**. Điểm cao không làm P* trở thành ứng viên hợp lệ.

Sau khi sửa G3 và trước khi thử I1/I2: C1-T1 đạt 0.737661; C2-T0 đạt 0.735036. Chênh lệch 0.002626 nhỏ hơn ngưỡng “gần hòa” 0.005. C2 có số tham số gấp 9.513 lần và thời gian chạy gấp 1.521 lần. Vì vậy C1 là mốc so sánh tạm thời, chưa phải model thắng cuối.

### 4. Từ cần hiểu trước khi đọc code

**Số mẫu hiệu dụng (effective number):** 100 ảnh gần giống nhau không cung cấp nhiều thông tin bằng 100 ảnh rất khác nhau. Công thức dùng số mẫu lớp \(n_c\): \(E_{n_c}=(1-\beta^{n_c})/(1-\beta)\), rồi tạo trọng số nghịch đảo \(w_c=(1-\beta)/(1-\beta^{n_c})\). Khi \(\beta\) gần 1, lớp hiếm nhận trọng số lớn hơn. Repo dùng \(\beta=0.9999\), chỉ tính từ phần train của từng fold, rồi chuẩn hóa trung bình bốn trọng số về 1.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** nếu số mẫu là `[Fall 90, Spring 10, Summer 160, Winter 60]`, Spring nhận trọng số lớn nhất vì có ít mẫu nhất. Công thức chỉ nói lỗi Spring sẽ được chú ý hơn; nó không bảo đảm Spring F1 hay macro-F1 sẽ tăng.

**Đổi chác precision–recall:** `TP` là ảnh Spring được đoán đúng Spring. `FP` là ảnh không phải Spring nhưng bị gọi nhầm là Spring. `FN` là ảnh Spring nhưng model bỏ sót. Recall tăng khi bỏ sót ít hơn; precision giảm khi báo nhầm nhiều hơn. Vì vậy recall có thể tăng nhưng F1 vẫn giảm.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** trước I1, model gọi 10 ảnh là Spring và 9 ảnh đúng, nên precision = 9/10 = 0.90. Sau I1, model gọi 20 ảnh là Spring và 12 ảnh đúng, nên tìm thêm 3 ảnh đúng nhưng precision chỉ còn 12/20 = 0.60. “Gọi Spring nhiều hơn” chưa đủ để kết luận model tốt hơn.

**Học nhiều nhiệm vụ (multi-task learning):** phần rút đặc trưng dùng chung nhận tín hiệu sửa sai từ nhiệm vụ chính Season và nhiệm vụ phụ ArticleType. Repo tính:
\[
L=L_{season}+\lambda_{aux}L_{articleType,masked}.
\]
\(\lambda_{aux}\) điều khiển sức nặng của nhiệm vụ phụ. Nếu một hàng thiếu ArticleType, code gán chỉ số bỏ qua −100 cho loss phụ; hàng đó vẫn được dùng để học Season.

**Chuyển giao âm (negative transfer)** xảy ra khi nhiệm vụ phụ làm nhiệm vụ chính tệ hơn. `Aligned slice` gồm các hàng ArticleType–Season đi theo quan hệ thường thấy trong phần train. `Conflict slice` gồm các hàng đi ngược quan hệ đó. Mapping này chỉ được học từ phần train của fold để tránh rò rỉ nhãn validation.

**Ranh giới pretrained:** P0S và P* dùng cùng ResNet18 standard-stem và cùng quy trình; P0S bắt đầu ngẫu nhiên, P* bắt đầu từ trọng số đã học trên ImageNet. Cả hai có <code>benchmark_only=true</code> và <code>final_eligible=false</code>, nên chỉ trả lời “pretraining có thể nâng mức tham khảo bao nhiêu”, không tham gia chọn model cuối.

**OOF (out-of-fold)** là dự đoán cho một ảnh bởi model không dùng ảnh đó để train. `Pooled OOF macro-F1` nối OOF của cả năm fold rồi tính macro-F1 một lần; cao hơn tốt. Macro-F1 cho bốn lớp Season trọng lượng ngang nhau dù số ảnh mỗi lớp khác nhau.

**Kết quả thật của dự án:** I1 làm macro-F1 giảm. I2 với `λ_aux = 0.1` và `λ_aux = 0.3` đều tăng macro-F1; `λ_aux = 0.3` tốt hơn và được giữ. P* cao hơn P0S nhưng chỉ là benchmark không hợp lệ cho model cuối.

**Quy tắc quyết định đã khóa trước:** Δ của I1/I2 được tính so với C1-T1 đã sửa. Với P*, Δ được tính `P* − P0S`, vì đây là cặp benchmark riêng. Không được lấy P* so trực tiếp với I2 để tuyên bố model cuối.

### 5. Tài liệu cần mở lúc này

**Effective-number loss**

- Vì sao đọc lúc này: trước I1 code.
- Phần/trang cần đọc: §3 pp. 9270–9271; effective-number equation; §4–4.1 pp. 9271–9273.
- Ý chính cần lấy: diminishing effective samples và inverse-effective weighting.
- Phần có thể bỏ qua lúc này: focal-loss branch.
- Liên hệ với repository: <code>effective_number_class_weights</code>, fold audit, weighted CrossEntropyLoss.
- Liên kết trực tiếp: [Cui et al., 2019 — Class-Balanced Loss Based on Effective Number of Samples](https://doi.org/10.1109/CVPR.2019.00949).
- Khác biệt/giới hạn: mean-one normalization và training-ID hash là repo contract; paper không hứa Spring F1 tăng.

**Multi-task learning**

- Vì sao đọc lúc này: trước I2 shared encoder.
- Phần/trang cần đọc: §1.1 và §1.3, journal pp. 41–44.
- Ý chính cần lấy: related tasks constrain shared representation như inductive bias.
- Phần có thể bỏ qua lúc này: KNN, kernel regression và decision-tree extensions.
- Liên hệ với repository: <code>SeasonArticleTypeMultiTaskModel</code> có two heads; <code>predict_season_logits</code> image-only.
- Liên kết trực tiếp: [Caruana, 1997 — Multitask Learning](https://doi.org/10.1023/A:1007379606734).
- **Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** ảnh “jacket” góp tín hiệu sửa sai cho cả Season và ArticleType; vector đặc trưng có thể học tay áo và hình dáng tốt hơn. Ví dụ không nói ArticleType gây ra Season.

**TorchVision weights**

- Vì sao đọc lúc này: hiểu P* và final boundary.
- Phần/trang cần đọc: <code>resnet18</code> signature và <code>weights</code>.
- Ý chính cần lấy: <code>weights=None</code> random; <code>ResNet18_Weights.DEFAULT</code> tải learned parameters.
- Phần có thể bỏ qua lúc này: other architectures.
- Liên hệ với repository: <code>BenchmarkStandardStemResNet18</code> riêng khỏi <code>build_season_model</code>.
- Liên kết trực tiếp: [TorchVision — resnet18](https://docs.pytorch.org/vision/stable/models/generated/torchvision.models.resnet18.html).

### 6. Thứ tự đọc code

1. I1/I2/P0S/P* configs và frozen decision rules.
2. <code>effective_number_class_weights</code> và audit.
3. Multitask Dataset/loader mask.
4. Two-head model <code>forward</code> và image-only method.
5. Masked loss, multitask train fold và checkpoint selection.
6. Benchmark builder/boundary audit.
7. Tests.
8. Corrected G3 → I1 → I2 → P* artifacts, đúng chronology.
9. Notebook/report consumers.

### 7. Đi xuyên qua cách chạy

I1 đổi loss only. History lưu counts, weights, beta, label order và SHA-256 training IDs. Weighted loss values không trừ với ordinary CE values.

I2 trả về một `dict`, tức một nhóm giá trị có tên:

~~~text
embedding = base_model.forward_embedding(images)
season_logits = base_model.classify_embedding(embedding)       # [N,4]
article_logits = article_type_head(embedding)                  # [N,124]
season_loss = CE(season_logits, season_targets)
aux_loss = CE(article_logits[mask], article_targets[mask])
total = season_loss + lambda * aux_loss
select checkpoint by validation Season macro-F1 only
~~~

Quan hệ aligned/conflict của validation chỉ được học từ ArticleType và Season trong fold train. Khi inference, API không có đối số ArticleType, nên nhãn phụ thật không thể “vô tình” đi vào dự đoán.

Đọc đoạn giả mã từ trên xuống: ảnh đi qua model nền để thành `embedding`; hai đầu dự đoán đọc cùng embedding; code tính hai loss; loss tổng dùng `λ_aux`; checkpoint chỉ được chọn bằng Season macro-F1 trên validation. ArticleType giúp **lúc train**, nhưng lúc dự đoán thật API chỉ nhận ảnh.

### 8. Test và các luật được bảo vệ

- I1: kiểm tra beta và số lượng mẫu, tính trọng số chỉ từ fold train, nối đúng weighted loss, và giữ đúng quy tắc cache/OOF.
- I2: missing mask gradients, zero-valid-aux batch, real model smoke, kiểm tra `λ_aux`, OOF schema, image-only path.
- Pretraining: pair phải đủ scratch control + pretrained treatment, same protocol, scratch first, boundary flags.
- Regressions: seed before model construction, semantic OOF cache, implementation dependency hash, missing-value canonicalization, plot title overlap.

### 9. Câu chuyện thay đổi theo commit

Câu chuyện theo thời gian giữ cả những hướng thử rồi bị loại:

- 140–141 thêm I1 loss/runner.
- 142–158 dừng để sửa nền G3: <code>63ae24a→64273e6</code> model từng khởi tạo trước seed; <code>895e482→9ad82b3</code> cache từng nhận OOF semantics chưa đủ; <code>e4d11eb→77e448a</code> implementation hash thiếu data-interpretation dependencies; <code>c46a0ff→a9c4800→62e57e2</code> min-delta/history replay. Corrected clean G3 evidence thay selection claim; old attempt giữ trace.
- 159–169 I1 tests/evidence/plot regression <code>af196ce→f02401f</code>; measured gate đóng với reject.
- 170–183 I2 loader→optimizer→runner→configs→real smoke→evidence. <code>7055afd→7b2485e</code> canonical missing labels. Both lambdas pass; 0.3 selected.
- 184–191 matched pretraining boundary. <code>fcbd79c→8f4cf4a</code> sửa title overlap; P* evidence ghi rõ ineligible.

### 10. Bằng chứng và số đo thật

**Cách đọc bảng:** `Cổng/phép thử` cho biết cấu hình nào đang được kiểm tra. `Bằng chứng chính` là dải run hoặc số lần chạy tạo số liệu; `f0` đến `f4` là năm fold, không phải năm thời điểm. `Pooled OOF macro-F1 và Δ` là macro-F1 gộp từ dự đoán out-of-fold; càng cao càng tốt. Δ của I1/I2 là treatment trừ C1-T1; Δ của P* là P* trừ P0S. `Quyết định` nói cấu hình được giữ, loại hay chỉ dùng làm mức trần.

| Cổng/phép thử | Bằng chứng chính | Pooled OOF macro-F1 và Δ | Quyết định |
|---|---|---:|---|
| G3 đã sửa — C1-T1 | runs <code>g3-c1-t1-smallcnn-f0...1ce4f9978b12</code> → <code>...f4...2b4a6d779fa3</code> | 0.737661 | mốc so sánh tạm thời |
| G3 đã sửa — C2-T0 | <code>...f0...66ee7a85d5c6</code> → <code>...f4...7b3a3bf2d06e</code> | 0.735036 | giữ làm model đối chiếu |
| I1 | <code>g4-i1...f0...9288633e212b</code> → <code>...f4...a70502c769db</code> | 0.701471; Δ = −0.036191 | loại |
| I2, `λ_aux = 0.1` | <code>g4-i2...0-1...f0...1ffe70bcc40d</code> → <code>...f4...6291e9a96fde</code> | 0.750758; Δ = +0.013097 | đạt |
| I2, `λ_aux = 0.3` | <code>g4-i2...0-3...f0...902fcc852d5f</code> → <code>...f4...8d210d54f01e</code> | 0.752687; Δ = +0.015026 | chọn |
| P0S / P* | 5 + 5 run cùng quy trình | 0.731172 / 0.754196; Δ = +0.023024 | chỉ là mức trần tham khảo |

I1 Spring: recall 0.627540→0.650113 (+0.022573), precision 0.916484→0.763926 (−0.152558), F1 −0.042536. Worst other class Fall −0.060738.

I2 với `λ_aux = 0.3`: nhóm aligned tăng 0.013792, nhóm conflict tăng 0.027598, Spring F1 tăng 0.019809. Với P*, cả năm fold và cả bốn lớp đều nghiêng về P*; trung vị epoch tốt nhất giảm từ 22 xuống 11.

### 11. Cách hiểu kết quả

Cơ chế I1 đã hoạt động: model gọi Spring nhiều hơn. Nhưng metric chính xấu đi vì số báo nhầm tăng. Đây là một kết quả âm có giá trị. I2 tăng điểm tổng thể và tăng cả ở conflict slice, nên lời giải thích “I2 chỉ học đường tắt” trở nên yếu hơn; rủi ro đường tắt vẫn chưa biến mất. P* cho thấy việc chuyển đặc trưng đã học còn có thể nâng điểm, nhưng không cho phép phá luật đề bài.

### 12. Quyết định

Loại I1 và giữ Cross-Entropy bình thường. Chọn I2 với `λ_aux = 0.3` làm ứng viên hợp lệ hiện tại; giữ C2 để đối chiếu. P* chỉ xuất hiện trong phần benchmark. Dừng tìm kiến trúc mới; câu hỏi tiếp theo là độ ổn định và cách model thất bại.

### 13. Bài học của senior

Một can thiệp phải được đánh giá bằng kết quả đã chọn trước, không bằng cơ chế ta mong nó sẽ có. Recall của lớp hiếm tăng một mình có thể đi kèm nhiều báo nhầm. Không được “cứu” một kết quả âm bằng cách xem số xong mới đổi beta.

### 14. Hiểu lầm hay gặp

- Loss của I1 không được so trực tiếp với Cross-Entropy không trọng số vì hai hàm có thang khác nhau.
- Recall tăng không bảo đảm F1 tăng.
- `λ_aux` lớn hơn không có nghĩa nhiệm vụ phụ “quan trọng hơn” theo quan hệ nguyên nhân.
- ArticleType là nhãn phụ lúc train, không phải đặc trưng được đưa vào lúc inference.
- P0S và P* đều không đủ điều kiện làm model cuối; chúng chỉ tạo một cặp benchmark cùng cấu trúc.
- Điểm pretrained không được đưa vào bảng xếp hạng các ứng viên cuối hợp lệ.

### 15. Câu hỏi tự luyện

<details>
<summary><strong>Nhớ lại 1:</strong> Effective-number weight có dạng gì?</summary>

**Gợi ý trả lời**

- w_c tỉ lệ (1−β)/(1−β^n_c), sau đó repo normalize bốn weights về mean 1.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

<details>
<summary><strong>Nhớ lại 2:</strong> I2 total loss là gì?</summary>

**Gợi ý trả lời**

- `L_season + λ_aux × L_articleType_masked`; checkpoint selection chỉ dùng Season validation macro-F1.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

<details>
<summary><strong>Nhớ lại 3:</strong> Inference I2 nhận input nào?</summary>

**Gợi ý trả lời**

- Chỉ image tensor; predict_season_logits không nhận true hay predicted ArticleType.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

<details>
<summary><strong>Vì sao 4:</strong> Vì sao Spring recall tăng nhưng I1 vẫn fail?</summary>

**Gợi ý trả lời**

- Recall +0.022573 nhưng precision −0.152558; Spring F1 −0.042536, overall −0.036191 và Fall giảm quá guard.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

<details>
<summary><strong>Vì sao 5:</strong> Vì sao `λ_aux = 0.3` thắng `λ_aux = 0.1` dù bản 0.1 có conflict gain lớn hơn?</summary>

**Gợi ý trả lời**

- Cả hai đều đạt; luật phụ đã khóa ưu tiên pooled OOF macro-F1 tổng thể cao nhất, và `λ_aux = 0.3` cao hơn.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

<details>
<summary><strong>Vì sao 6:</strong> Vì sao P* score tốt vẫn không được submit?</summary>

**Gợi ý trả lời**

- Nó tải ImageNet weights, benchmark_only=True và final_eligible=False; spec yêu cầu final train from scratch.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

<details>
<summary><strong>Lần theo code 7:</strong> Batch không có ArticleType label xử lý sao?</summary>

**Gợi ý trả lời**

- Mask ignore −100; auxiliary loss trả safe zero/no gradient cho head path đó; Season loss vẫn train mọi valid Season row.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

<details>
<summary><strong>Lần theo code 8:</strong> Trace shared representation I2.</summary>

**Gợi ý trả lời**

- Image → SmallCNN embedding → Season head và ArticleType head; backprop tổng loss cập nhật shared encoder; deployment chỉ Season head.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

<details>
<summary><strong>Tìm lỗi 9:</strong> Nếu class weights fit toàn development trước CV, lỗi gì?</summary>

**Gợi ý trả lời**

- Validation label counts chảy vào loss; fold evidence bị leakage. Audit training-ID hash phải fail.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

<details>
<summary><strong>Tìm lỗi 10:</strong> Nếu missing labels hash khác giữa NaN và empty string, hậu quả gì?</summary>

**Gợi ý trả lời**

- Semantically same rows có cache/evidence identity khác; regression 7055afd và fix 7b2485e canonicalize.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

<details>
<summary><strong>Bảo vệ miệng 11:</strong> I2 có chứng minh ArticleType gây ra Season không?</summary>

**Gợi ý trả lời**

- Không. Controlled auxiliary supervision improved OOF metrics; relation vẫn observational và có shortcut risk.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

<details>
<summary><strong>Bảo vệ miệng 12:</strong> P* boundary nói được gì?</summary>

**Gợi ý trả lời**

- Trong matched standard-stem one-seed pipeline, ImageNet initialization tăng 0.023024; không so causal trực tiếp với different I2 architecture.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g4_i1_*, g4_i2_*, g4_p0s_* và g4_pstar_*
- Code: src/fashion/train/losses.py, multitask.py; src/fashion/task2/class_balance.py, multitask.py, pretraining.py
- Test: tests/train/test_multitask.py; tests/task2/test_class_balance.py, test_multitask_runner.py, test_pretraining_runner.py
- Run/artifact: results/evidence/task2/i1_class_balance/, i2_multitask/, pretraining_benchmark/, g3_full_budget/
- Commit: dải 10d2cad... → c05bd8d...
- Limitation: I2 gain là controlled association dưới hai lambdas/seed chính; P* là benchmark-only và one-seed.

</details>

### 16. Checklist trước khi đi tiếp

- [ ] Tôi tính và giải thích effective-number weight.
- [ ] Tôi kể precision–recall failure của I1 bằng số.
- [ ] Tôi trace mask và two-head I2.
- [ ] Tôi áp dụng đúng luật quyết định cho `λ_aux` và không nhầm nó với weight decay.
- [ ] Tôi bảo vệ được pretrained benchmark boundary.

### 17. Bước tiếp theo

Next: [Stability, slices, robustness và calibration](07_STABILITY_SLICES_ROBUSTNESS_AND_CALIBRATION.md)
