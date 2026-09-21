# Phase 02 — Repository và nền tảng tái lập được

### 1. Bạn đang ở đâu?

Luật của bài toán đã khóa. Phase này đọc commit 012–024, từ <code>a09b1ac...</code> đến <code>e9ed2c2...</code>. Mục tiêu là hiểu “máy chạy model” trước khi xem model.

**Tái lập được (reproducible)** trong tutorial này nghĩa là: ta lưu đủ cấu hình, seed, phiên bản môi trường, split, code identity và artifact để người khác biết chính xác kết quả được tạo như thế nào và có thể chạy lại gần nhất có thể. Nó không hứa mọi máy luôn tạo ra từng byte giống hệt nhau.

### 2. Vì sao cần phase này?

Một file train đơn lẻ không đủ cho 5 fold nhân với nhiều model ứng viên. Ta cần luật dữ liệu, cách biến đổi tránh rò rỉ, môi trường có seed, bộ máy train, metric, sổ ghi lần chạy, cache, cách ghi file an toàn và test. Nếu thiếu, một lần chạy bị ngắt hoặc một file đã bị đổi có thể bị nhầm thành bằng chứng hợp lệ.

### 3. Nối EDA với hạ tầng

- **Quan sát:** ảnh có tỉ lệ cao/rộng khác nhau và vùng đệm (padding) có thể ảnh hưởng model.
- **Giả thuyết:** giữ tỉ lệ ảnh và chỉ tính mean/std trên pixel thật sẽ tránh bóp hình và tránh để padding làm lệch thống kê.
- **Phép thử ở phase này:** test các contract và G0 smoke, tức kiểm tra nhanh toàn pipeline; chưa phải so model.
- **Kết quả:** loader, transform và engine có ranh giới được máy kiểm tra; G0 về sau học thuộc một batch rất nhỏ và tạo được dòng trong registry.
- **Kết luận:** hạ tầng đủ an toàn để tạo các lần chạy có thể so sánh.
- **Giới hạn:** test bằng dữ liệu giả hoặc rất nhỏ không chứng minh chất lượng trên dữ liệu thật.

Mã cần biết ở phase này: `P0` là ảnh đầu vào cao 80, rộng 60 pixel. `G0` là cổng kiểm tra pipeline, không phải thí nghiệm chọn model.

### 4. Từ cần hiểu trước khi đọc code

**Các tầng trong repository**

- <code>configs/</code>: ý định đã khóa, như model nào và thông số nào.
- <code>src/fashion/data/</code>: dòng dữ liệu, ảnh, nhãn và cách biến đổi ảnh.
- <code>src/fashion/models/</code>: cấu trúc model.
- <code>src/fashion/train/</code>: code chạy train dùng lại được và code ghi lý lịch kết quả.
- <code>src/fashion/task2/</code>: code điều phối riêng cho Task 2 và tạo evidence.
- <code>tests/</code>: các luật có thể chạy để kiểm tra.
- <code>results/evidence/</code>: số đo nhỏ gọn đã được kiểm tra.
- <code>models/</code>: chỉ gói model cuối và manifest mô tả gói đó.

**Python**

Một <code>dataclass</code> gom các trường có tên thành một object. Gợi ý kiểu (type hint) như <code>Path | str</code> nói đầu vào có thể là đường dẫn hoặc chuỗi; code vẫn phải kiểm tra lúc chạy. Context manager, tức khối <code>with ...</code>, đảm bảo file hoặc một dòng registry được đóng đúng cả khi có lỗi.

**Tensor và loaders**

Tensor là mảng nhiều chiều. Batch ảnh P0 có shape <code>[N, 3, 80, 60]</code>: `N` là số ảnh trong batch, `3` là ba kênh RGB, `80` là chiều cao và `60` là chiều rộng. “Rank 4” chỉ có nghĩa tensor có bốn trục; nó không phải thứ hạng model. <code>Dataset.__len__</code> cho số mẫu; <code>__getitem__</code> trả tensor ảnh, nhãn thật, ID và metadata để kiểm tra. <code>DataLoader</code> ghép batch, xáo trộn và có thể dùng worker để nạp song song. Train được xáo trộn; validation luôn giữ ID để ghép dự đoán về đúng sản phẩm.

Resize giữ tỉ lệ cao/rộng, sau đó thêm vùng đệm trung tính. Mean/std chỉ được tính từ pixel thật của training fold, không tính padding. Tăng cường dữ liệu (augmentation) chỉ chạy ở train.

**Forward và loss**

Logit \(z_c\) là điểm thô cho lớp \(c\). Softmax \(p_c=e^{z_c}/\sum_j e^{z_j}\) đổi bốn logit thành bốn xác suất có tổng bằng 1. Với lớp thật \(y\), cross-entropy \(L=-\log p_y\). PyTorch <code>CrossEntropyLoss</code> nhận logit trực tiếp; không chạy softmax trước loss vì hàm loss đã làm phần đó theo cách ổn định hơn.

<code>autograd</code> ghi lại chuỗi phép tính. <code>loss.backward()</code> đi ngược chuỗi đó để tính gradient, tức hướng và mức cần đổi mỗi weight. <code>optimizer.step()</code> dùng gradient để cập nhật weights. <code>zero_grad</code> xóa gradient cũ trước vòng cập nhật mới; nếu quên, gradient sẽ cộng dồn ngoài ý muốn.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** một ảnh thật là Spring nhưng model cho Spring xác suất 0.10. Loss lớn. <code>backward()</code> tính cách đổi weights để lần sau tăng điểm Spring và giảm điểm sai. <code>optimizer.step()</code> thực hiện một bước đổi nhỏ. <code>zero_grad()</code> dọn phần tính cũ trước batch sau.

Tích lũy gradient (gradient accumulation) chia một batch hiệu dụng thành nhiều mini-batch. Cắt gradient (gradient clipping) giới hạn độ lớn để update không bùng lên. AMP dùng nhiều độ chính xác số trên GPU và <code>GradScaler</code> giúp tránh số gradient quá nhỏ trên CUDA.

**Optimizer và schedule**

AdamW tách lực kéo weight nhỏ lại (weight decay) khỏi gradient của loss. Learning rate là độ lớn của mỗi bước cập nhật. Warm-up tăng learning rate từ nhỏ, rồi lịch cosine giảm dần. Early stopping dừng sau nhiều epoch không tăng validation macro-F1. Checkpoint tốt nhất được chọn theo macro-F1 validation chưa làm tròn, không phải cứ lấy epoch cuối.

**Artifact/provenance**

SHA-256 là dấu vân tay gồm 64 ký tự hệ 16. Nó phát hiện bytes khác nhau nhưng không chứng minh nội dung đúng về khoa học. Ghi nguyên tử (atomic write) tạo file tạm hoàn chỉnh rồi mới thay file đích để code khác không đọc phải nửa file. Dòng registry đã kết thúc không được viết lại.

Cache key gồm config, split, nhãn, code implementation, fold và seed. **Cache hit** chỉ xảy ra khi toàn bộ identity đó khớp và bytes/hash của artifact vẫn đúng. Chỉ cần đổi một phần thì phải coi là **cache miss** và không được lặng lẽ dùng kết quả cũ.

**Bốn hộp của “máy chạy model”**

1. **Dữ liệu đi vào:** split chọn dòng; Dataset mở ảnh; transform resize/pad; DataLoader ghép batch.
2. **Model học một batch:** forward tạo logit; loss đo sai; backward tính gradient; optimizer cập nhật weights.
3. **Kết quả được lưu:** checkpoint lưu state tốt nhất; OOF lưu dự đoán; history lưu đường học; registry lưu trạng thái lần chạy.
4. **Cache quyết định có dùng lại không:** so identity và hash; chỉ reuse khi tất cả cùng khớp.

**Các loại file được tạo ra**

**Cách đọc bảng:** “Loại” là tên dễ nhớ. “Ví dụ vị trí” là nơi thường gặp. “Mục đích” nói file phục vụ việc gì. “Là evidence cho report?” trả lời có thể trích làm bằng chứng chính hay chỉ là file hỗ trợ. Cache giúp tránh train lại nhưng không tự trở thành bằng chứng.

| Loại | Ví dụ vị trí | Mục đích | Là evidence cho report? |
|---|---|---|---|
| Checkpoint cache | `tmp/task2/.../*.pt` | Lưu weights tốt nhất để replay hoặc tiếp tục quy trình | Không, nếu đứng một mình |
| History cache | `tmp/task2/.../*history*` | Lưu loss/metric theo epoch | Không, nếu chưa qua evidence builder |
| OOF evidence | `results/evidence/task2/.../oof_predictions.csv` | Lưu đúng một dự đoán validation cho mỗi dòng development hợp lệ | Có |
| Notebook output | `notebooks/03_task2_season.ipynb` | Hiển thị bảng và hình cho người đọc | Là phần trình bày; phải dẫn về evidence |
| Final bundle | `models/` | Đóng gói model cuối, label map và manifest để inference | Dùng cho bàn giao; không thay OOF evidence |

### 5. File và tài liệu cần mở

**PyTorch reproducibility**

- **Vì sao đọc lúc này (Why read this now):** hiểu giới hạn trước khi đọc <code>seed_everything</code>.
- **Đọc đúng phần nào (Exact sections/pages):** cảnh báo đầu trang; Controlling sources of randomness; CUDA convolution benchmarking; Avoiding nondeterministic algorithms; DataLoader.
- **Cần lấy ý gì (What idea to extract):** seed Python/NumPy/Torch, seed worker, yêu cầu tính toán xác định và giới hạn giữa các máy.
- **Tạm bỏ qua gì (What can be skipped for now):** danh sách dài cho từng phép toán ít gặp.
- **Nối với repository (Repository connection):** <code>src/fashion/train/reproducibility.py</code> yêu cầu deterministic algorithms với <code>warn_only=True</code>.
- **Nguồn trực tiếp:** [PyTorch — Reproducibility](https://docs.pytorch.org/docs/stable/notes/randomness.html).

**AdamW**

- **Vì sao đọc lúc này (Why read this now):** hiểu optimizer trong engine.
- **Đọc đúng phần nào (Exact sections/pages):** §2–§3 và thuật toán, trang 2–4 của PDF.
- **Cần lấy ý gì (What idea to extract):** weight decay được tách khỏi gradient loss; không mô tả AdamW đơn giản là “Adam cộng L2”.
- **Tạm bỏ qua gì (What can be skipped for now):** phụ lục cosine restart.
- **Nối với repository (Repository connection):** <code>engine.py</code> và <code>multitask.py</code> dùng <code>torch.optim.AdamW</code>.
- **Nguồn trực tiếp:** [Loshchilov & Hutter, 2019 — Decoupled Weight Decay Regularization](https://arxiv.org/abs/1711.05101), [OpenReview chính thức](https://openreview.net/forum?id=Bkg6RiCqY7).
- **Công thức:** \(\theta_t=\theta_{t-1}-\eta \hat m_t/(\sqrt{\hat v_t}+\epsilon)-\eta\lambda\theta_{t-1}\). \(\eta\) là learning rate; \(\lambda\) là weight decay.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** nếu classifier có một weight 1.0, \(\eta=0.001\) và \(\lambda=0.01\), riêng phần decay kéo weight xuống 0.00001 trước ảnh hưởng của gradient. Paper không chọn hộ hyperparameter đúng cho Task 2.

**PyTorch DataLoader và CrossEntropyLoss**

- **Vì sao đọc lúc này (Why read this now):** hiểu đường dữ liệu và một bước train.
- **Đọc đúng phần nào (Exact sections/pages):** constructor/automatic batching của [DataLoader](https://docs.pytorch.org/docs/stable/data.html); shape đầu vào/nhãn và công thức class-index của [CrossEntropyLoss](https://docs.pytorch.org/docs/stable/generated/torch.nn.CrossEntropyLoss.html).
- **Cần lấy ý gì (What idea to extract):** luật ghép batch và luật đổi logit thành loss.
- **Tạm bỏ qua gì (What can be skipped for now):** dataset streaming kiểu iterable.
- **Nối với repository (Repository connection):** <code>fashion.data.torch</code> và <code>train.engine</code>.

**Ví dụ minh họa — số tự đặt, không phải kết quả dự án:** logit `[0, 0, 2, 0]` cho ảnh thật là Summer tạo xác suất Summer lớn và loss nhỏ hơn bốn logit bằng nhau. Đây chỉ minh họa toán.

### 6. Thứ tự đọc code

1. Dataclasses/config validation trong <code>src/fashion/train/engine.py</code>.
2. <code>src/fashion/data/dataset.py</code> rồi <code>src/fashion/data/torch.py</code>.
3. <code>seed_everything</code> trong <code>reproducibility.py</code>.
4. Public <code>train_fold</code>; sau đó validation helpers.
5. <code>multiclass_metrics</code> trong <code>metrics.py</code>.
6. <code>RunRecord</code>, <code>RunRegistry</code>, tracked-run context.
7. <code>CacheKey</code> và cache verification.
8. Tests; rồi environment/registry artifacts; cuối cùng Notebook consumer.

### 7. Đi xuyên qua cách chạy

~~~text
validate config and loader batch sizes
seed before model construction
with tracked_run(registry, identity):
    for epoch:
        model.train()
        for batch:
            forward → loss / accumulation_steps → backward
            at boundary: unscale → clip → optimizer.step → schedule
        model.eval(); no_grad
        collect ID, target, logits
        metric = raw validation macro-F1
        if better: atomic checkpoint(state_dict + contract)
        if patience exhausted: stop
    reload best state_dict
    write OOF CSV and history
    hash every artifact
~~~

<code>state_dict</code> là mapping tên parameter/buffer → tensor. Checkpoint lưu state và contract; model class vẫn phải được code xây lại. Public result trả paths, hashes, best epoch, metrics, runtime và peak VRAM.

Đọc mã giả trên theo bốn bước:

1. Kiểm tra config và đặt seed **trước khi** tạo model, để khởi tạo weights đi từ seed đã ghi.
2. Trong mỗi batch train: forward → loss → backward. Khi đủ số mini-batch cần tích lũy thì unscale, clip, cập nhật optimizer và đổi learning rate theo schedule.
3. Ở validation: bật <code>model.eval()</code>, không tính gradient, giữ ID và logit. Nếu macro-F1 thô tốt hơn trước thì ghi checkpoint bằng atomic write.
4. Cuối cùng nạp lại checkpoint tốt nhất, ghi OOF/history, tính hash rồi mới đánh dấu run hoàn tất.

Các lỗi có thể gặp: batch hiệu dụng không chia hết; batch size của DataLoader bị lệch; validation thiếu ID; loss là NaN/Inf; ID OOF bị trùng; bytes checkpoint bị đổi; Windows tạm thời từ chối rename. Test cố tình tạo từng tình huống để bắt lỗi sớm, thay vì chờ một lần train dài mới phát hiện.

~~~mermaid
flowchart LR
    C[Config dataclass] --> L[LoaderSpec]
    L --> E[train_fold]
    E --> CK[checkpoint + history + OOF]
    CK --> R[registry row]
    R --> CA[cache verifier]
    CK --> EV[evidence builder]
    EV --> N[Notebook/report]
~~~

Producer nào đổi interface thì mọi consumer và test liên quan phải đổi cùng.

### 8. Test và luật được bảo vệ

- <code>test_torch_transforms.py</code>: aspect ratio, padding, training-only augmentation, content-weighted statistics.
- <code>test_engine.py</code>: checkpoint, OOF, early stopping, batch drift, missing IDs.
- <code>test_metrics.py</code>: label order, probability normalization, macro metrics, calibration helpers.
- <code>test_registry.py</code>: completed/failed/interrupted state, immutable identity, duplicate run, Windows retry.
- <code>test_cache.py</code>: docs không đổi implementation hash; code đổi thì hash đổi; failed/tampered artifact không reuse.
- Scratch model tests về sau kiểm tra <code>weights=None</code>.

### 9. Câu chuyện thay đổi theo thời gian

**Red–Green** là cách sửa có bằng chứng: đầu tiên viết hoặc chạy test tái hiện lỗi và thấy **đỏ**; sau đó sửa nhỏ nhất để test **xanh**. Xanh chỉ có nghĩa test đã đạt, không có nghĩa model tự động tốt.

**Cách đọc bảng:** “#” là số thứ tự curriculum. “Commit” gồm hash ngắn và tên thay đổi. Cột cuối nói hạ tầng được thêm hoặc lỗi được tái hiện/sửa. Khi thấy “regression đỏ/xanh”, hãy ghép commit tái hiện lỗi với commit sửa ngay sau nó; bảng này không chứa metric model.

| # | Commit | Red/Green hoặc implementation story |
|---:|---|---|
| 012 | a09b1ac runtime capture | Thêm seed, runtime và Git provenance; nền cho mọi run |
| 013 | 0ac5038 hashed artifacts | Canonical JSON, SHA-256, atomic write; reject NaN |
| 014 | e87030c registry | Append-only run lifecycle; failure vẫn để lại row |
| 015 | d465135 OOF metrics | Explicit labels, pooled metrics, confusion/probability scores |
| 016 | 642424a AMP engine | Fold engine, accumulation, clipping, checkpoint, early stop |
| 017 | 21fbf27 regression test | Tái hiện float32 log-loss warning trước fix |
| 018 | 84f2328 fix normalization | Normalize probabilities; regression xanh |
| 019 | 1b9de7d hash cache | Reuse chỉ khi identity và artifacts cùng đúng |
| 020 | 8fb8567 data-flow docs | Ghi producer/consumer order |
| 021 | 727bc25 shared verification | Chốt core trước experiment |
| 022 | cb22d48 fold transforms | Resize/pad, fit stats từ train fold |
| 023 | 5546324 content weighting fix | Statistic phải weight theo content pixels, không theo ảnh/padding |
| 024 | e9ed2c2 season loaders | Loader leakage-safe; commit body từng ghi sai test count 23 thay vì 22, code/tests vẫn là evidence cần tin |

### 10. Bằng chứng và số đo thật

Phase này tạo bằng chứng hạ tầng, không tạo bảng xếp hạng model:

- <code>results/evidence/task2/environment.json</code> ghi runtime.
- <code>results/evidence/task2/transform_matrix.csv</code> ghi transform contract.
- <code>results/runs.csv</code> là live registry nên có thể tăng khi một local rerun mới chạy. Snapshot khóa cho curriculum, lấy lúc preflight còn sạch ngày 2026-08-31, có 130 unique Task 2 rows: 122 completed, 2 failed, 6 interrupted. Report từng freeze ảnh chụp 123/116/2/5; đó là mốc cũ, không xóa. Run xuất hiện sau snapshot không được dùng để viết lại historical decision nếu chưa qua gate đầy đủ.
- CV digest: <code>bad7bc4...</code>.
- Limitation: registry count cho biết trace completeness, không phải quality.

### 11. Cách hiểu kết quả

Khả năng tái lập không có nghĩa “mọi máy cho bytes giống nhau”. Repository yêu cầu hành vi ổn định khi có thể và ghi lại môi trường chạy. <code>warn_only=True</code> nghĩa là một phép tính không hoàn toàn ổn định vẫn có thể chạy, nhưng phải phát cảnh báo. Hash trả lời “file có cùng bytes không”; seed trả lời “luồng ngẫu nhiên bắt đầu thế nào”; test trả lời “luật nào đã được kiểm”. Ba câu trả lời này không thay thế nhau.

### 12. Quyết định

Hạ tầng đủ để chạy B0/B1 và learned models. Không chạy long experiment nếu G0, loader, registry và cache contract chưa xanh.

### 13. Bài học của senior

Các dòng `failed` (thất bại) và `interrupted` (bị ngắt) là dấu vết kiểm tra, không phải rác. Xóa chúng sẽ làm mất lịch sử vận hành. Cách đúng là tạo run ID mới, giữ bằng chứng cũ, và chỉ cho cache dùng dòng `completed` khi mọi hash còn hợp lệ.

### 14. Hiểu lầm hay gặp

- <code>model.eval()</code> không tắt gradient; <code>no_grad</code> mới làm việc đó.
- <code>state_dict</code> không chứa Python class implementation.
- Seed giống nhau không xóa khác biệt platform/version.
- SHA-256 match không chứng minh đúng split nếu manifest khai sai input; vì vậy verify cả declarations.
- Peak VRAM là MiB dù field kết thúc bằng <code>_mb</code>.
- AMP không phải decimal display precision.

### 15. Câu hỏi tự luyện

<details>
<summary><strong>Nhớ lại 1:</strong> Tensor ảnh có shape nào trong engine?</summary>

**Gợi ý trả lời**

- Batch dùng [N, C, H, W]; P0 thường là [N, 3, 80, 60]. N là batch, C là RGB channels.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

<details>
<summary><strong>Nhớ lại 2:</strong> Dataset và DataLoader chia việc thế nào?</summary>

**Gợi ý trả lời**

- Dataset ánh xạ index thành sample; DataLoader gom sample thành batch, shuffle train và điều phối worker.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

<details>
<summary><strong>Nhớ lại 3:</strong> Registry, cache và manifest khác nhau ra sao?</summary>

**Gợi ý trả lời**

- Registry là ledger từng run; cache quyết định reuse bằng identity+hash; manifest khai báo artifact cùng digest/provenance.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

<details>
<summary><strong>Vì sao 4:</strong> Vì sao thống kê chuẩn hóa phải tính riêng từ các fold train?</summary>

**Gợi ý trả lời**

- Nếu dùng validation pixels để fit mean/std, validation đã ảnh hưởng transform và OOF không còn held-out hoàn toàn.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

<details>
<summary><strong>Vì sao 5:</strong> Vì sao model.train và model.eval đều cần?</summary>

**Gợi ý trả lời**

- Chúng đổi hành vi Dropout/BatchNorm; train dùng stochastic/update stats, eval dùng frozen behavior.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

<details>
<summary><strong>Vì sao 6:</strong> Vì sao một dòng registry đã hoàn tất vẫn chưa đủ để dùng lại cache?</summary>

**Gợi ý trả lời**

- Artifact có thể thiếu hoặc bị đổi; cache còn xác minh config, split, labels, implementation và artifact SHA-256.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

<details>
<summary><strong>Lần theo code 7:</strong> Lần theo một batch qua một bước train.</summary>

**Gợi ý trả lời**

- zero_grad → forward logits → CrossEntropyLoss → scaled/backward → accumulation boundary → unscale/clip → optimizer.step → scheduler.step.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

<details>
<summary><strong>Lần theo code 8:</strong> Lần theo validation để tạo artifact OOF.</summary>

**Gợi ý trả lời**

- eval + no_grad → logits → softmax → id/true/pred/prob columns → exactly-once audit → atomic CSV + hash → registry.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

<details>
<summary><strong>Tìm lỗi 9:</strong> Validation loader thiếu ID sẽ gây gì?</summary>

**Gợi ý trả lời**

- Engine từ chối vì không thể gắn prediction với product và không thể audit OOF coverage; test có case riêng.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

<details>
<summary><strong>Tìm lỗi 10:</strong> Tại sao xác suất float32 từng làm log-loss cảnh báo?</summary>

**Gợi ý trả lời**

- Sai số tổng probability/biên số có thể làm metric warning; regression test tái hiện và fix normalize trước metric.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

<details>
<summary><strong>Bảo vệ miệng 11:</strong> Giải thích AMP khác việc làm tròn số để hiển thị.</summary>

**Gợi ý trả lời**

- AMP dùng float16/bfloat16 cho một số GPU ops và scaling gradients; rounding chỉ đổi chữ số khi trình bày artifact.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

<details>
<summary><strong>Bảo vệ miệng 12:</strong> Bạn bảo vệ nguồn gốc kết quả bằng chuỗi nào?</summary>

**Gợi ý trả lời**

- Config canonical hash + split hash + label-map hash + implementation hash + artifact hash + immutable terminal registry row.
- Nói được “được kết luận” và “không được kết luận”.
- Dùng raw evidence, không suy từ số đã làm tròn.

**Bằng chứng cần nhắc đến**

- Config: configs/task2/g0_pipeline_smoke.json và experiment dataclasses
- Code: src/fashion/data/torch.py; src/fashion/train/engine.py, registry.py, cache.py, reproducibility.py
- Test: tests/data/test_torch_transforms.py; tests/train/test_engine.py, test_registry.py, test_cache.py
- Run/artifact: results/evidence/task2/environment.json; results/runs.csv; tmp/task2/checkpoints (generated)
- Commit: dải a09b1ac... → e9ed2c2...
- Limitation: Deterministic settings giảm biến thiên; PyTorch không hứa bit-identical giữa mọi platform/version.

</details>

### 16. Checklist trước khi đi tiếp

- [ ] Tôi trace được batch từ Dataset tới OOF CSV.
- [ ] Tôi phân biệt train/eval, backward/step và logits/probability.
- [ ] Tôi giải thích registry, cache, manifest và SHA-256.
- [ ] Tôi biết fold-fitted transform ngăn leakage thế nào.
- [ ] Tôi biết reproducible claim bị giới hạn bởi platform/runtime.

### 17. Bước tiếp theo

Next: [Baselines B0 và B1](03_BASELINES_B0_AND_B1.md)
