# Phase 07 — Độ ổn định, nhóm lỗi, sức chịu ảnh và độ tin cậy

### 1. Bạn đang ở đâu?

I2 với `λ_aux = 0.3` đang là ứng viên chính; C2 là model đối chiếu. Commit 192–236, từ <code>1341254...</code> đến <code>b845414...</code>, ngừng tìm thêm kiến trúc rồi hỏi bốn câu: thứ hạng có lặp lại khi đổi seed không, model hay sai ở nhóm nào, model chịu ảnh bị thay đổi ra sao, và số confidence có đáng tin không?

> **Đọc mã trước khi đọc số:** `G5` là cổng kiểm tra lại với seed khác; `G6` là cổng chẩn đoán theo nhóm, ảnh bị thay đổi, chi phí và calibration. `C2` là ResNet18 small-stem học từ đầu. `I2` là SmallCNN học đồng thời Season và ArticleType, nhưng lúc dự đoán chỉ nhận ảnh. `λ_aux = 0.3` nghĩa loss ArticleType được nhân 0.3; đây không phải weight decay. Trong run ID, `f0`…`f4` là năm fold validation; `s2753` và `s2026` là hai seed. `Seed` là số khởi đầu cho các bước ngẫu nhiên, giúp chạy lại cùng một quy trình.

### 2. Vì sao cần phase này?

Một điểm gộp từ một seed chưa đủ để đưa model vào dùng thật. Ta cần xem chiều hơn–kém có giữ khi đổi seed không, nhóm nào gặp lỗi, ảnh thay đổi nhẹ có làm model sụp không, model tốn bao nhiêu tài nguyên, và xác suất dự đoán có quá tự tin không. Các phép **chẩn đoán (diagnostics)** này chỉ giúp hiểu model đã chọn; chúng không được dùng để lén tạo ứng viên mới hay đổi luật sau khi thấy kết quả.

### 3. Nối với EDA

- Nguy cơ model dùng ArticleType như đường tắt → xem các nhóm aligned, conflict, unseen và missing.
- Phần lớn ảnh đến từ một vài năm → xem riêng 2011–2012 và các năm khác.
- Kích thước file khác nhau → chia theo bốn khoảng trong phần train và thử nén lại JPEG.
- Có ảnh greyscale và RGB → xem riêng từng chế độ ảnh.
- Ảnh người dùng có thể tối, sáng hoặc mờ → thử brightness ±15% và blur radius 1.
- Ảnh cùng họ sản phẩm có thể giống nhau → luôn ghi số mẫu `support`; phase sau sẽ lấy mẫu lại theo cả nhóm.
- Season có thể mơ hồ → kiểm tra confidence đã được hiệu chỉnh và kịch bản chuyển ảnh khó cho người xem.

Quan sát và giả thuyết không chứng minh quan hệ nguyên nhân. Một slice chỉ cho biết model đã train yếu ở nhóm nào. Stress test chỉ cho biết model phản ứng thế nào với đúng thay đổi ảnh nhân tạo đã khai báo.

### 4. Từ cần hiểu trước khi đọc code

**Ổn định theo seed (seed stability):** dù cấu hình giống nhau, trọng số ban đầu và thứ tự batch ngẫu nhiên có thể làm đường học khác đi. Hai model phải được so ở cùng seed. `Drift` của một model luôn là `macro-F1(seed 2026) − macro-F1(seed 2753)`. Drift gần 0 nghĩa điểm ít đổi hơn. Hai seed chỉ là hai lần kiểm tra, chưa mô tả được mọi khả năng ngẫu nhiên.

**Nhóm cắt (slice):** một tập con được định nghĩa trước, ví dụ ảnh greyscale hoặc ArticleType chưa từng thấy. Mọi metric của slice phải đi cùng `support`, tức số hàng được dùng để tính. Quan hệ aligned/conflict chỉ được học từ fold train; dùng nhãn validation để tạo quan hệ sẽ gây **rò rỉ dữ liệu (leakage)**. Metadata chỉ được nối sau khi dự đoán, nên model vẫn chỉ nhìn ảnh.

**Phép làm nhiễu để thử sức chịu (robustness perturbation):** một hàm cố định làm ảnh tối, sáng, mờ hoặc nén JPEG rồi chạy lại đúng model. `Clean` là ảnh không đổi nhưng đi qua cùng đường code. Δ so với clean đo mức giảm; ở đây Δ = `điểm sau khi đổi ảnh − điểm clean`, nên càng gần 0 càng tốt. “I2 cao hơn C2” chỉ là so sánh tương đối; cả hai vẫn có thể rất yếu.

**Chi phí (cost):** gồm số tham số, byte của tham số và buffer, kích thước checkpoint, RAM của tiến trình, VRAM cao nhất và độ trễ khi dự đoán một ảnh. `ms` là mili-giây; nhỏ hơn tốt. `MiB = bytes / 1024²`; nhỏ hơn tốt. Số latency chỉ có nghĩa trên đúng thiết bị, số thread, lượt làm nóng và số lần lặp đã ghi.

**Hiệu chỉnh độ tin cậy (calibration):** nếu nhiều dự đoán cùng báo confidence khoảng 0.8, ta mong khoảng 80% trong số đó là đúng. Temperature scaling chia logits cho một số `T`:
\[
p_i=\operatorname{softmax}(z_i/T),\quad T>0.
\]
`T > 1` làm xác suất bớt cực đoan. Lớp có logit lớn nhất vẫn giữ nguyên, nên nhãn dự đoán và accuracy không đổi. `NLL` phạt xác suất thấp cho đáp án đúng; thấp hơn tốt. `Brier` đo sai số bình phương của xác suất; thấp hơn tốt. `ECE` đo khoảng cách giữa confidence và tỷ lệ đúng theo các khoảng; thấp hơn tốt.

**Risk–coverage:** xếp ảnh theo confidence, tự nhận phần chắc nhất và gửi phần còn lại cho người xem. `Coverage` là tỷ lệ ảnh model tự xử lý; cao hơn nghĩa ít việc cho người. `Selective risk` là tỷ lệ sai trong phần model tự nhận; thấp hơn tốt. Đường này chỉ là chẩn đoán, chưa phải luật vận hành app.

**Cross-fit** nghĩa một hàng không được dùng để học chính nhiệt độ `T` sẽ hiệu chỉnh confidence của nó. Cách này tránh việc đánh giá quá lạc quan. `Pooled OOF macro-F1` là macro-F1 tính một lần sau khi nối dự đoán out-of-fold của cả năm fold; cao hơn tốt.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** có 10 ảnh. Nếu app tự nhận 8 ảnh có confidence cao nhất thì coverage = 8/10 = 80%. Nếu 1 trong 8 ảnh đó sai thì selective risk = 1/8 = 12.5%. Hai ảnh còn lại được gửi cho người xem.

**Kết quả thật của dự án:** I2 vẫn cao hơn C2 ở cả seed 2753 và 2026. Tuy nhiên I2 thay đổi nhiều hơn khi đổi seed, một vài slice đổi dấu, và ảnh tối làm cả hai model yếu nghiêm trọng. Calibration cải thiện các metric xác suất của I2.

**Quy tắc quyết định đã khóa trước:** so I2 và C2 tại cùng seed; không chọn model bằng một slice đơn lẻ; mọi stress condition phải so với clean đi qua cùng code; metric chi phí luôn đi cùng máy và protocol. Phase này chưa khóa winner.

### 5. Tài liệu cần mở lúc này

**Calibration**

- Vì sao đọc lúc này: finalist logits đã freeze.
- Phần/trang cần đọc: §2.1–2.2 pp. 1321–1323; §4 pp. 1324–1325.
- Ý chính cần lấy: reliability, ECE/NLL/Brier và scalar temperature.
- Phần có thể bỏ qua lúc này: vector/matrix scaling.
- Liên hệ với repository: <code>fit_temperature</code>, <code>cross_fit_temperature</code>, G6 evidence.
- Liên kết trực tiếp: [Guo et al., 2017 — On Calibration of Modern Neural Networks](https://proceedings.mlr.press/v70/guo17a.html).
- **Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** logits `[4, 1, 0, −1]` vẫn chọn Fall sau khi chia `T=2`, nhưng xác suất Fall giảm. Nếu model ban đầu quá tự tin, NLL có thể tốt hơn. Ví dụ không nói calibration chắc chắn áp dụng được cho holdout.

**Selective prediction**

- Vì sao đọc lúc này: sau calibrated OOF confidence.
- Phần/trang cần đọc: §2, PMLR pp. 2151–2153, definitions selection function/coverage/risk.
- Ý chính cần lấy: abstain/review trade-off.
- Phần có thể bỏ qua lúc này: three-head SelectiveNet architecture.
- Liên hệ với repository: repo chỉ rank frozen predictions; không train reject head.
- Liên kết trực tiếp: [Geifman & El-Yaniv, 2019 — SelectiveNet](https://proceedings.mlr.press/v97/geifman19a.html).
- Giới hạn của kết luận: 20% review row is scenario, không phải policy.

**Determinism reminder**

- Vì sao đọc lúc này: giải thích seed evidence đúng mức.
- Phần/trang cần đọc: reproducibility warning và deterministic algorithms.
- Ý chính cần lấy: deterministic settings are requested/recorded; release/platform may differ.
- Phần có thể bỏ qua lúc này: unrelated ops.
- Liên hệ với repository: <code>warn_only=True</code> và environment manifest.
- Liên kết trực tiếp: [PyTorch reproducibility note](https://docs.pytorch.org/docs/stable/notes/randomness.html).

### 6. Thứ tự đọc code

1. G5 configs, then stability runner/evidence.
2. Slice spec/config; training-fold mapping and support guard.
3. Robustness condition dataclass; clean reconciliation; cost probe/cache.
4. Calibration metrics, cross-fitting and risk-coverage.
5. Tests for each boundary.
6. Decision JSON then raw tables/figures/manifests.
7. Notebook diagnostic consumers.

### 7. Đi xuyên qua cách chạy

Lần kiểm tra ổn định dùng lại đúng máy chạy thí nghiệm cũ nhưng đổi seed thành 2026. Trước khi so số, code từ chối nếu hash implementation đã đổi, vì lúc đó ta không còn chỉ đổi seed.

Luồng tính metric cho từng nhóm cắt:

~~~text
load aligned OOF candidates
join development metadata after predictions
for each fold, fit ArticleType→Season majority on other folds
assign aligned/conflict/unseen/missing
compute candidate/seed metric only with support
flag support < 100
never change selected candidate from a slice
~~~

Luồng robustness mở đúng ảnh validation đã khai báo, áp dụng từng thay đổi ảnh một, dùng checkpoint và thống kê gốc của fold, kiểm xác suất ảnh sạch khớp bản OOF, rồi gộp kết quả theo điều kiện. Chi phí được đo riêng trên ID 1163 với số lượt chạy thử và số lượt làm nóng cố định.

Calibration theo kiểu cross-fit nghĩa là không dòng nào được dùng để tìm chính nhiệt độ `T` áp vào nó. Giá trị `T=1.3650016` tìm từ toàn bộ OOF chỉ được lưu làm metadata cho bundle tương lai; nó không phải bằng chứng đánh giá mới.

### 8. Test và các luật được bảo vệ

Các cặp test đỏ rồi sửa xanh theo đúng thời gian là phần quan trọng của bằng chứng:

- stability hash bypass <code>2da2754→04ef69d</code>;
- normalized slice config <code>1195f0a→077936a</code>;
- low-support warning <code>6af8ecd→15da0ec</code>;
- unpaired clean baseline <code>9e427d4→7d1310d</code>;
- stale image cache <code>cf36479→41f9ada</code>;
- incomplete/untracked source provenance <code>4b48594→9570635</code>, <code>34966e8→bf852f0</code>;
- path/order/roundtrip regressions <code>3a88450→03069a0</code>, <code>08155ef→7c86a1f</code>, <code>d19fcbe→40e8e94</code>;
- calibration boundaries/numerics <code>eabd6a9→d35a1c4</code>;
- SciPy runtime provenance <code>500e83b→faa0f24</code>.

### 9. Câu chuyện thay đổi theo commit

- 192–200: declare/run/build G5, close hash bypass, record two-seed judgement.
- 201–207: slice config/code; normalize config hashing; add low-support guard; measured error/minority evidence.
- 208–225: robustness/cost declaration; app/report explicitly deferred; probe implementation; eight Red–Green provenance/cache/portability corrections; measured evidence.
- 226–236: calibration contract, SciPy optimizer dependency, temperature metrics/numeric hardening, risk-coverage rounding, evidence builder and closed gate.

### 10. Bằng chứng và số đo thật

**Độ ổn định theo seed**

**Cách đọc bảng:** `Ứng viên` là model đang xét. Hai cột seed là pooled OOF macro-F1, nằm trong khoảng 0–1 và càng cao càng tốt. `Drift` được tính `seed 2026 − seed 2753`; số âm nghĩa lần chạy seed 2026 thấp hơn, còn độ lớn tuyệt đối gần 0 nghĩa ổn định hơn.

| Ứng viên | Macro-F1 seed 2753 | Macro-F1 seed 2026 | Drift = 2026 − 2753 |
|---|---:|---:|---:|
| C2 | 0.735036 | 0.733137 | −0.001899 |
| I2 | 0.752687 | 0.744743 | −0.007944 |

**Cách đọc bảng:** `Seed` cho biết hai model bắt đầu từ bộ số ngẫu nhiên nào. `Lợi thế I2 − C2` là macro-F1 của I2 trừ C2 tại cùng seed; số dương nghĩa I2 cao hơn, số âm nghĩa C2 cao hơn. Cột `Ý nghĩa` chỉ diễn giải dấu, không phải một metric mới.

| Seed | Lợi thế macro-F1 I2 − C2 | Ý nghĩa |
|---:|---:|---|
| 2753 | +0.017651 | I2 cao hơn C2 ở seed 2753 |
| 2026 | +0.011607 | I2 cao hơn C2 ở seed 2026 |

Dải run seed 2026: C2 <code>...f0...5444e94d7f03</code> → <code>...f4...b9ac258333f7</code>; I2 <code>...f0...af9e3079222a</code> → <code>...f4...67a70e52f92f</code>.

**Các nhóm cắt**

Hàng xấu nhất là ArticleType chưa từng thấy ở seed 2026: −0.119048, support 19 nên độ tin cậy thấp. Nhóm greyscale ở seed 2753 có Δ = −0.045315, support 294. Có hai nhóm đổi dấu khi đổi seed. Vì vậy lợi ích trung bình không xuất hiện đều ở mọi nhóm.

**Sức chịu ảnh và chi phí**

I2 cao hơn C2 trên ảnh clean, JPEG85, brightness 0.85/1.15 và blur. Điều kiện tuyệt đối xấu nhất là brightness 0.85: C2 đạt 0.337542 và I2 đạt 0.363961 macro-F1. Spring recall của I2 chỉ còn 0.003010. I2 thắng tương đối, nhưng kết quả tuyệt đối vẫn rất yếu.

Trung vị thời gian chỉ chạy model trên CPU: C2 47.9758 ms, I2 6.54705 ms. Trên CUDA: 2.24615 so với 1.3124 ms. Tổng byte tham số và buffer của I2 bằng 0.108049 lần C2. Các số này chỉ đúng cho máy và quy trình đo đã ghi.

**Calibration**

I2 cross-fitted: ECE 0.046210→0.016767; NLL 0.632467→0.608241; Brier 0.337816→0.334753. Với 20% diagnostic review, selective macro-F1 0.825837, risk 0.172843. `App threshold = null` nghĩa là app **chưa có ngưỡng tự động** để chuyển ảnh sang người xem; con số 20% chỉ là kịch bản chẩn đoán của phase này.

### 11. Cách hiểu kết quả

I2 vẫn đứng trên C2 ở hai seed, nhưng điểm I2 đổi nhiều hơn và lợi ích không đều theo lớp hoặc slice. I2 nhẹ, nhanh và cao hơn C2 dưới mọi thay đổi ảnh đã thử; tuy vậy, làm ảnh tối là một lỗi tuyệt đối nghiêm trọng. Calibration giảm sự quá tự tin. Risk–coverage gợi ý người kiểm tra ảnh khó có thể hữu ích, nhưng chưa đủ bằng chứng để đặt ngưỡng cho app.

### 12. Quyết định

Giữ I2 làm ứng viên hiện tại và C2 làm mốc đối chiếu. Đóng việc tìm kiến trúc. Tiếp theo đo độ không chắc chắn theo nhóm phụ thuộc và xem một tập lỗi cố định. Model thắng vẫn chưa được khóa ở cuối cổng calibration.

### 13. Bài học của senior

Câu hỏi khi dùng thật là “model hỏng thế nào và ta tin mức tự tin của nó tới đâu?”, không chỉ là “score bao nhiêu?”. Một model thắng tương đối vẫn có thể không an toàn dưới một thay đổi ảnh cụ thể.

### 14. Hiểu lầm hay gặp

- Hai seed không phải bằng chứng thống kê cho mọi lần khởi tạo.
- Nhóm cắt có ít mẫu không có sức nặng bằng nhóm có 8,000 dòng.
- Metadata dùng để tạo nhóm chẩn đoán không phải đặc trưng được đưa vào inference.
- Điểm trên ảnh gây nhiễu nhân tạo không cho biết loại lỗi đó phổ biến bao nhiêu ngoài thực tế.
- Temperature scaling đổi độ tự tin, không đổi nhãn có logit lớn nhất.
- Đường risk–coverage không tự tạo ra ngưỡng nghiệp vụ cho app.

### 15. Câu hỏi tự luyện

<details>
<summary><strong>Nhớ lại 1:</strong> Seed stability đã thay field nào?</summary>

**Gợi ý trả lời**

- Chỉ seed 2753 thành 2026 cho retained C2 và I2; model/data/transform/loss/optimizer/budget giữ nguyên.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

<details>
<summary><strong>Nhớ lại 2:</strong> Support của slice nghĩa là gì?</summary>

**Gợi ý trả lời**

- Số OOF rows thuộc slice; support nhỏ làm metric biến động mạnh và conclusion yếu.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

<details>
<summary><strong>Nhớ lại 3:</strong> Temperature scaling làm gì với logits?</summary>

**Gợi ý trả lời**

- Chia logits cho scalar T>0 trước softmax; argmax trong một row không đổi.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

<details>
<summary><strong>Vì sao 4:</strong> Vì sao hai seeds support ordering nhưng không prove stability phổ quát?</summary>

**Gợi ý trả lời**

- Hai random starts chỉ lấy hai điểm trong distribution; I2 drift −0.007944 và hai folds seed 2026 đảo chiều.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

<details>
<summary><strong>Vì sao 5:</strong> Vì sao brightness 0.85 là strongest limitation?</summary>

**Gợi ý trả lời**

- I2 macro-F1 rơi 0.752687→0.363961 và Spring recall còn 0.003010; mild darkening phá model nặng.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

<details>
<summary><strong>Vì sao 6:</strong> Vì sao không freeze app threshold ở 20% review?</summary>

**Gợi ý trả lời**

- Risk–coverage chỉ diagnostic; chưa có business cost để chọn trade-off coverage/error.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

<details>
<summary><strong>Lần theo code 7:</strong> Cross-fitted temperature tránh optimistic calibration thế nào?</summary>

**Gợi ý trả lời**

- Mỗi fold’s temperature fit trên OOF rows của four other folds rồi apply held-out fold; row không fit chính temperature dùng cho nó.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

<details>
<summary><strong>Lần theo code 8:</strong> Year/file size slice được tạo lúc nào?</summary>

**Gợi ý trả lời**

- Sau khi image-only OOF prediction đã có; metadata chỉ join để group metrics, không vào model input.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

<details>
<summary><strong>Tìm lỗi 9:</strong> Nếu robustness clean path khác normal OOF inference, lỗi gì?</summary>

**Gợi ý trả lời**

- Perturbation delta có pipeline confound; regression buộc clean probe tái tạo frozen probabilities.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

<details>
<summary><strong>Tìm lỗi 10:</strong> Nếu latency cache không hash source image bytes, rủi ro gì?</summary>

**Gợi ý trả lời**

- Probe có thể reuse measurement cho input đã đổi; stale cache regression phải fail.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

<details>
<summary><strong>Bảo vệ miệng 11:</strong> I2 tốt hơn mọi stress condition có nghĩa robust không?</summary>

**Gợi ý trả lời**

- Không. Nó tốt hơn C2 tương đối, nhưng cả hai rất yếu dưới brightness 0.85; absolute failure vẫn quan trọng.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

<details>
<summary><strong>Bảo vệ miệng 12:</strong> Calibration tốt hơn có đổi accuracy không?</summary>

**Gợi ý trả lời**

- Scalar temperature giữ argmax nên accuracy/macro-F1 không đổi; NLL/Brier/ECE được cải thiện.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g5_* và g6_shortcut_error_slices.json, g6_robustness_cost.json, g6_cross_fitted_calibration.json
- Code: src/fashion/task2/stability.py, slices.py, robustness.py, calibration.py; src/fashion/train/metrics.py
- Test: tests/task2/test_stability_*, test_slices.py, test_robustness.py, test_calibration.py
- Run/artifact: results/evidence/task2/seed_stability/, shortcut_error_slices/, robustness_cost/, calibration/
- Commit: dải 1341254... → b845414...
- Limitation: Hai seeds, synthetic perturbations, development OOF và machine-specific latency không bao phủ production.

</details>

### 16. Checklist trước khi đi tiếp

- [ ] Tôi giải thích seed drift và limitation hai seeds.
- [ ] Tôi luôn đọc slice cùng support.
- [ ] Tôi phân biệt relative robustness và absolute failure.
- [ ] Tôi giải thích bytes, MiB, RAM, VRAM và latency protocol.
- [ ] Tôi trace cross-fitted calibration và risk–coverage.

### 17. Bước tiếp theo

Next: [Bootstrap, Grad-CAM và Ultimate Judgement](08_BOOTSTRAP_GRADCAM_AND_ULTIMATE_JUDGEMENT.md)
