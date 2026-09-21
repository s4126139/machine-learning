# Phase 08 — Đo độ chắc chắn, xem model nhìn đâu và chốt lựa chọn

### 1. Bạn đang ở đâu?

Thứ hạng ứng viên, các chẩn đoán và calibration đã xong. Commit 237–266, từ <code>97533b5...</code> đến <code>1464f0d...</code>, đo độ không chắc chắn của chênh lệch I2–C2, xem một tập lỗi nặng đã chọn cố định, rồi áp dụng bảng luật đã khóa để ghi lựa chọn cuối trên development data.

> **Đọc mã trước khi đọc số:** `G6` là cổng chẩn đoán và đo độ không chắc chắn; `G7` là cổng chọn model cuối trước khi mở holdout. `C2` là ResNet18 small-stem học từ đầu. `I2` là SmallCNN học đồng thời Season và ArticleType, nhưng lúc dự đoán chỉ nhận ảnh. `P0` là ảnh 80×60; `A0` là bộ biến đổi ảnh nhẹ không colour jitter. `Seed 2753` và `seed 2026` là hai lần bắt đầu ngẫu nhiên. `Δ` trong phase này luôn là `macro-F1(I2) − macro-F1(C2)` tại cùng seed.

**Ultimate Judgement** không phải tên một metric. Nó là **bản ghi quyết định cuối**: gom các bằng chứng đã khai báo, kiểm tra từng luật đạt/rớt, ghi model được chọn, model bị loại và giới hạn còn lại. Bản ghi được khóa trước holdout để kết quả holdout không thể quay ngược lại thay lý do chọn model.

**Bootstrap trong phase này không train lại model.** Code chỉ lấy lại các dự đoán OOF đã có, lấy mẫu lại các nhóm sản phẩm 10,000 lần và tính lại metric. Vì vậy “10,000 bootstrap lần” không có nghĩa “train 10,000 model”.

### 2. Vì sao cần phase này?

Các ảnh cùng họ sản phẩm có thể rất giống nhau, nên không thể giả sử mọi hàng độc lập. Ta phải lấy mẫu lại theo cả nhóm khi đo độ không chắc chắn. Bảng metric gộp cũng không cho thấy model tập trung vào vùng nào của ảnh, nên cần một tập Grad-CAM cố định để xem lỗi. Cuối cùng, model phải qua nhiều luật an toàn; không được chọn chỉ vì có một điểm cao nhất.

### 3. Nối với EDA

- Ảnh cùng họ sản phẩm có thể phụ thuộc nhau → bootstrap theo nhóm và dùng cùng mẫu cho C2/I2.
- Nguy cơ model học đường tắt → gắn loại lỗi và xem Grad-CAM trong ngữ cảnh ảnh.
- Spring ít mẫu và dễ mơ hồ → lấy số ví dụ đúng/sai cân bằng theo nhãn thật.
- Bằng chứng chi phí, sức chịu ảnh và calibration → đưa vào bảng luật G7.
- **Kết quả thật:** khoảng macro-F1 của cả hai cặp đã train nằm trên 0; các heatmap cố định hợp lệ; I2 qua sáu kiểm tra trực tiếp.
- **Giới hạn:** nhóm family chỉ là cách gần đúng thận trọng; heatmap không chứng minh nguyên nhân; holdout vẫn chưa được dùng.

### 4. Từ cần hiểu trước khi đọc code

**Bootstrap** là cách tạo nhiều mẫu giả lập bằng cách lấy lại các đơn vị đã quan sát, **có hoàn lại**. “Có hoàn lại” nghĩa một nhóm có thể được chọn nhiều lần, còn nhóm khác có thể không xuất hiện trong một lượt. Vì các ảnh trong cùng family có thể phụ thuộc, đơn vị được lấy là cả <code>product_family_group</code>, không phải từng hàng ảnh.

**Grouped** nghĩa lấy cả nhóm. **Paired** nghĩa trong mỗi lượt bootstrap, C2 và I2 được tính trên đúng cùng các nhóm với đúng cùng số lần lặp. Nhờ vậy, Δ chủ yếu phản ánh khác biệt giữa hai model thay vì khác biệt do hai mẫu ngẫu nhiên khác nhau.

**OOF (out-of-fold) prediction** là dự đoán cho một ảnh bởi model không dùng ảnh đó để train. Bootstrap ở đây chỉ dùng các OOF prediction đã lưu. **Replicate** là một lượt lấy mẫu lại và tính metric, không phải một lần train.

Với lượt \(b\), \(\Delta_b=F1_{I2,b}-F1_{C2,b}\). Sau 10,000 lượt, mốc 2.5% và 97.5% của 10,000 giá trị Δ tạo **khoảng tin cậy 95% (95% confidence interval, CI)**. Khoảng này mô tả độ dao động khi lấy lại các nhóm từ đúng bộ dự đoán đã train. Nó không bao phủ mọi seed, mọi dữ liệu tương lai hay holdout.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** có ba family `A`, `B`, `C`. Một lượt bootstrap có thể lấy `A, A, C`; khi đó toàn bộ ảnh của A được tính hai lần, toàn bộ ảnh của C tính một lần, còn B không được tính. C2 và I2 đều dùng đúng mẫu `A, A, C`. Nếu lượt đó C2 macro-F1 = 0.70 và I2 = 0.73 thì Δ = `0.73 − 0.70 = +0.03`. Lặp lại cách **tính metric** này nhiều lần để xem Δ dao động; model không học lại.

**Gần hòa trong thực tế (practical tie):** chỉ khi độ lớn chênh lệch nhỏ hơn 0.005 và CI chứa 0 thì mới mở luật phụ xét chi phí. CI trả lời “dấu của chênh lệch có ổn định dưới cách lấy mẫu nhóm này không?”. Ngưỡng 0.005 trả lời “chênh lệch có đủ lớn để đáng quan tâm không?”. Đây là hai câu khác nhau.

**Grad-CAM:** tạo bản đồ nhiệt để chỉ ra vùng đặc trưng nào đang đẩy logit của lớp dự đoán lên. Công thức dự án dùng là:
\[
\alpha_k^c=\frac{1}{Z}\sum_{i,j}\frac{\partial y^c}{\partial A_{ij}^k},
\quad
L^c=\operatorname{ReLU}\left(\sum_k\alpha_k^cA^k\right).
\]
\(A^k\) là kênh thứ k của bản đồ đặc trưng; \(y^c\) là logit của lớp c; \(Z\) là số ô không gian. ReLU chỉ giữ ảnh hưởng dương.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** với một dự đoán Summer, heatmap có thể sáng ở phần vải hoặc nền. Ta chỉ được nói model **nhạy với** vùng đó trong ví dụ này. Không được nói vùng đó “gây ra” dự đoán, và cũng không được suy ra tỷ lệ lỗi của toàn bộ dữ liệu.

**Bảng phân loại lỗi (failure taxonomy)** gắn nhãn chẩn đoán từ metadata sau khi model đã dự đoán. Số đếm trong tập lỗi nặng được chọn có chủ ý không phải tỷ lệ lỗi của toàn bộ dữ liệu.

**Kết quả thật của dự án:** ở seed 2753, Δ quan sát được là +0.017651 với CI [+0.013050, +0.022453]. Ở seed 2026, Δ là +0.011607 với CI [+0.005793, +0.017341]. Cả hai CI tổng thể đều không chứa 0.

**Quy tắc quyết định đã khóa trước:** I2 phải dẫn C2 ở seed chính và seed lặp lại; hai CI tổng thể phải trên 0; guard conflict, JPEG và mọi stress comparison phải đạt. Nếu luật trực tiếp đạt thì không dùng tie-break chi phí. Grad-CAM chỉ dùng để xem lỗi, không chọn winner.

### 5. Tài liệu cần mở lúc này

**Cluster bootstrap**

- Vì sao đọc lúc này: OOF rows có family dependence.
- Phần/trang cần đọc: abstract; pp. 369–376 clustered setup/bootstrap; conclusion.
- Ý chính cần lấy: resample whole clusters khi within-cluster observations phụ thuộc.
- Phần có thể bỏ qua lúc này: asymptotic proofs.
- Liên hệ với repository: <code>paired_group_bootstrap</code> dùng same group multiplicities.
- Liên kết trực tiếp: [Field & Welsh, 2007 — Bootstrapping Clustered Data](https://doi.org/10.1111/j.1467-9868.2007.00593.x).
- **Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** nếu một family có hai ảnh của cùng chiếc áo và family đó được lấy hai lần, cả hai ảnh được tính hai lần cho C2 lẫn I2. Không được lấy riêng từng ảnh vì như vậy sẽ giả vờ chúng độc lập.
- Khác biệt/giới hạn: product family là repo proxy; percentile CI không causal và không bao phủ mọi random seed.

**Grad-CAM**

- Vì sao đọc lúc này: trước fixed visual failure review.
- Phần/trang cần đọc: §3 pp. 620–622, equations và Figure 2.
- Ý chính cần lấy: class-gradient-weighted final conv maps.
- Phần có thể bỏ qua lúc này: VQA experiments.
- Liên hệ với repository: predicted Season logit, declared target layer, ReLU, bilinear upsample, [0,1] normalize.
- Liên kết trực tiếp: [Selvaraju et al., 2017 — Grad-CAM](https://doi.org/10.1109/ICCV.2017.74).
- Dự án không tuyên bố: highlighted pixels caused prediction, complete feature importance, or error prevalence.

**Saliency sanity limits**

- Vì sao đọc lúc này: tránh đọc heatmap như causal truth.
- Phần/trang cần đọc: §3 randomization sanity checks và experiments.
- Ý chính cần lấy: explanation method phải phụ thuộc learned model/data.
- Phần có thể bỏ qua lúc này: every method comparison.
- Liên hệ với repository: repo không chạy full model/data randomization suite.
- Liên kết trực tiếp: [Adebayo et al., 2018 — Sanity Checks for Saliency Maps](https://papers.nips.cc/paper/2018/hash/294a8ed24b1ad22ec2e7efea049b8737-Abstract.html).

### 6. Thứ tự đọc code

1. Bootstrap/Grad-CAM/G7 configs.
2. <code>paired_group_bootstrap</code> validation và loop.
3. Bootstrap evidence builder/decision.
4. <code>gradcam.py</code> target layer, hooks, selection, heatmap.
5. Failure taxonomy/evidence.
6. <code>ultimate_judgement.py</code> load/verify six gates và immutable write.
7. Tests.
8. Interval/heatmap/scorecard/decision/freeze artifacts.
9. Notebook ultimate consumer.

### 7. Đi xuyên qua cách chạy

Bootstrap kiểm tra 32,753 ID và 22,885 nhóm. Nó lấy chỉ số nhóm có hoàn lại. Nhóm được chọn hai lần sẽ đưa toàn bộ hàng vào hai lần. Cùng trọng số đó được áp cho dự đoán của cả hai ứng viên.

Tập Grad-CAM dùng confidence OOF đã calibration theo cross-fit. Với mỗi model và mỗi trong bốn lớp thật, code lấy 3 dự đoán đúng có confidence cao nhất và 3 dự đoán sai có confidence cao nhất. Vì vậy mỗi model có 12 lượt xem đúng + 12 lượt xem sai = 24 lượt xem; hai model có 48 `model–row views`, tương ứng 44 ảnh khác nhau vì một ảnh có thể được xem cho cả hai model. Hooks được gỡ sau mỗi lần dùng; sai số đối chiếu xác suất thô phải không quá 0.0001.

G7 nạp manifest, hash và các trường quyết định đã có; nó không tính lại dự đoán của model. G7 dừng nếu thấy metric holdout, ứng viên pretrained, nội dung freeze bị đổi hoặc thiếu một điều kiện bảo vệ.

~~~mermaid
flowchart TD
    A[I2 dẫn primary seed?] -->|yes| B[I2 dẫn seed 2026?]
    B -->|yes| C[Hai grouped CI trên 0?]
    C -->|yes| D[Conflict và JPEG guards pass?]
    D -->|yes| E[I2 trên C2 ở mọi declared stress?]
    E -->|yes| F[Direct rule: select I2]
    A -->|no| G[Không select trực tiếp]
    B -->|no| G
    C -->|no| H{gap < 0.005 và CI chứa 0?}
    H -->|yes| I[Cost tie-break có safety guard]
    H -->|no| G
~~~

### 8. Test và các luật được bảo vệ

- Bootstrap: identity, group coverage, paired weights, reproducibility, config/stability ID drift (<code>5443c91→63ddc4f</code>).
- Grad-CAM: target layer, deterministic selection, probability reconciliation, empty map, no protected IDs.
- Luật của Notebook từ chối kết quả nếu thiếu nhóm cắt hoặc sai cột của bảng phân loại lỗi.
- Quyết định cuối kiểm đủ sáu điều kiện, chỉ cho phép ghi lại nội dung bất biến giống hệt, cấm holdout và ứng viên benchmark; cặp <code>d5b50af→58afe78</code> sửa việc vẽ nhóm cắt khi không có màn hình.

### 9. Câu chuyện thay đổi theo commit

- 237–243: declare/bootstrap implementation/config identity fix/analysis/evidence/measured uncertainty.
- 244–247: deterministic Grad-CAM analysis/evidence; failure and literature limits.
- 248–256: notebook measured-results integration. Tests first expose missing ArticleType slice, empty image-mode slice và taxonomy mismatch; docs only integrate after contracts.
- 257–266: declare G7; write immutable freeze; record judgement; fix interactive slice plot; add notebook/evidence-boundary tests and final frozen record.

### 10. Bằng chứng và số đo thật

**Bootstrap macro-F1**

**Cách đọc bảng:** `Seed của cặp I2–C2` cho biết hai model nào được so trong cùng lần bắt đầu ngẫu nhiên. `Chênh lệch thật I2 − C2` là pooled OOF macro-F1 của I2 trừ C2; dương nghĩa I2 cao hơn. `Khoảng tin cậy 95%` được tạo từ 10,000 lượt lấy lại cùng nhóm cho cả hai model; đây không phải 10,000 lần train. `Có chứa 0 không?` trả lời liệu khoảng còn cho phép hai model hòa hoặc đảo chiều; “không” hỗ trợ chiều I2 > C2 cho cặp đã train.

| Seed của cặp I2–C2 | Chênh lệch thật I2 − C2 | Khoảng tin cậy 95% từ paired grouped bootstrap | Có chứa 0 không? |
|---|---:|---:|---|
| seed 2753 | +0.017651 | [+0.013050, +0.022453] | không |
| seed 2026 | +0.011607 | [+0.005793, +0.017341] | không |

Khoảng theo từng lớp kém chắc hơn. Với seed 2026, CI Spring [−0.007213,+0.019608] chứa 0 dù CI tổng thể không chứa 0. Vì vậy không được nói I2 chắc chắn hơn C2 ở mọi lớp.

**Grad-CAM**

Mỗi model có 24 lượt xem: 12 đúng và 12 sai. Hai model tạo 48 lượt xem trên 44 ảnh khác nhau. `Zero heatmap` là bản đồ nhiệt toàn giá trị 0, không chỉ ra được vùng nào; số lượng là 0. `Attention flag` là cờ theo luật đã khai báo khi vùng sáng tập trung bất thường vào viền/nền; số lượng là 0 trong tập cố định này, nhưng không chứng minh toàn bộ dữ liệu không có shortcut. `Reconciliation error` là độ lệch giữa xác suất dùng để chọn hàng và xác suất tính lại khi dựng heatmap; lớn nhất 0.000077, dưới tolerance 0.0001. Trong **12 lượt xem sai của mỗi model**, C2 có 6 tag shortcut-conflict + 6 tag weak-proxy; I2 có 9 + 3. Tổng cộng là 24 lượt xem sai đã chọn, không phải tỷ lệ lỗi của quần thể. Manifest SHA-256 <code>3dd2893d7d38f3dd25833e7895ab8910ba85119f16f1245a060b98b09d57df25</code>.

**G7**

I2 dẫn ở seed chính và seed lặp lại, qua cả hai khoảng tin cậy, guard conflict, guard JPEG và so sánh ở mọi stress đã khai báo. Luật phụ về chi phí không được dùng. Giới hạn mạnh nhất là Spring recall chỉ còn 0.003010 ở brightness 0.85. Freeze SHA-256 <code>51475a6e83c3e49e904633e1fa8a7e86bcc5e2f592c81f981561dac9f7cff995</code>; G7 manifest SHA-256 <code>cd87705b94219bd07bebb720fb4bd3736b4442afe6f1316c046b4cd98c960ab0</code>.

### 11. Cách hiểu kết quả

Cả hai CI tổng thể hỗ trợ chiều I2 cao hơn C2 cho hai cặp model đã train. CI Spring ở seed 2026 chứa 0, nên không được mở rộng thành kết luận đúng cho mọi lớp. Grad-CAM không tìm thấy cờ viền/nền theo luật đã khai báo trong tập cố định, nhưng không chứng minh nguyên nhân. G7 chọn bằng nhiều bằng chứng cùng hướng, không dựa vào một điểm cao nhất.

### 12. Quyết định

Khóa I2 với `λ_aux = 0.3`: SmallCNN multi-task học từ đầu, lúc dự đoán chỉ nhận ảnh, dùng P0/A0, seed 2753, luật refit 24 epoch và `T=1.3650016` làm metadata confidence của bundle. Holdout vẫn được giữ kín.

### 13. Bài học của senior

Ultimate Judgement là bản ghi quyết định có đầu vào, luật bảo vệ, lựa chọn bị loại và giới hạn. Nó phải **bất biến (immutable)**: chỉ chấp nhận ghi lại đúng cùng nội dung, không được sửa sau khi xem holdout. Nhờ vậy, kết quả tương lai không thể quay lại đổi lý do ban đầu.

### 14. Hiểu lầm hay gặp

- CI trên 0 không chứng minh I2 thắng ở mọi seed.
- Ngưỡng gần hòa trong thực tế không phải p-value.
- Nhóm family là cách gần đúng, không phải SKU đã được xác minh.
- Màu trên Grad-CAM không phải xác suất.
- Không có attention flag trong tập cố định không chứng minh model không dùng đường tắt.
- Freeze là quyết định trước holdout, không phải đánh giá cuối trên holdout.

### 15. Câu hỏi tự luyện

<details>
<summary><strong>Nhớ lại 1:</strong> Paired grouped bootstrap resample unit là gì?</summary>

**Gợi ý trả lời**

- Toàn bộ product_family_group với replacement; cùng group multiplicities dùng cho C2 và I2.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

<details>
<summary><strong>Nhớ lại 2:</strong> 95% interval seed 2753 là gì?</summary>

**Gợi ý trả lời**

- I2−C2 macro-F1 observed +0.017651; percentile CI [+0.013050,+0.022453].
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

<details>
<summary><strong>Nhớ lại 3:</strong> Grad-CAM heatmap được tạo từ gì?</summary>

**Gợi ý trả lời**

- Gradient của predicted-class logit theo last conv feature maps; channel weights là spatial mean gradients; weighted sum + ReLU.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

<details>
<summary><strong>Vì sao 4:</strong> Vì sao row-wise bootstrap sai ở đây?</summary>

**Gợi ý trả lời**

- Rows cùng product family có thể phụ thuộc; resample độc lập giả tạo effective sample size lớn và interval quá tự tin.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

<details>
<summary><strong>Vì sao 5:</strong> Vì sao Grad-CAM không dùng để chọn winner?</summary>

**Gợi ý trả lời**

- Nó post-hoc, fixed high-confidence sample và non-causal; population metrics/guards đã đóng selection inputs.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

<details>
<summary><strong>Vì sao 6:</strong> Vì sao cost tie-break không dùng?</summary>

**Gợi ý trả lời**

- Direct rule đã pass: I2 dẫn cả seeds, both intervals >0 và guards pass; near-tie branch không trigger.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

<details>
<summary><strong>Lần theo code 7:</strong> Trace một bootstrap replicate.</summary>

**Gợi ý trả lời**

- Sample 22,885 group indices with replacement → expand rows theo multiplicity → compute C2/I2 metrics trên same weighted rows → store delta.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

<details>
<summary><strong>Lần theo code 8:</strong> Trace một Grad-CAM map.</summary>

**Gợi ý trả lời**

- register hooks last conv → forward image → predicted logit backward → average gradients per channel → weighted ReLU → bilinear upsample/normalize.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

<details>
<summary><strong>Tìm lỗi 9:</strong> Nếu bootstrap dùng khác draw cho hai models, chuyện gì xảy ra?</summary>

**Gợi ý trả lời**

- Paired structure mất; delta chứa sampling mismatch và variance tăng/sai interpretation.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

<details>
<summary><strong>Tìm lỗi 10:</strong> Nếu heatmap toàn zero, pipeline làm gì?</summary>

**Gợi ý trả lời**

- Ghi zero/invalid audit và fail declared count/tolerance; không im lặng thay example.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

<details>
<summary><strong>Bảo vệ miệng 11:</strong> CI không chứa zero cho phép claim gì?</summary>

**Gợi ý trả lời**

- Cluster resampling supports positive I2−C2 difference cho từng fitted development OOF pair; không phải all-seed/holdout proof.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

<details>
<summary><strong>Bảo vệ miệng 12:</strong> Nói một câu bảo vệ Ultimate Judgement.</summary>

**Gợi ý trả lời**

- I2 được chọn bởi six predeclared checks across quality, stability, grouped uncertainty, shortcut/JPEG, robustness; cost chỉ củng cố chứ không cứu score.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g6_paired_group_bootstrap.json, g6_gradcam_failure_review.json, g7_ultimate_judgement.json
- Code: src/fashion/train/metrics.py; src/fashion/task2/bootstrap.py, gradcam.py, ultimate_judgement.py
- Test: tests/task2/test_bootstrap.py, test_gradcam.py, test_ultimate_judgement.py
- Run/artifact: results/evidence/task2/paired_bootstrap/, gradcam_failure_review/, ultimate_judgement/, selection_freeze.json
- Commit: dải 97533b5... → 1464f0d...
- Limitation: Intervals condition on fitted pairs/groups; Grad-CAM is non-causal; G7 uses development evidence only.

</details>

### 16. Checklist trước khi đi tiếp

- [ ] Tôi giải thích paired group resampling bằng pseudocode.
- [ ] Tôi đọc đúng CI và class-specific caveat.
- [ ] Tôi viết được Grad-CAM equations và giới hạn.
- [ ] Tôi kể six G7 checks.
- [ ] Tôi biết vì sao cost tie-break không dùng.

### 17. Bước tiếp theo

Next: [Freeze, refit, inference và handoff](09_FREEZE_REFIT_INFERENCE_AND_HANDOFF.md)
