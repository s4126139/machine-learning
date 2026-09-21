# Phase 01 — Assignment và EDA handoff

### 1. Bạn đang ở đâu?

EDA là khám phá dữ liệu (exploratory data analysis): ta đếm, vẽ và tìm vấn đề trước khi train. Task 2 cần biến các quan sát EDA thành câu hỏi có thể kiểm tra, dưới đúng luật assignment. Dải thời gian của phase là commit 001–011: <code>6348d4a...</code> đến <code>f273524...</code>.

Ở phase này, bạn chưa cần hiểu code model. Bạn cần trả lời được: **bài toán là gì, dữ liệu nào được phép dùng, đo bằng gì và khi nào mới được mở holdout?**

### 2. Vì sao cần phase này?

Không có luật giao tiếp rõ (contract), một số điểm đẹp vẫn có thể vô nghĩa. Contract khóa người dùng, đầu vào, đầu ra, đơn vị dự đoán, thứ tự nhãn, cách chia dữ liệu, metric chính, ranh giới train từ đầu và thời điểm được mở holdout.

Assignment yêu cầu phân loại **Season** từ ảnh: mỗi ảnh nhận đúng một nhãn Fall, Spring, Summer hoặc Winter. Model cuối phải train từ đầu (from scratch), nghĩa là weights bắt đầu ngẫu nhiên. Model pretrained chỉ được làm mốc so sánh (benchmark). Rubric thưởng độ rộng của so sánh, lý do chọn model, quyết định cuối (Ultimate Judgement) và phân tích giới hạn; không có ô điểm riêng cho accuracy.

### 3. Nối EDA với thí nghiệm

**Quan sát (observation)** là điều dữ liệu development cho thấy. **Giả thuyết (hypothesis)** là lời đoán có thể bị chứng minh là sai. **Thí nghiệm (experiment)** thay một yếu tố có kiểm soát. **Kết quả (result)** là số đo. **Kết luận (conclusion)** là quyết định hợp lệ trong phạm vi số đo đó. **Giới hạn (limitation)** là phần ta vẫn chưa biết.

Mã cần biết trước khi đọc bảng:

- `B0`: không đọc ảnh, luôn đoán lớp đông nhất trong training fold.
- `B1`: đọc đặc trưng cạnh HOG và màu HSV, rồi phân loại bằng LinearSVC.
- `I1`: tăng trọng số lớp hiếm trong loss.
- `I2`: khi train học thêm ArticleType; khi dự đoán thật vẫn chỉ nhận ảnh.
- `P0`/`P1`: ảnh 80×60 / ảnh phóng lên 128×96.
- `A0`/`A1`: tăng cường ảnh không đổi màu / có thêm đổi màu nhẹ.

**Cách đọc bảng:** “Quan sát EDA” là điều thấy trước khi chạy model. “Giả thuyết” là lời đoán cần kiểm tra. “Phép thử” chỉ cách kiểm tra. “Kết quả đo được” là số thật của dự án. “Kết luận về giả thuyết” dùng bốn mức: **được ủng hộ**, **bị bác bỏ**, **được ủng hộ một phần**, hoặc **chưa rõ**. “Quyết định tiếp theo” nói đội đã làm gì. “Điều chưa biết” chặn việc nói quá bằng chứng. Metric trong bảng nằm trên thang 0–1 và cao hơn là tốt hơn; số âm là mức giảm so với đối chứng được nói trong cùng hàng.

| Quan sát EDA | Giả thuyết | Phép thử theo timeline | Kết quả đo được | Kết luận về giả thuyết | Quyết định tiếp theo | Điều chưa biết |
|---|---|---|---|---|---|---|
| Summer 49.57%, Spring 4.06% | Accuracy sẽ che lỗi ở lớp hiếm | B0 rồi I1 | B0 macro-F1 0.165704; I1 thấp hơn đối chứng 0.036191 | Metric được ủng hộ; I1 bị bác bỏ | Giữ macro-F1, loại I1 | Chưa thử mọi cách xử lý mất cân bằng |
| Hình dáng và màu có vẻ hữu ích | Đặc trưng làm bằng tay thắng cách luôn đoán lớp đông nhất | B1 dùng HOG+HSV | Macro-F1 0.609561 | Được ủng hộ | Đi tiếp tới đặc trưng do model tự học | Chưa tách riêng đóng góp HOG và HSV |
| ArticleType-majority agreement 65.05%; NMI 0.174 | ArticleType có tín hiệu nhưng cũng có thể tạo đường tắt | I2 và lát aligned/conflict | I2 tăng 0.015026; lát conflict tăng 0.027598 | Được ủng hộ một phần | Dùng nhãn phụ khi train, chỉ dùng ảnh khi dự đoán | Không phải bằng chứng nhân quả |
| 2011–2012 chiếm 69.9%; lookup 74.46% | Thời kỳ thu thập dữ liệu có nguy cơ tạo đường tắt | Các lát theo năm | I2 có accuracy cao nhưng macro-F1 thấp hơn ở 2011–2012 | Nguy cơ được ủng hộ | Chỉ dùng năm để phân tích sau dự đoán | Năm không đi vào model |
| Fall có trung vị 2.2 KiB, lớp khác 15–18.1 KiB | Model có thể học dấu vết nén ảnh | Nhóm theo tứ phân vị dung lượng + gây nhiễu JPEG | Có chênh lệch theo nhóm dung lượng; JPEG guard đạt | Được ủng hộ một phần | Giữ kiểm tra gây nhiễu và nêu giới hạn | Dung lượng file không chứng minh cơ chế |
| Các ảnh cùng family/có thể trùng nhau | Chia ngẫu nhiên từng dòng sẽ quá lạc quan | Fold theo nhóm + bootstrap theo nhóm | 0 family đi qua hai phía; bootstrap theo group | Nguy cơ thiết kế được ủng hộ | Không tạo split khác | Group là đại diện bảo thủ, chưa chắc là SKU thật |
| Ảnh greyscale hiếm | Model có thể yếu ở kiểu ảnh hiếm | Lát ảnh xám | Một số lát đổi dấu chênh lệch giữa hai seed | Chưa rõ | Chỉ dùng để chẩn đoán | Số mẫu nhỏ |
| Ảnh gốc 60×80 | Phóng lớn có thể giữ thêm chi tiết | P1 128×96 so với P0 | `P1 − P0 = −0.001787`; runtime bằng 1.992 lần | Bị bác bỏ | Giữ P0 | Chỉ thử một kích thước lớn hơn |
| Đổi màu nhẹ | Có thể giảm việc học đường tắt | A1 so với A0 | `A1 − A0 = −0.010438`; Fall và Spring cùng giảm | Bị bác bỏ | Giữ A0 | Đổi màu cũng có thể phá tín hiệu thật |

### 4. Từ cần hiểu trước khi đọc code

**Phân loại nhiều lớp (multiclass classification)** chọn một trong nhiều lớp. Model xuất bốn **logit**, tức bốn điểm thô chưa phải xác suất. Softmax đổi chúng thành bốn số dương có tổng bằng 1.

Với class \(c\):

- độ chính xác theo dự đoán (precision) = \(TP_c/(TP_c+FP_c)\): trong những dòng đoán là \(c\), bao nhiêu dòng đúng;
- độ bao phủ lớp thật (recall) = \(TP_c/(TP_c+FN_c)\): trong những dòng thật là \(c\), model tìm được bao nhiêu;
- F1 = \(2PR/(P+R)\): trung bình điều hòa của precision và recall; một phía thấp sẽ kéo F1 xuống mạnh;
- macro-F1 = tính F1 riêng cho bốn lớp rồi lấy trung bình không trọng số;
- accuracy = số dòng đoán đúng chia tổng số dòng.

`TP` là đoán đúng lớp đang xét. `FP` là đoán nhầm một dòng khác thành lớp đó. `FN` là bỏ sót một dòng thật thuộc lớp đó.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** bốn nhãn thật là `Spring, Spring, Summer, Fall`; dự đoán là `Spring, Summer, Summer, Summer`. Với Spring: `TP=1`, `FP=0`, `FN=1`; precision = 1, recall = 0.5 và F1 xấp xỉ 0.67. Ví dụ này chỉ để học công thức.

**Ma trận nhầm lẫn (confusion matrix)** ghi lớp thật theo hàng và lớp dự đoán theo cột trong repo. Ô đường chéo là dự đoán đúng. Ô ngoài đường chéo cho biết model nhầm lớp nào sang lớp nào.

**NLL** phạt model khi nó cho xác suất rất nhỏ cho lớp thật; càng thấp càng tốt. **Brier** đo bình phương khoảng cách giữa vector xác suất và đáp án one-hot; càng thấp càng tốt. **ECE** chia độ tự tin thành các nhóm rồi so độ tự tin trung bình với accuracy trong từng nhóm; càng gần 0 thường càng tốt nhưng kết quả phụ thuộc cách chia nhóm.

**Cách chia chính thức (canonical split)** là file <code>data/processed/splits.csv</code> duy nhất. Development dùng năm <code>cv_fold</code>. Mỗi dòng được validation đúng một lần, tạo **dự đoán ngoài fold (out-of-fold prediction, OOF)**. Pooled OOF ghép 32,753 dự đoán rồi tính metric một lần; nó không bắt buộc bằng trung bình của năm metric riêng.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** có 10 sản phẩm và 5 fold, mỗi fold giữ 2 sản phẩm làm validation. Vòng 1 train trên 8 sản phẩm và dự đoán 2 sản phẩm còn lại. Sau 5 vòng, mỗi sản phẩm có đúng một dự đoán từ một model chưa train trên chính nó. Ghép 10 dự đoán đó là pooled OOF.

**Rò rỉ dữ liệu (leakage)** là thông tin đáng lẽ chưa được biết lại chảy vào train hoặc tuning. Thống kê dùng cho một fold chỉ được học từ bốn training fold. Loader che nhãn holdout bằng redaction, tức xóa khỏi dữ liệu mà code bình thường nhìn thấy.

Ký hiệu `Δ` đọc là “delta”, nghĩa là chênh lệch. Luôn hỏi **lấy cái gì trừ cái gì**. Ví dụ `P1 − P0 = −0.001787` nghĩa là macro-F1 của P1 thấp hơn P0 đúng 0.001787. Với macro-F1 và accuracy, cao hơn là tốt hơn; với NLL, Brier, ECE, thấp hơn thường là tốt hơn.

### 5. File và tài liệu cần mở

**Assignment PDF**

- **Vì sao đọc lúc này (Why read this now):** khóa sản phẩm phải nộp và luật chỉ dùng scratch cho model cuối trước khi làm model.
- **Đọc đúng phần nào (Exact sections/pages):** trang 2–6, phần dataset, Task 2, model comparison và final deliverables.
- **Cần lấy ý gì (What idea to extract):** đầu vào là ảnh, đầu ra là Season; bài có bốn task; model cuối phải tự train.
- **Tạm bỏ qua gì (What can be skipped for now):** chi tiết Task 1, 3 và 4 ngoài interface chung.
- **Nối với repository (Repository connection):** <code>docs/COSC2753_2026B_Assignment 2.pdf</code> → <code>configs/task2/</code> và scratch audit.
- **Nguồn:** file local ở đường dẫn trên.

**Rubric**

- **Vì sao đọc lúc này (Why read this now):** biết phần nào thật sự mang điểm học thuật.
- **Đọc đúng phần nào (Exact sections/pages):** <code>rubrics/RUBRIC.md</code>, ba mục Approach, Ultimate Judgement và Report.
- **Cần lấy ý gì (What idea to extract):** cần so sánh đủ rộng, giải thích lựa chọn, đánh giá độc lập và phân tích thất bại trung thực.
- **Tạm bỏ qua gì (What can be skipped for now):** không có phần nào cần bỏ; file ngắn.
- **Nối với repository (Repository connection):** các cổng đã tuyên bố trước và danh sách phương án bị loại.
- **Nguồn:** file local ở đường dẫn trên.

### 6. Thứ tự đọc code

1. <code>configs/task2/README.md</code>: từ vựng và thứ tự chạy.
2. <code>src/fashion/data/dataset.py</code>: <code>load_splits</code>, <code>get_cv_split</code>, <code>iter_cv_folds</code>.
3. <code>results/evidence/task2/eda_handoff.csv</code>: observation đã materialize.
4. Notebook 03, section 1–3: consumer của contract; không cần chạy ở bước đọc này. Nếu chạy toàn notebook, dùng artifact replay đã khóa; không train lại.
5. <code>tests/test_notebook_scaffolds.py</code> và dataset tests: guard structure và protected boundary.

### 7. Đi xuyên qua cách chạy

Mã giả tránh rò rỉ dữ liệu:

~~~text
splits = load_splits()             # protected targets đã redacted
for fold in 0..4:
    train, valid = get_cv_split(splits, fold)
    train = rows có Season label
    valid = rows có Season label
    fit mọi statistic trên train
    predict valid đúng một lần
assert union(valid IDs) == valid development IDs
~~~

<code>load_splits</code> trả một bảng DataFrame. <code>get_cv_split</code> nhận bảng đó và số fold, rồi kiểm tra fold tạo được cả tập train lẫn validation. Luật không được phá (invariant) là cross-validation chỉ dùng development. Các lỗi quan trọng gồm fold không tồn tại, thiếu lớp do lọc sai, ID trùng, hoặc nhãn được bảo vệ xuất hiện.

32,773 development rows có 20 Season trống, nên population đánh giá là 32,753. Năm validation fold có 6,550; 6,551; 6,550; 6,550; 6,552 row.

### 8. Test và luật được bảo vệ

Tests bảo vệ ba tầng:

- static notebook test: leaf section có đúng code/interpretation contract;
- dataset tests: holdout và quarantine targets bị redacted trừ khi explicit final-evaluation unlock;
- OOF evidence tests: mỗi valid development ID xuất hiện đúng một lần, label/probability schema cố định.

Test không chứng minh model generalize. Nó chứng minh pipeline không vi phạm contract mà test mô tả.

### 9. Câu chuyện thay đổi theo thời gian

Commit là một mốc thay đổi trong Git. Chuỗi ngắn như `6348d4a` là hash dùng để tìm đúng commit. Bảng này dành cho lần đọc thứ hai; lần đầu bạn chỉ cần hiểu vấn đề → thay đổi → cách kiểm tra → bài học.

**Cách đọc bảng:** “#” là số thứ tự trong curriculum, không phải mã model. “Commit” gồm hash ngắn và tên thay đổi. Cột cuối đọc từ trái sang phải: trạng thái hoặc vấn đề ban đầu → thay đổi đã làm → cách kiểm tra → bài học. Bảng không có metric model; “đỏ/xanh” nếu xuất hiện nghĩa là test thất bại/test đã đạt.

| # | Commit | Trạng thái/vấn đề → thay đổi → cách kiểm tra → lesson |
|---:|---|---|
| 001 | 6348d4a docs scaffold | Chưa có execution story → dựng Notebook 03 skeleton → static inspection → narrative phải có trước run |
| 002 | 89acc6d test leaf structure | Structure dễ drift → thêm contract test → test đỏ nếu leaf sai → notebook cũng là interface |
| 003 | a10846b fix execution status | Status text không khớp state → sửa → test xanh → đừng claim execution quá mức |
| 004 | a80ef9b freeze protocol | Chưa khóa metric/trace → ghi policy → review config/notebook → freeze trước score |
| 005 | a905af8 config boundaries | Artifact locations mơ hồ → khai báo path → config test → path là contract |
| 006 | a3d5fd7 pin stack | Runtime chưa cố định → pin PyTorch stack → dependency check → environment là provenance |
| 007 | c771b21 regression test | Constraints khóa backend → test tái hiện → test đỏ → lỗi packaging cần reproducer |
| 008 | 41ac8e6 fix backends | CPU/CUDA không cùng cài được → nới constraint đúng chỗ → test xanh → portability phải có test |
| 009 | 6ea9ed1 setup commands | Intern khó chạy đúng env → ghi lệnh → docs review → command phải khớp Windows/Linux boundary |
| 010 | b97f751 fix expression | Cell summary dễ lỗi parse/layout → wrap expression → static test → presentation code vẫn là code |
| 011 | f273524 fix comments | Scaffold comments phá contract → wrap comment → test xanh → giữ notebook machine-checkable |

### 10. Bằng chứng và số đo thật

EDA trace chính:

- Thí nghiệm: development EDA handoff, không phải một lần train model.
- Artifact, tức file được tạo ra: <code>results/evidence/data_preparation/target_summary.csv</code>, <code>results/evidence/task2/eda_handoff.csv</code>.
- Split SHA-256: <code>d76a49...</code>; label-map SHA-256: <code>51b762...</code>; CV assignment SHA-256: <code>bad7bc4ae65fbbfd815567f4ccfa308d6e57dc650bc15c0b8e798867a335f2fd</code>.
- Source/test: dataset loader và OOF contracts ở trên.
- Giới hạn: mọi số đều chỉ dùng development và mang tính mô tả.

### 11. Cách hiểu kết quả

Mất cân bằng buộc ta dùng macro-F1, nhưng không tự nói cách sửa tốt nhất. ArticleType, year và file size tạo hypotheses về shortcut; chúng không được đưa vào inference. Shape/colour observation hợp lý hóa B1, nhưng B1 mới là experiment kiểm tra signal.

### 12. Quyết định

Khóa image-only input, bốn label, canonical five-fold CV, pooled OOF macro-F1 và holdout seal. Đi tiếp xây hạ tầng trước khi chạy model.

### 13. Bài học của senior

Một senior không bắt đầu bằng architecture. Họ khóa population, unit, split, metric, forbidden inputs và decision rule. Nhờ vậy negative result vẫn có giá trị và score không thể đổi nghĩa sau khi nhìn thấy.

### 14. Hiểu lầm hay gặp

- 74.46% year-majority agreement không phải model accuracy.
- 0.005 là 0.5 percentage points, không phải 0.005%.
- Pooled OOF không phải chọn fold tốt nhất.
- Làm tròn display không đổi checkpoint hay selection.
- Association giữa ArticleType và Season không cho phép dùng true ArticleType lúc inference.
- Holdout “chưa đọc label” mạnh hơn “đã đọc nhưng hứa không dùng”.

### 15. Câu hỏi tự luyện

<details>
<summary><strong>Nhớ lại 1:</strong> Task 2 nhận gì và trả gì?</summary>

**Gợi ý trả lời**

- Nhận một ảnh sản phẩm; trả đúng một nhãn trong Fall, Spring, Summer, Winter. ID chỉ định vị ảnh, không phải feature.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

<details>
<summary><strong>Nhớ lại 2:</strong> Vì sao macro-F1 là metric chính?</summary>

**Gợi ý trả lời**

- Nó tính F1 từng class rồi lấy mean không trọng số, nên Spring 4.06% có tiếng nói ngang Summer 49.57%.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

<details>
<summary><strong>Nhớ lại 3:</strong> OOF gộp khác trung bình các fold thế nào?</summary>

**Gợi ý trả lời**

- Pooled OOF ghép đúng một dự đoán held-out cho mỗi row rồi tính metric một lần; fold mean lấy mean của năm metric riêng.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

<details>
<summary><strong>Vì sao 4:</strong> Vì sao accuracy 49.57% của B0 chưa phải tín hiệu hình ảnh?</summary>

**Gợi ý trả lời**

- B0 đoán Summer cho mọi row và không đọc ảnh; class imbalance tự tạo accuracy cao.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

<details>
<summary><strong>Vì sao 5:</strong> Vì sao holdout phải khóa tới sau khi chốt lựa chọn?</summary>

**Gợi ý trả lời**

- Nếu dùng holdout để đổi model, nó trở thành tuning data và không còn là kiểm tra độc lập.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

<details>
<summary><strong>Vì sao 6:</strong> Vì sao NMI ArticleType–Season 0.174 không chứng minh ArticleType gây ra Season?</summary>

**Gợi ý trả lời**

- NMI chỉ đo association trong dữ liệu quan sát; có thể cùng bị chi phối bởi catalog và acquisition process.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

<details>
<summary><strong>Lần theo code 7:</strong> Một dòng development đi từ splits.csv tới fold validation ra sao?</summary>

**Gợi ý trả lời**

- load_splits redacts protected targets; get_cv_split lọc partition development và cv_fold; validation là fold đang giữ lại.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

<details>
<summary><strong>Lần theo code 8:</strong> Thứ tự nhãn đi qua pipeline bằng luật nào?</summary>

**Gợi ý trả lời**

- Label map cố định Fall, Spring, Summer, Winter; metrics, probability columns, confusion matrix và bundle đều kiểm tra cùng order.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

<details>
<summary><strong>Tìm lỗi 9:</strong> Nếu ai thêm train_test_split trong Notebook 03, lỗi khoa học là gì?</summary>

**Gợi ý trả lời**

- So sánh không còn dùng canonical folds; family grouping có thể vỡ và OOF evidence không còn cùng population.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

<details>
<summary><strong>Tìm lỗi 10:</strong> Nếu số mẫu Spring thành 0 ở một fold, cần kiểm tra gì trước?</summary>

**Gợi ý trả lời**

- Kiểm tra canonical cv_fold, has_season_label, label order và filter partition; không tự tạo split mới để chữa số.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

<details>
<summary><strong>Bảo vệ miệng 11:</strong> Hãy bảo vệ câu: EDA là đầu vào của thí nghiệm, không phải kết quả model.</summary>

**Gợi ý trả lời**

- EDA tạo observation và hypothesis; experiment có controlled change và held-out evidence mới kiểm tra hypothesis.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

<details>
<summary><strong>Bảo vệ miệng 12:</strong> Bạn không được kết luận gì từ mức đồng ý 74.46% của mốc năm?</summary>

**Gợi ý trả lời**

- Không được gọi đó là validation accuracy hay bằng chứng CNN dùng year; đó là descriptive same-data lookup và shortcut warning.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/README.md và contract đã freeze trong Notebook 03
- Code: notebooks/03_task2_season.ipynb, phần 1–3; src/fashion/data/dataset.py
- Test: tests/test_notebook_scaffolds.py và tests/data/test_torch_loaders.py
- Run/artifact: results/evidence/task2/eda_handoff.csv; results/evidence/task2/oof_contract.json
- Commit: dải 6348d4a... → f273524...
- Limitation: EDA là development-only; association không phải causation.

</details>

### 16. Checklist trước khi đi tiếp

- [ ] Tôi phân biệt observation, hypothesis, experiment, result, conclusion và limitation.
- [ ] Tôi giải thích được accuracy, precision, recall, F1, macro-F1 và pooled OOF.
- [ ] Tôi biết population là 32,753 valid development rows.
- [ ] Tôi biết vì sao holdout và new split bị cấm.
- [ ] Tôi nói được ít nhất ba EDA hypothesis mà không gọi association là causation.

### 17. Bước tiếp theo

Next: [Repository và nền tảng reproducible](02_REPOSITORY_AND_REPRODUCIBLE_FOUNDATION.md)
