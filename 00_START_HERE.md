# Task 2 tutor — bắt đầu ở đây

Đây là tài liệu học riêng trên máy. Nó không phải bài nộp. Folder này bị Git bỏ qua bằng local exclude, nên không lên GitHub.

Tài liệu giả sử bạn bắt đầu từ số 0. Khi một từ tiếng Anh xuất hiện lần đầu, phần tiếng Việt đi trước và từ tiếng Anh nằm trong ngoặc. Các mã như `B0`, `A1` hay `G6` là mã riêng của dự án này, không phải ký hiệu chuẩn mà ai học Machine Learning cũng tự biết.

## Cách đọc lần đầu

Đừng cố nhớ mọi con số ngay.

1. **Lần một:** đọc câu chuyện, ví dụ và quyết định. Có thể bỏ qua hash, run ID và lịch sử Git.
2. **Lần hai:** mở các file code và file bằng chứng được chỉ tên. Lúc này mới trace, tức lần theo đường đi của một kết quả.
3. **Lần ba:** đóng đáp án trong các thẻ câu hỏi, tự trả lời thành tiếng rồi mới mở ra kiểm tra.

Nếu một chữ viết tắt bị quên, quay lại phần “Từ điển mã” hoặc “Từ điển từ ngữ” ngay trong file này.

Tutorial dùng ba hệ thống số khác nhau: **Phase 00–12** là số bài học; **G0–G8** là số giai đoạn thí nghiệm; **001–337** là số thứ tự commit trong lịch sử được kể. Chúng không thể đổi chỗ cho nhau.

## Điểm xuất phát đã được xác minh

Task 2 hiện đã được đóng gói để bàn giao cho phần tích hợp của cả nhóm. Điều đó **không** có nghĩa là nhãn holdout đã được mở hoặc model đã được chấm trên holdout.

<details>
<summary><strong>Thông tin bảo trì — có thể bỏ qua ở lần đọc đầu</strong></summary>

- Branch: **feature/task2-season**.
- HEAD, tức commit mới nhất đang được dùng: **0d92496a831a5557d19089fb4284cf33dd100e99**.
- Base, tức điểm bắt đầu đã khóa khi kiểm tra sạch: **17e028edcd99697f425ad4bb6baf90a84a1fd43d**. Local <code>linh/main</code> có thể fast-forward về sau; curriculum vẫn giữ range preflight để xương sống lịch sử không đổi giữa lúc học.
- Phạm vi học: 337 commit, từ **6348d4a...** đến **0d92496...**, theo đúng thứ tự topo, nghĩa là commit cha được đọc trước commit con.
- Trạng thái component handoff nghĩa là phần Task 2 đã sẵn sàng để nhóm nhận và tích hợp.
- Notebook 06, holdout và protected labels vẫn khóa.

</details>

## Một đường đọc duy nhất

Đọc từ trên xuống. Không nhảy file. “Thời gian” là thời gian ước lượng để vừa đọc vừa mở code, **không phải** thời gian train model.

**Cách đọc bảng:** “Thứ tự” là thứ tự bài học, không phải số commit. “File” là link mở bài học trên máy. “Thời gian” là thời gian học chủ động. Cột cuối nói kỹ năng bạn nên có sau khi đọc xong.

| Thứ tự | File | Thời gian | Sau phase này bạn làm được gì |
|---:|---|---:|---|
| 00 | [Bắt đầu ở đây](00_START_HERE.md) | 15 phút | Biết luật học, pipeline và ranh giới holdout |
| 01 | [Assignment và EDA handoff](01_ASSIGNMENT_AND_EDA_HANDOFF.md) | 70 phút | Biến EDA thành giả thuyết và hiểu metric |
| 02 | [Repository và nền tảng tái lập](02_REPOSITORY_AND_REPRODUCIBLE_FOUNDATION.md) | 100 phút | Đọc repository, tensor, loader, engine, registry, cache và hash |
| 03 | [Baseline B0 và B1](03_BASELINES_B0_AND_B1.md) | 80 phút | Bảo vệ B0, HOG+HSV và LinearSVC |
| 04 | [Model scratch C1, C2 và C3](04_SCRATCH_MODELS_C1_C2_C3.md) | 120 phút | Giải thích SmallCNN, ResNet18, MobileNetV3 và train từ đầu |
| 05 | [Ablation, tuning và learning curve](05_ABLATIONS_TUNING_AND_LEARNING_CURVES.md) | 110 phút | Đọc thí nghiệm có kiểm soát, cổng kiểm tra và đường học |
| 06 | [I1, I2 và ranh giới pretrained](06_I1_I2_AND_PRETRAINED_BOUNDARY.md) | 110 phút | Giải thích I1 thất bại, I2 thắng và ranh giới pretrained |
| 07 | [Độ ổn định, lát dữ liệu, robustness và calibration](07_STABILITY_SLICES_ROBUSTNESS_AND_CALIBRATION.md) | 120 phút | Đọc seed, lát dữ liệu, kiểm tra gây nhiễu, calibration và risk–coverage |
| 08 | [Bootstrap, Grad-CAM và quyết định cuối](08_BOOTSTRAP_GRADCAM_AND_ULTIMATE_JUDGEMENT.md) | 100 phút | Giải thích độ không chắc chắn, Grad-CAM và quyết định cuối |
| 09 | [Freeze, refit, inference và handoff](09_FREEZE_REFIT_INFERENCE_AND_HANDOFF.md) | 100 phút | Lần theo freeze → refit → bundle → inference → handoff |
| 10 | [Toàn bộ lịch sử commit](10_COMPLETE_COMMIT_TIMELINE.md) | 150 phút | Ôn đủ 337 commit, kể cả lỗi, kết quả âm và nhánh Git |
| 11 | [Viva thử và code review](11_MOCK_VIVA_AND_CODE_REVIEW.md) | 120 phút | Tập đọc code và bảo vệ bằng lời |
| 12 | [Ôn cuối và bảng truy vết](12_FINAL_REVISION_AND_TRACE_MATRIX.md) | 75 phút | Lần theo từng claim và tự chấm mức sẵn sàng |

Tổng thời gian gợi ý: 1,270 phút, tức khoảng 21 giờ 10 phút. Chia thành 8–10 buổi sẽ dễ nhớ hơn.

## Từ điển mã của dự án

### Mã model và cách làm

**Cách đọc bảng:** “Mã” là tên ngắn xuất hiện trong config, run ID và bảng kết quả. “Tên đầy đủ” cho biết model hoặc cách làm. “Nói đơn giản” trả lời model nhìn gì và làm gì. “Vai trò” cho biết nó được phép trở thành model cuối hay chỉ dùng để so sánh.

| Mã | Tên đầy đủ | Nói đơn giản | Vai trò |
|---|---|---|---|
| B0 | Baseline 0 — dự đoán lớp đông nhất | Không đọc ảnh. Nó luôn đoán mùa xuất hiện nhiều nhất trong training fold. | Mốc thấp nhất để kiểm tra metric |
| B1 | HOG + HSV + LinearSVC | HOG tóm tắt hình dáng/cạnh; HSV tóm tắt màu; LinearSVC chọn mùa từ hai nhóm đặc trưng đó. | Baseline cổ điển có đọc ảnh |
| C1 | SmallCNN train từ đầu | Mạng CNN nhỏ tự học đặc trưng từ pixel. | Ứng viên cuối |
| C2 | ResNet18 small-stem train từ đầu | ResNet18 có đường tắt residual; phần đầu được sửa cho ảnh nhỏ. | Ứng viên cuối |
| C3 | MobileNetV3-Small train từ đầu | Mạng gọn, hướng tới chi phí thấp. | Ứng viên sàng lọc |
| I1 | Loss cân bằng lớp theo effective number | Tăng trọng số cho lớp hiếm trong hàm mất mát. | Can thiệp thử nghiệm; kết quả không được chọn |
| I2 | Auxiliary ArticleType head | Khi train, model học thêm loại sản phẩm để hỗ trợ encoder; khi dự đoán thật vẫn chỉ cần ảnh. | Ứng viên cuối |
| P0S | ResNet18 stem chuẩn, train từ đầu | Giữ phần đầu chuẩn của ResNet18 để làm mốc công bằng cho pretrained. | Benchmark-only, không phải preprocessing P0 |
| P* | ResNet18 stem chuẩn có ImageNet weights | Giống P0S nhưng bắt đầu từ weights đã học trên ImageNet. | Chỉ benchmark; không bao giờ là final |

`P0S` là **mã model benchmark**. Nó không cùng loại với `P0` ở bảng biến thể bên dưới. Chữ giống nhau nhưng vai trò khác nhau.

### Mã biến thể được thay trong thí nghiệm

**Cách đọc bảng:** “Nhóm mã” cho biết phần nào của pipeline được đổi. “Mã” là lựa chọn cụ thể. “Thông số thật” là giá trị code dùng. Trong một thí nghiệm có kiểm soát, chỉ đổi một nhóm và giữ các nhóm còn lại cố định.

| Nhóm mã | Mã | Ý nghĩa | Thông số thật |
|---|---|---|---|
| Kích thước ảnh | P0 | Kích thước gốc | `(height, width) = (80, 60)`, tức ảnh cao 80 và rộng 60 pixel |
| Kích thước ảnh | P1 | Phóng ảnh lớn hơn | `(128, 96)`; chỉ kích thước đổi |
| Tăng cường ảnh | A0 | Biến đổi nhẹ | Lật ngang xác suất 0.5; xoay ±8°; dịch 0.05; scale 0.95–1.05; không đổi màu |
| Tăng cường ảnh | A1 | A0 cộng đổi màu nhẹ | A0 + brightness 0.10, contrast 0.10, saturation 0.08, hue 0.02 |
| Tối ưu | T0 | Learning rate và weight decay gốc | `lr=3e-4`, `weight_decay=1e-4` |
| Tối ưu | T1 | Learning rate lớn hơn | `lr=1e-3`, `weight_decay=1e-4` |
| Tối ưu | T2 | Weight decay lớn hơn | `lr=3e-4`, `weight_decay=1e-3` |

`P` trong P0/P1 là preprocessing, tức xử lý ảnh trước model. `A` là augmentation, tức tạo biến thể ảnh chỉ trong lúc train. `T` là tuning choice, tức bộ thông số tối ưu được thử.

### Mã cổng kiểm tra

Cổng (gate) là một điểm dừng có luật rõ: chạy xong bằng chứng của cổng này rồi mới quyết định có đi tiếp hay không.

**Cách đọc bảng:** “Cổng” là mã giai đoạn chạy. “Câu hỏi” là điều duy nhất giai đoạn đó cần trả lời. “Không được hiểu thành” chặn một kết luận quá mạnh.

| Cổng | Câu hỏi cần trả lời | Không được hiểu thành |
|---|---|---|
| G0 | Pipeline có chạy hết, học được tiny batch và ghi đủ artifact không? | Model đã tổng quát tốt |
| G1 | Với cùng ngân sách ngắn, C1/C2/C3 xếp hạng ra sao? | Đã có winner cuối |
| G2 | Khi chỉ đổi P, A hoặc T, kết quả thay đổi thế nào? | Đã thử mọi hyperparameter có thể có |
| G3 | Hai ứng viên tốt nhất làm gì ở ngân sách đầy đủ? | Một seed đã đủ chứng minh ổn định |
| G4 | I1/I2 có giúp không, và pretrained benchmark cách scratch bao xa? | Pretrained được phép làm final |
| G5 | Kết luận có giữ khi đổi seed không? | Hai seed đại diện cho mọi biến động |
| G6 | Lỗi nằm ở lát dữ liệu nào, model có bền và có tự tin đúng mức không? | Chẩn đoán development là điểm holdout |
| G7 | Khóa lựa chọn cuối bằng tất cả bằng chứng đã có. | Được phép xem holdout rồi đổi lựa chọn |
| G8 | Refit trên development, đóng gói và bàn giao. | Refit tạo thêm bằng chứng chọn model |

### Cách giải mã một run ID

**Ví dụ minh họa — mã tự đặt, không phải run ID thật của dự án:** `g1-c2-resnet18-f3-s2753-abc123...`

- `g1`: chạy ở cổng G1.
- `c2-resnet18`: dùng model C2.
- `f3`: fold 3 là validation fold; `f0` đến `f4` là năm fold, không phải năm thời điểm chạy.
- `s2753`: seed là 2753. Seed là số khởi tạo ngẫu nhiên để lần chạy có thể được lặp lại gần nhất có thể.
- `abc123...`: phần nhận dạng ngắn/hash để phân biệt chính xác cấu hình và lần chạy.

Run ID là nhãn truy vết. Nó không phải metric và phần số lớn hơn không có nghĩa model tốt hơn.

## Từ điển từ ngữ cần biết

**Cách đọc bảng:** “Từ” là chữ bạn sẽ gặp trong tutorial. “Nghĩa trong dự án này” giải thích bằng ngôn ngữ thường. “Đừng nhầm với” chỉ ra cách hiểu sai hay gặp.

| Từ | Nghĩa trong dự án này | Đừng nhầm với |
|---|---|---|
| EDA | Khám phá dữ liệu (exploratory data analysis): đếm, vẽ và tìm vấn đề trước khi train. | Kết luận nhân quả |
| Fold | Một phần của development được giữ lại làm validation trong một vòng cross-validation. | Holdout cuối |
| OOF | Dự đoán ngoài fold (out-of-fold): mỗi sản phẩm được dự đoán bởi model không train trên chính sản phẩm đó. | Dự đoán trên training row |
| Metric | Một số đo chất lượng, ví dụ macro-F1 hoặc accuracy. | Loss dùng để cập nhật weights |
| Baseline | Mốc so sánh đơn giản. | Model tệ hoặc không cần nghiêm túc |
| Scratch | Train từ đầu: weights bắt đầu ngẫu nhiên. | Tự viết toàn bộ architecture, không dùng thư viện |
| Pretrained | Weights đã học từ dữ liệu khác trước khi vào Task 2. | Model train từ đầu |
| Artifact | File được tạo ra từ một lần chạy, như checkpoint, CSV, JSON hoặc hình. | Tự động là bằng chứng hợp lệ |
| Evidence | Bằng chứng nhỏ gọn đã kiểm tra để hỗ trợ một claim. | Mọi file tạm trong cache |
| Provenance | Lý lịch của kết quả: config, code, split, seed và hash nào đã tạo nó. | Chỉ tên file |
| Cache | Bản lưu cục bộ để dùng lại kết quả và tránh train lại khi mọi identity còn khớp. | Nguồn sự thật duy nhất của report |
| Hash / SHA-256 | Dấu vân tay của bytes; file đổi thì hash gần như chắc chắn đổi. | Bảo đảm nội dung đúng về khoa học |
| Handoff | Bàn giao component, contract và bằng chứng cho phần còn lại của nhóm. | Đã mở holdout hoặc đã nộp bài |
| Freeze | Khóa một quyết định để không đổi sau khi nhìn dữ liệu đánh giá cuối. | Xóa file hoặc ngừng chạy code |
| Bootstrap | Ước lượng độ không chắc chắn bằng cách lấy lại mẫu từ các nhóm đã có. Không train lại model. | Khởi động máy, CSS Bootstrap, hoặc một training run mới |
| Ultimate Judgement | Quyết định cuối có lý do: chọn gì, bác gì, rủi ro gì và bằng chứng nào hỗ trợ. | Chọn score lớn nhất rồi dừng |

## Từ điển cho lúc train và đọc kết quả

Bạn không cần học thuộc bảng này. Hãy dùng nó như tờ giấy tra nhanh khi một từ xuất hiện trong code, bảng hoặc biểu đồ.

**Cách đọc bảng:** “Từ” là tên trong code hoặc tài liệu. “Nói đơn giản” giải thích nó đang làm gì. “Khi đọc kết quả” nhắc điều phải kiểm tra để không hiểu sai. Với metric, cột cuối cũng nói chiều nào tốt hơn.

| Từ | Nói đơn giản | Khi đọc kết quả |
|---|---|---|
| Development data | Phần dữ liệu được phép dùng để tìm hiểu, train, validation và chọn model. | Không phải holdout cuối. |
| Validation | Phần development tạm giữ ra để chấm model trong một fold. | Model không được train trên chính các dòng này ở fold đó. |
| Holdout | “Đề thi cuối” được giữ kín cho tới khi cả nhóm khóa lựa chọn. | Không được dùng để tuning hoặc đổi model. |
| Cross-validation (CV) | Chia development thành nhiều fold rồi lần lượt đổi fold làm validation. | Repo dùng 5 fold; một model vật lý được train cho mỗi fold. |
| Seed | Con số cố định luồng ngẫu nhiên khi khởi tạo weights và xáo dữ liệu. | Cùng seed giúp chạy lại gần giống; không bảo đảm mọi máy cho bytes giống hệt. |
| Dataset | Đối tượng biết cách lấy một sản phẩm và trả ảnh, nhãn cùng metadata cần thiết. | Dataset chưa tự gom nhiều ảnh thành batch. |
| DataLoader | Công cụ lấy nhiều mẫu từ Dataset, gom thành batch và đưa vào vòng train. | Kiểm tra batch size, shuffle và fold đang dùng. |
| Batch | Một nhóm ảnh được model xử lý trong cùng một bước. | `[N,3,80,60]` nghĩa N ảnh RGB, cao 80 và rộng 60. |
| Epoch | Một lượt model đi qua toàn bộ tập train của lần chạy. | Nhiều epoch hơn không tự bảo đảm model tốt hơn. |
| Weight / parameter | Con số model có thể thay đổi để học. | “Nhiều parameter hơn” không đồng nghĩa “tốt hơn” hoặc “nhanh hơn”. |
| Logit | Điểm thô model cho từng lớp trước softmax. | Logit không phải xác suất và không bị giới hạn trong 0–1. |
| Probability | Xác suất sau softmax; bốn giá trị cộng lại bằng 1. | Tổng bằng 1 chưa chứng minh xác suất đã được hiệu chỉnh tốt. |
| Confidence | Xác suất lớn nhất của dự đoán. | Confidence cao vẫn có thể sai; phải kiểm calibration. |
| Loss | Số đo sai được dùng để tính cách cập nhật weights lúc train. | Thường thấp hơn là tốt trong cùng một loại loss; không so thẳng hai loss khác định nghĩa. |
| Gradient | Tín hiệu cho biết mỗi weight nên đổi theo hướng nào để giảm loss. | Gradient hữu hạn chỉ cho thấy phép học chạy được, không phải điểm đánh giá. |
| Learning rate | Độ dài của mỗi bước cập nhật weights. | Quá lớn có thể nhảy quá xa; quá nhỏ có thể học rất chậm. |
| Weight decay | Mức kéo weights về nhỏ hơn để hạn chế bám quá sát tập train. | Đây là thông số tối ưu, không phải `λ_aux` của I2. |
| Checkpoint | Bản lưu trạng thái model ở một thời điểm train. | Checkpoint tốt nhất của CV khác bundle refit cuối. |
| Registry | Sổ `results/runs.csv` ghi vòng đời từng lần train thật. | Dòng `completed` vẫn phải khớp hash và artifact mới được dùng lại. |
| Manifest | Phiếu kê file: đường dẫn, kích thước, hash, schema và nguồn tạo. | Manifest giúp phát hiện file đổi; nó không tự chứng minh model tốt. |
| Refit | Train lại đúng cấu hình đã thắng trên toàn bộ development sau khi ngừng chọn model. | Refit không được mở lại tuning và train metric không phải điểm kiểm tra độc lập. |
| Inference | Dùng model đã train để đoán ảnh mới mà không cập nhật weights. | API cuối chỉ nhận ảnh, không nhận ArticleType thật. |
| Augmentation | Tạo biến thể ảnh trong lúc train, như lật hoặc đổi màu nhẹ. | Validation và inference không dùng biến đổi ngẫu nhiên này. |
| Accuracy | Tỷ lệ mọi dự đoán đúng. | Cao hơn tốt hơn, nhưng lớp đông có thể che lỗi lớp hiếm. |
| Precision | Trong các ảnh model gọi là một lớp, tỷ lệ gọi đúng. | Cao hơn tốt hơn; nhiều báo nhầm làm precision giảm. |
| Recall | Trong các ảnh thật của một lớp, tỷ lệ model tìm được. | Cao hơn tốt hơn; bỏ sót làm recall giảm. |
| Macro-F1 | Tính F1 riêng cho từng lớp rồi cho bốn lớp trọng lượng bằng nhau. | Cao hơn tốt hơn; đây là metric chính của Task 2. |
| Calibration | Kiểm tra confidence có khớp tần suất đúng ngoài thực tế không. | Ví dụ các dự đoán 80% tự tin nên đúng khoảng 80% trong một nhóm lớn. |
| Slice | Một nhóm con được định nghĩa để tìm chỗ model yếu, như chỉ ảnh xám. | Luôn đọc cùng `support`, tức số mẫu trong nhóm. |
| Robustness | Mức model giữ chất lượng khi ảnh bị thay đổi có kiểm soát. | Model thắng tương đối vẫn có thể rất yếu tuyệt đối. |
| Grad-CAM | Bản đồ nhiệt gợi ý vùng đặc trưng đang đẩy điểm một lớp lên. | Không phải xác suất, không chứng minh nguyên nhân và không đại diện mọi ảnh. |
| Delta (`Δ`) | Phép trừ giữa hai kết quả. | Luôn ghi rõ chiều, ví dụ `I2 − C2`; với F1, số dương ủng hộ tên đứng trước. |

## Bản đồ toàn bộ pipeline

~~~mermaid
flowchart LR
    A[EDA và canonical split] --> B[Dataset, DataLoader, transform]
    B --> C[Model]
    C --> D[Training engine]
    D --> E[Registry và cache]
    E --> F[OOF predictions]
    F --> G[Evidence và figures]
    G --> H[Notebook 03 và report]
    H --> I[Selection freeze]
    I --> J[Development refit]
    J --> K[Image-only inference]
    K --> L[Component handoff]
    L -. chỉ sau group freeze .-> M[Notebook 06 và holdout]
~~~

Mỗi mũi tên là một contract, tức luật giao tiếp giữa hai hộp. Đầu ra của hộp trước phải đúng shape, tên cột, thứ tự nhãn và hash để hộp sau tin được. “Model tốt” nhưng sai split hoặc sai provenance vẫn là sản phẩm không hợp lệ.

### Một sản phẩm đi qua pipeline như thế nào?

**Ví dụ minh họa — ID tự đặt, không phải sản phẩm đang được trích làm bằng chứng:** một ảnh áo có ID `12345` đi qua các bước sau:

1. `splits.csv` nói ID này thuộc development và fold nào.
2. Dataset mở ảnh, resize/pad và biến nó thành tensor `[3, 80, 60]`.
3. DataLoader ghép nhiều sản phẩm thành batch `[N, 3, 80, 60]`.
4. Model tạo bốn logits cho Fall, Spring, Summer và Winter.
5. Engine tính loss, cập nhật weights khi train, hoặc ghi dự đoán khi validation.
6. Khi ID `12345` nằm ở validation fold, dự đoán của nó được ghi vào OOF CSV đúng một lần.
7. Evidence builder ghép năm fold, tính metric và tạo bảng/hình.
8. Notebook chỉ đọc các artifact đó để kể lại kết quả; nó không cần train lại.

## Ba lớp sự thật

1. **Yêu cầu (requirement)** nói ta phải làm gì: assignment PDF và rubric.
2. **Cách làm thật (implementation)** nói code thực sự làm gì: source, config và test.
3. **Bằng chứng (evidence)** nói lần chạy đã đo gì: run row, CSV/JSON, figure, manifest và SHA-256.

Notebook và report là nơi trình bày. Chúng đọc ba lớp trên; chúng không tự tạo ra sự thật.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** assignment nói final phải train từ đầu. Code dùng `weights=None`. Manifest ghi `training_origin=scratch`. Notebook dẫn lại manifest đó. Bốn điểm khớp nhau thì claim “model train từ đầu” có đường truy vết rõ.

## Cache, evidence và output trong notebook khác nhau ra sao?

**Cách đọc bảng:** “Nơi” là loại dữ liệu được lưu. “Dùng để làm gì” là công việc chính. “Nếu xóa” nói hậu quả thường gặp. “Có nên dùng làm nguồn cho report?” trả lời file đó có đủ ổn định để trích dẫn hay không.

| Nơi | Dùng để làm gì | Nếu xóa | Có nên dùng làm nguồn cho report? |
|---|---|---|---|
| Cache trong `tmp/task2/` | Dùng lại checkpoint/history để tránh train lại khi identity khớp. | Có thể phải train lại hoặc không replay được checkpoint cục bộ. | Không dùng một mình |
| Evidence trong `results/evidence/task2/` | Lưu số đo đã kiểm tra, bảng CSV/JSON và provenance. | Mất đường truy vết của kết quả. | Có |
| Output đã nhúng trong `.ipynb` | Cho người mở notebook thấy bảng và hình ngay. | Nếu clear output thì phải replay artifact để hiện lại. | Là phần trình bày, phải dẫn về evidence |
| Figure trong `results/figures/` | Cho notebook/report hiển thị hình ổn định. | Hình tham chiếu có thể bị thiếu. | Có, khi manifest/hash khớp |
| Final bundle trong `models/` | Cho code inference nạp model đã chọn. | Không thể chạy dự đoán cuối bằng bundle đó. | Dùng cho deployment/handoff, không thay OOF evidence |

Vì vậy một notebook **có thể hiển thị đầy đủ mà không train lại**: nó đọc evidence, figure và cache hợp lệ. Cache có thể có nhiều file vì một lần chạy cần checkpoint, history, prediction và identity riêng. Notebook là câu chuyện; nó không chứa mọi weights và mọi bằng chứng bên trong một file duy nhất.

## Bootstrap trong đúng ngữ cảnh này

Bootstrap ở Phase 08 không chạm vào training. Ta đã có OOF prediction của C2 và I2. Ta lấy lại mẫu các **nhóm sản phẩm cùng family** nhiều lần, rồi tính lại chênh lệch `I2 − C2` ở mỗi lần lấy mẫu. Dùng cùng một mẫu nhóm cho hai model gọi là **paired**; làm vậy giữ phép so sánh công bằng.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** giả sử chỉ có ba family A, B, C. Một lượt bootstrap có thể lấy `A, A, C`; lượt khác lấy `B, C, C`. Với mỗi lượt, ta tính macro-F1 của I2 và C2 trên đúng các family được lấy, rồi lấy `I2 − C2`. Lặp nhiều lần cho ta một khoảng không chắc chắn. Model không học lại weights ở bất kỳ lượt nào.

Nếu khoảng 95% chứa 0, dữ liệu hiện có chưa khóa được hướng thắng. Điều đó không có nghĩa hai model giống hệt nhau; nó chỉ nói độ không chắc chắn còn đủ lớn để chênh lệch có thể đổi dấu.

## Luật holdout

Holdout là bộ dữ liệu chỉ dùng một lần để kiểm tra độc lập sau khi toàn nhóm freeze. Nếu nhìn nhãn holdout rồi đổi model, holdout biến thành dữ liệu tuning và không còn độc lập.

Trong curriculum này:

- không mở Notebook 06;
- không gọi loader với <code>evaluation_unlocked=True</code>;
- không đọc protected labels;
- không suy ra holdout score;
- handoff chỉ chứng minh gói Task 2 sẵn sàng, không chứng minh chất lượng trên holdout.

## Cách dùng câu hỏi toggle

Mỗi phase có ít nhất 12 câu trong thẻ <code>&lt;details&gt;</code>. Làm như sau:

1. Đọc câu hỏi nhưng chưa mở đáp án.
2. Nói thành tiếng câu trả lời trong 30–60 giây.
3. Nêu ít nhất một đường evidence.
4. Mở thẻ và đánh dấu phần còn thiếu.
5. Nếu chưa đạt checklist, đọc lại ngay đoạn nằm phía trên câu hỏi. Không cần rời file hiện tại.

## Tự kiểm tra trước khi đi tiếp

Bạn được đi tiếp khi làm được cả bốn việc:

- kể lại câu hỏi khoa học của phase bằng lời của mình;
- trace một kết quả theo chuỗi config → code → test → run → artifact → manifest → commit;
- nói rõ kết quả **cho phép** kết luận gì;
- nói rõ ít nhất một điều kết quả **không cho phép** kết luận.

## Quy ước số

- Metric tỉ lệ nằm trong khoảng 0–1. Ví dụ 0.7527 là 75.27% nếu đổi để trình bày.
- Chênh lệch 0.005 macro-F1 là 0.5 **điểm phần trăm** (percentage points).
- Ký hiệu `Δ` đọc là “delta” và nghĩa là chênh lệch. Tutorial luôn phải nói rõ chiều trừ, ví dụ `I2 − C2`. Với metric càng cao càng tốt, Δ dương ủng hộ model đứng trước; Δ âm nghĩa là nó thấp hơn model sau.
- Làm tròn chỉ đổi chữ số hiển thị. Model selection dùng số raw chưa làm tròn.
- NLL và Brier có thang riêng; không tự thêm ký hiệu phần trăm. Hai metric này càng thấp càng tốt.
- Field <code>peak_vram_mb</code> là một <em>legacy field</em>, tức tên cũ còn giữ để tương thích; giá trị repo tính theo MiB bằng bytes / 1024².
- AMP/mixed precision là cách tính bằng nhiều kiểu số trong GPU. Nó không liên quan việc hiển thị 3 hay 6 chữ số thập phân.

Next: [Assignment và EDA handoff](01_ASSIGNMENT_AND_EDA_HANDOFF.md)
