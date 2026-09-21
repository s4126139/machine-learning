# Phase 05 — Thử từng thay đổi, chỉnh thông số và đọc đường học

### 1. Bạn đang ở đâu?

C1 và C2 đã qua vòng chọn kiến trúc. Trong commit 086–139, từ <code>c0563fe...</code> đến <code>edea07c...</code>, nhóm chỉ thay **một nhóm thông số mỗi lần**: kích thước ảnh, cách làm biến đổi ảnh, cặp thông số học và số epoch tối đa. Phase kết thúc bằng test cho trường hợp lỗi. Lần chạy G3 đầu tiên vẫn còn vấn đề về nguồn gốc bằng chứng, nên chưa được dùng để kết luận cuối.

> **Đọc mã trước khi đọc số:** `G2` là cổng thử từng thay đổi có kiểm soát; `G3` là cổng chạy các ứng viên với ngân sách đầy đủ. `C1` là SmallCNN học từ đầu; `C2` là ResNet18 small-stem học từ đầu. `P` nói về kích thước ảnh theo thứ tự **height × width (cao × rộng)**: `P0` = 80×60, `P1` = 128×96. `A` nói về biến đổi ảnh lúc train: `A0` là bộ nhẹ không đổi màu; `A1` = A0 cộng colour jitter nhẹ. `T` là cặp learning rate/weight decay: `T0` = 0.0003/0.0001, `T1` = 0.001/0.0001, `T2` = 0.0003/0.001. `I1` và `I2` là hai can thiệp sẽ học ở phase sau. Trong run ID, `f0`…`f4` là năm fold validation; `s2753` là seed 2753.

Một run ID như <code>g2-p1-c2-resnet18-f0-s2753-...</code> đọc từ trái sang phải là: chạy cổng G2, dùng ảnh P1, model C2, fold validation số 0, seed 2753. Phần cuối là mã nhận diện để không nhầm hai lần chạy.

### 2. Vì sao cần phase này?

Điểm của một kiến trúc không cho biết phần nào tạo ra thay đổi. Có thể model tốt hơn vì ảnh lớn hơn, vì cách biến đổi ảnh, vì learning rate, hoặc chỉ vì được train lâu hơn.

**Ablation** trong tài liệu này nghĩa là một phép thử chỉ đổi một yếu tố, còn các yếu tố khác giữ nguyên. **Giả thuyết (hypothesis)** là điều ta nghĩ sẽ xảy ra trước khi chạy. **Gate** là luật đạt/rớt được ghi trước khi xem kết quả. Viết luật trước giúp tránh việc thấy số xong mới đặt luật có lợi cho model mình thích.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** model cũ đạt 0.700 và model dùng ảnh lớn đạt 0.706. Nếu mọi thứ khác giống hệt nhau thì chênh lệch là `0.706 − 0.700 = +0.006`. Nếu luật đã ghi trước yêu cầu ít nhất +0.005, ảnh lớn đạt cổng. Nếu đồng thời đổi cả ảnh, model và số epoch thì +0.006 không còn trả lời được thay đổi nào có ích.

### 3. Nối với EDA

EDA là **khám phá dữ liệu ban đầu** (exploratory data analysis). Các quan sát EDA tạo ra câu hỏi; bảng dưới cho biết từng câu hỏi được biến thành phép thử thế nào.

**Cách đọc bảng:** `Câu hỏi` là điều muốn kiểm tra. `Phần được đổi` là treatment, tức cấu hình mới. `Phần giữ cố định` là các điều kiện phải giống control, tức cấu hình mốc. `Kỳ vọng trước khi chạy` là giả thuyết, không phải kết quả. `Kết quả thật` là chênh lệch macro-F1 của treatment trừ control; macro-F1 càng cao càng tốt, nên Δ dương là tốt và Δ âm là xấu. `Luật và quyết định` so kết quả với ngưỡng đã khóa trước. Runtime là thời gian chạy; nhỏ hơn tốt.

| Câu hỏi | Phần được đổi | Phần giữ cố định | Kỳ vọng trước khi chạy | Kết quả thật | Luật và quyết định |
|---|---|---|---|---|---|
| P1 có giữ được nhiều chi tiết hơn không? | ảnh 80×60 → 128×96, theo cao × rộng | C2, A0, năm fold, seed, 8 epoch | macro-F1 tăng | Δ = −0.001787; runtime = 1.992× | cần Δ ≥ +0.005 → giữ P0 |
| A1 có giảm việc học nhầm màu nền không? | thêm colour jitter, tức đổi nhẹ màu | C2, P0, năm fold, seed, ngân sách | khả năng áp dụng sang ảnh mới tăng | Δ = −0.010438; Fall và Spring giảm | cần Δ ≥ +0.003 và qua robustness guard → giữ A0 |
| Chỉnh thông số có giúp C1 không? | learning rate 0.0003 → 0.001 | mọi phần khác | quá trình học tốt hơn | Δ = +0.008173 | cần Δ ≥ +0.003 → chọn T1 |
| Chỉnh thông số có giúp C2 không? | thử T1 và T2 so với T0 | mọi phần khác | macro-F1 tăng | tốt nhất là T2, Δ = +0.001146 | dưới +0.003 → giữ T0 |
| Train lâu hơn có đổi thứ hạng không? | 8 epoch → tối đa 30 epoch, có patience | các cấu hình đã chọn | đường học đủ dài để ổn định | lần chạy còn cần kiểm tra nguồn gốc | chưa khóa model ở cuối phase |

### 4. Từ cần hiểu trước khi đọc code

**Phép thử có kiểm soát (controlled experiment):** treatment và control phải dùng cùng tập ảnh, fold, seed, code và ngân sách; chỉ trường đang hỏi được phép khác. **Treatment** là cấu hình mới. **Control** là cấu hình mốc. **Delta (Δ)** luôn được tính `treatment − control` từ số chưa làm tròn.

**Ngân sách sàng lọc (screen budget)** là lần train ngắn, rẻ, dùng để loại ứng viên yếu. **Ngân sách đầy đủ (full budget)** cho ứng viên cuối đủ thời gian học. Không được so model chạy 8 epoch với model chạy 30 epoch rồi nói khác biệt chỉ do kiến trúc.

**Đường học (learning curves)** là các đường vẽ giá trị theo từng epoch. Một epoch là một lượt model đi qua toàn bộ tập train:

- `train loss`: mức sai theo hàm loss trên tập train; thấp hơn thường tốt;
- `validation loss`: cùng cách đo sai trên fold validation; thấp hơn tốt khi hai run dùng cùng loại loss;
- `validation accuracy` và `validation macro-F1`: chất lượng dự đoán; cao hơn tốt;
- `best epoch`: epoch có metric chính chưa làm tròn cao nhất;
- `patience`: số epoch được chờ mà không tốt hơn trước khi dừng sớm.

Loss của weighted và unweighted objectives không có cùng scale, nên về sau I1 loss curve không được trừ trực tiếp với C1 loss.

**Ngưỡng ghi trước (predeclared threshold):** +0.005 macro-F1 bằng +0.5 điểm phần trăm. Đây là mức cải thiện tối thiểu để đáng đổi cấu hình. Nó không phải khoảng tin cậy.

**Macro-F1** tính F1 riêng cho Fall, Spring, Summer và Winter rồi lấy trung bình đều. Vì mỗi lớp có một phiếu ngang nhau, lớp Spring ít mẫu vẫn có ảnh hưởng rõ. Giá trị nằm từ 0 đến 1; cao hơn tốt.

**OOF (out-of-fold)** là dự đoán cho một ảnh bởi model không dùng ảnh đó để train. `Pooled OOF` nghĩa nối dự đoán OOF của cả năm fold rồi tính metric một lần trên toàn bộ các hàng.

**Learning rate** là độ dài mỗi bước cập nhật trọng số; quá lớn có thể nhảy qua điểm tốt, quá nhỏ có thể học chậm. **Weight decay** là mức phạt trọng số lớn, dùng để hạn chế model bám quá sát train. **Shortcut** là dấu hiệu dễ học nhưng không bền, ví dụ màu nền. **Guard** là điều kiện bảo vệ phải đạt thêm ngoài điểm chính.

**Kết quả thật của dự án:** P1 và A1 đều làm macro-F1 giảm. T1 cải thiện C1 đủ lớn để qua luật. T2 chỉ cải thiện C2 rất nhỏ nên không qua luật.

**Quy tắc quyết định đã khóa trước:** P1 cần ít nhất +0.005; A1 và tuning cần ít nhất +0.003, cùng các guard được khai báo. Không làm tròn số trước khi so ngưỡng.

### 5. Tài liệu cần mở lúc này

**Pooled CV warning**

- Vì sao đọc lúc này: evidence builder có cả fold mean và pooled OOF.
- Phần/trang cần đọc: warning của <code>cross_val_predict</code> về metric từ concatenated predictions.
- Ý chính cần lấy: pooled metric có weighting theo row và không bắt buộc bằng unweighted fold mean.
- Phần có thể bỏ qua lúc này: estimators không dùng.
- Liên hệ với repository: <code>fashion.train.metrics.multiclass_metrics</code> tính trên concatenated OOF.
- Liên kết trực tiếp: [scikit-learn — cross_val_predict](https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.cross_val_predict.html).

**Metric definitions**

- Vì sao đọc lúc này: đọc curves/gates đúng đơn vị.
- Phần/trang cần đọc: Accuracy; precision/recall/F-measures; confusion matrix; log loss; Brier.
- Ý chính cần lấy: direction, averaging và probability metric scale.
- Phần có thể bỏ qua lúc này: multilabel ranking.
- Liên hệ với repository: explicit four-label order, zero_division=0, ECE 15 equal-width bins.
- Liên kết trực tiếp: [scikit-learn — Metrics and scoring](https://scikit-learn.org/stable/modules/model_evaluation.html), [f1_score](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.f1_score.html).

### 6. Thứ tự đọc code

1. P/A/T/G3 JSON configs; diff fields bằng mắt.
2. Experiment dataclasses và validation.
3. <code>run_or_load</code>; Windows-safe launcher guard.
4. Evidence builder comparison validations.
5. Decision JSON generator.
6. Tests cho each gate và negative paths.
7. Raw pooled/per-class/curve CSV; decision; manifest; figure.
8. Notebook consumer, không chạy.

### 7. Đi xuyên qua cách chạy

~~~text
load control and treatment evidence
verify each source manifest and every artifact hash
assert same valid-ID set, folds, seed, labels and implementation
assert only declared field differs
delta = treatment_raw_macro_f1 - control_raw_macro_f1
apply frozen threshold
write comparison + per-class + decision + manifest atomically
~~~

Khi chạy nhiều tiến trình trên Windows, <code>if __name__ == "__main__":</code> ngăn tiến trình con chạy lại toàn bộ file khởi động. Cơ chế phục hồi run bị bỏ dở phải tách khỏi cache model: một dòng <code>running</code> có tiến trình đã chết được đổi thành <code>interrupted</code>, nhưng tuyệt đối không được coi là run hoàn tất để dùng lại.

### 8. Test và các luật được bảo vệ

Mỗi gate có positive và negative tests: tampered hashes, wrong path, duplicate run identity, unverified screen score, order-dependent tie và missing artifact. Plot regressions cũng có test vì hình sai có thể làm reviewer đọc sai evidence.

~~~mermaid
sequenceDiagram
    participant Test
    participant Bug
    participant Fix
    participant Evidence
    Test->>Bug: tái hiện exact failure và đỏ
    Bug->>Fix: chỉ ra root cause
    Fix->>Test: regression xanh
    Test->>Evidence: rebuild/load từ verified inputs
    Evidence-->>Reviewer: claim có trace
~~~

### 9. Câu chuyện thay đổi theo commit

- 086–100, P0/P1: declaration → orphan <code>running</code> regression/fix (<code>22b94e1→e4ce303</code>) → recovery/cache isolation (<code>e7946eb→f4992e8</code>) → Windows-safe launcher → measured P1 → decision gate → chart regression/fix (<code>358549a→6db73de</code>) → close P0.
- 101–107, A0/A1: declaration → five-fold A1 → audited decision → notebook execution → reject A1.
- 108–118, compact tuning: gate; missing artifact path pair <code>eea0b08→eb9bc3c</code>; compressed curve pair <code>898532d→487e089</code>; measured leaderboard; selection story.
- 119–128, first G3: declare/train/evidence/notebook. Notebook drift pair <code>74dad3d→1704d71</code>. Attempt looked complete but independent review continued.
- 129–139, review hardening: historical coupling <code>2fdb3bc→420cd23</code>; duplicate weighting <code>da6d431→3baaa61</code>; unverified screen score <code>272fd2e→798ba6b</code>; tie order <code>810f523→2a33531</code>; final negative-path isolation test <code>edea07c</code>. Old G3 bytes remain trace, not current selection evidence.

### 10. Bằng chứng và số đo thật

Bằng chứng cho P/A/T đã được kiểm tra và đóng:

- Năm run P1: <code>g2-p1-c2-resnet18-f0-s2753-67217738d381</code> → <code>...f4...9294db7bbaf4</code>; quyết định nằm ở <code>g2_input_size_ablation/decision.json</code>.
- Năm run A1: <code>g2-a1-c2-resnet18-f0-s2753-c4cc0669c376</code> → <code>...f4...170d6fa1d34a</code>.
- C1-T1 đạt 0.708075 so với T0 đạt 0.699902; T1 được chọn.
- C2-T2 đạt 0.708246 so với T0 đạt 0.707099; chênh lệch dưới ngưỡng nên giữ T0.
- Lần chạy full-budget trong đoạn lịch sử này chỉ là dấu vết cũ. Không trích nó làm bằng chứng G3 cuối đã sửa.

### 11. Cách hiểu kết quả

Ảnh lớn hơn không giúp và gần như làm thời gian chạy gấp đôi. Colour jitter mạnh hơn làm kết quả xấu đi; màu có thể vừa là thông tin thật vừa là đường tắt. Chỉnh thông số giúp C1 đủ rõ, nhưng mức tăng rất nhỏ của C2 không đủ qua luật. Việc review cũng cho thấy kết luận khoa học cần đúng nguồn gốc run và artifact, không chỉ cần con số trông hợp lý.

### 12. Quyết định

Giữ cố định P0/A0, C1-T1 và C2-T0. Không mở thêm lưới tuning. Không dùng gói G3 đầu tiên để quyết định; giữ nó làm dấu vết lịch sử và sửa khả năng chạy lại đúng trước can thiệp mới.

### 13. Bài học của senior

Review độc lập sau khi test xanh vẫn tìm ra lỗi về nguồn gốc dữ liệu. Khi bằng chứng không hợp lệ, phải sửa luật và chạy lại sạch; không sửa tay CSV để giữ kết quả mình muốn.

### 14. Hiểu lầm hay gặp

- P1/A1 rớt trong cấu hình đã thử không có nghĩa mọi ảnh lớn hoặc mọi colour jitter đều xấu.
- Điểm cao nhất nhìn thấy không tự động thắng ngưỡng đã ghi trước.
- Trục của hình chỉ để đọc; việc chọn dùng số thô trong artifact.
- Run bị ngắt phải giữ trạng thái để audit, không xóa mất dấu vết.
- Dừng sớm chỉ nhìn validation, không nhìn holdout.
- Lần G3 cũ là lịch sử, không phải bằng chứng hiện tại.

### 15. Câu hỏi tự luyện

<details>
<summary><strong>Nhớ lại 1:</strong> Controlled variable là gì?</summary>

**Gợi ý trả lời**

- Mọi yếu tố giữ cố định để observed delta chủ yếu gắn với đúng intervention đã khai báo.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

<details>
<summary><strong>Nhớ lại 2:</strong> Overfitting nhìn trên curves ra sao?</summary>

**Gợi ý trả lời**

- Train loss tiếp tục giảm trong khi validation loss tăng hoặc validation macro-F1 plateau/giảm.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

<details>
<summary><strong>Nhớ lại 3:</strong> Underfitting nhìn ra sao?</summary>

**Gợi ý trả lời**

- Train và validation đều kém, train loss còn cao; model/budget chưa fit được training pattern.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

<details>
<summary><strong>Vì sao 4:</strong> Vì sao P1 bị loại dù idea giữ detail nghe hợp lý?</summary>

**Gợi ý trả lời**

- Measured delta −0.001787 không đạt +0.005 gate và runtime gần 1.992×; hypothesis bị contradicted trong tested setup.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

<details>
<summary><strong>Vì sao 5:</strong> Vì sao A1 bị loại trước robustness check?</summary>

**Gợi ý trả lời**

- Quality gate đã fail với −0.010438, nên điều kiện AND không thể pass; chạy thêm robustness để cứu là post-hoc.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

<details>
<summary><strong>Vì sao 6:</strong> Vì sao C2-T2 score cao nhất nhưng giữ T0?</summary>

**Gợi ý trả lời**

- Gain chỉ +0.001146, dưới predeclared +0.003; không đổi config vì noise-sized win.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

<details>
<summary><strong>Lần theo code 7:</strong> Evidence builder xác minh comparison trước khi trừ score thế nào?</summary>

**Gợi ý trả lời**

- Nó load manifests/registry/artifacts, kiểm tra hashes, population, folds, seed, implementation và controlled fields rồi tính raw delta.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

<details>
<summary><strong>Lần theo code 8:</strong> Early stopping chọn checkpoint nào?</summary>

**Gợi ý trả lời**

- Epoch có raw validation macro-F1 tốt nhất; patience chỉ quyết định lúc dừng, không biến last epoch thành best.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

<details>
<summary><strong>Tìm lỗi 9:</strong> Process bị kill để lại status running; cách đúng là gì?</summary>

**Gợi ý trả lời**

- Recovery đánh dấu interrupted bằng cơ chế riêng; cache không coi nó completed; rerun dùng run ID mới.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

<details>
<summary><strong>Tìm lỗi 10:</strong> Nếu two curves có y-axis quá rộng, lỗi khoa học hay presentation?</summary>

**Gợi ý trả lời**

- Presentation có thể che delta; fix axis nhưng selection vẫn dùng raw CSV. Không được đổi dữ liệu để làm plot đẹp.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

<details>
<summary><strong>Bảo vệ miệng 11:</strong> Negative result P1/A1 có giá trị gì?</summary>

**Gợi ý trả lời**

- Nó đóng hypotheses đã khai báo, giảm search space và cho thấy quyết định theo gate chứ không cherry-pick.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

<details>
<summary><strong>Bảo vệ miệng 12:</strong> Vì sao initial G3 attempt không được dùng?</summary>

**Gợi ý trả lời**

- Review phát hiện reproducibility/provenance coupling; evidence không thỏa identity contract nên được giữ làm trace, không làm claim.
- Phân biệt mechanism, measured evidence và limitation.
- Nêu được bước kiểm tra bằng code hoặc artifact.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g2_* và g3_c1_t1_smallcnn.json, g3_c2_t0_resnet18.json
- Code: src/fashion/task2/experiments.py và evidence.py; src/fashion/train/recovery.py
- Test: tests/task2/test_g2_*; test_g3_full_budget_evidence.py; tests/train/test_registry.py
- Run/artifact: results/evidence/task2/g2_* và g3_full_budget historical trace
- Commit: dải c0563fe... → edea07c...
- Limitation: G3 ở cuối dải này còn bị review về initialization/provenance; không dùng attempt cũ làm final evidence.

</details>

### 16. Checklist trước khi đi tiếp

- [ ] Tôi nêu 12 câu hỏi chuẩn cho một controlled experiment.
- [ ] Tôi đọc được bốn đường học.
- [ ] Tôi phân biệt screen và full budget.
- [ ] Tôi áp dụng đúng P/A/T thresholds.
- [ ] Tôi giải thích được vì sao invalid evidence phải giữ nhưng không dùng.

### 17. Bước tiếp theo

Next: [I1, I2 và pretrained boundary](06_I1_I2_AND_PRETRAINED_BOUNDARY.md)
