# Phase 09 — Freeze, refit, inference và handoff

**Từ cần biết trước khi đọc dòng đầu tiên:** các từ dưới đây là tên bước và tên
file của chính repository này. Chúng không phải mật mã mà người đọc phải tự đoán.

- **Holdout** là phần dữ liệu “đề thi cuối”. Nhóm chưa mở nhãn Season của phần này.
  Holdout chỉ được dùng một lần sau khi cả nhóm đã khóa mọi quyết định.
- **Freeze** là khóa một quyết định để không sửa nó sau khi thấy thêm kết quả.
  “Immutable” cũng mang ý này: nội dung đã khóa thì không được ghi đè bằng nội dung khác.
- **G8** là mã của giai đoạn thí nghiệm số 8 trong repository. G8 không chọn model
  mới. Nó lấy lựa chọn đã khóa ở G7 và tạo gói model cuối.
- **Refit** là train lại đúng model đã chọn trên toàn bộ dữ liệu development hợp lệ.
  Refit không phải tuning: không thử learning rate, kiến trúc hay số epoch mới.
- **Bundle** là file gói model: trọng số đã học cùng thông tin cần để dùng model đúng cách.
- **Manifest** là “phiếu kê hàng” đứng cạnh bundle. Nó ghi tên file, kích thước,
  hash và nguồn tạo file để máy có thể phát hiện file sai hoặc bị đổi.
- **Registry** là sổ nhật ký các lần chạy ở <code>results/runs.csv</code>. Một dòng cho
  biết run nào đang chạy, hoàn tất hay thất bại và artifact của run nằm ở đâu.
- **Provenance** là nguồn gốc có thể truy ngược: bundle này đến từ code nào, config
  nào, dữ liệu nào và run nào.
- **Inference** là dùng model đã train để dự đoán cho ảnh mới. Bước này chỉ đọc
  bundle; nó không train lại model.
- **Handoff** là bàn giao component Task 2 đã kiểm tra cho người phụ trách đánh giá
  chung của nhóm. Bàn giao xong vẫn không có nghĩa được phép mở holdout.

### 1. Bạn đang ở đâu?

I2 đã được freeze ở phase trước. Commit 267–337, từ <code>073082c...</code> đến
HEAD <code>0d92496...</code>, làm năm việc: refit trên toàn bộ development, sửa lỗi
toàn vẹn artifact, tạo inference chỉ nhận ảnh, khóa gói handoff, rồi làm Notebook
đọc lại artifact mà không train. Đây là phase kỹ thuật dài nhất, nhưng không còn là
phase đi tìm model tốt hơn.

### 2. Vì sao cần phase này?

Trong cross-validation (CV), mỗi checkpoint chỉ học trên 4/5 dữ liệu development;
1/5 còn lại được giữ ra để chấm fold đó. Các checkpoint này phù hợp để **chọn**
model, nhưng không phải gói cuối để giao.

Sau khi lựa chọn đã freeze, G8 train lại đúng cấu hình đó trên toàn bộ 32,753 dòng
development có nhãn Season. G8 không tạo validation split mới và không nhìn holdout
để sửa config. Khi đóng gói, nguyên tắc **fail closed** được dùng: nếu bytes, nguồn
gốc hoặc registry không khớp thì dừng và báo lỗi; không đoán rằng file “chắc vẫn ổn”.

### 3. Nối với EDA

Phép biến đổi ảnh cuối vẫn giữ tỉ lệ ảnh (preserve aspect ratio). Thống kê chuẩn hóa
được tính trên pixel nội dung của toàn bộ development hợp lệ. Dòng thiếu ArticleType
được che loss phụ bằng mask; dòng thiếu Season bị loại khỏi Task 2. Các metadata dễ
tạo đường tắt không đi vào inference. Nhãn holdout vẫn bị che.

- **Giả thuyết (hypothesis):** đúng cấu hình I2 đã freeze có thể được refit với số
  epoch cố định và đóng gói sao cho lần kiểm tra sau vẫn truy được nguồn gốc.
- **Phép thử (experiment):** G8 chỉ dùng development.
- **Kết quả (result):** mọi số tối ưu đều hữu hạn; audit handoff đạt 10/10 kiểm tra.
- **Kết luận (conclusion):** component sẵn sàng để bàn giao nội bộ.
- **Giới hạn (limitation):** đường train không đo khả năng tổng quát hóa; đánh giá
  độc lập trên holdout chưa chạy.

### 4. Từ cần hiểu trước khi đọc code

**Selection freeze** là file JSON khóa ứng viên, config/run ID, hash, metric, thông
tin calibration, luật refit và giới hạn. Chạy lại với nội dung y hệt thì được; dùng
nội dung khác để ghi đè cùng quyết định thì bị cấm.

**Development refit** train cấu hình đã chọn trên toàn bộ development. Số epoch cố
định là trung vị của best epoch trong CV: 24. Không có validation split mới và không
early stopping. Train loss/accuracy chỉ cho thấy bộ tối ưu (optimizer) đang học trên
chính dữ liệu train; chúng không phải điểm kiểm tra độc lập.

**Bundle** gồm trạng thái model, đặc tả model, thứ tự label, thống kê transform,
temperature calibration và provenance. **Manifest** đứng ngoài bundle, khai kích
thước bytes, hash, cấu trúc và nguồn. **SHA-256** là dấu vân tay dài 64 ký tự hệ 16;
chỉ cần một byte đổi thì dấu vân tay gần như chắc chắn đổi.

**Provenance** trả lời bytes được tạo bởi code, config, dữ liệu và run nào. Dòng
registry ghi vòng đời run. Implementation hash ghi dấu tập source code phụ thuộc.
Cache key chỉ quyết định có thể tái dùng cache hay không; nó không tự chứng minh final
bundle hợp lệ. Loader cuối vẫn kiểm tra artifact thật đang nằm trên đĩa.

**Inference** là API chỉ nhận ảnh và cho cùng kết quả khi bundle và ảnh không đổi.
Nó trả về label, bốn xác suất đúng thứ tự, confidence, thời gian chạy và hash.
<code>review_required=None</code> vì nhóm chưa có chi phí lỗi nghiệp vụ để khóa một
ngưỡng chuyển ảnh sang người kiểm tra.

**Handoff** là hợp đồng bàn giao giữa Task 2 và người phụ trách đánh giá chung.
“Ready” chỉ nói gói qua kiểm tra kỹ thuật. Nó không đồng nghĩa “Notebook 06 đã mở”.

### 5. Tài liệu cần mở lúc này

**Local immutable sources**

- Vì sao đọc lúc này (Why read this now): sự thật cuối nằm trong freeze/manifest,
  không nằm trong lời kể.
- Phần cần đọc (Exact sections/pages): toàn bộ
  <code>results/evidence/task2/selection_freeze.json</code>,
  <code>models/task2_season.manifest.json</code> và
  <code>results/evidence/task2/final_handoff/manifest.json</code>.
- Ý cần rút ra (What idea to extract): hash, cờ khóa, run ID và ranh giới
  refit/inference chính xác.
- Có thể bỏ qua gì lúc này (What can be skipped for now): không bỏ field nào;
  ba file này là hợp đồng nguồn gốc và an toàn.
- Nối với repository (Repository connection):
  <code>src/fashion/task2/refit.py</code>, <code>src/fashion/task2/inference.py</code>
  và <code>src/fashion/task2/handoff.py</code> kiểm các field đó.
- Nguồn trực tiếp (Direct source): ba file local ở trên.

**PyTorch state serialization**

- Vì sao đọc lúc này (Why read this now): hiểu <code>state_dict</code> và ranh giới load.
- Phần cần đọc (Exact sections/pages): phần lưu/nạp <code>state_dict</code> và gọi
  <code>model.eval()</code> sau khi load.
- Ý cần rút ra (What idea to extract): code dựng khung model; state dict cung cấp
  tham số và buffer đã học.
- Có thể bỏ qua gì lúc này (What can be skipped for now): distributed checkpoint.
- Nối với repository (Repository connection): bundle giữ đúng trạng thái model
  scratch; verifier chạy trước khi dựng và load model.
- Link trực tiếp (Direct link): [PyTorch — Saving and Loading Models](https://docs.pytorch.org/tutorials/beginner/saving_loading_models.html).
- Ranh giới claim (Claim boundary): tài liệu serialization không chứng minh nguồn
  gốc artifact; manifest và test của repository làm việc đó.

### 6. Thứ tự đọc code

1. <code>selection_freeze.json</code>.
2. Development-only refit loader.
3. Fixed-epoch multitask refit engine.
4. <code>refit.py</code> validation, locks, staging, registry, manifest load verifier.
5. Refit tests và invalidated package records.
6. Model manifest/bundle hash/history/runtime.
7. <code>inference.py</code> dataclasses, loader, predict.
8. <code>handoff.py</code> ten-check audit.
9. Inference/handoff tests then live handoff manifest.
10. Notebook 03 section 14–15 consumer; không cần chạy ở bước đọc này. Nếu chạy toàn notebook, dùng artifact replay đã khóa; không train lại.

### 7. Đi xuyên qua cách chạy

Refit:

Đọc khối dưới từ trên xuống. Mỗi dòng là một chốt an toàn. Nếu một chốt thất bại,
run không được xuất bản thành gói đang dùng.

~~~text
load and verify immutable G7 freeze
lock lifecycle; refuse parallel live process
load all valid development rows only
fit content-pixel normalization on these rows
seed before model construction
build scratch I2; assert boundary
train exactly 24 epochs; no validation
reject non-finite state/history
stage bundle/history/runtime/manifest
append exact registry row; verify it
publish transactionally; verify all hashes
~~~

- **Lock lifecycle** ngăn hai process cùng ghi đè gói cuối.
- **Non-finite** là giá trị không dùng được như <code>NaN</code> hoặc vô cực.
- **Stage** là ghi vào vùng tạm để kiểm trước.
- **Publish transactionally** là chỉ công bố cả bộ file sau khi tất cả đều hợp lệ;
  không để lại “nửa bundle mới, nửa manifest cũ”.

Inference:

Khối này không có bước <code>backward</code>, optimizer hay train. Nó chỉ giải mã ảnh,
áp dụng đúng transform đã freeze, chạy model và chuyển logits thành xác suất.

~~~text
bundle = load_season_bundle(path)
image = safe_decode(explicit_path, pixel_limit)
tensor = frozen_transform(image)
logits = bundle.model.predict_season_logits(tensor)
probs = softmax(logits / 1.3650015953)
return ordered SeasonPrediction + provenance
~~~

Handoff state machine:

**Cách đọc sơ đồ:** mỗi ô là một trạng thái của gói model. Mũi tên ghi
hành động hoặc điều kiện làm gói chuyển sang trạng thái kế. Đường bình thường là
<code>Frozen → RefitRunning → BundleVerified → InferenceVerified → ComponentReady</code>.
Nếu kiểm tra thất bại, gói đi sang <code>Invalidated</code>; muốn thử lại phải tạo run
ID mới. Hai ô cuối, <code>GroupFreeze</code> và <code>Notebook06</code>, cần hành động
của cả nhóm và chưa xảy ra trong phase này. Sơ đồ mô tả trạng thái, không phải điểm
accuracy và không chứng minh model tổng quát hóa tốt.

~~~mermaid
stateDiagram-v2
    [*] --> Frozen: G7 decision
    Frozen --> RefitRunning: exact 24-epoch config
    RefitRunning --> Invalidated: integrity check fails
    Invalidated --> RefitRunning: new run ID
    RefitRunning --> BundleVerified: all artifacts + registry match
    BundleVerified --> InferenceVerified: safe image-only smoke
    InferenceVerified --> ComponentReady: 10/10 handoff checks
    ComponentReady --> GroupFreeze: external group action
    GroupFreeze --> Notebook06: one independent evaluation
~~~

Các gói đã bị đánh dấu không hợp lệ không được quay lại trạng thái đang dùng. Chúng được giữ để giải thích lỗi đã xảy ra và chứng minh gói nào thay thế chúng.

Nói đơn giản: package bị đánh dấu hỏng vẫn được giữ làm bằng chứng điều tra, nhưng
loader không được phép dùng nó để dự đoán.

### 8. Test và các luật được bảo vệ

Test refit kiểm đúng số dòng và 24 epoch, cấm holdout, bắt các cờ Boolean đúng kiểu, yêu cầu đúng một dòng registry hoàn tất, phát hiện file bị sửa, xử lý hai tiến trình chạy cùng lúc, xuất bản theo giao dịch, chặn số NaN/Inf và tính hash trên đầy đủ code phụ thuộc.

Test inference kiểm thứ tự nhãn/xác suất và tổng xác suất, yêu cầu kiểm manifest trước khi nạp model, xử lý ảnh hỏng/thiếu/quá lớn, giữ API chỉ nhận ảnh và trả lỗi CLI đúng JSON.

Test bàn giao tự tính lại các claim, hash, thời gian chạy, identity trong registry, đầu vào chuẩn, lần dự đoán thử, luật thay thế bất biến và các cờ khóa.

### 9. Câu chuyện thay đổi theo commit

- 267–271: loader → fixed-epoch engine → bundle publisher → initial provenance/notebook evidence.
- 272–283: five Red–Green integrity pairs: registry binding, parallel overwrite lock, transactional publish, full implementation hash, non-finite rejection, strict booleans.
- 284–292: archive first invalid package; Windows lock retry <code>7c4346b→a37a6cf</code>; canonical file-order mismatch <code>4208592→319eeba</code>; replacement refit.
- 293–297: verified inference + CLI; oversized image regression/fix <code>db59a06→e76f222</code>.
- 298–305: locked handoff + launcher/evidence; regression pack <code>4372442→9624d76</code>; component checklist.
- 306–321: edge defect audit, bind registry provenance, portable/unified validation, font fix, notebook single-output refactor. A later valid package <code>...4ab5682a30e1</code> bị archive/supersede khi provenance implementation changed; commits 315–318 publish hardened replacement/handoff.
- 322–333: tests reject generic/shallow/duplicated notebook interpretations; deep analysis added; table visibility, numeric precision và units clarified. Không có model selection change.
- 334: Notebook 03 được chạy sạch từ 147 artifact-only cells; mọi table/figure/output được lưu lại, replay roots được khóa hash, và các guard cấm training/write được siết. Không train lại model và không đổi metric, parameter hay selection.
- 335: Notebook 03 thêm bản đồ code training chỉ-đọc, lệnh `load`/`run` đúng launcher và guard cấm gọi trainer trong replay; execution report đồng bộ số kiểm tra và dùng mô tả audit trung tính. Không train lại model, không đổi artifact, metric, parameter hay selection.
- 336: PR merge đưa lịch sử Task 2 đã kiểm tra vào nhánh chính bằng clean merge; combined merge view không có conflict-resolution diff và tree đúng bằng parent chứa Task 2.
- 337: nhánh feature nhận lại nhánh chính bằng clean merge; tree giữ nguyên đúng bằng `f800ff5`, nên không có code, artifact, metric, parameter hay selection mới.

### 10. Bằng chứng và số đo thật

**Refit cuối**

- Run: <code>task2-season-i2-refit-fall-s2753-637dd6378be9</code>.
- 32,753 rows/epoch; 6,144 optimizer updates; 24 epochs.
- Total train loss 1.789050→0.551781; train accuracy 0.559124→0.820505.
- 1,206,112 parameters; 231.30 s; peak 135.04 MiB.
- Bundle 4,856,199 bytes, SHA-256 <code>5927eff73130acedc8015199e1df5a6c6edf64c0b45023ebd91c48d7ed40f93c</code>.
- Manifest SHA-256 <code>25d918061dbd9b46501de9aa3671adabf951649862ce9613317983dadbac55d9</code>.
- Selection freeze SHA-256 <code>51475a6e...</code>.

Cách đọc các số trên:

- <code>rows/epoch</code> là số mẫu model thấy trong một vòng train.
- <code>optimizer updates</code> là số lần trọng số được cập nhật.
- Loss thấp dần và train accuracy cao dần là dấu hiệu quá trình train chạy được;
  chúng không phải điểm OOF hay điểm holdout.
- <code>parameters</code> là số tham số có thể học của model.
- Giây và MiB là chi phí đo trên máy đã chạy; không nên coi là tốc độ chung cho mọi máy.
- Số bytes và SHA-256 nhận dạng đúng file; chúng không đo chất lượng dự đoán.

Dấu vết các gói bị loại: <code>...3d60bd14cc91</code> là gói đầu; <code>...294dece2c93b</code> thất bại và được quay lui vì thứ tự file không cố định; <code>...4ab5682a30e1</code> từng hợp lệ nhưng được thay bằng bản kiểm nguồn gốc chặt hơn. Không dùng ba gói này.

**Dự đoán và bàn giao**

Ảnh dùng để thử nhanh có ID 1163 được đoán là Summer với confidence 0.9282096; đây không phải metric trên holdout. Audit artifact đạt 10/10 kiểm tra. Manifest bàn giao cuối có SHA-256 <code>ccf5eb5e36a6b160e2b70e04f2f8b3daabea9fe863f00c567e4b2cbeb81b8eab</code>. Các cờ vẫn ghi Notebook 06 và holdout là `false`, tức chưa mở.

**Vì sao số dòng registry thay đổi theo thời điểm**

Snapshot registry trước khi replay tại <code>45c1d40</code>, được lấy trước các lần chạy lại cục bộ về sau, có 130 dòng Task 2 khác nhau: 122 hoàn tất, 2 thất bại và 6 bị ngắt. Execution report ghi 123 dòng = 116/2/5 vì đó là snapshot cũ hơn. <code>results/runs.csv</code> là trạng thái cục bộ đang sống nên số dòng có thể tăng; tutorial luôn gắn số với đúng thời điểm/phạm vi và không viết lại report lịch sử.

### 11. Cách hiểu kết quả

Chẩn đoán train cho thấy optimizer tiếp tục học; nó không phải điểm chất lượng không thiên lệch. Kết luận chất lượng cuối vẫn dựa trên OOF năm fold trước khi freeze. Inference có hash đúng chứng minh gói nhất quán, không chứng minh accuracy ngoài thực tế. Việc nhiều gói cũ bị loại cho thấy audit trail đã làm đúng việc: tìm lỗi, tái hiện, sửa và cô lập bytes cũ.

### 12. Quyết định

Component Task 2 đã sẵn sàng để cả nhóm freeze. Trong phần việc này không thêm kiến trúc, không chỉnh ngưỡng, không chạm holdout, không tạo CSV chính thức và không mở Notebook 06.

### 13. Bài học của senior

Bước hoàn thiện thường lộ lỗi mà test model chưa thấy: hai tiến trình chạy cùng lúc, chỉ xuất bản được nửa gói, registry cũ, tensor NaN/Inf, Windows khóa file và thứ tự nguồn gốc không cố định. Phải coi code đóng gói như code dùng thật, không phải chỉ gọi “save model” một dòng.

### 14. Hiểu lầm hay gặp

- Refit train accuracy 0.8205 không phải final evaluation accuracy.
- Last epoch đúng vì epoch count đã freeze, không vì last luôn tốt.
- SHA match không thay thế schema/semantic validation.
- Inference smoke success không phải holdout evidence.
- Handoff ready không unlock group evaluation.
- Invalidated package không được xóa khỏi story hoặc dùng lại.

### 15. Câu hỏi tự luyện

<details>
<summary><strong>Nhớ lại 1:</strong> Refit dùng bao nhiêu dòng và bao nhiêu epoch?</summary>

**Gợi ý trả lời**

- 32,753 valid development rows, fixed 24 epochs từ median primary-seed CV best epochs [22,29,14,26,24].
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

<details>
<summary><strong>Nhớ lại 2:</strong> Hash của bundle cuối là gì?</summary>

**Gợi ý trả lời**

- 5927eff73130acedc8015199e1df5a6c6edf64c0b45023ebd91c48d7ed40f93c.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

<details>
<summary><strong>Nhớ lại 3:</strong> Các cờ khóa quan trọng khi bàn giao là gì?</summary>

**Gợi ý trả lời**

- task2_component_ready=true, notebook_06_unlocked=false, holdout_opened=false.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

<details>
<summary><strong>Vì sao 4:</strong> Vì sao refit không có metric validation?</summary>

**Gợi ý trả lời**

- Freeze yêu cầu train all valid development rows; tạo validation mới sẽ đổi population/selection sau freeze.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

<details>
<summary><strong>Vì sao 5:</strong> Vì sao checkpoint cuối lấy epoch cuối thay vì dừng sớm?</summary>

**Gợi ý trả lời**

- 24 epochs đã freeze từ CV median; refit không có validation/holdout để chọn epoch khác.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

<details>
<summary><strong>Vì sao 6:</strong> Vì sao ngưỡng chuyển cho người kiểm tra trong app để null?</summary>

**Gợi ý trả lời**

- Không có business error cost; calibration/risk curve chưa đủ để chọn operational threshold.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

<details>
<summary><strong>Lần theo code 7:</strong> Lần theo load_season_bundle.</summary>

**Gợi ý trả lời**

- Verify manifest/bundle/canonical inputs/hashes/provenance → construct exact scratch model → load state_dict → validate label/transform/temperature → return immutable bundle.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

<details>
<summary><strong>Lần theo code 8:</strong> Lần theo predict_season.</summary>

**Gợi ý trả lời**

- Validate explicit image size/decode → EXIF/RGB/frozen resize-pad-normalize → image-only logits → divide T/softmax → ordered probabilities/label/confidence/latency/provenance.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

<details>
<summary><strong>Tìm lỗi 9:</strong> Thứ tự file trong manifest không cố định gây gì?</summary>

**Gợi ý trả lời**

- Implementation hash/provenance disagree dù files same; failed run rollback; fix canonical order and create new run, không edit old row.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

<details>
<summary><strong>Tìm lỗi 10:</strong> Nếu process dừng giữa lúc xuất bản bundle và manifest, cách phòng là gì?</summary>

**Gợi ý trả lời**

- Stage artifacts và transactional publish; registry completed chỉ sau full verification; partial residue không trở thành live package.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

<details>
<summary><strong>Bảo vệ miệng 11:</strong> Bàn giao chứng minh gì?</summary>

**Gợi ý trả lời**

- Artifact/inference/provenance component passes 10 checks and is ready for group freeze.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

<details>
<summary><strong>Bảo vệ miệng 12:</strong> Bàn giao không chứng minh gì?</summary>

**Gợi ý trả lời**

- Không có holdout quality, production accuracy, app policy hay official CSV validity; Notebook 06 vẫn khóa.
- Gắn câu trả lời với exact evidence.
- Nêu ít nhất một claim boundary.

**Bằng chứng cần nhắc đến**

- Config: results/evidence/task2/selection_freeze.json và frozen bundle metadata
- Code: src/fashion/task2/refit.py, inference.py, handoff.py; src/fashion/train/multitask.py
- Test: tests/task2/test_refit.py, test_inference.py, test_handoff.py và launcher tests
- Run/artifact: models/task2_season.pt; models/task2_season.manifest.json; results/evidence/task2/development_refit/ và final_handoff/
- Commit: dải 073082c... → 0d92496...
- Limitation: Refit train metrics không unbiased quality; handoff không phải holdout evidence; app/group integration còn deferred.

</details>

### 16. Checklist trước khi đi tiếp

- [ ] Tôi phân biệt CV checkpoint, selection freeze và refit bundle.
- [ ] Tôi giải thích được vì sao refit không validation.
- [ ] Tôi trace load/predict/handoff.
- [ ] Tôi kể ba invalidated package stories.
- [ ] Tôi nói rõ component-ready khác holdout-tested.

### 17. Bước tiếp theo

Next: [Complete commit timeline](10_COMPLETE_COMMIT_TIMELINE.md)
