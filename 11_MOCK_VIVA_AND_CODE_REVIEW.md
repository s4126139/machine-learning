# Mock viva và code review

## Cách trả lời

Dùng khung 5 câu: **claim → mechanism → evidence → decision → limitation**. Nếu không nhớ số, nói đúng artifact để kiểm. Không bịa decimal.

Năm từ này có vai trò khác nhau:

- **Claim — điều bạn khẳng định:** một câu ngắn có thể đúng hoặc sai, ví dụ
  “P1 không giúp C2 trong phép thử đã chạy”.
- **Mechanism — cách nó hoạt động:** giải thích code hoặc thiết kế tạo ra phép thử
  đó như thế nào. Với P1, chỉ kích thước ảnh đổi từ 80×60 thành 128×96; model,
  fold, seed và budget được giữ cố định.
- **Evidence — bằng chứng:** tên số đo và đường dẫn file chứa số đó. Ví dụ
  <code>results/evidence/task2/g2_input_size_ablation/decision.json</code> ghi
  chênh lệch macro-F1 là −0.001787 và runtime ratio là 1.992×.
- **Decision — hành động sau khi xem bằng chứng:** “giữ P0, loại P1”. Đây là việc
  nhóm làm, không phải một metric.
- **Limitation — điều chưa được chứng minh:** “chỉ thử một kích thước lớn hơn; thời
  gian chạy phụ thuộc máy”. Phần này ngăn câu trả lời nói quá bằng chứng.

Một câu trả lời nói mẫu:

> “Tôi kết luận P1 không qua cổng đã đặt trước. P1 chỉ tăng kích thước ảnh, còn các
> điều kiện chính được giữ nguyên. File
> <code>results/evidence/task2/g2_input_size_ablation/decision.json</code> cho thấy
> macro-F1 giảm 0.001787 và thời gian tăng 1.992 lần. Vì vậy nhóm giữ P0. Kết luận
> này chỉ áp dụng cho một kích thước P1 và máy đã đo, không nói mọi ảnh lớn đều xấu.”

Đó là **một chuỗi lập luận**. Không đọc năm từ như năm bullet rời nhau. Nếu chỉ nói
“score giảm” mà không nói config nào đổi, người nghe chưa biết phép so sánh có công
bằng hay không. Nếu chỉ nói file mà không nói decision, người nghe chưa biết nhóm đã
làm gì với bằng chứng.

### Cách tìm đúng file khi câu hỏi dùng tên ngắn

Các toggle bên dưới đôi lúc dùng tên ngắn để câu trả lời dễ nhìn. Khi mở repository,
dùng các gốc sau:

- Config Task 2: <code>configs/task2/</code>.
- Code model: <code>src/fashion/models/</code>.
- Code train dùng chung: <code>src/fashion/train/</code>.
- Code phép thử Task 2: <code>src/fashion/task2/</code>.
- Test: <code>tests/task2/</code>, <code>tests/train/</code>,
  <code>tests/data/</code> hoặc <code>tests/models/</code>.
- Evidence của Task 2: <code>results/evidence/task2/</code>.
- Evidence EDA dùng chung: <code>results/evidence/data_preparation/</code>.

Ví dụ, “G7 scorecard” nghĩa là
<code>results/evidence/task2/ultimate_judgement/scorecard.csv</code>, không phải một
bảng nằm trong file tutorial này. “season.py” nghĩa là
<code>src/fashion/models/season.py</code>. Nếu không chắc, dùng
<code>rg --files | rg "tên-file"</code> từ thư mục gốc repository.

### Từ ngữ dùng trong phần luyện nói

- **Hỏi nhanh:** trả lời trong khoảng 30 giây. Chỉ cần nói kết luận, lý do chính và
  một file bằng chứng.
- **Vẽ bảng:** dùng sơ đồ hoặc công thức để cho thấy dữ liệu đi qua hệ thống ra sao.
- **Xem code:** tìm lỗi trong một đoạn code giả định rồi nói cách sửa và cách kiểm tra.
- **Rò rỉ dữ liệu:** thông tin của phần validation hoặc holdout lọt vào lúc train hay
  chọn model, làm kết quả đẹp hơn thực tế.
- **Đường học:** đồ thị theo epoch của loss hoặc metric ở train và validation.
- **Ranh giới kết luận:** phần nói rõ bằng chứng hiện có chưa cho phép khẳng định điều gì.

Mỗi gợi ý bên dưới là ý cần nói, không phải câu thần chú để học thuộc. Khi trả lời,
hãy nối các ý thành câu hoàn chỉnh theo khung năm bước ở đầu file.

## Hỏi nhanh: câu trả lời 30 giây

<details>
<summary><strong>30 giây:</strong> Bài toán Task 2 là gì?</summary>

**Gợi ý trả lời**

- Đây là bài phân loại Season chỉ từ ảnh; model không nhận metadata làm đầu vào.
- Có bốn nhãn: Fall, Spring, Summer và Winter. Mỗi đơn vị dự đoán là một product ID.
- Development có 32.753 dòng hợp lệ. Holdout vẫn bị khóa ở giai đoạn này.

**Bằng chứng cần nhắc đến**

- Đề bài: <code>docs/COSC2753_2026B_Assignment 2.pdf</code>
- Code chia dữ liệu: <code>src/fashion/data/dataset.py</code>
- Hợp đồng OOF: <code>results/evidence/task2/oof_contract.json</code>

</details>

<details>
<summary><strong>30 giây:</strong> Vì sao số đo chính là macro-F1?</summary>

**Gợi ý trả lời**

- Spring chỉ chiếm 4,06%, nhưng macro-F1 cho F1 của mỗi lớp trọng số bằng nhau.
- Accuracy có thể trông cao chỉ vì Summer là lớp đông nhất.
- B0 là ví dụ cụ thể: nó luôn đoán Summer mà vẫn có accuracy đáng kể.

**Bằng chứng cần nhắc đến**

- Tỉ lệ nhãn: <code>results/evidence/data_preparation/target_summary.csv</code>
- Metric B0: <code>results/evidence/task2/b0_majority/pooled_metrics.json</code>

</details>

<details>
<summary><strong>30 giây:</strong> OOF gộp là gì?</summary>

**Gợi ý trả lời**

- Mỗi dòng development làm validation đúng một lần và được model chưa train trên dòng đó dự đoán.
- Ta ghép tất cả dự đoán này rồi tính metric đúng một lần trên toàn bộ development.
- Không chọn fold tốt nhất, vì làm vậy sẽ báo cáo một trường hợp may mắn.

**Bằng chứng cần nhắc đến**

- Hàm tạo fold <code>iter_cv_folds</code> trong <code>src/fashion/data/dataset.py</code>
- Code metric: <code>src/fashion/train/metrics.py</code>
- Coverage: <code>results/evidence/task2/oof_contract.json</code>

</details>

<details>
<summary><strong>30 giây:</strong> C1/C2/C3 khác nhau thế nào?</summary>

**Gợi ý trả lời**

- C1 là SmallCNN nhỏ, dùng các khối convolution thẳng.
- C2 là ResNet18 có kết nối residual và phần đầu nhỏ để giữ chi tiết ảnh 60×80.
- C3 là MobileNetV3, dùng depthwise và inverted blocks để giảm chi phí tính toán.
- Cả ba đều train từ đầu; không model nào nạp pretrained weights.

**Bằng chứng cần nhắc đến**

- Model: <code>src/fashion/models/season.py</code>
- Test model: <code>tests/models/test_smallcnn.py</code>,
  <code>tests/models/test_resnet18.py</code>, <code>tests/models/test_mobilenet.py</code>
- Kết quả G1: <code>results/evidence/task2/g1_family_screen/leaderboard.csv</code>

</details>

<details>
<summary><strong>30 giây:</strong> I1 thất bại vì sao?</summary>

**Gợi ý trả lời**

- Recall của Spring tăng 0,022573, nhưng precision giảm 0,152558.
- Vì có quá nhiều dự đoán Spring sai, F1 của Spring và macro-F1 toàn bộ đều giảm.
- Tất cả luật kiểm tra đã khóa cho I1 đều rớt, nên nhóm loại I1.

**Bằng chứng cần nhắc đến**

- Quyết định: <code>results/evidence/task2/i1_class_balance/decision.json</code>
- Metric từng lớp: <code>results/evidence/task2/i1_class_balance/per_class_comparison.csv</code>
- Năm run fold: <code>results/evidence/task2/i1_class_balance/registry_snapshot.csv</code>

</details>

<details>
<summary><strong>30 giây:</strong> I2 dùng ArticleType có gây rò rỉ dữ liệu không?</summary>

**Gợi ý trả lời**

- Nhãn phụ ArticleType chỉ xuất hiện trong lúc train, không phải đầu vào khi dự đoán.
- Mapping và các slice được học riêng từ bốn fold train trong mỗi vòng.
- Hàm <code>predict_season_logits</code> chỉ nhận ảnh.
- Holdout không được đọc, nên đường này không lấy thông tin từ holdout.

**Bằng chứng cần nhắc đến**

- Code I2: <code>src/fashion/task2/multitask.py</code> và
  <code>src/fashion/train/multitask.py</code>
- Test I2: <code>tests/task2/test_multitask_runner.py</code> và
  <code>tests/train/test_multitask.py</code>
- Manifest I2: <code>results/evidence/task2/i2_multitask/manifest.json</code>

</details>

<details>
<summary><strong>30 giây:</strong> P* có điểm tốt, vì sao không được nộp làm model cuối?</summary>

**Gợi ý trả lời**

- P* bắt đầu từ ImageNet weights, trái với yêu cầu model cuối phải train từ đầu.
- Metadata ghi <code>benchmark_only=true</code> và <code>final_eligible=false</code>.
- Điểm cao không thể xóa điều kiện hợp lệ của đề bài; P* chỉ là mốc so sánh.

**Bằng chứng cần nhắc đến**

- <code>BenchmarkModelSpec</code> trong <code>src/fashion/models/season.py</code>
- Quyết định: <code>results/evidence/task2/pretraining_benchmark/decision.json</code>
- Luật scratch: <code>docs/COSC2753_2026B_Assignment 2.pdf</code>

</details>

<details>
<summary><strong>30 giây:</strong> Model thắng cuối là model nào?</summary>

**Gợi ý trả lời**

- Model được chọn là I2 với trọng số loss phụ \(\lambda_{aux}=0.3\).
- I2 hơn C2 ở cả seed 2753 và seed 2026.
- Khoảng tin cậy bootstrap theo nhóm của chênh lệch đều nằm trên 0.
- I2 qua các luật an toàn, đồng thời nhỏ hơn và nhanh hơn C2 trên máy đã đo.

**Bằng chứng cần nhắc đến**

- <code>results/evidence/task2/ultimate_judgement/decision.json</code>
- <code>results/evidence/task2/ultimate_judgement/scorecard.csv</code>
- <code>results/evidence/task2/selection_freeze.json</code>

</details>

## Câu trả lời 2 phút

<details>
<summary><strong>2 phút:</strong> Kể bậc thang chọn model mà không chỉ đọc điểm.</summary>

**Gợi ý trả lời**

- B0 kiểm tra cách tính metric và đường chạy cơ bản; B1 kiểm tra tín hiệu hình dạng và màu.
- C1 là mạng nhỏ học đặc trưng; C2 thử sức chứa lớn hơn; C3 thử kiến trúc tiết kiệm hơn.
- Các phép P/A/T đổi từng yếu tố về ảnh, augmentation và tối ưu để biết yếu tố nào thực sự giúp.
- G3 được sửa và chạy sạch sau khi phát hiện lỗi về provenance, seed và evidence.
- I1 kiểm giả thuyết đổi loss; I2 kiểm giả thuyết học biểu diễn bằng nhiệm vụ phụ.
- Sau đó nhóm kiểm độ ổn định, lỗi theo slice, sức chịu ảnh, calibration và bootstrap.
- G7 dùng toàn bộ bằng chứng đã khóa để chọn I2 rồi freeze quyết định.

**Bằng chứng cần nhắc đến**

- <code>results/evidence/task2/selection_story/incremental_model_selection.csv</code>
- File <code>decision.json</code> trong từng thư mục evidence của gate liên quan
- <code>results/evidence/task2/ultimate_judgement/rejected_alternatives.csv</code>

</details>

<details>
<summary><strong>2 phút:</strong> Giải thích G3 đã sửa và bài học từ việc kiểm tra.</summary>

**Gợi ý trả lời**

- Lần chạy đầu có lỗ hổng về provenance, thời điểm đặt seed và cách evidence nối với run.
- Regression tests tái hiện các lỗi đó để chứng minh vấn đề có thật.
- Seed được đặt trước khi tạo model; cache, implementation hash và history được kiểm chặt hơn.
- Các lần chạy sạch dùng run ID mới. File cũ vẫn được giữ để có dấu vết kiểm tra.
- Kết quả G3 đã sửa là C1 = 0,737661 và C2 = 0,735036; đây là gần hòa, không phải thắng lớn.

**Bằng chứng cần nhắc đến**

- commits 63ae24a→64273e6, 895e482→9ad82b3, e4d11eb→77e448a, c46a0ff→62e57e2
- <code>results/evidence/task2/g3_full_budget/manifest.json</code>

</details>

<details>
<summary><strong>2 phút:</strong> Giải thích quy trình hiệu chỉnh độ tin cậy.</summary>

**Gợi ý trả lời**

- Quy trình dùng OOF logits đã khóa; không chạy lại model và không đổi dự đoán gốc.
- Một số vô hướng \(T\) được học bằng cách giảm NLL.
- Khi đánh giá, năm vòng cross-fit bảo đảm mỗi dòng được hiệu chỉnh bằng \(T\) không học từ chính dòng đó.
- \(T\) đổi độ tự tin nhưng không đổi lớp có logit lớn nhất.
- Với I2, NLL, Brier và ECE đều tốt hơn sau hiệu chỉnh.
- \(T\) học từ toàn bộ OOF chỉ được ghi vào metadata của bundle để dùng khi inference.
- Không có ngưỡng chuyển sang người kiểm tra vì nhóm chưa có chi phí sai của nghiệp vụ.

**Bằng chứng cần nhắc đến**

- Code: <code>src/fashion/task2/calibration.py</code>
- Test: <code>tests/task2/test_calibration.py</code>
- Bảng: <code>results/evidence/task2/calibration/calibration_summary.csv</code>
- Quyết định: <code>results/evidence/task2/calibration/decision.json</code>

</details>

<details>
<summary><strong>2 phút:</strong> Giải thích sức chịu ảnh lỗi và chi phí đúng mức.</summary>

**Gợi ý trả lời**

- C2 và I2 dùng checkpoint và thống kê của cùng fold; hàng ảnh sạch phải khớp lại kết quả gốc.
- Phép thử đã khai báo trước ba loại nhiễu: JPEG, giảm sáng và blur.
- I2 hơn C2 trong mọi điều kiện đã thử, nhưng cả hai vẫn có thể yếu về mặt tuyệt đối.
- Ở mức brightness 0.85, điểm giảm mạnh; đây là lỗi sức chịu ảnh cần báo cáo.
- Latency chỉ đúng cho máy và quy trình đo đã ghi, không đại diện cho mọi thiết bị.
- Kích thước file và số tham số không đồng nghĩa với latency; phải đo từng đại lượng riêng.

**Bằng chứng cần nhắc đến**

- Code: <code>src/fashion/task2/robustness.py</code>
- So sánh: <code>results/evidence/task2/robustness_cost/candidate_comparison.csv</code>
- Chi phí: <code>results/evidence/task2/robustness_cost/deployment_cost.csv</code>
- Manifest: <code>results/evidence/task2/robustness_cost/manifest.json</code>

</details>

<details>
<summary><strong>2 phút:</strong> Giải thích bootstrap theo nhóm và theo cặp.</summary>

**Gợi ý trả lời**

- Các ảnh trong cùng family có thể phụ thuộc nhau, nên không lấy mẫu từng dòng riêng lẻ.
- Mỗi lượt lấy lại toàn bộ các nhóm trong 22.885 nhóm, có hoàn lại.
- C2 và I2 dùng đúng cùng một mẫu nhóm trong từng lượt; đó là ý nghĩa của “theo cặp”.
- 10.000 lượt chỉ tính lại 10.000 chênh lệch metric, không train 10.000 model.
- Khoảng tin cậy tổng thể của cả hai cặp seed đều nằm trên 0.
- Kết luận chỉ đúng cho hai cặp model đã train và cách gom nhóm này, không đại diện cho mọi seed.

**Bằng chứng cần nhắc đến**

- Config: <code>configs/task2/g6_paired_group_bootstrap.json</code>
- Code metric: <code>src/fashion/task2/bootstrap.py</code>
- Khoảng tin cậy: <code>results/evidence/task2/paired_bootstrap/interval_summary.csv</code>
- Quyết định: <code>results/evidence/task2/paired_bootstrap/decision.json</code>

</details>

<details>
<summary><strong>2 phút:</strong> Giải thích khóa lựa chọn rồi train lại toàn bộ development.</summary>

**Gợi ý trả lời**

- G7 khóa chính xác ứng viên, run, config, hash và luật chọn số epoch trước khi refit.
- Trung vị của best epoch từ năm fold CV là 24, nên refit dùng đúng 24 epoch.
- Refit train trên toàn bộ development hợp lệ và không tạo validation mới.
- Vì số epoch đã khóa, checkpoint cuối là trạng thái sau epoch 24.
- Sau train, code kiểm state, history, registry và các manifest trước khi tạo bundle.
- Bàn giao vẫn khóa; cờ cho biết holdout chưa được mở.

**Bằng chứng cần nhắc đến**

- Freeze: <code>results/evidence/task2/selection_freeze.json</code>
- Code: <code>src/fashion/task2/refit.py</code>
- Model manifest: <code>models/task2_season.manifest.json</code>
- Handoff manifest: <code>results/evidence/task2/final_handoff/manifest.json</code>

</details>

## Vẽ bảng — giải thích bằng sơ đồ

<details>
<summary><strong>Vẽ bảng:</strong> Vẽ luồng tensor của C1/I2.</summary>

**Gợi ý trả lời**

- Batch ảnh đi từ `[N,3,80,60]` qua các khối convolution thành `[N,256,h,w]`, rồi global pooling thành `[N,256]`.
- Đầu Season biến mỗi vector thành bốn logits, nên output có shape `[N,4]`.
- Riêng khi train I2, đầu ArticleType tạo 124 logits, shape `[N,124]`.
- Viết loss tổng \(L=L_{season}+\lambda_{aux}L_{article}\), đồng thời vẽ mask bỏ các dòng thiếu nhãn phụ.

**Bằng chứng cần nhắc đến**

- <code>forward_features</code> trong <code>src/fashion/models/season.py</code>
- Code/test multi-task: <code>src/fashion/task2/multitask.py</code> và
  <code>tests/task2/test_multitask_runner.py</code>

</details>

<details>
<summary><strong>Vẽ bảng:</strong> Viết precision, recall, F1 và macro-F1.</summary>

**Gợi ý trả lời**

- Precision là \(P=TP/(TP+FP)\): trong các mẫu model đoán là lớp này, bao nhiêu mẫu đúng.
- Recall là \(R=TP/(TP+FN)\): trong các mẫu thật của lớp này, model tìm được bao nhiêu.
- F1 là \(2PR/(P+R)\), cân bằng precision và recall.
- Macro-F1 là trung bình không trọng số của F1 ở bốn lớp Season.
- Code dùng <code>zero_division=0</code>, nên lớp không có mẫu dự đoán hợp lệ nhận giá trị 0 thay vì lỗi chia cho 0.

**Bằng chứng cần nhắc đến**

- Code: <code>src/fashion/train/metrics.py</code>
- Định nghĩa chính thức của scikit-learn được dẫn trong phase đánh giá

</details>

<details>
<summary><strong>Vẽ bảng:</strong> Vẽ OOF năm fold và ranh giới chống rò rỉ dữ liệu.</summary>

**Gợi ý trả lời**

- Năm phần dữ liệu đến từ cột <code>cv_fold</code> đã lưu, không được chia lại.
- Mỗi vòng dùng bốn fold để train và một fold để validation.
- Thống kê transform, class weights và mapping chỉ được học từ bốn fold train.
- Sau năm vòng, mỗi product ID làm validation đúng một lần.
- Holdout và quarantine không tham gia sơ đồ này.

**Bằng chứng cần nhắc đến**

- Code: <code>src/fashion/data/dataset.py</code>
- Hợp đồng: <code>results/evidence/task2/oof_contract.json</code>
- Coverage của từng phép thử: file <code>manifest.json</code> trong thư mục evidence tương ứng

</details>

<details>
<summary><strong>Vẽ bảng:</strong> Vẽ chuỗi kiểm chứng bundle.</summary>

**Gợi ý trả lời**

- Vẽ chuỗi: hash của freeze → hash config và dữ liệu chuẩn → run refit trong registry → hash bundle, history và runtime → model manifest → inference smoke → 10 kiểm tra → handoff manifest.
- Mỗi mũi tên nghĩa là file sau kiểm tra hoặc ghi lại định danh của file trước; nếu hash lệch, quy trình dừng.

**Bằng chứng cần nhắc đến**

- Freeze: <code>results/evidence/task2/selection_freeze.json</code>
- Refit: <code>src/fashion/task2/refit.py</code>
- Handoff: <code>src/fashion/task2/handoff.py</code>
- Audit: <code>results/evidence/task2/final_handoff/artifact_audit.csv</code>

</details>

## Câu hỏi khi xem code

<details>
<summary><strong>Xem code:</strong> Bạn thấy <code>softmax(model(x))</code> trước CrossEntropyLoss.</summary>

**Gợi ý trả lời**

- Đây là lỗi áp dụng softmax hai lần theo nghĩa toán của loss.
- <code>CrossEntropyLoss</code> cần logits thô vì bên trong nó đã xử lý log-softmax.
- Softmax sớm có thể làm gradient yếu và giảm ổn định số.
- Chỉ dùng softmax khi cần đổi logits thành xác suất để báo cáo hoặc inference.

**Bằng chứng cần nhắc đến**

- Code: <code>src/fashion/train/engine.py</code>
- Tài liệu chính thức PyTorch về <code>CrossEntropyLoss</code>
- Test: <code>tests/train/test_engine.py</code>

</details>

<details>
<summary><strong>Xem code:</strong> Bạn thấy thống kê chuẩn hóa được học trước vòng CV.</summary>

**Gợi ý trả lời**

- Đây là rò rỉ dữ liệu vì pixel của validation đã ảnh hưởng thống kê dùng khi train.
- Chuyển bước tính mean/std vào trong từng fold và chỉ đọc pixel của phần train.
- Lưu hash của các training ID để biết thống kê được học từ tập nào.
- Thêm test thay pixel validation rồi kiểm rằng mean/std của train không đổi.

**Bằng chứng cần nhắc đến**

- Code: <code>src/fashion/data/torch.py</code>
- Test transform: <code>tests/data/test_torch_transforms.py</code>
- Lịch sử thống kê fold nằm trong artifact/history của run được hỏi

</details>

<details>
<summary><strong>Xem code:</strong> Bạn thấy <code>resnet18(weights=DEFAULT)</code> trong hàm tạo model cuối.</summary>

**Gợi ý trả lời**

- Chặn ngay vì lệnh này nạp pretrained weights.
- Nó vi phạm đề bài và hợp đồng <code>ModelBoundaryError</code> của repository.
- Chuyển pretrained model sang builder benchmark riêng, không cho đi vào đường final.
- Thêm test bảo đảm đường model cuối không tải weights từ mạng.

**Bằng chứng cần nhắc đến**

- Code: <code>src/fashion/models/season.py</code>
- Test: <code>tests/models/test_resnet18.py</code>
- Luật scratch: <code>docs/COSC2753_2026B_Assignment 2.pdf</code>

</details>

<details>
<summary><strong>Xem code:</strong> Bạn thấy trạng thái một dòng registry bị sửa từ completed thành failed.</summary>

**Gợi ý trả lời**

- Đây là vi phạm luật không sửa trạng thái kết thúc đã ghi.
- Tạo run mới hoặc bản ghi invalidation mới thay vì viết đè dòng cũ.
- Giữ dòng cũ để còn dấu vết kiểm tra.
- Nếu viết đè, cache có thể hiểu sai lịch sử và tái dùng artifact không đúng.

**Bằng chứng cần nhắc đến**

- Code: <code>src/fashion/train/registry.py</code>
- Test: <code>tests/train/test_registry.py</code>
- Gói bị loại: <code>results/evidence/task2/development_refit/invalidated/</code>

</details>

<details>
<summary><strong>Xem code:</strong> Bạn thấy evidence builder tin đường dẫn CSV nhưng không kiểm SHA.</summary>

**Gợi ý trả lời**

- Có nguy cơ file bị đổi hoặc đã cũ nhưng vẫn được nhận là bằng chứng đúng.
- Kiểm khai báo và SHA trước khi nạp CSV.
- Ràng buộc thêm hash của dữ liệu chuẩn và implementation.
- Nếu thiếu hoặc lệch hash thì dừng rõ ràng; không đoán rằng file vẫn an toàn.

**Bằng chứng cần nhắc đến**

- Code: <code>src/fashion/train/artifacts.py</code> và <code>src/fashion/train/cache.py</code>
- Test: <code>tests/train/test_cache.py</code> và các file <code>tests/task2/test_*_evidence.py</code>
- Manifest trong thư mục <code>results/evidence/task2/</code> của phép thử liên quan

</details>

## Bài tìm rò rỉ dữ liệu

<details>
<summary><strong>Tìm rò rỉ:</strong> Dùng train_test_split để tạo validation mới.</summary>

**Gợi ý trả lời**

- Cách này phá phép so sánh vì vi phạm split chuẩn và có thể tách các ảnh cùng family sang hai phía.
- Chỉ dùng cột <code>cv_fold</code> đã lưu trong <code>splits.csv</code>.
- Nếu chia lại, OOF và artifact mới không còn cùng nền dữ liệu với kết quả cũ, nên không được so trực tiếp.

**Bằng chứng cần nhắc đến**

- Luật project: <code>AGENTS.md</code>
- Code: <code>src/fashion/data/dataset.py</code>
- Hash split/CV: <code>results/evidence/task2/oof_contract.json</code>

</details>

<details>
<summary><strong>Tìm rò rỉ:</strong> Học mapping ArticleType→Season trên cả train và validation.</summary>

**Gợi ý trả lời**

- Nhãn validation sẽ ảnh hưởng cách gán slice, nên phép đánh giá không còn độc lập.
- Học mapping chỉ trên bốn fold train của vòng hiện tại.
- Áp mapping đó lên fold được giữ lại; giá trị chưa từng thấy phải giữ trạng thái “unseen”.

**Bằng chứng cần nhắc đến**

- Code: <code>src/fashion/task2/slices.py</code> và
  <code>src/fashion/task2/multitask_evidence.py</code>
- Test: <code>tests/task2/test_slices.py</code> và
  <code>tests/task2/test_slice_evidence.py</code>

</details>

<details>
<summary><strong>Tìm rò rỉ:</strong> Nhìn điểm holdout rồi đổi ngưỡng confidence.</summary>

**Gợi ý trả lời**

- Khi dùng điểm holdout để đổi ngưỡng, holdout đã biến thành dữ liệu tuning.
- Muốn đặt ngưỡng, nhóm phải khai báo trước chi phí nghiệp vụ của từng loại sai rồi mới mở holdout.
- Dự án chưa có chi phí đó, nên ngưỡng hiện tại vẫn là <code>null</code>.

**Bằng chứng cần nhắc đến**

- Freeze: <code>results/evidence/task2/selection_freeze.json</code>
- Calibration: <code>results/evidence/task2/calibration/decision.json</code>
- Cờ handoff: <code>results/evidence/task2/final_handoff/manifest.json</code>

</details>

<details>
<summary><strong>Tìm rò rỉ:</strong> Dùng dung lượng file và năm làm đầu vào model.</summary>

**Gợi ý trả lời**

- Đây là metadata đường tắt bị cấm; model có thể học cách dữ liệu được thu thập thay vì học ảnh thời trang.
- Chỉ dùng các cột đó sau dự đoán để chia slice và tìm lỗi.
- API inference của Task 2 chỉ được nhận ảnh và thiết bị chạy, không nhận các metadata này.

**Bằng chứng cần nhắc đến**

- Contract Task 2: <code>results/evidence/task2/oof_contract.json</code>
- API: <code>src/fashion/task2/inference.py</code>
- Quyết định: <code>results/evidence/task2/robustness_cost/decision.json</code> và
  manifest/decision trong thư mục slice liên quan

</details>

## Bài đọc đường học

<details>
<summary><strong>Đường học:</strong> Train loss giảm; validation loss tăng; macro-F1 đứng yên.</summary>

**Gợi ý trả lời**

- Đây thường là dấu hiệu model bắt đầu học quá sát dữ liệu train, còn gọi là overfitting.
- Checkpoint tốt nhất có thể nằm trước epoch cuối.
- Early stopping giữ ứng viên ở epoch validation tốt nhất trong vòng CV.
- Đây chỉ là chênh lệch train–validation; không được gọi nó là kết quả holdout.

**Bằng chứng cần nhắc đến**

- Curves: <code>results/evidence/task2/g3_full_budget/learning_curves_by_fold.csv</code>
- History của từng run trong cache/checkpoint đã khai trong manifest G3
- Luật checkpoint: config G3 trong <code>configs/task2/</code>

</details>

<details>
<summary><strong>Đường học:</strong> Train và validation macro-F1 đều thấp, train loss còn cao.</summary>

**Gợi ý trả lời**

- Model có thể chưa học đủ, còn gọi là underfitting, hoặc bước tối ưu chưa hiệu quả.
- Kiểm loader, learning rate, sức chứa model và số epoch trước.
- Dùng G0 để loại khả năng gradient hoặc đường train bị hỏng.
- Không tăng model một cách mù quáng; mỗi thay đổi phải có giả thuyết và phép thử riêng.

**Bằng chứng cần nhắc đến**

- G0: <code>results/evidence/task2/g0/manifest.json</code>
- G1: <code>results/evidence/task2/g1_family_screen/leaderboard.csv</code> và
  các config <code>configs/task2/g1_*.json</code>

</details>

<details>
<summary><strong>Đường học:</strong> Loss có trọng số của I1 thấp hơn loss không trọng số của C1.</summary>

**Gợi ý trả lời**

- Không thể so trực tiếp hai loss vì hàm mục tiêu và thang đo đã đổi.
- Hãy so macro-F1 gộp và precision/recall/F1 từng lớp trên cùng OOF rows.
- Khi trình bày, nêu beta và class weights đã lưu trong history của từng fold.

**Bằng chứng cần nhắc đến**

- Quyết định: <code>results/evidence/task2/i1_class_balance/decision.json</code>
- Code: <code>src/fashion/train/losses.py</code>
- Trọng số: <code>results/evidence/task2/i1_class_balance/class_weights_by_fold.csv</code>

</details>

## Câu hỏi bảo vệ model thắng

<details>
<summary><strong>Bảo vệ lựa chọn:</strong> Người chấm nói C2 ổn định hơn nên phải chọn C2.</summary>

**Gợi ý trả lời**

- Thừa nhận độ trôi giữa hai seed của C2 nhỏ hơn I2.
- Tuy vậy, trong phép so theo cặp, I2 vẫn hơn C2 ở cả hai seed.
- Hai khoảng tin cậy bootstrap tổng thể đều nằm trên 0 và mọi guard đều đạt.
- I2 cũng nhỏ hơn và nhanh hơn trên máy đã đo, nên toàn bộ luật chọn vẫn nghiêng về I2.
- Giữ nguyên giới hạn: mới chỉ có hai seed, nên không được nói I2 ổn định hơn trong mọi lần chạy.

**Bằng chứng cần nhắc đến**

- Seed: <code>results/evidence/task2/seed_stability/seed_stability.csv</code>
- Bootstrap: <code>results/evidence/task2/paired_bootstrap/interval_summary.csv</code>
- G7: <code>results/evidence/task2/ultimate_judgement/scorecard.csv</code>

</details>

<details>
<summary><strong>Bảo vệ lựa chọn:</strong> Người chấm nói I2 chỉ học đường tắt ArticleType.</summary>

**Gợi ý trả lời**

- Slice xung đột giữa ArticleType và Season vẫn cải thiện ở cả hai seed.
- Khi inference, model không nhận ArticleType làm đầu vào.
- Tuy vậy, slice đồng thuận dễ hơn và nguy cơ học đường tắt vẫn còn.
- Bằng chứng quan sát không cho phép kết luận quan hệ nhân quả.

**Bằng chứng cần nhắc đến**

- I2: <code>results/evidence/task2/i2_multitask/</code> và thư mục slice evidence liên quan
- API model: <code>tests/task2/test_inference.py</code>
- Giới hạn G7: <code>results/evidence/task2/ultimate_judgement/decision.json</code>

</details>

<details>
<summary><strong>Bảo vệ lựa chọn:</strong> Người chấm nói pretrained P* có điểm cao nhất.</summary>

**Gợi ý trả lời**

- Điều kiện hợp lệ được xét trước điểm.
- P* khởi tạo từ ImageNet và được đánh dấu chỉ dùng làm benchmark.
- Luật model cuối phải train từ đầu đã cố định trong đề bài.
- Chỉ dùng P* để cho thấy còn khoảng cải thiện về biểu diễn, không dùng làm model nộp.

**Bằng chứng cần nhắc đến**

- Pretrained boundary: <code>results/evidence/task2/pretraining_benchmark/decision.json</code>
- Luật bài: <code>docs/COSC2753_2026B_Assignment 2.pdf</code>
- Audit model: <code>tests/models/test_boundaries.py</code>

</details>

<details>
<summary><strong>Bảo vệ lựa chọn:</strong> Người chấm hỏi vì sao không tuning thêm sau lỗi ảnh tối.</summary>

**Gợi ý trả lời**

- Quá trình tìm model đã đóng và bản freeze không được sửa.
- Phép stress test dùng để chẩn đoán giới hạn, không được mở lại cuộc chọn model.
- Tuning sau khi đã thấy lỗi này tạo nguy cơ tối ưu hậu nghiệm theo đúng bằng chứng dùng để đánh giá.
- Báo cáo giới hạn và nhu cầu người kiểm tra; chỉ xem đây là hướng làm sau đánh giá độc lập.

**Bằng chứng cần nhắc đến**

- Robustness: <code>results/evidence/task2/robustness_cost/decision.json</code>
- Freeze: <code>results/evidence/task2/selection_freeze.json</code>
- Rubric: <code>rubrics/RUBRIC.md</code>

</details>

## Câu hỏi “không được kết luận điều gì?”

<details>
<summary><strong>Không được kết luận:</strong> Hai khoảng bootstrap đều nằm trên 0.</summary>

**Gợi ý trả lời**

- Không được nói I2 thắng ở mọi seed, tốt hơn do quan hệ nhân quả, hay chắc chắn thắng trên production/holdout.
- Bằng chứng chỉ ủng hộ I2 khi lấy mẫu lại theo nhóm trên hai cặp model development đã train.

**Bằng chứng cần nhắc đến**

- <code>results/evidence/task2/paired_bootstrap/decision.json</code>

</details>

<details>
<summary><strong>Không được kết luận:</strong> Grad-CAM có foreground lift &gt; 1 và không có cờ lỗi.</summary>

**Gợi ý trả lời**

- Không được nói vùng sáng gây ra dự đoán, model không dùng đường tắt, heatmap giải thích hoàn hảo hay lỗi này phổ biến.
- Phép xem chỉ dùng một tập confidence cao đã cố định và foreground mask gần đúng.

**Bằng chứng cần nhắc đến**

- <code>results/evidence/task2/gradcam_failure_review/decision.json</code> và
  <code>results/evidence/task2/gradcam_failure_review/manifest.json</code>
- Giới hạn từ bài Adebayo được dẫn trong phase Grad-CAM

</details>

<details>
<summary><strong>Không được kết luận:</strong> Inference smoke có confidence 0,9282.</summary>

**Gợi ý trả lời**

- Không được nói xác suất đúng là 92,82%, chất lượng holdout tốt hay đây là ngưỡng review phù hợp.
- Đây chỉ là một ảnh development dùng để kiểm bundle và API chạy đúng hợp đồng.

**Bằng chứng cần nhắc đến**

- <code>results/evidence/task2/final_handoff/inference_smoke.json</code>
- <code>results/evidence/task2/calibration/decision.json</code>

</details>

<details>
<summary><strong>Không được kết luận:</strong> Accuracy train của refit là 0,8205.</summary>

**Gợi ý trả lời**

- Không được gọi đây là khả năng áp dụng cho ảnh mới hoặc accuracy trên holdout.
- Mọi dòng trong phép tính đều là dòng train; refit cố ý không có validation.

**Bằng chứng cần nhắc đến**

- <code>results/evidence/task2/development_refit/training_history.csv</code>
- <code>results/evidence/task2/selection_freeze.json</code>

</details>

## Một bài bảo vệ miệng mẫu hoàn chỉnh

<details>
<summary><strong>Bảo vệ mẫu đầy đủ:</strong> Tóm tắt 5 phút: bài toán → bằng chứng → model → thất bại → lựa chọn → giới hạn.</summary>

**Gợi ý trả lời**

- Bài toán: dự đoán một trong bốn nhãn Season chỉ từ ảnh; model cuối train từ đầu; đánh giá bằng OOF năm fold chuẩn.
- EDA: dữ liệu lệch lớp, ảnh nhỏ, hình dạng và màu có tín hiệu, đồng thời có nguy cơ đường tắt và phụ thuộc theo family.
- Bậc thang: B0 = 0,1657; B1 = 0,6096; sàng lọc C1/C2/C3; thử P/A/T có kiểm soát; G3 đã sửa cho kết quả gần hòa.
- Kết quả âm: P1, A1, C3 và I1 bị loại; phải nói lý do cụ thể của từng phương án.
- I2 với \(\lambda_{aux}=0.3\) đạt 0,752687; Spring và slice xung đột cải thiện. P* cho biết trần cao hơn nhưng không hợp lệ để nộp.
- Độ ổn định: I2 dẫn ở seed 2753 và 2026, nhưng hai seed chưa đại diện cho mọi lần train.
- Chẩn đoán: có đảo chiều theo slice, sụt mạnh khi ảnh tối, calibration tốt hơn, khoảng tin cậy theo nhóm trên 0 và Grad-CAM không mang ý nghĩa nhân quả.
- Quyết định: I2 qua sáu kiểm tra G7, train từ đầu và chỉ nhận ảnh khi inference.
- Hoàn thiện: refit 24 epoch trên toàn bộ development rồi kiểm bundle và handoff.
- Ranh giới: chưa mở holdout, Notebook 06 vẫn khóa và app chưa có ngưỡng tự động.

**Bằng chứng cần nhắc đến**

- Dùng <code>results/evidence/task2/ultimate_judgement/scorecard.csv</code>,
  <code>results/evidence/task2/ultimate_judgement/decision.json</code>,
  <code>results/evidence/task2/selection_freeze.json</code>,
  <code>models/task2_season.manifest.json</code> và
  <code>results/evidence/task2/final_handoff/manifest.json</code>
- Nêu ít nhất một dải run và một SHA để người nghe có thể kiểm lại.
- Kết thúc bằng giới hạn mạnh nhất, không kết thúc bằng lời quảng cáo model.

</details>

## Bảng tự chấm theo rubric

Tự chấm mỗi dòng 0, 1 hoặc 2: 0 = chưa nói được; 1 = đúng nhưng thiếu trace/limit; 2 = đúng, có evidence và boundary.

**Cách đọc bảng:** “Area” là kỹ năng đang luyện, không phải tên mục điểm chính thức
của RMIT. Cột “0–2” để trống cho **bạn tự điền điểm luyện tập**: 0 là chưa giải
thích được, 1 là có ý đúng nhưng thiếu bằng chứng hoặc giới hạn, 2 là nói được trọn
chuỗi claim → mechanism → evidence → decision → limitation. “Dấu hiệu đạt 2” là
checklist học, không phải cam kết điểm assignment và không được cộng thành điểm RMIT.
Bảng không có metric model; số 0–2 càng cao chỉ có nghĩa câu trả lời luyện tập đầy đủ hơn.

| Kỹ năng đang luyện (Area) | 0–2 | Dấu hiệu đạt 2 |
|---|---:|---|
| Độ rộng cách tiếp cận (Approach breadth) |  | Kể được B0/B1/C1/C2/C3/I1/I2/P* và câu hỏi của từng model |
| Xử lý ảnh trước model (Preprocessing) |  | Giải thích giữ tỉ lệ, padding, thống kê theo fold và hai kết quả âm P1/A1 |
| Chỉnh thông số có kiểm soát (Controlled tuning) |  | Nêu phần giữ cố định, ngưỡng, số thô và G3 đã sửa |
| Vấn đề riêng của bài toán (Unique problem) |  | Nói được Spring, ảnh 60×80, nhãn mơ hồ và đường tắt ArticleType/năm/dung lượng file |
| Phần vượt kiến thức cơ bản (Beyond-class) |  | Giải thích multi-task, calibration, robustness, bootstrap theo nhóm và Grad-CAM |
| Quyết định cuối (Ultimate Judgement) |  | Nêu sáu kiểm tra, phương án bị loại và vì sao không dùng luật phụ về chi phí |
| Đánh giá độc lập (Independent evaluation) |  | Nói holdout vẫn khóa và chỉ được đánh giá một lần sau khi cả nhóm freeze |
| Khả năng dùng thật (Real-world viability) |  | Nêu lỗi tuyệt đối khi ảnh tối, quy trình đo chi phí và ranh giới người kiểm tra |
| Khả năng truy vết (Traceability) |  | Đi được chuỗi claim → config → code → test → run → artifact → commit → giới hạn |
| Trung thực về giới hạn (Honesty) |  | Nêu chỉ có hai seed, nhóm cắt, saliency không nhân quả và chưa có ngưỡng app |

Mục tiêu **tự luyện**: ít nhất 16/20 và không được 0 ở đánh giá độc lập, khả năng truy vết hoặc trung thực về giới hạn. Đây không phải cách RMIT tự động tính điểm bài nộp.

Next: [Final revision và trace matrix](12_FINAL_REVISION_AND_TRACE_MATRIX.md)
