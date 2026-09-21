# Phase 03 — Hai mốc so sánh B0 và B1

### 1. Bạn đang ở đâu?

Pipeline đã có luật. Phase này là hai commit liên tục 025–026: <code>c83f06f...</code> và <code>cacd68a...</code>. Ta tạo hai mốc so sánh (baseline) trước deep learning.

- `B0` là **Baseline 0**: không đọc ảnh, chỉ luôn đoán lớp đông nhất trong training fold.
- `B1` là **Baseline 1**: đọc hình dáng bằng HOG, đọc màu bằng HSV, rồi dùng LinearSVC để chọn Season.

Baseline không có nghĩa là “model làm qua loa”. Nó là mốc bắt buộc để biết model phức tạp có thật sự tạo thêm giá trị hay không.

### 2. Vì sao cần phase này?

Không có B0, ta không biết accuracy có bị mất cân bằng lớp đánh lừa. Không có B1, ta không biết CNN tự học đặc trưng thật sự vượt một cách đọc ảnh cổ điển hay chỉ vượt cách đoán lớp đông nhất.

### 3. Nối EDA với hai baseline

- **Quan sát:** Summer gần nửa dữ liệu; Spring chỉ 4.06%; hình dáng và màu có vẻ liên quan Season.
- **Giả thuyết 1:** đoán lớp đông nhất có accuracy cao nhưng macro-F1 thấp.
- **Phép thử 1:** B0 tìm lớp xuất hiện nhiều nhất riêng trong từng training fold.
- **Kết quả 1:** accuracy 0.495680, macro-F1 0.165704, Spring F1 bằng 0.
- **Giả thuyết 2:** cạnh và phân bố màu chứa tín hiệu thị giác.
- **Phép thử 2:** HOG + HSV + LinearSVC sau khi chuẩn hóa đặc trưng.
- **Kết quả 2:** macro-F1 0.609561, Spring F1 0.486901.
- **Kết luận:** giả thuyết về metric và tín hiệu hình dáng/màu đều được ủng hộ.
- **Giới hạn:** B1 chưa tách riêng HOG khỏi HSV và không tạo xác suất đã hiệu chỉnh.

### 4. Từ cần hiểu trước khi đọc code

**B0 dự đoán lớp đông nhất** chọn lớp có số lượng lớn nhất trong training fold. **Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** nếu train có Fall 27, Spring 4, Summer 50, Winter 19 thì B0 luôn dự đoán Summer. Accuracy có thể là 50%, nhưng ba lớp còn lại không bao giờ được tìm thấy.

**HOG** là biểu đồ hướng gradient (Histogram of Oriented Gradients). Nó tóm tắt hướng của các cạnh thay vì dùng trực tiếp từng pixel. Mỗi ô nhỏ (cell) gom hướng cạnh vào các ngăn (bin); chuẩn hóa theo block giảm ảnh hưởng độ sáng; vector cuối giữ hình dáng và đường viền thô.

Ý chính: với gradient \(g_x,g_y\), độ mạnh \(m=\sqrt{g_x^2+g_y^2}\), hướng \(\theta=\operatorname{atan2}(g_y,g_x)\). **Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** áo có nhiều cạnh dọc sẽ bỏ nhiều phiếu vào bin gần 90°; điều đó không có nghĩa “cạnh dọc = Winter”.

**HSV histogram** đếm phân bố sắc màu (Hue), độ đậm màu (Saturation) và độ sáng (Value) trên pixel thật. Nó bỏ vị trí không gian, nên cùng một áo xanh nằm ở góc khác vẫn có histogram gần giống nhau. HOG giữ hình dáng cục bộ; HSV bổ sung màu tổng thể.

**LinearSVC** là bộ phân loại tuyến tính dựa trên khoảng cách tới ranh giới. Nó học một phép so “một lớp với tất cả lớp còn lại” (one-vs-rest) cho mỗi Season. Với vector đặc trưng \(x\), điểm lớp \(c\) là \(w_c^\top x+b_c\); `argmax` chọn lớp có điểm lớn nhất. Điểm này không phải xác suất.

**Đã hiệu chỉnh (calibrated)** nghĩa là mức tự tin khớp với tần suất đúng ngoài thực tế. Ví dụ, trong nhiều dự đoán ghi 80% tự tin, khoảng 80% nên đúng. B1 chỉ đổi điểm LinearSVC bằng softmax để giữ đúng schema; không có bằng chứng rằng các số đó đã calibrated.

**Một ảnh đi qua B1**

~~~text
ảnh sản phẩm
  → HOG vector: tóm tắt cạnh và hình dáng
  → HSV vector: tóm tắt phân bố màu
  → nối hai vector
  → StandardScaler: chuẩn hóa từng đặc trưng bằng thống kê của training fold
  → LinearSVC: tạo bốn điểm cho Fall/Spring/Summer/Winter
  → argmax: chọn điểm lớn nhất làm nhãn dự đoán
~~~

Validation chỉ được dùng `transform` và `predict`. Nếu scaler hoặc SVC được fit bằng validation, đó là rò rỉ dữ liệu.

~~~mermaid
flowchart LR
    B0[B0: train-fold majority] -->|image-blind limit| B1[B1: HOG + HSV + LinearSVC]
    B1 -->|fixed handcrafted features| C1[C1: learned SmallCNN]
    C1 --> C2[C2: residual capacity]
    C1 --> C3[C3: mobile efficiency]
    C1 --> AB[Ablation và tuning]
    AB --> I1[I1: class-balanced loss]
    AB --> I2[I2: auxiliary ArticleType]
    I2 --> WIN[stability, diagnostics, winner]
~~~

Mỗi nấc trả lời limitation của nấc trước; không phải danh sách model ngẫu nhiên.

### 5. File và tài liệu cần mở

**Majority strategy**

- **Vì sao đọc lúc này (Why read this now):** hiểu B0 cố ý bỏ qua ảnh.
- **Đọc đúng phần nào (Exact sections/pages):** <code>strategy=most_frequent</code>, <code>predict</code>, <code>predict_proba</code>.
- **Cần lấy ý gì (What idea to extract):** mốc dummy dùng tần suất lớp quan sát trong tập train.
- **Tạm bỏ qua gì (What can be skipped for now):** chiến lược stratified và uniform.
- **Nối với repository (Repository connection):** repo tự triển khai majority riêng từng fold để giữ đúng schema và provenance.
- **Nguồn trực tiếp:** [scikit-learn — DummyClassifier](https://scikit-learn.org/stable/modules/generated/sklearn.dummy.DummyClassifier.html).

**HOG**

- **Vì sao đọc lúc này (Why read this now):** hiểu hàm <code>extract_hog_hsv</code>.
- **Đọc đúng phần nào (Exact sections/pages):** §3 trang 886; §6.1–6.6 trang 889–892.
- **Cần lấy ý gì (What idea to extract):** gradient → bin hướng → cell → block → chuẩn hóa.
- **Tạm bỏ qua gì (What can be skipped for now):** dataset người đi bộ và thí nghiệm cửa sổ dò vật thể.
- **Nối với repository (Repository connection):** <code>classical.py:91–100</code> dùng <code>skimage.feature.hog</code>, rồi nối HSV.
- **Nguồn trực tiếp:** [Dalal & Triggs, 2005 — Histograms of Oriented Gradients for Human Detection](https://doi.org/10.1109/CVPR.2005.177), [scikit-image HOG API](https://scikit-image.org/docs/stable/api/skimage.feature.html#skimage.feature.hog).
- **Ranh giới kết luận:** paper giải bài toán tìm người, không phải Season; repo còn thêm HSV và mask padding. Paper không dự đoán score của repo.

**LinearSVC**

- **Vì sao đọc lúc này (Why read this now):** đã có vector đặc trưng và cần luật chọn nhãn.
- **Đọc đúng phần nào (Exact sections/pages):** tài liệu LinearSVC về constructor; C, loss, dual, class_weight, random_state, max_iter; decision_function; Notes. Với Rifkin & Klautau, đọc Abstract và §1, trang 101–104 để hiểu one-vs-all.
- **Cần lấy ý gì (What idea to extract):** ranh giới tuyến tính và phân loại nhiều lớp one-vs-rest.
- **Tạm bỏ qua gì (What can be skipped for now):** kernel phi tuyến.
- **Nối với repository (Repository connection):** <code>fit_hog_hsv_svm</code> dùng StandardScaler + LinearSVC; <code>_full_decision_scores</code> giữ thứ tự nhãn.
- **Nguồn trực tiếp:** [scikit-learn — LinearSVC](https://scikit-learn.org/stable/modules/generated/sklearn.svm.LinearSVC.html), [Rifkin & Klautau, 2004 — In Defense of One-Vs-All Classification](https://www.jmlr.org/papers/v5/rifkin04a.html).

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** bốn điểm `[0.2, −0.4, 1.1, 0.1]` theo thứ tự Fall, Spring, Summer, Winter sẽ chọn Summer. Softmax của các điểm có tổng bằng 1 nhưng chưa vì thế mà calibrated.

### 6. Thứ tự đọc code

1. Hai JSON config: identity, labels, folds, feature/model settings.
2. <code>run_majority_baseline</code> và validation trong <code>baselines.py</code>.
3. <code>HogHsvSpec</code>, <code>extract_hog_hsv</code>, <code>fit_hog_hsv_svm</code>.
4. Full score mapping và OOF writer.
5. Hai test files.
6. Registry snapshots → pooled metrics → per-class → confusion → manifest.
7. Notebook 03 baseline consumer.

### 7. Đi xuyên qua cách chạy

B0 nhận bảng train và validation. Với mỗi ID validation, nó ghi nhãn thật, nhãn dự đoán không đổi và bốn cột xác suất theo tần suất lớp của train. Luật không được phá: lớp đông nhất phải được tìm riêng trong từng training fold.

B1 nhận ảnh đã giải mã. Đầu ra phần đặc trưng là một vector một chiều. StandardScaler học mean/std của đặc trưng từ train; LinearSVC cũng chỉ fit trên train. Validation chỉ được transform và predict. Lỗi cần chặn gồm ảnh hỏng, thứ tự nhãn sai, thiếu điểm một lớp, đặc trưng NaN/Inf và ID OOF trùng.

~~~text
for fold:
    X_train = HOG_HSV(train images)
    X_valid = HOG_HSV(valid images)
    scaler.fit(X_train)
    svm.fit(scaler.transform(X_train), y_train)
    scores = svm.decision_function(scaler.transform(X_valid))
    write full-order scores and argmax labels
pool five validation outputs; audit IDs; compute metrics
~~~

Sau vòng lặp, năm file validation được ghép thành một tập OOF. Code kiểm tra mỗi development ID hợp lệ xuất hiện đúng một lần, rồi mới tính metric.

### 8. Test và luật được bảo vệ

Test của B0 kiểm tra lớp đông nhất chỉ được tính từ nhãn train, cách phá hòa và thứ tự nhãn luôn cố định, bốn cột xác suất đúng schema, và không có ID được bảo vệ. Test của B1 kiểm tra vector đặc trưng luôn hữu hạn và cùng độ dài, phần đệm bị che đúng, scaler/model chỉ fit trên train, bốn score đi đúng thứ tự lớp, và output được gắn nhãn rõ là <code>uncalibrated_softmax_of_decision_scores</code> — softmax của score chưa được hiệu chỉnh.

### 9. Câu chuyện thay đổi theo thời gian

**Cách đọc bảng:** “#” là thứ tự commit trong curriculum. “Commit” là hash ngắn và tên. Cột cuối đi theo sáu bước: trạng thái trước đó → giả thuyết → thay đổi code → cách kiểm tra → số đo thật → việc tiếp theo. Macro-F1/accuracy càng cao càng tốt; không có phép trừ Δ trong bảng này.

| # | Commit | Before → hypothesis → change → verify → result/next |
|---:|---|---|
| 025 | c83f06f majority | Chưa có lower bound → imbalance sẽ đánh lừa accuracy → thêm fold-fitted B0 + tests → 5-fold OOF → macro-F1 0.165704 → cần visual baseline |
| 026 | cacd68a HOG-HSV SVM | B0 image-blind → shape+colour có signal → thêm HOG/HSV/scaler/LinearSVC + tests → 5-fold OOF → 0.609561 → fixed features vẫn giới hạn, thử CNN |

### 10. Bằng chứng và số đo thật

**Cách đọc bảng:** “Thí nghiệm” là mã B0/B1. “Dải Run ID” từ `f0` đến `f4` nghĩa là năm lần chạy cho năm validation fold, không phải một khoảng thời gian. “Pooled OOF macro-F1” tính F1 từng lớp trên toàn bộ 32,753 dự đoán OOF rồi lấy trung bình; “Accuracy” là tỉ lệ đoán đúng; “Spring F1” chỉ nhìn lớp Spring. Ba metric nằm trên thang 0–1 và càng cao càng tốt. “Artifact” là file JSON chứa số đo được dùng ở bảng.

| Thí nghiệm | Dải Run ID | Pooled OOF macro-F1 | Accuracy | Spring F1 | Artifact nguồn |
|---|---|---:|---:|---:|---|
| B0 | <code>b0-majority-f0-s2753-7c18ce1e2b33</code> → <code>...f4...5caca17b070f</code> | 0.165704 | 0.495680 | 0 | <code>results/evidence/task2/b0_majority/pooled_metrics.json</code> |
| B1 | <code>b1-hog-hsv-svm-f0-s2753-bd4b188deb8a</code> → <code>...f4...9473ae8f8cd2</code> | 0.609561 | 0.657405 | 0.486901 | <code>results/evidence/task2/b1_hog_hsv_svm/pooled_metrics.json</code> |

Mỗi folder có manifest nối tới config, ảnh chụp registry, metric theo fold/lớp và confusion matrix. Population của cả hai đều là 32,753 dòng OOF. Ví dụ 0.609561 tương đương 60.9561% nếu đổi sang phần trăm để trình bày; model selection vẫn dùng số raw.

### 11. Cách hiểu kết quả

B0 cho thấy accuracy gần 50% có thể đi cùng thất bại hoàn toàn trên Spring. B1 tăng mạnh cả macro-F1 và Spring F1, nên pixel có tín hiệu hữu ích. Vì điểm B1 chưa được hiệu chỉnh, NLL/Brier/ECE tính từ softmax của margin không được dùng để kết luận calibration.

### 12. Quyết định

Giữ B0 làm mốc thấp nhất và B1 làm baseline cổ điển nghiêm túc. B1 không phải ứng viên cuối vì đặc trưng HOG/HSV đã được thiết kế cố định; bước tiếp theo để model tự học đặc trưng trực tiếp từ ảnh.

### 13. Bài học của senior

Baseline tốt vừa rẻ vừa có khả năng làm model phức tạp “xấu hổ”. Nếu CNN không vượt B1, phải tìm lỗi trong pipeline hoặc giải thích rõ đổi chác khi dùng thật; không được bỏ B1 khỏi report chỉ vì nó làm kết quả kém đẹp.

### 14. Hiểu lầm hay gặp

- B0 không dùng validation distribution để chọn majority.
- HOG không “nhìn thấy áo”; nó mô tả local gradients.
- HSV histogram không giữ vị trí pixel.
- LinearSVC margin không phải calibrated confidence.
- B1 vượt B0 không chứng minh shortcut-free.
- Macro-F1 0.609561 không đổi khi bảng làm tròn thành 0.610.

### 15. Câu hỏi tự luyện

<details>
<summary><strong>Nhớ lại 1:</strong> B0 học gì từ fold train?</summary>

**Gợi ý trả lời**

- Chỉ class có count lớn nhất trong training fold; không dùng pixel hay metadata.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

<details>
<summary><strong>Nhớ lại 2:</strong> HOG biến ảnh thành gì?</summary>

**Gợi ý trả lời**

- Gradient orientation bins theo cells, normalized qua overlapping blocks, rồi flatten thành fixed vector.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

<details>
<summary><strong>Nhớ lại 3:</strong> Histogram HSV thêm tín hiệu nào?</summary>

**Gợi ý trả lời**

- Phân bố hue, saturation, value của content pixels; padded pixels bị loại.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

<details>
<summary><strong>Vì sao 4:</strong> Vì sao B1 là một baseline nghiêm túc?</summary>

**Gợi ý trả lời**

- Nó dùng shape+colour visual signal, có learned linear boundary và 5-fold OOF; mạnh hơn một guess rule.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

<details>
<summary><strong>Vì sao 5:</strong> Vì sao B0 có accuracy cao nhưng macro-F1 thấp?</summary>

**Gợi ý trả lời**

- Đoán Summer đúng gần nửa rows nhưng Fall/Spring/Winter F1 bằng 0; macro-F1 phạt đều bốn class.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

<details>
<summary><strong>Vì sao 6:</strong> Vì sao không dùng score softmax của B1 để kết luận calibration?</summary>

**Gợi ý trả lời**

- LinearSVC margins không phải logits xác suất; repo softmax chỉ để thống nhất OOF schema và đánh dấu uncalibrated.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

<details>
<summary><strong>Lần theo code 7:</strong> Lần theo B1 từ ảnh tới nhãn.</summary>

**Gợi ý trả lời**

- decode/resize → HOG + masked HSV hist → concatenate → StandardScaler fit train → LinearSVC fit train → decision scores → argmax.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

<details>
<summary><strong>Lần theo code 8:</strong> Lớp đông nhất của một fold phải được tính ở đâu?</summary>

**Gợi ý trả lời**

- Count labels chỉ trên bốn training folds; sau đó dự đoán toàn validation fold.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

<details>
<summary><strong>Tìm lỗi 9:</strong> Nếu histogram HSV tính cả phần đệm trắng, rủi ro gì?</summary>

**Gợi ý trả lời**

- Padding amount liên quan aspect ratio có thể thành signal giả và lấn át colour content.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

<details>
<summary><strong>Tìm lỗi 10:</strong> Nếu LinearSVC thiếu một lớp trong fold train, helper cần làm gì?</summary>

**Gợi ý trả lời**

- Phải map decision score về full label order hoặc fail rõ; không âm thầm đổi probability columns.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

<details>
<summary><strong>Bảo vệ miệng 11:</strong> B1 đạt 0.609561 chứng minh gì?</summary>

**Gợi ý trả lời**

- Trên canonical development OOF, handcrafted shape+colour features chứa Season signal vượt image-blind B0.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

<details>
<summary><strong>Bảo vệ miệng 12:</strong> B1 không chứng minh gì?</summary>

**Gợi ý trả lời**

- Không chứng minh HOG/HSV causal, calibrated, tối ưu, hay sẽ đạt cùng score trên holdout.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/b0_majority.json; configs/task2/b1_hog_hsv_svm.json
- Code: src/fashion/task2/baselines.py; src/fashion/task2/classical.py
- Test: tests/task2/test_majority_baseline.py; tests/task2/test_classical_baseline.py
- Run/artifact: results/evidence/task2/b0_majority/ và b1_hog_hsv_svm/
- Commit: c83f06f... và cacd68a...
- Limitation: B1 decision-score softmax là uncalibrated; HOG paper không chứng minh Season performance.

</details>

### 16. Checklist trước khi đi tiếp

- [ ] Tôi giải thích được B0 accuracy/macro-F1 gap.
- [ ] Tôi trace B1 từ pixels tới LinearSVC decision.
- [ ] Tôi biết vì sao B1 probability không dùng cho calibration claim.
- [ ] Tôi bảo vệ được đường B0 → B1 → CNN.
- [ ] Tôi nêu được evidence path và limitation của mỗi baseline.

### 17. Bước tiếp theo

Next: [Scratch models C1, C2 và C3](04_SCRATCH_MODELS_C1_C2_C3.md)
