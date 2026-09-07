# Toàn bộ lịch sử commit (Complete commit timeline) — 337/337

Trang này là **sổ lịch sử code**, không phải một bài học model mới. Một commit là
một lần lưu thay đổi vào Git. Con số 337 nghĩa là phạm vi đã chốt có 337 commit và
trang này có đúng một card cho từng commit.

## Đọc trang dài này theo ba lượt

Đừng cố đọc 337 card từ đầu đến cuối trong một lần.

1. **Lượt 1 — hiểu câu chuyện:** đọc bảng phase ở dưới. Sau đó chỉ mở dòng
   <code>summary</code> của card bạn quan tâm. Mục tiêu là biết thay đổi xảy ra ở đâu.
2. **Lượt 2 — kiểm bằng chứng:** trong card đó, đọc “Trạng thái trước”, “Thay đổi
   thực tế”, “Cách xác minh” và “Limitation”. Mục tiêu là phân biệt điều commit thật
   sự làm với điều ta chưa được phép kết luận.
3. **Lượt 3 — kiểm Git khi cần:** dùng full hash trong card với
   <code>git show --stat FULL_HASH</code> và <code>git show --name-status FULL_HASH</code>.
   Lượt này dành cho review hoặc viva; không cần chạy cho cả 337 card mỗi lần học.

Đây là lần ôn cuối theo đúng thời gian cũ nhất → mới nhất. Source of truth là read-only command:

<code>git log --reverse --topo-order 17e028edcd99697f425ad4bb6baf90a84a1fd43d..0d92496</code>

## Phạm vi phải bao phủ (Coverage contract)

- Base excluded: <code>17e028edcd99697f425ad4bb6baf90a84a1fd43d</code>.
- First included commit index 001; last index 337.
- Mỗi full 40-character hash xuất hiện đúng một lần trong ledger cards.
- Changed files được lấy trực tiếp từ Git, không suy từ report.
- Subject cho biết intent; diff/test/artifact mới cho biết actual change.
- Classification gồm Task 2 direct, shared dependency, project boundary, unrelated to Task 2. Không commit nào bị bỏ im lặng.
- Sau khi đọc diff: 298 commit là <code>Task 2 direct</code>, 39 là <code>shared dependency</code>; không commit nào trong exact range này thật sự thuộc hai nhãn còn lại.
- File <code>audit_tutor.ps1</code> so exact hash list, duplicate, missing và order.

## Các dải phase liên tục (Continuous phase ranges)

**Cách đọc bảng:** “Chương tutorial” là phase 01–09, không phải số commit và
không phải mã thí nghiệm G0–G8. “Chỉ số commit” là vị trí 001–337 trong sổ,
không phải hash Git. “Mục đích chính theo thời gian” tóm tắt việc chung của cả dải;
nó không nói mọi commit trong dải đều train model hoặc đều tạo metric mới. Chỉ số
commit tăng theo thứ tự lịch sử topo đã chốt, không đo chất lượng hay độ lớn thay đổi.

| Chương tutorial | Chỉ số commit | Mục đích chính theo thời gian |
|---|---:|---|
| 01 | 001–011 | dựng khung assignment, khóa quy trình, môi trường chạy và thư viện phụ thuộc |
| 02 | 012–024 | nền chạy ổn định, artifact, registry, metric, engine, cache, transform và loader |
| 03 | 025–026 | triển khai hai baseline B0 và B1 |
| 04 | 027–085 | model train từ đầu, G0, bằng chứng baseline, sàng lọc G1 và các bản sửa |
| 05 | 086–139 | thử P/A, chỉnh thông số, lần chạy ngân sách đầy đủ đầu tiên và review độc lập |
| 06 | 140–191 | nền I1, sửa G3, thử I1/I2 và khóa ranh giới pretrained |
| 07 | 192–236 | độ ổn định, nhóm cắt, sức chịu ảnh/chi phí và calibration |
| 08 | 237–266 | bootstrap theo nhóm, Grad-CAM, nối vào notebook và freeze G7 |
| 09 | 267–337 | refit, siết toàn vẹn, inference, bàn giao, phân tích notebook, replay chỉ từ artifact, bản đồ code train và lịch sử merge |

## Cách đọc một card

Mỗi card là một khối có thể bấm mở. Dòng đầu và các field bên trong có nghĩa như sau:

- **Số 001–337** là vị trí của commit trong phạm vi tutorial. Đây không phải số
  experiment G0–G8 và không phải phase 00–12.
- **Full hash** là mã Git 40 ký tự. Dùng mã này để mở đúng commit, kể cả khi hai
  commit có tiêu đề giống nhau.
- **Subject** là tiêu đề commit do người viết commit đặt. Subject nói ý định ngắn,
  chưa đủ để chứng minh code hoặc kết quả thật.
- **Task 2 direct / shared dependency** là phạm vi. “Direct” chạm trực tiếp Task 2;
  “shared dependency” chạm nền dùng chung mà Task 2 phụ thuộc. Tổng đã review là
  298 direct và 39 shared.
- **Trạng thái trước / problem / hypothesis** nói cái gì còn thiếu, lỗi nào cần sửa
  hoặc giả thuyết nào đang được thử trước commit.
- **Files changed** liệt kê đúng file Git thấy thay đổi. Số trong ngoặc là số file,
  không phải số dòng và không phải độ khó.
- **Git diff footprint** nói commit thường hay merge và Git dùng kiểu diff nào.
  Merge có thể không có file resolution dù vẫn quan trọng cho lịch sử nhánh.
- **Code cần đọc** chỉ nơi có cơ chế chính. Nếu là <code>n/a</code>, commit có thể chỉ
  đổi docs, test hoặc artifact.
- **Test cần đọc** chỉ contract hoặc regression test liên quan. Test pass chứng minh
  hành vi đã kiểm, không tự chứng minh accuracy trên dữ liệu mới.
- **Artifact/consumer bị tác động** chỉ file kết quả hoặc nơi đọc thay đổi đó.
- **Thay đổi thực tế / result** mô tả điều diff thật sự làm. Nếu có metric, đó phải
  là số từ artifact; nếu không có metric, field này không được bịa model gain.
- **Cách xác minh** cho biết lệnh, test, hash hoặc artifact dùng để kiểm lại claim.
- **Limitation** đặt ranh giới: commit này chưa chứng minh được điều gì.
- **Vì sao commit kế cần tồn tại** nối bước hiện tại với vấn đề tiếp theo. Đây là lý
  do lịch sử, không phải yêu cầu người đọc phải checkout từng commit.
- **Senior lesson** rút ra quy tắc làm việc có thể dùng lại ở project khác.

Ví dụ: nếu card nói “thêm test tái hiện cache sai”, claim hợp lệ là lỗi đã được mã
hóa thành test. Không được đổi claim thành “model chính xác hơn” khi card không có
run và artifact metric mới.

## Sổ 337 commit (Ledger)

<details>
<summary><strong>001</strong> — <code>6348d4aaf566f504e98a168321317da1acb35564</code> — docs(task2): add execution-ready season scaffold — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “add execution-ready season scaffold” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>docs/task2-season-execution-report.md</code><br><code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code><br><code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “add execution-ready season scaffold”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +2615/-128; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6348d4a</code>, rồi <code>git show --name-status 6348d4a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 002 — <code>89acc6d</code> — test(notebooks): enforce task2 leaf-cell structure
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>002</strong> — <code>89acc6df91bf957c596d9629fdacee3ae9930ba2</code> — test(notebooks): enforce task2 leaf-cell structure — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “enforce task2 leaf-cell structure” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “enforce task2 leaf-cell structure”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +94/-3; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 89acc6d</code>, rồi <code>git show --name-status 89acc6d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 003 — <code>a10846b</code> — fix(notebooks): align task2 execution status
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>003</strong> — <code>a10846b08bf4573b7f49543f4f9d60dd89283450</code> — fix(notebooks): align task2 execution status — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “align task2 execution status”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>notebooks/README.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/README.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “align task2 execution status”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +9/-3; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a10846b</code>, rồi <code>git show --name-status a10846b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 004 — <code>a80ef9b</code> — docs(task2): freeze protocol and trace policy
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>004</strong> — <code>a80ef9b7d2ac3dcf1adcfdc5e7d7484a2c71fa31</code> — docs(task2): freeze protocol and trace policy — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “freeze protocol and trace policy” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “freeze protocol and trace policy”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +33/-6; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a80ef9b</code>, rồi <code>git show --name-status a80ef9b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 005 — <code>a905af8</code> — feat(config): define task2 artifact boundaries
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>005</strong> — <code>a905af8ef44448edc0e2dfcd284e1a25ccbcdf6a</code> — feat(config): define task2 artifact boundaries — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “define task2 artifact boundaries” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/config.py</code><br><code>tests/test_config.py</code>
- **Code cần đọc:** <code>src/fashion/config.py</code>
- **Test cần đọc:** <code>tests/test_config.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “define task2 artifact boundaries” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +53/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a905af8</code>, rồi <code>git show --name-status a905af8</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Không tác động trực tiếp Task 2 theo changed-file audit; vẫn ghi để coverage không có lỗ.
- **Vì sao commit kế cần tồn tại:** Runtime hoặc dependency boundary phải được khai báo trước khi code có thể chạy ổn định: 006 — <code>a3d5fd7</code> — build(deps): pin task2 training stack
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>006</strong> — <code>a3d5fd7868af7d895d53b3892d752ec6b31b946a</code> — build(deps): pin task2 training stack — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: dependency/runtime boundary “pin task2 training stack” chưa tái lập đủ. Hypothesis: pin/constraint đúng sẽ làm environment portable hơn.
- **Files changed (2):** <code>pyproject.toml</code><br><code>requirements/constraints-py312.txt</code>
- **Code cần đọc:** <code>pyproject.toml</code><br><code>requirements/constraints-py312.txt</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: cập nhật “pin task2 training stack”. Result là dependency boundary; không phải modelling improvement.
- **Git diff footprint:** +84/-24; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a3d5fd7</code>, rồi <code>git show --name-status a3d5fd7</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Dependency pass trên environment ghi nhận không bảo đảm mọi CPU/GPU/OS.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 007 — <code>c771b21</code> — test(deps): reproduce backend-locked constraints
- **Senior lesson:** Giữ thay đổi focused, traceable và independently verifiable.

</details>

<details>
<summary><strong>007</strong> — <code>c771b21495a218430ea52ca033c16458dc05754a</code> — test(deps): reproduce backend-locked constraints — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce backend-locked constraints” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_dependencies.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_dependencies.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce backend-locked constraints”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +28/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat c771b21</code>, rồi <code>git show --name-status c771b21</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 008 — <code>41ac8e6</code> — fix(deps): allow cpu and cuda torch backends
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>008</strong> — <code>41ac8e66b232ef2c72d4da1ea8771367ecdb60e9</code> — fix(deps): allow cpu and cuda torch backends — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “allow cpu and cuda torch backends”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>requirements/constraints-py312.txt</code>
- **Code cần đọc:** <code>requirements/constraints-py312.txt</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “allow cpu and cuda torch backends”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +2/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 41ac8e6</code>, rồi <code>git show --name-status 41ac8e6</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 009 — <code>6ea9ed1</code> — docs(setup): add task2 runtime commands
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>009</strong> — <code>6ea9ed1275686d47cf38376fd23a851cca7bf81b</code> — docs(setup): add task2 runtime commands — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “add task2 runtime commands” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (3):** <code>README.md</code><br><code>docs/decisions/0006-python-constraints-workflow.md</code><br><code>tests/test_documentation.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_documentation.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “add task2 runtime commands”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +58/-8; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6ea9ed1</code>, rồi <code>git show --name-status 6ea9ed1</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 010 — <code>b97f751</code> — fix(notebook): wrap artifact summary expression
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>010</strong> — <code>b97f7512b4416315ca4f0eda76c71f5736adb368</code> — fix(notebook): wrap artifact summary expression — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “wrap artifact summary expression”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>notebooks/01_data_preparation.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/01_data_preparation.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “wrap artifact summary expression”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +6/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat b97f751</code>, rồi <code>git show --name-status b97f751</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 011 — <code>f273524</code> — fix(notebook): wrap task2 scaffold comments
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>011</strong> — <code>f27352458b1be15ac69971451b71d445c2b03422</code> — fix(notebook): wrap task2 scaffold comments — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “wrap task2 scaffold comments”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “wrap task2 scaffold comments”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +44/-23; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f273524</code>, rồi <code>git show --name-status f273524</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 012 — <code>a09b1ac</code> — feat(train): add deterministic runtime capture
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>012</strong> — <code>a09b1ac796fcf2c49da8b3c6824c8d6a3cf7091a</code> — feat(train): add deterministic runtime capture — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add deterministic runtime capture” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/reproducibility.py</code><br><code>tests/train/test_reproducibility.py</code>
- **Code cần đọc:** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/reproducibility.py</code>
- **Test cần đọc:** <code>tests/train/test_reproducibility.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add deterministic runtime capture” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +191/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a09b1ac</code>, rồi <code>git show --name-status a09b1ac</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 013 — <code>0ac5038</code> — feat(train): add atomic hashed artifacts
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>013</strong> — <code>0ac5038db5b509154666077ffc1bf88b4ebd2494</code> — feat(train): add atomic hashed artifacts — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add atomic hashed artifacts” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/artifacts.py</code><br><code>tests/train/test_artifacts.py</code>
- **Code cần đọc:** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/artifacts.py</code>
- **Test cần đọc:** <code>tests/train/test_artifacts.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add atomic hashed artifacts” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +209/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0ac5038</code>, rồi <code>git show --name-status 0ac5038</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 014 — <code>e87030c</code> — feat(train): add auditable run registry
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>014</strong> — <code>e87030cac614fa48e190c479664bfc43fbfa08e1</code> — feat(train): add auditable run registry — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add auditable run registry” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/registry.py</code><br><code>tests/train/test_registry.py</code>
- **Code cần đọc:** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/registry.py</code>
- **Test cần đọc:** <code>tests/train/test_registry.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add auditable run registry” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +415/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e87030c</code>, rồi <code>git show --name-status e87030c</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 015 — <code>d465135</code> — feat(train): add multiclass oof evaluation
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>015</strong> — <code>d465135267e9e5835424302f9b6fe506f43b46a5</code> — feat(train): add multiclass oof evaluation — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add multiclass oof evaluation” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/metrics.py</code><br><code>tests/train/test_metrics.py</code>
- **Code cần đọc:** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/metrics.py</code>
- **Test cần đọc:** <code>tests/train/test_metrics.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add multiclass oof evaluation” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +332/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat d465135</code>, rồi <code>git show --name-status d465135</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 016 — <code>642424a</code> — feat(train): add mixed-precision fold engine
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>016</strong> — <code>642424a7376711bd9568244d4e23ddbde699e759</code> — feat(train): add mixed-precision fold engine — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add mixed-precision fold engine” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/engine.py</code><br><code>tests/train/test_engine.py</code>
- **Code cần đọc:** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/engine.py</code>
- **Test cần đọc:** <code>tests/train/test_engine.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add mixed-precision fold engine” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +544/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 642424a</code>, rồi <code>git show --name-status 642424a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 017 — <code>21fbf27</code> — test(train): reproduce float32 log-loss warning
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>017</strong> — <code>21fbf272795ff3b858f440239e103b504b636fc9</code> — test(train): reproduce float32 log-loss warning — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce float32 log-loss warning” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/train/test_metrics.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/train/test_metrics.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce float32 log-loss warning”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +16/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 21fbf27</code>, rồi <code>git show --name-status 21fbf27</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 018 — <code>84f2328</code> — fix(train): normalize float32 probabilities
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>018</strong> — <code>84f23285171a85af6d948e07d410f1b2fd7672c2</code> — fix(train): normalize float32 probabilities — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “normalize float32 probabilities”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/train/metrics.py</code>
- **Code cần đọc:** <code>src/fashion/train/metrics.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “normalize float32 probabilities”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +3/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 84f2328</code>, rồi <code>git show --name-status 84f2328</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 019 — <code>1b9de7d</code> — feat(train): add hash-validated run cache
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>019</strong> — <code>1b9de7dfbdb9bcba5bd49346e28a2dc5c10023f2</code> — feat(train): add hash-validated run cache — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add hash-validated run cache” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/cache.py</code><br><code>tests/train/test_cache.py</code>
- **Code cần đọc:** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/cache.py</code>
- **Test cần đọc:** <code>tests/train/test_cache.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add hash-validated run cache” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +355/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1b9de7d</code>, rồi <code>git show --name-status 1b9de7d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 020 — <code>8fb8567</code> — docs(src): map task2 training data flow
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>020</strong> — <code>8fb8567411f383c040eb16e79943e6e363b1d141</code> — docs(src): map task2 training data flow — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “map task2 training data flow” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “map task2 training data flow”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +76/-18; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 8fb8567</code>, rồi <code>git show --name-status 8fb8567</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 021 — <code>727bc25</code> — docs(task2): record shared-core verification
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>021</strong> — <code>727bc2551a7d6203518509795e472add25bbbe44</code> — docs(task2): record shared-core verification — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record shared-core verification” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record shared-core verification”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +1/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 727bc25</code>, rồi <code>git show --name-status 727bc25</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 022 — <code>cb22d48</code> — feat(data): add fold-fitted tensor transforms
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>022</strong> — <code>cb22d48f24a0c9740ebfa1eb21c08403584f4128</code> — feat(data): add fold-fitted tensor transforms — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add fold-fitted tensor transforms” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/data/torch.py</code><br><code>tests/data/test_torch_transforms.py</code>
- **Code cần đọc:** <code>src/fashion/data/torch.py</code>
- **Test cần đọc:** <code>tests/data/test_torch_transforms.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add fold-fitted tensor transforms” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +321/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat cb22d48</code>, rồi <code>git show --name-status cb22d48</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 023 — <code>5546324</code> — fix(test): weight fold statistics by content pixels
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>023</strong> — <code>554632411c27e74d15c78b4aafc200fb2f059f97</code> — fix(test): weight fold statistics by content pixels — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “weight fold statistics by content pixels”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>tests/data/test_torch_transforms.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/data/test_torch_transforms.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “weight fold statistics by content pixels”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +9/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 5546324</code>, rồi <code>git show --name-status 5546324</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 024 — <code>e9ed2c2</code> — feat(data): add leakage-safe season loaders
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>024</strong> — <code>e9ed2c2fd9196be660c6431ea6b0dc7b277f7515</code> — feat(data): add leakage-safe season loaders — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add leakage-safe season loaders” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/data/torch.py</code><br><code>tests/data/test_torch_loaders.py</code>
- **Code cần đọc:** <code>src/fashion/data/torch.py</code>
- **Test cần đọc:** <code>tests/data/test_torch_loaders.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add leakage-safe season loaders” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +322/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e9ed2c2</code>, rồi <code>git show --name-status e9ed2c2</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 025 — <code>c83f06f</code> — feat(task2): add training-fold majority baseline
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>025</strong> — <code>c83f06f47153e31b61a3a2d392c42603bcc0a727</code> — feat(task2): add training-fold majority baseline — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add training-fold majority baseline” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/baselines.py</code><br><code>tests/task2/test_majority_baseline.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/baselines.py</code>
- **Test cần đọc:** <code>tests/task2/test_majority_baseline.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add training-fold majority baseline” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +253/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat c83f06f</code>, rồi <code>git show --name-status c83f06f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 026 — <code>cacd68a</code> — feat(task2): add hog-hsv svm baseline
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>026</strong> — <code>cacd68a0d59bcc4930423a138457fb44fd74a4be</code> — feat(task2): add hog-hsv svm baseline — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add hog-hsv svm baseline” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/classical.py</code><br><code>tests/task2/test_classical_baseline.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/classical.py</code>
- **Test cần đọc:** <code>tests/task2/test_classical_baseline.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add hog-hsv svm baseline” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +413/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat cacd68a</code>, rồi <code>git show --name-status cacd68a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 027 — <code>a547f4b</code> — feat(models): add scratch smallcnn season model
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>027</strong> — <code>a547f4b4d6b03dc0db76c4e111e5de1341845182</code> — feat(models): add scratch smallcnn season model — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add scratch smallcnn season model” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/models/__init__.py</code><br><code>src/fashion/models/season.py</code><br><code>tests/models/test_smallcnn.py</code>
- **Code cần đọc:** <code>src/fashion/models/__init__.py</code><br><code>src/fashion/models/season.py</code>
- **Test cần đọc:** <code>tests/models/test_smallcnn.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add scratch smallcnn season model” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +193/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a547f4b</code>, rồi <code>git show --name-status a547f4b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 028 — <code>1fb1107</code> — fix(models): target final smallcnn convolution
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>028</strong> — <code>1fb110761cbf44133c9fe38bdbcda4c123d5d252</code> — fix(models): target final smallcnn convolution — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “target final smallcnn convolution”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (3):** <code>src/fashion/models/__init__.py</code><br><code>src/fashion/models/season.py</code><br><code>tests/models/test_smallcnn.py</code>
- **Code cần đọc:** <code>src/fashion/models/__init__.py</code><br><code>src/fashion/models/season.py</code>
- **Test cần đọc:** <code>tests/models/test_smallcnn.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “target final smallcnn convolution”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +3/-3; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1fb1107</code>, rồi <code>git show --name-status 1fb1107</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 029 — <code>577cabc</code> — fix(test): correct smallcnn parameter count
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>029</strong> — <code>577cabc17cf02942930d0c4657edaee2870b05e9</code> — fix(test): correct smallcnn parameter count — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “correct smallcnn parameter count”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>tests/models/test_smallcnn.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/models/test_smallcnn.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “correct smallcnn parameter count”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +1/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 577cabc</code>, rồi <code>git show --name-status 577cabc</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 030 — <code>432630c</code> — feat(models): add scratch small-stem resnet18
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>030</strong> — <code>432630c08cd152faf1ea5b119aa9209510baea34</code> — feat(models): add scratch small-stem resnet18 — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add scratch small-stem resnet18” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/models/__init__.py</code><br><code>src/fashion/models/season.py</code><br><code>tests/models/test_resnet18.py</code>
- **Code cần đọc:** <code>src/fashion/models/__init__.py</code><br><code>src/fashion/models/season.py</code>
- **Test cần đọc:** <code>tests/models/test_resnet18.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add scratch small-stem resnet18” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +156/-3; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 432630c</code>, rồi <code>git show --name-status 432630c</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 031 — <code>5ff332a</code> — feat(models): add scratch mobilenetv3
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>031</strong> — <code>5ff332a9f76ec40576a3363e4654dd1ad58f71f3</code> — feat(models): add scratch mobilenetv3 — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add scratch mobilenetv3” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/models/__init__.py</code><br><code>src/fashion/models/season.py</code><br><code>tests/models/test_mobilenet.py</code>
- **Code cần đọc:** <code>src/fashion/models/__init__.py</code><br><code>src/fashion/models/season.py</code>
- **Test cần đọc:** <code>tests/models/test_mobilenet.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add scratch mobilenetv3” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +145/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 5ff332a</code>, rồi <code>git show --name-status 5ff332a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 032 — <code>2668d3e</code> — feat(models): enforce benchmark and multitask boundaries
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>032</strong> — <code>2668d3e9259d7a3bfcfc8d9404e3c6bd0f584c43</code> — feat(models): enforce benchmark and multitask boundaries — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “enforce benchmark and multitask boundaries” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/models/__init__.py</code><br><code>src/fashion/models/season.py</code><br><code>tests/models/test_boundaries.py</code>
- **Code cần đọc:** <code>src/fashion/models/__init__.py</code><br><code>src/fashion/models/season.py</code>
- **Test cần đọc:** <code>tests/models/test_boundaries.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “enforce benchmark and multitask boundaries” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +319/-9; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2668d3e</code>, rồi <code>git show --name-status 2668d3e</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 033 — <code>8a477ef</code> — fix(models): align mobilenet multitask embedding
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>033</strong> — <code>8a477eff82c00a2c84243694c8faea91fffdbdba</code> — fix(models): align mobilenet multitask embedding — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “align mobilenet multitask embedding”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/models/season.py</code>
- **Code cần đọc:** <code>src/fashion/models/season.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “align mobilenet multitask embedding”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +1/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 8a477ef</code>, rồi <code>git show --name-status 8a477ef</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 034 — <code>a532eee</code> — feat(task2): add config-driven experiment runner
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>034</strong> — <code>a532eee60ffcff9c4a5650f3cb7ad4d1fde8dbc3</code> — feat(task2): add config-driven experiment runner — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add config-driven experiment runner” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/experiments.py</code><br><code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/experiments.py</code>
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add config-driven experiment runner” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +896/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a532eee</code>, rồi <code>git show --name-status a532eee</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 035 — <code>77b91cc</code> — fix(test): give runner fixture task2 labels
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>035</strong> — <code>77b91cccbc71156ace261c44c971549deff6b634</code> — fix(test): give runner fixture task2 labels — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “give runner fixture task2 labels”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “give runner fixture task2 labels”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +18/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 77b91cc</code>, rồi <code>git show --name-status 77b91cc</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 036 — <code>b197213</code> — feat(task2): add file impact visualization
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>036</strong> — <code>b19721389aa1da201132d3fac22f98d9527a93ca</code> — feat(task2): add file impact visualization — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add file impact visualization” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_file_impact.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_file_impact.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add file impact visualization” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +484/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat b197213</code>, rồi <code>git show --name-status b197213</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 037 — <code>2c211f5</code> — test(task2): reproduce absolute impact paths
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>037</strong> — <code>2c211f521772ac2e4c7f7da1e597975bc40a4f73</code> — test(task2): reproduce absolute impact paths — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce absolute impact paths” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_file_impact.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_file_impact.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce absolute impact paths”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +2/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2c211f5</code>, rồi <code>git show --name-status 2c211f5</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 038 — <code>dff0c80</code> — fix(task2): store portable impact paths
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>038</strong> — <code>dff0c8083f555c04c7dd1f9c0148fb2a2b55cc01</code> — fix(task2): store portable impact paths — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “store portable impact paths”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “store portable impact paths”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +17/-3; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat dff0c80</code>, rồi <code>git show --name-status dff0c80</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 039 — <code>84f3faf</code> — test(task2): reproduce interactive backend dependency
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>039</strong> — <code>84f3fafbfb0dd86032379747e099c3117b7b339b</code> — test(task2): reproduce interactive backend dependency — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce interactive backend dependency” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_file_impact.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_file_impact.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce interactive backend dependency”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +14/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 84f3faf</code>, rồi <code>git show --name-status 84f3faf</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 040 — <code>9d2a827</code> — fix(task2): render impact flow headlessly
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>040</strong> — <code>9d2a8274ef5e027aabdcb2238d5a662ae3c1a5d7</code> — fix(task2): render impact flow headlessly — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “render impact flow headlessly”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_file_impact.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_file_impact.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “render impact flow headlessly”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +7/-6; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 9d2a827</code>, rồi <code>git show --name-status 9d2a827</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 041 — <code>0cb0d55</code> — docs(notebook): add task2 file impact map
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>041</strong> — <code>0cb0d559d1bc3469782c33e9a6cb93da2cf10466</code> — docs(notebook): add task2 file impact map — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “add task2 file impact map” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (5):** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/file_impact_edges.csv</code><br><code>results/evidence/task2/file_impact_manifest.json</code><br><code>results/figures/task2/file_impact_flow.png</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** <code>results/evidence/task2/file_impact_manifest.json</code>
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/file_impact_edges.csv</code><br><code>results/evidence/task2/file_impact_manifest.json</code><br><code>results/figures/task2/file_impact_flow.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “add task2 file impact map”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +114/-2; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0cb0d55</code>, rồi <code>git show --name-status 0cb0d55</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 042 — <code>cfd6d34</code> — docs(notebook): execute task2 data protocol
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>042</strong> — <code>cfd6d3442a04ce3626fa7d14311a7a812399a83c</code> — docs(notebook): execute task2 data protocol — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “execute task2 data protocol” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “execute task2 data protocol”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +371/-104; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat cfd6d34</code>, rồi <code>git show --name-status cfd6d34</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 043 — <code>63bd722</code> — test(notebook): reproduce pandas reset misuse
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>043</strong> — <code>63bd72292feffde6715a2ecea8f3aa1adb77f08f</code> — test(notebook): reproduce pandas reset misuse — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce pandas reset misuse” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce pandas reset misuse”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +7/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 63bd722</code>, rồi <code>git show --name-status 63bd722</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 044 — <code>4cc89b3</code> — fix(notebook): build runtime table portably
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>044</strong> — <code>4cc89b3aa55366dd6bb042f140dec4507ffc2fcc</code> — fix(notebook): build runtime table portably — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “build runtime table portably”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “build runtime table portably”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +2/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 4cc89b3</code>, rồi <code>git show --name-status 4cc89b3</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 045 — <code>757e600</code> — test(notebook): reproduce uninformative padding mask
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>045</strong> — <code>757e60031dd4e8044348a2e2841739d1a0d622cd</code> — test(notebook): reproduce uninformative padding mask — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce uninformative padding mask” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce uninformative padding mask”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +9/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 757e600</code>, rồi <code>git show --name-status 757e600</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 046 — <code>5f83da9</code> — fix(notebook): show real letterbox mask
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>046</strong> — <code>5f83da99267898bc36db118edda30bc5dca1ecf0</code> — fix(notebook): show real letterbox mask — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “show real letterbox mask”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “show real letterbox mask”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +8/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 5f83da9</code>, rồi <code>git show --name-status 5f83da9</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 047 — <code>e25420c</code> — docs(evidence): record task2 data protocol
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>047</strong> — <code>e25420c21176d9944de0966ef6513b6cd22828ef</code> — docs(evidence): record task2 data protocol — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record task2 data protocol” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (9):** <code>results/evidence/task2/eda_figure_registry.csv</code><br><code>results/evidence/task2/eda_handoff.csv</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/fold_handoff.csv</code><br><code>results/evidence/task2/leakage_audit.json</code><br><code>results/evidence/task2/metric_contract.json</code><br><code>results/evidence/task2/oof_contract.json</code><br><code>results/evidence/task2/transform_matrix.csv</code><br><code>results/figures/task2/fold0_preprocessing_audit.png</code>
- **Code cần đọc:** <code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/leakage_audit.json</code><br><code>results/evidence/task2/metric_contract.json</code><br><code>results/evidence/task2/oof_contract.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/eda_figure_registry.csv</code><br><code>results/evidence/task2/eda_handoff.csv</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/fold_handoff.csv</code><br><code>results/evidence/task2/leakage_audit.json</code><br><code>results/evidence/task2/metric_contract.json</code><br><code>results/evidence/task2/oof_contract.json</code><br><code>results/evidence/task2/transform_matrix.csv</code><br><code>results/figures/task2/fold0_preprocessing_audit.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record task2 data protocol”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +139/-0; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e25420c</code>, rồi <code>git show --name-status e25420c</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 048 — <code>73d69b0</code> — docs(notebook): wire task2 models and registry
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>048</strong> — <code>73d69b052dccabbe9112b8ffe47761ebfc43206c</code> — docs(notebook): wire task2 models and registry — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “wire task2 models and registry” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “wire task2 models and registry”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +191/-53; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 73d69b0</code>, rồi <code>git show --name-status 73d69b0</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 049 — <code>2c4fde2</code> — docs(evidence): record task2 model boundaries
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>049</strong> — <code>2c4fde2a9ac906f26bbdba1dfbaa9eae01bab2e5</code> — docs(evidence): record task2 model boundaries — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record task2 model boundaries” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (4):** <code>results/evidence/task2/benchmark_boundary.csv</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code><br><code>results/evidence/task2/scratch_model_audit.csv</code>
- **Code cần đọc:** <code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/benchmark_boundary.csv</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code><br><code>results/evidence/task2/scratch_model_audit.csv</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record task2 model boundaries”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +19/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2c4fde2</code>, rồi <code>git show --name-status 2c4fde2</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Logic đã có nhưng lint/presentation contract vẫn chưa đóng: 050 — <code>a702bfc</code> — style(notebook): satisfy milestone c lint gate
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>050</strong> — <code>a702bfce579389de083974b0826168ee7154b560</code> — style(notebook): satisfy milestone c lint gate — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: behavior chính đã có nhưng structure/presentation “satisfy milestone c lint gate” chưa thỏa contract. Hypothesis: đổi structure mà giữ semantics.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế đúng theo subject “satisfy milestone c lint gate”; phạm vi được xác định bởi exact diff bên dưới.
- **Git diff footprint:** +44/-11; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a702bfc</code>, rồi <code>git show --name-status a702bfc</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 051 — <code>7eeaa75</code> — docs(task2): record milestone c handoff
- **Senior lesson:** Refactor/presentation cần contract để prove behavior không drift.

</details>

<details>
<summary><strong>051</strong> — <code>7eeaa755ecda81802e25ed2f2a9eae32fe11a9d6</code> — docs(task2): record milestone c handoff — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record milestone c handoff” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record milestone c handoff”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +52/-12; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7eeaa75</code>, rồi <code>git show --name-status 7eeaa75</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 052 — <code>8e18c51</code> — feat(task2): add g0 smoke runner
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>052</strong> — <code>8e18c5115d4c8711d7f07c8ed03532c559e202e5</code> — feat(task2): add g0 smoke runner — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add g0 smoke runner” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/smoke.py</code><br><code>tests/task2/test_smoke.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/smoke.py</code>
- **Test cần đọc:** <code>tests/task2/test_smoke.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add g0 smoke runner” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +820/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 8e18c51</code>, rồi <code>git show --name-status 8e18c51</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 053 — <code>843fab1</code> — chore(task2): declare g0 smoke gate
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>053</strong> — <code>843fab18465098a30cad1ca49e6dbc615bd01060</code> — chore(task2): declare g0 smoke gate — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare g0 smoke gate” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (3):** <code>configs/task2/README.md</code><br><code>configs/task2/g0_pipeline_smoke.json</code><br><code>tests/task2/test_smoke.py</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g0_pipeline_smoke.json</code>
- **Test cần đọc:** <code>tests/task2/test_smoke.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare g0 smoke gate”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +52/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 843fab1</code>, rồi <code>git show --name-status 843fab1</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 054 — <code>10eb668</code> — feat(task2): add g0 evidence pack
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>054</strong> — <code>10eb668af01b20551c4bd05c208dd16253087002</code> — feat(task2): add g0 evidence pack — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add g0 evidence pack” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_smoke.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_smoke.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add g0 evidence pack” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +184/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 10eb668</code>, rồi <code>git show --name-status 10eb668</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 055 — <code>1bdded8</code> — docs(experiment): record g0 pipeline evidence
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>055</strong> — <code>1bdded8cdab25f303ebe3313fcf48a2a25415f53</code> — docs(experiment): record g0 pipeline evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record g0 pipeline evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (7):** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/g0/integration_history.csv</code><br><code>results/evidence/task2/g0/manifest.json</code><br><code>results/evidence/task2/g0/registry_snapshot.csv</code><br><code>results/evidence/task2/g0/tiny_loss_trace.csv</code><br><code>results/figures/task2/g0_pipeline_smoke.png</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** <code>results/evidence/task2/g0/manifest.json</code>
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/g0/integration_history.csv</code><br><code>results/evidence/task2/g0/manifest.json</code><br><code>results/evidence/task2/g0/registry_snapshot.csv</code><br><code>results/evidence/task2/g0/tiny_loss_trace.csv</code><br><code>results/figures/task2/g0_pipeline_smoke.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record g0 pipeline evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +114/-11; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1bdded8</code>, rồi <code>git show --name-status 1bdded8</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 056 — <code>4cef70f</code> — docs(evidence): refresh g0 notebook audit
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>056</strong> — <code>4cef70ff098af210f453ebb8057a4d217dd64036</code> — docs(evidence): refresh g0 notebook audit — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “refresh g0 notebook audit” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Code cần đọc:** <code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “refresh g0 notebook audit”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +5/-3; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 4cef70f</code>, rồi <code>git show --name-status 4cef70f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 057 — <code>ff1ee0a</code> — chore(task2): declare b0 majority baseline
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>057</strong> — <code>ff1ee0ab9cb2857f0da7d35ada49d811aaef27d4</code> — chore(task2): declare b0 majority baseline — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare b0 majority baseline” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (2):** <code>configs/task2/b0_majority.json</code><br><code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** <code>configs/task2/b0_majority.json</code>
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare b0 majority baseline”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +32/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ff1ee0a</code>, rồi <code>git show --name-status ff1ee0a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 058 — <code>7c17d00</code> — feat(task2): add audited oof evidence packs
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>058</strong> — <code>7c17d001932829a4c7a4328386fa4d6a178cb6a5</code> — feat(task2): add audited oof evidence packs — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add audited oof evidence packs” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_experiment_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_experiment_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add audited oof evidence packs” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +460/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7c17d00</code>, rồi <code>git show --name-status 7c17d00</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 059 — <code>2b2bf2d</code> — docs(experiment): record b0 five-fold evidence
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>059</strong> — <code>2b2bf2d1c7c5b20db998b993e3f1e2b7a530d92f</code> — docs(experiment): record b0 five-fold evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record b0 five-fold evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (13):** <code>docs/task2-season-execution-report.md</code><br><code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/b0_majority/confusion_matrix.csv</code><br><code>results/evidence/task2/b0_majority/fold_metrics.csv</code><br><code>results/evidence/task2/b0_majority/fold_summary.csv</code><br><code>results/evidence/task2/b0_majority/manifest.json</code><br><code>results/evidence/task2/b0_majority/per_class_metrics.csv</code><br><code>results/evidence/task2/b0_majority/pooled_metrics.json</code><br><code>results/evidence/task2/b0_majority/registry_snapshot.csv</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code><br><code>results/figures/task2/b0_majority.png</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** <code>results/evidence/task2/b0_majority/manifest.json</code><br><code>results/evidence/task2/b0_majority/pooled_metrics.json</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code><br><code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/b0_majority/confusion_matrix.csv</code><br><code>results/evidence/task2/b0_majority/fold_metrics.csv</code><br><code>results/evidence/task2/b0_majority/fold_summary.csv</code><br><code>results/evidence/task2/b0_majority/manifest.json</code><br><code>results/evidence/task2/b0_majority/per_class_metrics.csv</code><br><code>results/evidence/task2/b0_majority/pooled_metrics.json</code><br><code>results/evidence/task2/b0_majority/registry_snapshot.csv</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code><br><code>results/figures/task2/b0_majority.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record b0 five-fold evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +286/-26; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2b2bf2d</code>, rồi <code>git show --name-status 2b2bf2d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 060 — <code>fff53c7</code> — docs(evidence): refresh b0 notebook audit
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>060</strong> — <code>fff53c7088068e4908d668ba8ccfa2cb678c21ca</code> — docs(evidence): refresh b0 notebook audit — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “refresh b0 notebook audit” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>results/evidence/task2/environment.json</code>
- **Code cần đọc:** <code>results/evidence/task2/environment.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/environment.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “refresh b0 notebook audit”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +2/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat fff53c7</code>, rồi <code>git show --name-status fff53c7</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Đường đi đã đúng nhưng cost/reuse còn là bottleneck cần xử lý có guard: 061 — <code>0546cde</code> — perf(task2): cache deterministic b1 features
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>061</strong> — <code>0546cde93e5525ada40744269a4c9edad6416b2d</code> — perf(task2): cache deterministic b1 features — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: correct path có repeated cost trong “cache deterministic b1 features”. Hypothesis: cache/performance change giữ semantics và giảm thời gian.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/classical.py</code><br><code>tests/task2/test_classical_baseline.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/classical.py</code>
- **Test cần đọc:** <code>tests/task2/test_classical_baseline.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: tối ưu “cache deterministic b1 features”. Verify semantics/hash tests trước khi tin runtime benefit.
- **Git diff footprint:** +64/-4; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0546cde</code>, rồi <code>git show --name-status 0546cde</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Cache/performance dễ reuse sai bytes; identity và semantic checks phải giữ nguyên.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 062 — <code>f462381</code> — chore(task2): declare b1 hog-hsv svm baseline
- **Senior lesson:** Performance optimization không được đổi semantic identity.

</details>

<details>
<summary><strong>062</strong> — <code>f4623810501092a0b5879c3e0119d96c70768a29</code> — chore(task2): declare b1 hog-hsv svm baseline — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare b1 hog-hsv svm baseline” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (3):** <code>configs/task2/README.md</code><br><code>configs/task2/b1_hog_hsv_svm.json</code><br><code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/b1_hog_hsv_svm.json</code>
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare b1 hog-hsv svm baseline”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +64/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f462381</code>, rồi <code>git show --name-status f462381</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 063 — <code>7d9f049</code> — docs(experiment): record b1 five-fold evidence
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>063</strong> — <code>7d9f049eefe675adae67e0ef9af1df853661df7f</code> — docs(experiment): record b1 five-fold evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record b1 five-fold evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (13):** <code>docs/task2-season-execution-report.md</code><br><code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/b1_hog_hsv_svm/confusion_matrix.csv</code><br><code>results/evidence/task2/b1_hog_hsv_svm/fold_metrics.csv</code><br><code>results/evidence/task2/b1_hog_hsv_svm/fold_summary.csv</code><br><code>results/evidence/task2/b1_hog_hsv_svm/manifest.json</code><br><code>results/evidence/task2/b1_hog_hsv_svm/per_class_metrics.csv</code><br><code>results/evidence/task2/b1_hog_hsv_svm/pooled_metrics.json</code><br><code>results/evidence/task2/b1_hog_hsv_svm/registry_snapshot.csv</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code><br><code>results/figures/task2/b1_hog_hsv_svm.png</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** <code>results/evidence/task2/b1_hog_hsv_svm/manifest.json</code><br><code>results/evidence/task2/b1_hog_hsv_svm/pooled_metrics.json</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code><br><code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/b1_hog_hsv_svm/confusion_matrix.csv</code><br><code>results/evidence/task2/b1_hog_hsv_svm/fold_metrics.csv</code><br><code>results/evidence/task2/b1_hog_hsv_svm/fold_summary.csv</code><br><code>results/evidence/task2/b1_hog_hsv_svm/manifest.json</code><br><code>results/evidence/task2/b1_hog_hsv_svm/per_class_metrics.csv</code><br><code>results/evidence/task2/b1_hog_hsv_svm/pooled_metrics.json</code><br><code>results/evidence/task2/b1_hog_hsv_svm/registry_snapshot.csv</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code><br><code>results/figures/task2/b1_hog_hsv_svm.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record b1 five-fold evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +348/-21; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7d9f049</code>, rồi <code>git show --name-status 7d9f049</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Đường đi đã đúng nhưng cost/reuse còn là bottleneck cần xử lý có guard: 064 — <code>a5be9ae</code> — perf(data): cache fold-fitted image statistics
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>064</strong> — <code>a5be9aeb2e317e4e471027486d1af8ed44a87943</code> — perf(data): cache fold-fitted image statistics — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: correct path có repeated cost trong “cache fold-fitted image statistics”. Hypothesis: cache/performance change giữ semantics và giảm thời gian.
- **Files changed (2):** <code>src/fashion/data/torch.py</code><br><code>tests/data/test_torch_loaders.py</code>
- **Code cần đọc:** <code>src/fashion/data/torch.py</code>
- **Test cần đọc:** <code>tests/data/test_torch_loaders.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: tối ưu “cache fold-fitted image statistics”. Verify semantics/hash tests trước khi tin runtime benefit.
- **Git diff footprint:** +158/-7; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a5be9ae</code>, rồi <code>git show --name-status a5be9ae</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Cache/performance dễ reuse sai bytes; identity và semantic checks phải giữ nguyên.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 065 — <code>3cbe0c1</code> — test(data): reproduce cached stats tuple regression
- **Senior lesson:** Performance optimization không được đổi semantic identity.

</details>

<details>
<summary><strong>065</strong> — <code>3cbe0c139390e3961e991cb8e9537d8e8f416c00</code> — test(data): reproduce cached stats tuple regression — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce cached stats tuple regression” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/data/test_torch_loaders.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/data/test_torch_loaders.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce cached stats tuple regression”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +9/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 3cbe0c1</code>, rồi <code>git show --name-status 3cbe0c1</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 066 — <code>f854db5</code> — fix(data): preserve cached stats tuple fields
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>066</strong> — <code>f854db5790b8d5f4169350923e9706f6bed18272</code> — fix(data): preserve cached stats tuple fields — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “preserve cached stats tuple fields”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/data/torch.py</code>
- **Code cần đọc:** <code>src/fashion/data/torch.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “preserve cached stats tuple fields”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +2/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f854db5</code>, rồi <code>git show --name-status f854db5</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 067 — <code>68e2bf2</code> — chore(task2): declare g1 scratch family screen
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>067</strong> — <code>68e2bf2aee92175ff027e831208d80c404913e45</code> — chore(task2): declare g1 scratch family screen — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare g1 scratch family screen” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (5):** <code>configs/task2/README.md</code><br><code>configs/task2/g1_c1_smallcnn.json</code><br><code>configs/task2/g1_c2_resnet18.json</code><br><code>configs/task2/g1_c3_mobilenetv3.json</code><br><code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g1_c1_smallcnn.json</code><br><code>configs/task2/g1_c2_resnet18.json</code><br><code>configs/task2/g1_c3_mobilenetv3.json</code>
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare g1 scratch family screen”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +179/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 68e2bf2</code>, rồi <code>git show --name-status 68e2bf2</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 068 — <code>3919213</code> — docs(experiment): record g1 c1 screen evidence
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>068</strong> — <code>39192135ffd9b31b8c42132f6580cfa2b59cab53</code> — docs(experiment): record g1 c1 screen evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record g1 c1 screen evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (8):** <code>results/evidence/task2/g1_c1_smallcnn/confusion_matrix.csv</code><br><code>results/evidence/task2/g1_c1_smallcnn/fold_metrics.csv</code><br><code>results/evidence/task2/g1_c1_smallcnn/fold_summary.csv</code><br><code>results/evidence/task2/g1_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g1_c1_smallcnn/per_class_metrics.csv</code><br><code>results/evidence/task2/g1_c1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g1_c1_smallcnn/registry_snapshot.csv</code><br><code>results/figures/task2/g1_c1_smallcnn.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g1_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g1_c1_smallcnn/pooled_metrics.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g1_c1_smallcnn/confusion_matrix.csv</code><br><code>results/evidence/task2/g1_c1_smallcnn/fold_metrics.csv</code><br><code>results/evidence/task2/g1_c1_smallcnn/fold_summary.csv</code><br><code>results/evidence/task2/g1_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g1_c1_smallcnn/per_class_metrics.csv</code><br><code>results/evidence/task2/g1_c1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g1_c1_smallcnn/registry_snapshot.csv</code><br><code>results/figures/task2/g1_c1_smallcnn.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record g1 c1 screen evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +245/-0; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 3919213</code>, rồi <code>git show --name-status 3919213</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 069 — <code>719cd7d</code> — docs(experiment): record g1 c2 screen evidence
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>069</strong> — <code>719cd7dacb43192221a51489db93d0a5e413b6f9</code> — docs(experiment): record g1 c2 screen evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record g1 c2 screen evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (8):** <code>results/evidence/task2/g1_c2_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g1_c2_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g1_c2_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g1_c2_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g1_c2_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g1_c2_resnet18/registry_snapshot.csv</code><br><code>results/figures/task2/g1_c2_resnet18.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g1_c2_resnet18/pooled_metrics.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g1_c2_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g1_c2_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g1_c2_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g1_c2_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g1_c2_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g1_c2_resnet18/registry_snapshot.csv</code><br><code>results/figures/task2/g1_c2_resnet18.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record g1 c2 screen evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +245/-0; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 719cd7d</code>, rồi <code>git show --name-status 719cd7d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 070 — <code>93b4caf</code> — docs(experiment): record g1 c3 screen evidence
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>070</strong> — <code>93b4caff17576480d5b35d83e0bfd12779b5e5c5</code> — docs(experiment): record g1 c3 screen evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record g1 c3 screen evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (8):** <code>results/evidence/task2/g1_c3_mobilenetv3/confusion_matrix.csv</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/fold_metrics.csv</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/fold_summary.csv</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/manifest.json</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/per_class_metrics.csv</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/pooled_metrics.json</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/registry_snapshot.csv</code><br><code>results/figures/task2/g1_c3_mobilenetv3.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g1_c3_mobilenetv3/manifest.json</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/pooled_metrics.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g1_c3_mobilenetv3/confusion_matrix.csv</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/fold_metrics.csv</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/fold_summary.csv</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/manifest.json</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/per_class_metrics.csv</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/pooled_metrics.json</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/registry_snapshot.csv</code><br><code>results/figures/task2/g1_c3_mobilenetv3.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record g1 c3 screen evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +245/-0; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 93b4caf</code>, rồi <code>git show --name-status 93b4caf</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 071 — <code>d7cd196</code> — feat(task2): add audited g1 family screen
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>071</strong> — <code>d7cd1966884b3ba48eeb8328b06a0fb074270202</code> — feat(task2): add audited g1 family screen — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add audited g1 family screen” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_g1_family_screen_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_g1_family_screen_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add audited g1 family screen” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +506/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat d7cd196</code>, rồi <code>git show --name-status d7cd196</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 072 — <code>1dd96c3</code> — test(task2): reproduce clipped g1 label regression
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>072</strong> — <code>1dd96c305a78af58599da489c158b839d16d7277</code> — test(task2): reproduce clipped g1 label regression — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce clipped g1 label regression” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_g1_family_screen_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_g1_family_screen_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce clipped g1 label regression”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +45/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1dd96c3</code>, rồi <code>git show --name-status 1dd96c3</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 073 — <code>b12e38e</code> — fix(task2): keep g1 labels inside figure
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>073</strong> — <code>b12e38edfd734e302789da3384c2890a145d6fe1</code> — fix(task2): keep g1 labels inside figure — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “keep g1 labels inside figure”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “keep g1 labels inside figure”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +4/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat b12e38e</code>, rồi <code>git show --name-status b12e38e</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 074 — <code>901c6c7</code> — docs(experiment): record g1 family shortlist
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>074</strong> — <code>901c6c752044b950cd9606e4d1f5c5abaecfa948</code> — docs(experiment): record g1 family shortlist — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record g1 family shortlist” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (4):** <code>results/evidence/task2/g1_family_screen/leaderboard.csv</code><br><code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g1_family_screen/shortlist.json</code><br><code>results/figures/task2/g1_family_screen.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g1_family_screen/shortlist.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g1_family_screen/leaderboard.csv</code><br><code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g1_family_screen/shortlist.json</code><br><code>results/figures/task2/g1_family_screen.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record g1 family shortlist”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +66/-0; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 901c6c7</code>, rồi <code>git show --name-status 901c6c7</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 075 — <code>9d4e8e7</code> — test(task2): reproduce g1 handoff mismatch
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>075</strong> — <code>9d4e8e75e8d493c9f216958b7e64758854adb300</code> — test(task2): reproduce g1 handoff mismatch — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce g1 handoff mismatch” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_g1_family_screen_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_g1_family_screen_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce g1 handoff mismatch”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +9/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 9d4e8e7</code>, rồi <code>git show --name-status 9d4e8e7</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 076 — <code>ba6c0f1</code> — fix(task2): align g1 handoff with transform gate
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>076</strong> — <code>ba6c0f17b88bdb1dd2dca94f07631c83e6ce0638</code> — fix(task2): align g1 handoff with transform gate — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “align g1 handoff with transform gate”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “align g1 handoff with transform gate”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +2/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ba6c0f1</code>, rồi <code>git show --name-status ba6c0f1</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 077 — <code>ac57cce</code> — docs(experiment): align g1 shortlist handoff
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>077</strong> — <code>ac57cce1354130bf76048b81253f32613c71d9da</code> — docs(experiment): align g1 shortlist handoff — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “align g1 shortlist handoff” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g1_family_screen/shortlist.json</code>
- **Code cần đọc:** <code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g1_family_screen/shortlist.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g1_family_screen/shortlist.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “align g1 shortlist handoff”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +2/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ac57cce</code>, rồi <code>git show --name-status ac57cce</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 078 — <code>0e83c1d</code> — docs(notebook): wire g1 family screen
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>078</strong> — <code>0e83c1d13c73bcafc939db8ded88e2d501fa8cb0</code> — docs(notebook): wire g1 family screen — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “wire g1 family screen” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “wire g1 family screen”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +120/-11; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0e83c1d</code>, rồi <code>git show --name-status 0e83c1d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 079 — <code>60264b9</code> — docs(notebook): record g1 run all and dirty g0 trace
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>079</strong> — <code>60264b9556d60afb46d98eaffd7968e879efb92e</code> — docs(notebook): record g1 run all and dirty g0 trace — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record g1 run all and dirty g0 trace” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (7):** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/g0/integration_history.csv</code><br><code>results/evidence/task2/g0/manifest.json</code><br><code>results/evidence/task2/g0/registry_snapshot.csv</code><br><code>results/evidence/task2/registry_health.json</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** <code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/g0/manifest.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/g0/integration_history.csv</code><br><code>results/evidence/task2/g0/manifest.json</code><br><code>results/evidence/task2/g0/registry_snapshot.csv</code><br><code>results/evidence/task2/registry_health.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record g1 run all and dirty g0 trace”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +3497/-152; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 60264b9</code>, rồi <code>git show --name-status 60264b9</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 080 — <code>6fc6568</code> — fix(notebook): keep incomplete cells visibly unexecuted
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>080</strong> — <code>6fc65680d969812e9e99ca3d6f8039a3b49b7517</code> — fix(notebook): keep incomplete cells visibly unexecuted — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “keep incomplete cells visibly unexecuted”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “keep incomplete cells visibly unexecuted”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +33/-33; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6fc6568</code>, rồi <code>git show --name-status 6fc6568</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 081 — <code>11dda77</code> — test(task2): reproduce dirty g0 provenance regression
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>081</strong> — <code>11dda778f587e8b4d0f2d50608d37ad4d18eafca</code> — test(task2): reproduce dirty g0 provenance regression — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce dirty g0 provenance regression” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce dirty g0 provenance regression”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +17/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 11dda77</code>, rồi <code>git show --name-status 11dda77</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 082 — <code>7d70e3f</code> — fix(task2): expose g0 dirty provenance
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>082</strong> — <code>7d70e3fe206e0deb86bbc83c30ffc8c0d036feb6</code> — fix(task2): expose g0 dirty provenance — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “expose g0 dirty provenance”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_smoke.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_smoke.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “expose g0 dirty provenance”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +6/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7d70e3f</code>, rồi <code>git show --name-status 7d70e3f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 083 — <code>9d18996</code> — docs(experiment): record clean g0 provenance rerun
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>083</strong> — <code>9d18996e595ba947ae6652665f41db4f96b3c875</code> — docs(experiment): record clean g0 provenance rerun — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record clean g0 provenance rerun” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>results/evidence/task2/g0/manifest.json</code><br><code>results/evidence/task2/g0/registry_snapshot.csv</code>
- **Code cần đọc:** <code>results/evidence/task2/g0/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g0/manifest.json</code><br><code>results/evidence/task2/g0/registry_snapshot.csv</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record clean g0 provenance rerun”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +7/-7; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 9d18996</code>, rồi <code>git show --name-status 9d18996</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 084 — <code>4407755</code> — fix(notebook): select clean g0 provenance
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>084</strong> — <code>44077559d5c2bec3899fd31f34729cc55a9076d9</code> — fix(notebook): select clean g0 provenance — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “select clean g0 provenance”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (6):** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/g0/integration_history.csv</code><br><code>results/evidence/task2/g0/manifest.json</code><br><code>results/evidence/task2/registry_health.json</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** <code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/g0/manifest.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/g0/integration_history.csv</code><br><code>results/evidence/task2/g0/manifest.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “select clean g0 provenance”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +399/-399; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 4407755</code>, rồi <code>git show --name-status 4407755</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 085 — <code>623afdd</code> — docs(task2): record g1 measured judgement
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>085</strong> — <code>623afdd42fac0b660a028535fc1a0813f20c3416</code> — docs(task2): record g1 measured judgement — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record g1 measured judgement” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record g1 measured judgement”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +45/-16; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 623afdd</code>, rồi <code>git show --name-status 623afdd</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 086 — <code>c0563fe</code> — chore(task2): declare p0-p1 size ablation
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>086</strong> — <code>c0563feb7192a0a93486d601773a6a14d108e0b0</code> — chore(task2): declare p0-p1 size ablation — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare p0-p1 size ablation” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (3):** <code>configs/task2/README.md</code><br><code>configs/task2/g2_p1_c2_resnet18.json</code><br><code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g2_p1_c2_resnet18.json</code>
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare p0-p1 size ablation”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +67/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat c0563fe</code>, rồi <code>git show --name-status c0563fe</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 087 — <code>22b94e1</code> — test(train): reproduce orphaned run regression
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>087</strong> — <code>22b94e146e5f9eed7701b621ea4981f895ef4285</code> — test(train): reproduce orphaned run regression — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce orphaned run regression” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/train/test_registry.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/train/test_registry.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce orphaned run regression”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +19/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 22b94e1</code>, rồi <code>git show --name-status 22b94e1</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 088 — <code>e4ce303</code> — fix(train): recover externally terminated runs
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>088</strong> — <code>e4ce30318f95b90cd91c4446d4d4c7b868c0963d</code> — fix(train): recover externally terminated runs — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “recover externally terminated runs”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/train/registry.py</code>
- **Code cần đọc:** <code>src/fashion/train/registry.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “recover externally terminated runs”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +19/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e4ce303</code>, rồi <code>git show --name-status e4ce303</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 089 — <code>e7946eb</code> — test(train): reproduce recovery cache-boundary regression
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>089</strong> — <code>e7946eb89a9f799ac6e0b3d2a7140d916b90b503</code> — test(train): reproduce recovery cache-boundary regression — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce recovery cache-boundary regression” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/train/test_registry.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/train/test_registry.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce recovery cache-boundary regression”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +3/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e7946eb</code>, rồi <code>git show --name-status e7946eb</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 090 — <code>f4992e8</code> — fix(train): isolate orphan recovery from model cache
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>090</strong> — <code>f4992e8fda7ff5f0b0b9239341ca7e3303d3267d</code> — fix(train): isolate orphan recovery from model cache — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “isolate orphan recovery from model cache”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/train/recovery.py</code><br><code>src/fashion/train/registry.py</code>
- **Code cần đọc:** <code>src/fashion/train/recovery.py</code><br><code>src/fashion/train/registry.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “isolate orphan recovery from model cache”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +37/-19; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f4992e8</code>, rồi <code>git show --name-status f4992e8</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 091 — <code>cf1184f</code> — feat(task2): add Windows-safe experiment launcher
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>091</strong> — <code>cf1184f2ddf969fbbb27780ceb01d0b72166c05f</code> — feat(task2): add Windows-safe experiment launcher — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add Windows-safe experiment launcher” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>scripts/run_task2_experiment.py</code><br><code>tests/task2/test_experiment_launcher.py</code>
- **Code cần đọc:** <code>scripts/run_task2_experiment.py</code>
- **Test cần đọc:** <code>tests/task2/test_experiment_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add Windows-safe experiment launcher” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +92/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat cf1184f</code>, rồi <code>git show --name-status cf1184f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 092 — <code>1fe31d4</code> — docs(scripts): explain task2 experiment launcher
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>092</strong> — <code>1fe31d48b2c67ba0b905bcc600a2cbf0194d2447</code> — docs(scripts): explain task2 experiment launcher — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “explain task2 experiment launcher” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>scripts/README.md</code>
- **Code cần đọc:** <code>scripts/README.md</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “explain task2 experiment launcher”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +13/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1fe31d4</code>, rồi <code>git show --name-status 1fe31d4</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 093 — <code>c7e053f</code> — docs(experiment): record p1 five-fold evidence
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>093</strong> — <code>c7e053f78a6372daa1bdd08529a93eaca11fb919</code> — docs(experiment): record p1 five-fold evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record p1 five-fold evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (8):** <code>results/evidence/task2/g2_p1_c2_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/registry_snapshot.csv</code><br><code>results/figures/task2/g2_p1_c2_resnet18.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g2_p1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/pooled_metrics.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g2_p1_c2_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/registry_snapshot.csv</code><br><code>results/figures/task2/g2_p1_c2_resnet18.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record p1 five-fold evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +245/-0; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat c7e053f</code>, rồi <code>git show --name-status c7e053f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 094 — <code>5ade32d</code> — feat(task2): add audited input-size decision gate
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>094</strong> — <code>5ade32d379a2f50bcbc5c4de62674580f2f00a1b</code> — feat(task2): add audited input-size decision gate — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add audited input-size decision gate” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_g2_input_size_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_g2_input_size_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add audited input-size decision gate” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +772/-9; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 5ade32d</code>, rồi <code>git show --name-status 5ade32d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 095 — <code>358549a</code> — test(task2): reproduce truncated quality-bar regression
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>095</strong> — <code>358549a829f0199defe65e3c9b392550a4ac979f</code> — test(task2): reproduce truncated quality-bar regression — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce truncated quality-bar regression” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_g2_input_size_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_g2_input_size_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce truncated quality-bar regression”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +45/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 358549a</code>, rồi <code>git show --name-status 358549a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 096 — <code>6db73de</code> — fix(task2): avoid truncated bars in size evidence
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>096</strong> — <code>6db73de94b7a0c97fcd549257be658c27d93ab46</code> — fix(task2): avoid truncated bars in size evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “avoid truncated bars in size evidence”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “avoid truncated bars in size evidence”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +34/-19; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6db73de</code>, rồi <code>git show --name-status 6db73de</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 097 — <code>f08c2f4</code> — docs(experiment): record input-size ablation
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>097</strong> — <code>f08c2f4d45124d6c28526e579d417bdd7428e52b</code> — docs(experiment): record input-size ablation — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record input-size ablation” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (5):** <code>results/evidence/task2/g2_input_size_ablation/comparison.csv</code><br><code>results/evidence/task2/g2_input_size_ablation/decision.json</code><br><code>results/evidence/task2/g2_input_size_ablation/manifest.json</code><br><code>results/evidence/task2/g2_input_size_ablation/paired_fold_metrics.csv</code><br><code>results/figures/task2/g2_input_size_ablation.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g2_input_size_ablation/decision.json</code><br><code>results/evidence/task2/g2_input_size_ablation/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g2_input_size_ablation/comparison.csv</code><br><code>results/evidence/task2/g2_input_size_ablation/decision.json</code><br><code>results/evidence/task2/g2_input_size_ablation/manifest.json</code><br><code>results/evidence/task2/g2_input_size_ablation/paired_fold_metrics.csv</code><br><code>results/figures/task2/g2_input_size_ablation.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record input-size ablation”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +73/-0; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f08c2f4</code>, rồi <code>git show --name-status f08c2f4</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 098 — <code>a781b32</code> — docs(notebook): wire input-size ablation
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>098</strong> — <code>a781b326883d807b475bb70c8cb46fa5e9abc52a</code> — docs(notebook): wire input-size ablation — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “wire input-size ablation” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “wire input-size ablation”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +133/-9; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a781b32</code>, rồi <code>git show --name-status a781b32</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 099 — <code>40f55d0</code> — docs(notebook): execute input-size ablation
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>099</strong> — <code>40f55d088a80371c84159317a0539359eb31b996</code> — docs(notebook): execute input-size ablation — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “execute input-size ablation” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (3):** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Code cần đọc:** <code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “execute input-size ablation”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +839/-682; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 40f55d0</code>, rồi <code>git show --name-status 40f55d0</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 100 — <code>ca6b849</code> — docs(task2): record p0-p1 decision and recovery trace
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>100</strong> — <code>ca6b849e8319e3086b5c425032a0bfdcef1ffc56</code> — docs(task2): record p0-p1 decision and recovery trace — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record p0-p1 decision and recovery trace” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record p0-p1 decision and recovery trace”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +35/-12; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ca6b849</code>, rồi <code>git show --name-status ca6b849</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 101 — <code>7f7b7f0</code> — chore(task2): declare a0-a1 augmentation ablation
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>101</strong> — <code>7f7b7f04c6915f3c813443e0dedcc3b5b629f076</code> — chore(task2): declare a0-a1 augmentation ablation — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare a0-a1 augmentation ablation” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (3):** <code>configs/task2/README.md</code><br><code>configs/task2/g2_a1_c2_resnet18.json</code><br><code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g2_a1_c2_resnet18.json</code>
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare a0-a1 augmentation ablation”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +73/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7f7b7f0</code>, rồi <code>git show --name-status 7f7b7f0</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 102 — <code>2542cfc</code> — docs(experiment): record a1 five-fold evidence
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>102</strong> — <code>2542cfc5ff1c628b9788e240744d04d3543a4fba</code> — docs(experiment): record a1 five-fold evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record a1 five-fold evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (8):** <code>results/evidence/task2/g2_a1_c2_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/registry_snapshot.csv</code><br><code>results/figures/task2/g2_a1_c2_resnet18.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g2_a1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/pooled_metrics.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g2_a1_c2_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/registry_snapshot.csv</code><br><code>results/figures/task2/g2_a1_c2_resnet18.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record a1 five-fold evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +245/-0; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2542cfc</code>, rồi <code>git show --name-status 2542cfc</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 103 — <code>0f67206</code> — feat(task2): add audited augmentation decision gate
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>103</strong> — <code>0f672068a9f7ae1b151ed2a034e72cccba1d88a7</code> — feat(task2): add audited augmentation decision gate — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add audited augmentation decision gate” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (4):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_g2_augmentation_evidence.py</code><br><code>tests/task2/test_g2_input_size_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_g2_augmentation_evidence.py</code><br><code>tests/task2/test_g2_input_size_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add audited augmentation decision gate” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +949/-19; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0f67206</code>, rồi <code>git show --name-status 0f67206</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 104 — <code>a4017e0</code> — docs(experiment): record augmentation ablation decision
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>104</strong> — <code>a4017e0f0f7038f62b31255ae157f89e2141f07d</code> — docs(experiment): record augmentation ablation decision — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record augmentation ablation decision” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (6):** <code>results/evidence/task2/g2_augmentation_ablation/comparison.csv</code><br><code>results/evidence/task2/g2_augmentation_ablation/decision.json</code><br><code>results/evidence/task2/g2_augmentation_ablation/manifest.json</code><br><code>results/evidence/task2/g2_augmentation_ablation/paired_fold_metrics.csv</code><br><code>results/evidence/task2/g2_augmentation_ablation/per_class_comparison.csv</code><br><code>results/figures/task2/g2_augmentation_ablation.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g2_augmentation_ablation/decision.json</code><br><code>results/evidence/task2/g2_augmentation_ablation/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g2_augmentation_ablation/comparison.csv</code><br><code>results/evidence/task2/g2_augmentation_ablation/decision.json</code><br><code>results/evidence/task2/g2_augmentation_ablation/manifest.json</code><br><code>results/evidence/task2/g2_augmentation_ablation/paired_fold_metrics.csv</code><br><code>results/evidence/task2/g2_augmentation_ablation/per_class_comparison.csv</code><br><code>results/figures/task2/g2_augmentation_ablation.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record augmentation ablation decision”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +89/-0; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a4017e0</code>, rồi <code>git show --name-status a4017e0</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 105 — <code>1e669dd</code> — docs(notebook): wire augmentation ablation
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>105</strong> — <code>1e669dd3d1248df5d3f42ae2d665ef57a9d65a91</code> — docs(notebook): wire augmentation ablation — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “wire augmentation ablation” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “wire augmentation ablation”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +110/-9; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1e669dd</code>, rồi <code>git show --name-status 1e669dd</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 106 — <code>4666a30</code> — docs(notebook): execute augmentation ablation
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>106</strong> — <code>4666a3017255bb150d9654bdb86695312ea9b560</code> — docs(notebook): execute augmentation ablation — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “execute augmentation ablation” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (3):** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Code cần đọc:** <code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “execute augmentation ablation”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +876/-475; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 4666a30</code>, rồi <code>git show --name-status 4666a30</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 107 — <code>16f0902</code> — docs(task2): record augmentation decision
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>107</strong> — <code>16f0902c57af81192f016a93305a9f068880d534</code> — docs(task2): record augmentation decision — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record augmentation decision” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record augmentation decision”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +27/-19; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 16f0902</code>, rồi <code>git show --name-status 16f0902</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 108 — <code>51364b7</code> — chore(task2): declare compact finalist tuning
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>108</strong> — <code>51364b7de0c8686f999aa023ae0360c2878aaae2</code> — chore(task2): declare compact finalist tuning — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare compact finalist tuning” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (6):** <code>configs/task2/README.md</code><br><code>configs/task2/g2_t1_c1_smallcnn.json</code><br><code>configs/task2/g2_t1_c2_resnet18.json</code><br><code>configs/task2/g2_t2_c1_smallcnn.json</code><br><code>configs/task2/g2_t2_c2_resnet18.json</code><br><code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g2_t1_c1_smallcnn.json</code><br><code>configs/task2/g2_t1_c2_resnet18.json</code><br><code>configs/task2/g2_t2_c1_smallcnn.json</code><br><code>configs/task2/g2_t2_c2_resnet18.json</code>
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare compact finalist tuning”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +232/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 51364b7</code>, rồi <code>git show --name-status 51364b7</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 109 — <code>8d16960</code> — feat(task2): add audited compact tuning gate
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>109</strong> — <code>8d16960e5b5b6742fc41c28e01c6845ca5eb09f4</code> — feat(task2): add audited compact tuning gate — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add audited compact tuning gate” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_g2_tuning_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_g2_tuning_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add audited compact tuning gate” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +1166/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 8d16960</code>, rồi <code>git show --name-status 8d16960</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 110 — <code>eea0b08</code> — test(task2): reproduce missing artifact path regression
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>110</strong> — <code>eea0b08ee80054e76fd0ecbea062beb68f4052d8</code> — test(task2): reproduce missing artifact path regression — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce missing artifact path regression” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_experiment_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_experiment_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce missing artifact path regression”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +5/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat eea0b08</code>, rồi <code>git show --name-status eea0b08</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 111 — <code>eb9bc3c</code> — fix(task2): retain artifact paths in evidence snapshots
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>111</strong> — <code>eb9bc3c2ee74eb621f2606f86f4131235a9fb590</code> — fix(task2): retain artifact paths in evidence snapshots — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “retain artifact paths in evidence snapshots”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “retain artifact paths in evidence snapshots”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +3/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat eb9bc3c</code>, rồi <code>git show --name-status eb9bc3c</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 112 — <code>898532d</code> — test(task2): reproduce compressed score curve regression
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>112</strong> — <code>898532d93dec52c1e424069775a90574bced4c63</code> — test(task2): reproduce compressed score curve regression — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce compressed score curve regression” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_g2_tuning_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_g2_tuning_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce compressed score curve regression”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +10/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 898532d</code>, rồi <code>git show --name-status 898532d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 113 — <code>487e089</code> — fix(task2): focus learning curve score scale
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>113</strong> — <code>487e089191d38913cc50b20ca453843765c73343</code> — fix(task2): focus learning curve score scale — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “focus learning curve score scale”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “focus learning curve score scale”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +11/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 487e089</code>, rồi <code>git show --name-status 487e089</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 114 — <code>87a5f1c</code> — docs(experiment): record compact tuning evidence
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>114</strong> — <code>87a5f1c388a3f7294aae482397a412d1fded180c</code> — docs(experiment): record compact tuning evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record compact tuning evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (48):** <code>results/evidence/task2/g1_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g1_c1_smallcnn/registry_snapshot.csv</code><br><code>results/evidence/task2/g1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g1_c2_resnet18/registry_snapshot.csv</code><br><code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g2_augmentation_ablation/manifest.json</code><br><code>results/evidence/task2/g2_compact_tuning/decision.json</code><br><code>results/evidence/task2/g2_compact_tuning/leaderboard.csv</code><br><code>results/evidence/task2/g2_compact_tuning/learning_curve_summary.csv</code><br><code>results/evidence/task2/g2_compact_tuning/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/g2_compact_tuning/manifest.json</code><br><code>results/evidence/task2/g2_compact_tuning/paired_fold_metrics.csv</code><br><code>results/evidence/task2/g2_compact_tuning/per_class_comparison.csv</code><br><code>results/evidence/task2/g2_input_size_ablation/manifest.json</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/fold_metrics.csv</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/fold_summary.csv</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/registry_snapshot.csv</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/registry_snapshot.csv</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/fold_metrics.csv</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/fold_summary.csv</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/registry_snapshot.csv</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/registry_snapshot.csv</code><br><code>results/figures/task2/g2_t1_c1_smallcnn.png</code><br><code>results/figures/task2/g2_t1_c2_resnet18.png</code><br><code>results/figures/task2/g2_t2_c1_smallcnn.png</code><br><code>results/figures/task2/g2_t2_c2_resnet18.png</code><br><code>results/figures/task2/g2_tuning_c1_learning_curves.png</code><br><code>results/figures/task2/g2_tuning_c2_learning_curves.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g1_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g2_augmentation_ablation/manifest.json</code><br><code>results/evidence/task2/g2_compact_tuning/decision.json</code><br><code>results/evidence/task2/g2_compact_tuning/manifest.json</code><br><code>results/evidence/task2/g2_input_size_ablation/manifest.json</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/pooled_metrics.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g1_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g1_c1_smallcnn/registry_snapshot.csv</code><br><code>results/evidence/task2/g1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g1_c2_resnet18/registry_snapshot.csv</code><br><code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g2_augmentation_ablation/manifest.json</code><br><code>results/evidence/task2/g2_compact_tuning/decision.json</code><br><code>results/evidence/task2/g2_compact_tuning/leaderboard.csv</code><br><code>results/evidence/task2/g2_compact_tuning/learning_curve_summary.csv</code><br><code>results/evidence/task2/g2_compact_tuning/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/g2_compact_tuning/manifest.json</code><br><code>results/evidence/task2/g2_compact_tuning/paired_fold_metrics.csv</code><br><code>results/evidence/task2/g2_compact_tuning/per_class_comparison.csv</code><br><code>results/evidence/task2/g2_input_size_ablation/manifest.json</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/fold_metrics.csv</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/fold_summary.csv</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g2_t1_c1_smallcnn/registry_snapshot.csv</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g2_t1_c2_resnet18/registry_snapshot.csv</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/fold_metrics.csv</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/fold_summary.csv</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g2_t2_c1_smallcnn/registry_snapshot.csv</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g2_t2_c2_resnet18/registry_snapshot.csv</code><br><code>results/figures/task2/g2_t1_c1_smallcnn.png</code><br><code>results/figures/task2/g2_t1_c2_resnet18.png</code><br><code>results/figures/task2/g2_t2_c1_smallcnn.png</code><br><code>results/figures/task2/g2_t2_c2_resnet18.png</code><br><code>results/figures/task2/g2_tuning_c1_learning_curves.png</code><br><code>results/figures/task2/g2_tuning_c2_learning_curves.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record compact tuning evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +1510/-18; 6 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 87a5f1c</code>, rồi <code>git show --name-status 87a5f1c</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 115 — <code>f0264b3</code> — feat(task2): add traceable selection story
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>115</strong> — <code>f0264b3a243a60aeaef5e60d22ea47c2253040d9</code> — feat(task2): add traceable selection story — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add traceable selection story” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_selection_story_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_selection_story_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add traceable selection story” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +450/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f0264b3</code>, rồi <code>git show --name-status f0264b3</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 116 — <code>11dd8c4</code> — docs(notebook): wire incremental task2 selection
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>116</strong> — <code>11dd8c4a72125509bd36a47ec1a6e9f6c740199a</code> — docs(notebook): wire incremental task2 selection — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “wire incremental task2 selection” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “wire incremental task2 selection”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +273/-21; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 11dd8c4</code>, rồi <code>git show --name-status 11dd8c4</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 117 — <code>441a991</code> — docs(notebook): execute compact tuning narrative
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>117</strong> — <code>441a9917d35593699b2e40eab78586352ce7abd1</code> — docs(notebook): execute compact tuning narrative — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “execute compact tuning narrative” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (19):** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/b0_majority/manifest.json</code><br><code>results/evidence/task2/b0_majority/registry_snapshot.csv</code><br><code>results/evidence/task2/b1_hog_hsv_svm/manifest.json</code><br><code>results/evidence/task2/b1_hog_hsv_svm/registry_snapshot.csv</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/manifest.json</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/registry_snapshot.csv</code><br><code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/registry_snapshot.csv</code><br><code>results/evidence/task2/g2_augmentation_ablation/manifest.json</code><br><code>results/evidence/task2/g2_input_size_ablation/manifest.json</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/registry_snapshot.csv</code><br><code>results/evidence/task2/registry_health.json</code><br><code>results/evidence/task2/selection_story/eda_reflection.csv</code><br><code>results/evidence/task2/selection_story/incremental_model_selection.csv</code><br><code>results/evidence/task2/selection_story/manifest.json</code>
- **Code cần đọc:** <code>results/evidence/task2/b0_majority/manifest.json</code><br><code>results/evidence/task2/b1_hog_hsv_svm/manifest.json</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/manifest.json</code><br><code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_augmentation_ablation/manifest.json</code><br><code>results/evidence/task2/g2_input_size_ablation/manifest.json</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/registry_health.json</code><br><code>results/evidence/task2/selection_story/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/b0_majority/manifest.json</code><br><code>results/evidence/task2/b0_majority/registry_snapshot.csv</code><br><code>results/evidence/task2/b1_hog_hsv_svm/manifest.json</code><br><code>results/evidence/task2/b1_hog_hsv_svm/registry_snapshot.csv</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/manifest.json</code><br><code>results/evidence/task2/g1_c3_mobilenetv3/registry_snapshot.csv</code><br><code>results/evidence/task2/g1_family_screen/manifest.json</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_a1_c2_resnet18/registry_snapshot.csv</code><br><code>results/evidence/task2/g2_augmentation_ablation/manifest.json</code><br><code>results/evidence/task2/g2_input_size_ablation/manifest.json</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/manifest.json</code><br><code>results/evidence/task2/g2_p1_c2_resnet18/registry_snapshot.csv</code><br><code>results/evidence/task2/registry_health.json</code><br><code>results/evidence/task2/selection_story/eda_reflection.csv</code><br><code>results/evidence/task2/selection_story/incremental_model_selection.csv</code><br><code>results/evidence/task2/selection_story/manifest.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “execute compact tuning narrative”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +1886/-675; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 441a991</code>, rồi <code>git show --name-status 441a991</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 118 — <code>538e24b</code> — docs(task2): connect eda to model selection
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>118</strong> — <code>538e24b2ec17d522d1462af25c1297c79ac4abd7</code> — docs(task2): connect eda to model selection — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “connect eda to model selection” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “connect eda to model selection”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +100/-15; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 538e24b</code>, rồi <code>git show --name-status 538e24b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 119 — <code>5ceec90</code> — chore(task2): declare full-budget finalists
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>119</strong> — <code>5ceec90f99ebec4f602b67341aebdf58a8e9af10</code> — chore(task2): declare full-budget finalists — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare full-budget finalists” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (4):** <code>configs/task2/README.md</code><br><code>configs/task2/g3_c1_t1_smallcnn.json</code><br><code>configs/task2/g3_c2_t0_resnet18.json</code><br><code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g3_c1_t1_smallcnn.json</code><br><code>configs/task2/g3_c2_t0_resnet18.json</code>
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare full-budget finalists”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +159/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 5ceec90</code>, rồi <code>git show --name-status 5ceec90</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 120 — <code>e6d42e2</code> — docs(experiment): record c1 full-budget evidence
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>120</strong> — <code>e6d42e2a33593e637549d4347d90487de47f5de8</code> — docs(experiment): record c1 full-budget evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record c1 full-budget evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (8):** <code>results/evidence/task2/g3_c1_t1_smallcnn/confusion_matrix.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/fold_metrics.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/fold_summary.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/per_class_metrics.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/registry_snapshot.csv</code><br><code>results/figures/task2/g3_c1_t1_smallcnn.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g3_c1_t1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/pooled_metrics.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g3_c1_t1_smallcnn/confusion_matrix.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/fold_metrics.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/fold_summary.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/per_class_metrics.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/registry_snapshot.csv</code><br><code>results/figures/task2/g3_c1_t1_smallcnn.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record c1 full-budget evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +245/-0; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e6d42e2</code>, rồi <code>git show --name-status e6d42e2</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 121 — <code>3b6efcd</code> — docs(experiment): record c2 full-budget evidence
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>121</strong> — <code>3b6efcd9b0696386e916681e7838013dd108f130</code> — docs(experiment): record c2 full-budget evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record c2 full-budget evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (8):** <code>results/evidence/task2/g3_c2_t0_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/manifest.json</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/registry_snapshot.csv</code><br><code>results/figures/task2/g3_c2_t0_resnet18.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g3_c2_t0_resnet18/manifest.json</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/pooled_metrics.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g3_c2_t0_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/manifest.json</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/registry_snapshot.csv</code><br><code>results/figures/task2/g3_c2_t0_resnet18.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record c2 full-budget evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +245/-0; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 3b6efcd</code>, rồi <code>git show --name-status 3b6efcd</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 122 — <code>39bcce4</code> — feat(task2): add audited full-budget comparison
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>122</strong> — <code>39bcce46ab658810c5f4cb4517fde52c32d8c4f4</code> — feat(task2): add audited full-budget comparison — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add audited full-budget comparison” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add audited full-budget comparison” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +862/-10; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 39bcce4</code>, rồi <code>git show --name-status 39bcce4</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 123 — <code>62c94e3</code> — docs(experiment): record full-budget comparison
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>123</strong> — <code>62c94e336c3cb8b6331f3d89c68c1ef011bca25e</code> — docs(experiment): record full-budget comparison — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record full-budget comparison” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (10):** <code>results/evidence/task2/g3_full_budget/decision.json</code><br><code>results/evidence/task2/g3_full_budget/leaderboard.csv</code><br><code>results/evidence/task2/g3_full_budget/learning_curve_summary.csv</code><br><code>results/evidence/task2/g3_full_budget/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/g3_full_budget/manifest.json</code><br><code>results/evidence/task2/g3_full_budget/paired_fold_metrics.csv</code><br><code>results/evidence/task2/g3_full_budget/per_class_comparison.csv</code><br><code>results/evidence/task2/g3_full_budget/screen_to_full_budget.csv</code><br><code>results/figures/task2/g3_c1_t1_learning_curves.png</code><br><code>results/figures/task2/g3_c2_t0_learning_curves.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g3_full_budget/decision.json</code><br><code>results/evidence/task2/g3_full_budget/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g3_full_budget/decision.json</code><br><code>results/evidence/task2/g3_full_budget/leaderboard.csv</code><br><code>results/evidence/task2/g3_full_budget/learning_curve_summary.csv</code><br><code>results/evidence/task2/g3_full_budget/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/g3_full_budget/manifest.json</code><br><code>results/evidence/task2/g3_full_budget/paired_fold_metrics.csv</code><br><code>results/evidence/task2/g3_full_budget/per_class_comparison.csv</code><br><code>results/evidence/task2/g3_full_budget/screen_to_full_budget.csv</code><br><code>results/figures/task2/g3_c1_t1_learning_curves.png</code><br><code>results/figures/task2/g3_c2_t0_learning_curves.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record full-budget comparison”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +412/-0; 2 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 62c94e3</code>, rồi <code>git show --name-status 62c94e3</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 124 — <code>fcec084</code> — docs(notebook): wire full-budget comparison
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>124</strong> — <code>fcec084b86bb80cff549a1c6629c6a50b54bfa12</code> — docs(notebook): wire full-budget comparison — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “wire full-budget comparison” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “wire full-budget comparison”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +164/-9; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat fcec084</code>, rồi <code>git show --name-status fcec084</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 125 — <code>74dad3d</code> — test(notebook): reproduce g3 evidence note drift
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>125</strong> — <code>74dad3d22ec8400ca1ec91f4c275515d782898cd</code> — test(notebook): reproduce g3 evidence note drift — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce g3 evidence note drift” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce g3 evidence note drift”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +11/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 74dad3d</code>, rồi <code>git show --name-status 74dad3d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 126 — <code>1704d71</code> — fix(notebook): stabilize g3 run-all evidence
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>126</strong> — <code>1704d71e9115df80ebf288e26dabba71fe4b08ed</code> — fix(notebook): stabilize g3 run-all evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “stabilize g3 run-all evidence”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (4):** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** <code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code><br><code>results/evidence/task2/registry_health.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “stabilize g3 run-all evidence”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +1980/-1026; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1704d71</code>, rồi <code>git show --name-status 1704d71</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 127 — <code>1e9d81b</code> — docs(notebook): verify full-budget execution
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>127</strong> — <code>1e9d81bd0cab0859b372e8865b160f617b5e659b</code> — docs(notebook): verify full-budget execution — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “verify full-budget execution” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code>
- **Code cần đọc:** <code>results/evidence/task2/environment.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “verify full-budget execution”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +962/-962; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1e9d81b</code>, rồi <code>git show --name-status 1e9d81b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 128 — <code>c397bff</code> — docs(task2): record full-budget judgement
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>128</strong> — <code>c397bff41eb98fa830de38b64b15374ab4c295c2</code> — docs(task2): record full-budget judgement — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record full-budget judgement” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record full-budget judgement”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +72/-22; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat c397bff</code>, rồi <code>git show --name-status c397bff</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 129 — <code>2fdb3bc</code> — test(notebook): reproduce historical g3 run coupling
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>129</strong> — <code>2fdb3bc68a4020df35e80ad56af00329a14015d5</code> — test(notebook): reproduce historical g3 run coupling — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce historical g3 run coupling” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce historical g3 run coupling”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +11/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2fdb3bc</code>, rồi <code>git show --name-status 2fdb3bc</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 130 — <code>420cd23</code> — fix(notebook): decouple g3 evidence from retry history
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>130</strong> — <code>420cd23f437c5a2569eb3189e5c120069a33a45c</code> — fix(notebook): decouple g3 evidence from retry history — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “decouple g3 evidence from retry history”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “decouple g3 evidence from retry history”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +18/-5; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 420cd23</code>, rồi <code>git show --name-status 420cd23</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 131 — <code>da6d431</code> — test(task2): reproduce duplicate g3 run weighting
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>131</strong> — <code>da6d431bc8deb8a39a5e95145ec4f1fcf1a0190e</code> — test(task2): reproduce duplicate g3 run weighting — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce duplicate g3 run weighting” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce duplicate g3 run weighting”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +16/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat da6d431</code>, rồi <code>git show --name-status da6d431</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 132 — <code>3baaa61</code> — fix(task2): reject duplicate g3 run identities
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>132</strong> — <code>3baaa610e0e9149919efa735dc3e821d5ee00439</code> — fix(task2): reject duplicate g3 run identities — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “reject duplicate g3 run identities”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “reject duplicate g3 run identities”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +2/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 3baaa61</code>, rồi <code>git show --name-status 3baaa61</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 133 — <code>272fd2e</code> — test(task2): reproduce unverified g2 screen score
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>133</strong> — <code>272fd2e31775ca187c2363fcd8ef5530a17ed0ae</code> — test(task2): reproduce unverified g2 screen score — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce unverified g2 screen score” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce unverified g2 screen score”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +29/-3; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 272fd2e</code>, rồi <code>git show --name-status 272fd2e</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 134 — <code>798ba6b</code> — fix(task2): verify g3 screen scores from leaderboard
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>134</strong> — <code>798ba6b57caf43160ae92164b2a7ebf291110545</code> — fix(task2): verify g3 screen scores from leaderboard — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “verify g3 screen scores from leaderboard”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “verify g3 screen scores from leaderboard”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +46/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 798ba6b</code>, rồi <code>git show --name-status 798ba6b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 135 — <code>810f523</code> — test(task2): reproduce order-dependent g3 tie rank
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>135</strong> — <code>810f523efb8e96fcf8a7677086e5c9053b6fbb61</code> — test(task2): reproduce order-dependent g3 tie rank — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce order-dependent g3 tie rank” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce order-dependent g3 tie rank”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +21/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 810f523</code>, rồi <code>git show --name-status 810f523</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 136 — <code>2a33531</code> — fix(task2): make g3 tie ranking deterministic
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>136</strong> — <code>2a3353192cb43adbecfec4118bb858bacd9c558b</code> — fix(task2): make g3 tie ranking deterministic — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “make g3 tie ranking deterministic”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/task2/evidence.py</code><br><code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “make g3 tie ranking deterministic”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +13/-8; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2a33531</code>, rồi <code>git show --name-status 2a33531</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 137 — <code>61c32bc</code> — docs(notebook): verify reviewed g3 execution
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>137</strong> — <code>61c32bcf7404b1b324c3aa45a4513cd29f4e543c</code> — docs(notebook): verify reviewed g3 execution — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “verify reviewed g3 execution” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code>
- **Code cần đọc:** <code>results/evidence/task2/environment.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>results/evidence/task2/environment.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “verify reviewed g3 execution”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +962/-962; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 61c32bc</code>, rồi <code>git show --name-status 61c32bc</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 138 — <code>f8c33f5</code> — docs(task2): trace g3 review corrections
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>138</strong> — <code>f8c33f5966ce26864f9fd08daaf84ac13a7c278b</code> — docs(task2): trace g3 review corrections — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “trace g3 review corrections” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “trace g3 review corrections”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +12/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f8c33f5</code>, rồi <code>git show --name-status f8c33f5</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 139 — <code>edea07c</code> — test(task2): isolate g3 negative-path outputs
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>139</strong> — <code>edea07c452b4417ec21fb6b1720534fc8f9e72b9</code> — test(task2): isolate g3 negative-path outputs — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “isolate g3 negative-path outputs” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “isolate g3 negative-path outputs”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +14/-4; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat edea07c</code>, rồi <code>git show --name-status edea07c</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 140 — <code>10d2cad</code> — feat(train): add effective-number class balancing
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>140</strong> — <code>10d2cad2f2a2738e02ea37901f35512dda0a1a31</code> — feat(train): add effective-number class balancing — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add effective-number class balancing” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/train/losses.py</code><br><code>tests/train/test_losses.py</code>
- **Code cần đọc:** <code>src/fashion/train/losses.py</code>
- **Test cần đọc:** <code>tests/train/test_losses.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add effective-number class balancing” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +309/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 10d2cad</code>, rồi <code>git show --name-status 10d2cad</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 141 — <code>4ba057c</code> — feat(task2): add isolated i1 experiment runner
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>141</strong> — <code>4ba057c8c3d8ea9f849afa4194aabf1cba5b3f69</code> — feat(task2): add isolated i1 experiment runner — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add isolated i1 experiment runner” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/task2/class_balance.py</code><br><code>tests/task2/test_class_balance.py</code>
- **Code cần đọc:** <code>src/fashion/task2/class_balance.py</code>
- **Test cần đọc:** <code>tests/task2/test_class_balance.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add isolated i1 experiment runner” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +758/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 4ba057c</code>, rồi <code>git show --name-status 4ba057c</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 142 — <code>63ae24a</code> — test(task2): reproduce unseeded model initialization
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>142</strong> — <code>63ae24a699d0cb3347ae41b7578e9884ca42711e</code> — test(task2): reproduce unseeded model initialization — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce unseeded model initialization” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_deep_reproducibility.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_deep_reproducibility.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce unseeded model initialization”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +109/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 63ae24a</code>, rồi <code>git show --name-status 63ae24a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 143 — <code>64273e6</code> — fix(task2): seed models before initialization
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>143</strong> — <code>64273e630735f5dd77a516a1e862aa5083e9e1a4</code> — fix(task2): seed models before initialization — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “seed models before initialization”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/task2/class_balance.py</code><br><code>src/fashion/task2/experiments.py</code>
- **Code cần đọc:** <code>src/fashion/task2/class_balance.py</code><br><code>src/fashion/task2/experiments.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “seed models before initialization”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +7/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 64273e6</code>, rồi <code>git show --name-status 64273e6</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 144 — <code>895e482</code> — test(task2): reproduce unsafe i1 cache acceptance
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>144</strong> — <code>895e4823b4971b5506edca92b3e5eaae394bbdcc</code> — test(task2): reproduce unsafe i1 cache acceptance — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce unsafe i1 cache acceptance” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_class_balance.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_class_balance.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce unsafe i1 cache acceptance”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +91/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 895e482</code>, rồi <code>git show --name-status 895e482</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 145 — <code>9ad82b3</code> — fix(task2): verify cached oof semantics
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>145</strong> — <code>9ad82b3e2aa28951b0e669c23519e50c668eecb7</code> — fix(task2): verify cached oof semantics — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “verify cached oof semantics”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (4):** <code>src/fashion/task2/class_balance.py</code><br><code>src/fashion/task2/experiments.py</code><br><code>src/fashion/train/metrics.py</code><br><code>tests/task2/test_class_balance.py</code>
- **Code cần đọc:** <code>src/fashion/task2/class_balance.py</code><br><code>src/fashion/task2/experiments.py</code><br><code>src/fashion/train/metrics.py</code>
- **Test cần đọc:** <code>tests/task2/test_class_balance.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “verify cached oof semantics”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +183/-6; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 9ad82b3</code>, rồi <code>git show --name-status 9ad82b3</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 146 — <code>e4d11eb</code> — test(task2): reproduce incomplete implementation hash
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>146</strong> — <code>e4d11ebb5936eac3ca4ffb7b6f46ec344785b079</code> — test(task2): reproduce incomplete implementation hash — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce incomplete implementation hash” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_class_balance.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_class_balance.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce incomplete implementation hash”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +12/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e4d11eb</code>, rồi <code>git show --name-status e4d11eb</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 147 — <code>77e448a</code> — fix(task2): hash data interpretation dependencies
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>147</strong> — <code>77e448a9a1660a4d55f065a19b15124422ff7960</code> — fix(task2): hash data interpretation dependencies — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “hash data interpretation dependencies”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/task2/class_balance.py</code><br><code>src/fashion/task2/experiments.py</code>
- **Code cần đọc:** <code>src/fashion/task2/class_balance.py</code><br><code>src/fashion/task2/experiments.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “hash data interpretation dependencies”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +10/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 77e448a</code>, rồi <code>git show --name-status 77e448a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 148 — <code>4cb5c1f</code> — test(task2): verify i1 weighted loss wiring
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>148</strong> — <code>4cb5c1f9a61eef10c55e41ea81aab6bb0cb7cf0b</code> — test(task2): verify i1 weighted loss wiring — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “verify i1 weighted loss wiring” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_class_balance.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_class_balance.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “verify i1 weighted loss wiring”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +97/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 4cb5c1f</code>, rồi <code>git show --name-status 4cb5c1f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 149 — <code>6173a5b</code> — chore(task2): declare i1 class-balanced experiment
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>149</strong> — <code>6173a5bf577f0ffc7877273269586bb632d3b6f5</code> — chore(task2): declare i1 class-balanced experiment — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare i1 class-balanced experiment” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (2):** <code>configs/task2/g4_i1_effective_number_c1.json</code><br><code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** <code>configs/task2/g4_i1_effective_number_c1.json</code>
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare i1 class-balanced experiment”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +65/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6173a5b</code>, rồi <code>git show --name-status 6173a5b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 150 — <code>13e7d99</code> — docs(config): explain i1 decision boundary
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>150</strong> — <code>13e7d99d5df9a80ea2017c6a02b701297674c08d</code> — docs(config): explain i1 decision boundary — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “explain i1 decision boundary” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>configs/task2/README.md</code>
- **Code cần đọc:** <code>configs/task2/README.md</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “explain i1 decision boundary”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +7/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 13e7d99</code>, rồi <code>git show --name-status 13e7d99</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 151 — <code>b6b319b</code> — feat(task2): add i1 experiment launcher
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>151</strong> — <code>b6b319bb2884c628103f5697a905c1b81dbc64db</code> — feat(task2): add i1 experiment launcher — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add i1 experiment launcher” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>scripts/run_task2_i1_experiment.py</code><br><code>tests/task2/test_i1_experiment_launcher.py</code>
- **Code cần đọc:** <code>scripts/run_task2_i1_experiment.py</code>
- **Test cần đọc:** <code>tests/task2/test_i1_experiment_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add i1 experiment launcher” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +124/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat b6b319b</code>, rồi <code>git show --name-status b6b319b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 152 — <code>47442a2</code> — docs(task2): freeze i1 after reproducibility audit
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>152</strong> — <code>47442a2bff0aa97561bd34e16322a9af987937c7</code> — docs(task2): freeze i1 after reproducibility audit — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “freeze i1 after reproducibility audit” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “freeze i1 after reproducibility audit”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +76/-27; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 47442a2</code>, rồi <code>git show --name-status 47442a2</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 153 — <code>c46a0ff</code> — test(task2): reproduce min-delta history audit
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>153</strong> — <code>c46a0fffd8ecbf09add03f7a8a4315524876a999</code> — test(task2): reproduce min-delta history audit — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce min-delta history audit” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce min-delta history audit”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +45/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat c46a0ff</code>, rồi <code>git show --name-status c46a0ff</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 154 — <code>a9c4800</code> — fix(test): resolve g3 evidence output path
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>154</strong> — <code>a9c480091a90759d1bf1bd1f502cc35108e0d616</code> — fix(test): resolve g3 evidence output path — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “resolve g3 evidence output path”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_g3_full_budget_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “resolve g3 evidence output path”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +5/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a9c4800</code>, rồi <code>git show --name-status a9c4800</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 155 — <code>62e57e2</code> — fix(task2): replay min-delta checkpoint selection
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>155</strong> — <code>62e57e27e3f858257933453a48e4e01d961fd6e6</code> — fix(task2): replay min-delta checkpoint selection — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “replay min-delta checkpoint selection”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “replay min-delta checkpoint selection”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +19/-9; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 62e57e2</code>, rồi <code>git show --name-status 62e57e2</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 156 — <code>f7525a9</code> — docs(experiment): record deterministic g3 evidence
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>156</strong> — <code>f7525a9ebdd5a6059056c44315ec4c98236ab4a3</code> — docs(experiment): record deterministic g3 evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record deterministic g3 evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (26):** <code>results/evidence/task2/g3_c1_t1_smallcnn/confusion_matrix.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/fold_metrics.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/fold_summary.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/per_class_metrics.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/registry_snapshot.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/manifest.json</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/registry_snapshot.csv</code><br><code>results/evidence/task2/g3_full_budget/decision.json</code><br><code>results/evidence/task2/g3_full_budget/leaderboard.csv</code><br><code>results/evidence/task2/g3_full_budget/learning_curve_summary.csv</code><br><code>results/evidence/task2/g3_full_budget/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/g3_full_budget/manifest.json</code><br><code>results/evidence/task2/g3_full_budget/paired_fold_metrics.csv</code><br><code>results/evidence/task2/g3_full_budget/per_class_comparison.csv</code><br><code>results/evidence/task2/g3_full_budget/screen_to_full_budget.csv</code><br><code>results/figures/task2/g3_c1_t1_learning_curves.png</code><br><code>results/figures/task2/g3_c1_t1_smallcnn.png</code><br><code>results/figures/task2/g3_c2_t0_learning_curves.png</code><br><code>results/figures/task2/g3_c2_t0_resnet18.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g3_c1_t1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/manifest.json</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g3_full_budget/decision.json</code><br><code>results/evidence/task2/g3_full_budget/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g3_c1_t1_smallcnn/confusion_matrix.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/fold_metrics.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/fold_summary.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/manifest.json</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/per_class_metrics.csv</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/pooled_metrics.json</code><br><code>results/evidence/task2/g3_c1_t1_smallcnn/registry_snapshot.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/confusion_matrix.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/fold_metrics.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/fold_summary.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/manifest.json</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/per_class_metrics.csv</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/pooled_metrics.json</code><br><code>results/evidence/task2/g3_c2_t0_resnet18/registry_snapshot.csv</code><br><code>results/evidence/task2/g3_full_budget/decision.json</code><br><code>results/evidence/task2/g3_full_budget/leaderboard.csv</code><br><code>results/evidence/task2/g3_full_budget/learning_curve_summary.csv</code><br><code>results/evidence/task2/g3_full_budget/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/g3_full_budget/manifest.json</code><br><code>results/evidence/task2/g3_full_budget/paired_fold_metrics.csv</code><br><code>results/evidence/task2/g3_full_budget/per_class_comparison.csv</code><br><code>results/evidence/task2/g3_full_budget/screen_to_full_budget.csv</code><br><code>results/figures/task2/g3_c1_t1_learning_curves.png</code><br><code>results/figures/task2/g3_c1_t1_smallcnn.png</code><br><code>results/figures/task2/g3_c2_t0_learning_curves.png</code><br><code>results/figures/task2/g3_c2_t0_resnet18.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record deterministic g3 evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +538/-533; 4 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f7525a9</code>, rồi <code>git show --name-status f7525a9</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 157 — <code>eb9bd4d</code> — docs(notebook): refresh deterministic g3 evidence
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>157</strong> — <code>eb9bd4defd9fde6d13503801307c4b601a27a876</code> — docs(notebook): refresh deterministic g3 evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “refresh deterministic g3 evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “refresh deterministic g3 evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +397/-250; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat eb9bd4d</code>, rồi <code>git show --name-status eb9bd4d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 158 — <code>ff4b4c3</code> — docs(task2): record corrected g3 judgement
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>158</strong> — <code>ff4b4c3569f99fa4bbe20a80933ce06711ea68fe</code> — docs(task2): record corrected g3 judgement — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record corrected g3 judgement” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record corrected g3 judgement”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +51/-35; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ff4b4c3</code>, rồi <code>git show --name-status ff4b4c3</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 159 — <code>6c18d39</code> — test(task2): define i1 evidence contract
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>159</strong> — <code>6c18d394e327414a3b27865563243042cf57c42f</code> — test(task2): define i1 evidence contract — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “define i1 evidence contract” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_i1_class_balance_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_i1_class_balance_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “define i1 evidence contract”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +367/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6c18d39</code>, rồi <code>git show --name-status 6c18d39</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 160 — <code>214941a</code> — feat(task2): add i1 decision evidence
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>160</strong> — <code>214941a86f56fc03a368688334602bd830ad3f9c</code> — feat(task2): add i1 decision evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add i1 decision evidence” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add i1 decision evidence” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +764/-423; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 214941a</code>, rồi <code>git show --name-status 214941a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 161 — <code>3387cdb</code> — fix(test): normalize synthetic i1 config hash
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>161</strong> — <code>3387cdb441ab7c596551df94527c739ab502c745</code> — fix(test): normalize synthetic i1 config hash — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “normalize synthetic i1 config hash”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>tests/task2/test_i1_class_balance_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_i1_class_balance_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “normalize synthetic i1 config hash”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +4/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 3387cdb</code>, rồi <code>git show --name-status 3387cdb</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 162 — <code>0259c80</code> — fix(test): resolve i1 evidence output paths
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>162</strong> — <code>0259c80bbc4c8240964305bc7eee52e8e7aca98a</code> — fix(test): resolve i1 evidence output paths — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “resolve i1 evidence output paths”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>tests/task2/test_i1_class_balance_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_i1_class_balance_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “resolve i1 evidence output paths”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +1/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0259c80</code>, rồi <code>git show --name-status 0259c80</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 163 — <code>202a1d2</code> — feat(task2): add load-only i1 evidence launcher
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>163</strong> — <code>202a1d27a8cd00d9b83c30bf03c78ced48332ec2</code> — feat(task2): add load-only i1 evidence launcher — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add load-only i1 evidence launcher” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>scripts/build_task2_i1_evidence.py</code><br><code>tests/task2/test_i1_evidence_launcher.py</code>
- **Code cần đọc:** <code>scripts/build_task2_i1_evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_i1_evidence_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add load-only i1 evidence launcher” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +144/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 202a1d2</code>, rồi <code>git show --name-status 202a1d2</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 164 — <code>2f0c1f0</code> — fix(test): remove unused i1 launcher import
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>164</strong> — <code>2f0c1f0bbc85368b03fc4d84357df35ba7a0aa54</code> — fix(test): remove unused i1 launcher import — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “remove unused i1 launcher import”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>tests/task2/test_i1_evidence_launcher.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_i1_evidence_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “remove unused i1 launcher import”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +0/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2f0c1f0</code>, rồi <code>git show --name-status 2f0c1f0</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 165 — <code>af196ce</code> — test(task2): reproduce clipped i1 chart label
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>165</strong> — <code>af196ceeceffb000ece5f1434690574940f6bffb</code> — test(task2): reproduce clipped i1 chart label — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce clipped i1 chart label” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_i1_class_balance_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_i1_class_balance_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce clipped i1 chart label”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +34/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat af196ce</code>, rồi <code>git show --name-status af196ce</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 166 — <code>f02401f</code> — fix(task2): keep i1 chart labels inside axis
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>166</strong> — <code>f02401faeff641e8ae2851159cdaf600e75455f5</code> — fix(task2): keep i1 chart labels inside axis — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “keep i1 chart labels inside axis”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “keep i1 chart labels inside axis”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +8/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f02401f</code>, rồi <code>git show --name-status f02401f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 167 — <code>57e2fcb</code> — docs(experiment): record i1 class-balance evidence
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>167</strong> — <code>57e2fcb456a44104f9c1c04dd43d08f19ba0f7bc</code> — docs(experiment): record i1 class-balance evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record i1 class-balance evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (19):** <code>results/evidence/task2/g4_i1_effective_number_c1/confusion_matrix.csv</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/fold_metrics.csv</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/fold_summary.csv</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/manifest.json</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/per_class_metrics.csv</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/pooled_metrics.json</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/registry_snapshot.csv</code><br><code>results/evidence/task2/i1_class_balance/class_weights_by_fold.csv</code><br><code>results/evidence/task2/i1_class_balance/comparison.csv</code><br><code>results/evidence/task2/i1_class_balance/decision.json</code><br><code>results/evidence/task2/i1_class_balance/learning_curve_summary.csv</code><br><code>results/evidence/task2/i1_class_balance/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/i1_class_balance/manifest.json</code><br><code>results/evidence/task2/i1_class_balance/paired_fold_metrics.csv</code><br><code>results/evidence/task2/i1_class_balance/per_class_comparison.csv</code><br><code>results/evidence/task2/i1_class_balance/registry_snapshot.csv</code><br><code>results/figures/task2/g4_i1_effective_number_c1.png</code><br><code>results/figures/task2/i1_effective_number_learning_curves.png</code><br><code>results/figures/task2/i1_per_class_f1_delta.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g4_i1_effective_number_c1/manifest.json</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/pooled_metrics.json</code><br><code>results/evidence/task2/i1_class_balance/decision.json</code><br><code>results/evidence/task2/i1_class_balance/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g4_i1_effective_number_c1/confusion_matrix.csv</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/fold_metrics.csv</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/fold_summary.csv</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/manifest.json</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/per_class_metrics.csv</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/pooled_metrics.json</code><br><code>results/evidence/task2/g4_i1_effective_number_c1/registry_snapshot.csv</code><br><code>results/evidence/task2/i1_class_balance/class_weights_by_fold.csv</code><br><code>results/evidence/task2/i1_class_balance/comparison.csv</code><br><code>results/evidence/task2/i1_class_balance/decision.json</code><br><code>results/evidence/task2/i1_class_balance/learning_curve_summary.csv</code><br><code>results/evidence/task2/i1_class_balance/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/i1_class_balance/manifest.json</code><br><code>results/evidence/task2/i1_class_balance/paired_fold_metrics.csv</code><br><code>results/evidence/task2/i1_class_balance/per_class_comparison.csv</code><br><code>results/evidence/task2/i1_class_balance/registry_snapshot.csv</code><br><code>results/figures/task2/g4_i1_effective_number_c1.png</code><br><code>results/figures/task2/i1_effective_number_learning_curves.png</code><br><code>results/figures/task2/i1_per_class_f1_delta.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record i1 class-balance evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +525/-0; 3 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 57e2fcb</code>, rồi <code>git show --name-status 57e2fcb</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 168 — <code>68a4f48</code> — docs(notebook): execute i1 class-balance gate
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>168</strong> — <code>68a4f4866e8d0758081953dffbff863bb12270ea</code> — docs(notebook): execute i1 class-balance gate — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “execute i1 class-balance gate” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “execute i1 class-balance gate”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +942/-15; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 68a4f48</code>, rồi <code>git show --name-status 68a4f48</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 169 — <code>2f53834</code> — docs(task2): record i1 minority judgement
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>169</strong> — <code>2f538340146884efb9ce7fecc91521cdc86aa538</code> — docs(task2): record i1 minority judgement — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record i1 minority judgement” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record i1 minority judgement”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +79/-28; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2f53834</code>, rồi <code>git show --name-status 2f53834</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 170 — <code>df8e0bf</code> — feat(data): add masked multitask loaders
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>170</strong> — <code>df8e0bf092eddc2d371c40a92324b6bb11438690</code> — feat(data): add masked multitask loaders — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add masked multitask loaders” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/data/multitask.py</code><br><code>tests/data/test_multitask_loaders.py</code>
- **Code cần đọc:** <code>src/fashion/data/multitask.py</code>
- **Test cần đọc:** <code>tests/data/test_multitask_loaders.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add masked multitask loaders” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +390/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat df8e0bf</code>, rồi <code>git show --name-status df8e0bf</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 171 — <code>ee95a02</code> — feat(train): add masked multitask optimisation
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>171</strong> — <code>ee95a02c3ca32241aaab638f608397fae5a01de1</code> — feat(train): add masked multitask optimisation — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add masked multitask optimisation” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/train/multitask.py</code><br><code>tests/train/test_multitask.py</code>
- **Code cần đọc:** <code>src/fashion/train/multitask.py</code>
- **Test cần đọc:** <code>tests/train/test_multitask.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add masked multitask optimisation” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +582/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ee95a02</code>, rồi <code>git show --name-status ee95a02</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 172 — <code>a8f9f85</code> — feat(task2): add masked multitask runner
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>172</strong> — <code>a8f9f854d765e40d4ec81c6de56d5a001ff52cd7</code> — feat(task2): add masked multitask runner — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add masked multitask runner” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/task2/multitask.py</code><br><code>tests/task2/test_multitask_runner.py</code>
- **Code cần đọc:** <code>src/fashion/task2/multitask.py</code>
- **Test cần đọc:** <code>tests/task2/test_multitask_runner.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add masked multitask runner” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +824/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a8f9f85</code>, rồi <code>git show --name-status a8f9f85</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 173 — <code>454fce2</code> — chore(task2): declare i2 multitask lambdas
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>173</strong> — <code>454fce2a881b634e4c284beb4e9c314fabe0f835</code> — chore(task2): declare i2 multitask lambdas — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare i2 multitask lambdas” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (4):** <code>configs/task2/README.md</code><br><code>configs/task2/g4_i2_article_type_lambda_0_1_c1.json</code><br><code>configs/task2/g4_i2_article_type_lambda_0_3_c1.json</code><br><code>tests/task2/test_multitask_runner.py</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g4_i2_article_type_lambda_0_1_c1.json</code><br><code>configs/task2/g4_i2_article_type_lambda_0_3_c1.json</code>
- **Test cần đọc:** <code>tests/task2/test_multitask_runner.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare i2 multitask lambdas”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +146/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 454fce2</code>, rồi <code>git show --name-status 454fce2</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 174 — <code>89f3c9b</code> — chore(task2): add i2 experiment launcher
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>174</strong> — <code>89f3c9bb4b3e093cb5b3ca343a4a601613a09b33</code> — chore(task2): add i2 experiment launcher — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “add i2 experiment launcher” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (2):** <code>scripts/run_task2_i2_experiments.py</code><br><code>tests/task2/test_i2_experiment_launcher.py</code>
- **Code cần đọc:** <code>scripts/run_task2_i2_experiments.py</code>
- **Test cần đọc:** <code>tests/task2/test_i2_experiment_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “add i2 experiment launcher”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +143/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 89f3c9b</code>, rồi <code>git show --name-status 89f3c9b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 175 — <code>e76eed2</code> — test(train): smoke real i2 model path
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>175</strong> — <code>e76eed29690d0cd4c75564f403e9c9add1650ba9</code> — test(train): smoke real i2 model path — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “smoke real i2 model path” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/train/test_multitask.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/train/test_multitask.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “smoke real i2 model path”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +63/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e76eed2</code>, rồi <code>git show --name-status e76eed2</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 176 — <code>6988264</code> — feat(task2): add i2 transfer evidence
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>176</strong> — <code>6988264a8d6da545bb20a5cd99e6ed96737643a3</code> — feat(task2): add i2 transfer evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add i2 transfer evidence” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/task2/multitask_evidence.py</code><br><code>tests/task2/test_i2_multitask_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/multitask_evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_i2_multitask_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add i2 transfer evidence” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +1106/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6988264</code>, rồi <code>git show --name-status 6988264</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 177 — <code>7a6bb49</code> — chore(task2): add i2 evidence launcher
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>177</strong> — <code>7a6bb493f0d91f56aa075bb3d1f1c6e8a6e6f884</code> — chore(task2): add i2 evidence launcher — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “add i2 evidence launcher” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (2):** <code>scripts/build_task2_i2_evidence.py</code><br><code>tests/task2/test_i2_evidence_launcher.py</code>
- **Code cần đọc:** <code>scripts/build_task2_i2_evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_i2_evidence_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “add i2 evidence launcher”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +155/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7a6bb49</code>, rồi <code>git show --name-status 7a6bb49</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 178 — <code>7055afd</code> — test(task2): reproduce i2 missing-value hash regression
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>178</strong> — <code>7055afdefe50a50be0ad8b02316ca23ed721e944</code> — test(task2): reproduce i2 missing-value hash regression — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce i2 missing-value hash regression” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_i2_multitask_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_i2_multitask_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce i2 missing-value hash regression”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +24/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7055afd</code>, rồi <code>git show --name-status 7055afd</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 179 — <code>7b2485e</code> — fix(task2): canonicalise missing shortcut labels
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>179</strong> — <code>7b2485ee3238dcf45a4b8e3fffb391af9aaa2c77</code> — fix(task2): canonicalise missing shortcut labels — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “canonicalise missing shortcut labels”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/multitask_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/multitask_evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “canonicalise missing shortcut labels”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +8/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7b2485e</code>, rồi <code>git show --name-status 7b2485e</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 180 — <code>a995819</code> — docs(experiment): record i2 transfer evidence
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>180</strong> — <code>a9958199efaf77f435476f05838d8ea072530989</code> — docs(experiment): record i2 transfer evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record i2 transfer evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (29):** <code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/confusion_matrix.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/fold_metrics.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/fold_summary.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/manifest.json</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/per_class_metrics.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/pooled_metrics.json</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/registry_snapshot.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/confusion_matrix.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/fold_metrics.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/fold_summary.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/manifest.json</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/per_class_metrics.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/pooled_metrics.json</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/registry_snapshot.csv</code><br><code>results/evidence/task2/i2_multitask/article_type_majorities_by_fold.csv</code><br><code>results/evidence/task2/i2_multitask/comparison.csv</code><br><code>results/evidence/task2/i2_multitask/decision.json</code><br><code>results/evidence/task2/i2_multitask/fold_shortcut_audit.csv</code><br><code>results/evidence/task2/i2_multitask/learning_curve_summary.csv</code><br><code>results/evidence/task2/i2_multitask/manifest.json</code><br><code>results/evidence/task2/i2_multitask/paired_fold_metrics.csv</code><br><code>results/evidence/task2/i2_multitask/per_class_comparison.csv</code><br><code>results/evidence/task2/i2_multitask/registry_snapshot.csv</code><br><code>results/evidence/task2/i2_multitask/slice_metrics.csv</code><br><code>results/evidence/task2/i2_multitask/slice_summary.csv</code><br><code>results/figures/task2/g4_i2_article_type_lambda_0_1_c1.png</code><br><code>results/figures/task2/g4_i2_article_type_lambda_0_3_c1.png</code><br><code>results/figures/task2/i2_multitask_learning_curves.png</code><br><code>results/figures/task2/i2_multitask_transfer_deltas.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/manifest.json</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/pooled_metrics.json</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/manifest.json</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/pooled_metrics.json</code><br><code>results/evidence/task2/i2_multitask/decision.json</code><br><code>results/evidence/task2/i2_multitask/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/confusion_matrix.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/fold_metrics.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/fold_summary.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/manifest.json</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/per_class_metrics.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/pooled_metrics.json</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_1_c1/registry_snapshot.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/confusion_matrix.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/fold_metrics.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/fold_summary.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/manifest.json</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/per_class_metrics.csv</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/pooled_metrics.json</code><br><code>results/evidence/task2/g4_i2_article_type_lambda_0_3_c1/registry_snapshot.csv</code><br><code>results/evidence/task2/i2_multitask/article_type_majorities_by_fold.csv</code><br><code>results/evidence/task2/i2_multitask/comparison.csv</code><br><code>results/evidence/task2/i2_multitask/decision.json</code><br><code>results/evidence/task2/i2_multitask/fold_shortcut_audit.csv</code><br><code>results/evidence/task2/i2_multitask/learning_curve_summary.csv</code><br><code>results/evidence/task2/i2_multitask/manifest.json</code><br><code>results/evidence/task2/i2_multitask/paired_fold_metrics.csv</code><br><code>results/evidence/task2/i2_multitask/per_class_comparison.csv</code><br><code>results/evidence/task2/i2_multitask/registry_snapshot.csv</code><br><code>results/evidence/task2/i2_multitask/slice_metrics.csv</code><br><code>results/evidence/task2/i2_multitask/slice_summary.csv</code><br><code>results/figures/task2/g4_i2_article_type_lambda_0_1_c1.png</code><br><code>results/figures/task2/g4_i2_article_type_lambda_0_3_c1.png</code><br><code>results/figures/task2/i2_multitask_learning_curves.png</code><br><code>results/figures/task2/i2_multitask_transfer_deltas.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record i2 transfer evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +1360/-0; 4 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a995819</code>, rồi <code>git show --name-status a995819</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 181 — <code>89b52da</code> — docs(notebook): execute i2 transfer gate
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>181</strong> — <code>89b52da1c26b0b664308b147913fe9cdd2986cd0</code> — docs(notebook): execute i2 transfer gate — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “execute i2 transfer gate” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “execute i2 transfer gate”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +1150/-15; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 89b52da</code>, rồi <code>git show --name-status 89b52da</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 182 — <code>ac4fdd6</code> — docs(task2): record i2 transfer judgement
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>182</strong> — <code>ac4fdd64f343b97fb0cd7298125fc2cd272b2eb8</code> — docs(task2): record i2 transfer judgement — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record i2 transfer judgement” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record i2 transfer judgement”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +99/-27; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ac4fdd6</code>, rồi <code>git show --name-status ac4fdd6</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 183 — <code>75417ca</code> — docs(task2): record i2 verification gate
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>183</strong> — <code>75417caac76bdb13cbeb15285105dbd78d921782</code> — docs(task2): record i2 verification gate — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record i2 verification gate” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record i2 verification gate”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +1/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 75417ca</code>, rồi <code>git show --name-status 75417ca</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 184 — <code>37825d4</code> — chore(task2): declare matched pretraining benchmark
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>184</strong> — <code>37825d49e98b1389c28963b53232d82a4011f641</code> — chore(task2): declare matched pretraining benchmark — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare matched pretraining benchmark” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (4):** <code>configs/task2/README.md</code><br><code>configs/task2/g4_p0s_resnet18_standard_scratch.json</code><br><code>configs/task2/g4_pstar_resnet18_standard_pretrained.json</code><br><code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g4_p0s_resnet18_standard_scratch.json</code><br><code>configs/task2/g4_pstar_resnet18_standard_pretrained.json</code>
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare matched pretraining benchmark”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +127/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 37825d4</code>, rồi <code>git show --name-status 37825d4</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 185 — <code>38b3491</code> — feat(task2): add pretraining benchmark runner
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>185</strong> — <code>38b3491da767d586694ac5d062e50392b7598df1</code> — feat(task2): add pretraining benchmark runner — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add pretraining benchmark runner” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (6):** <code>scripts/README.md</code><br><code>scripts/run_task2_pretraining_benchmark.py</code><br><code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/pretraining.py</code><br><code>tests/task2/test_pretraining_launcher.py</code><br><code>tests/task2/test_pretraining_runner.py</code>
- **Code cần đọc:** <code>scripts/README.md</code><br><code>scripts/run_task2_pretraining_benchmark.py</code><br><code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/pretraining.py</code>
- **Test cần đọc:** <code>tests/task2/test_pretraining_launcher.py</code><br><code>tests/task2/test_pretraining_runner.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add pretraining benchmark runner” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +339/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 38b3491</code>, rồi <code>git show --name-status 38b3491</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 186 — <code>e74d0fd</code> — feat(task2): add pretraining benchmark evidence
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>186</strong> — <code>e74d0fdbce1ab9f6c6cce7ad7376f0d256ca6468</code> — feat(task2): add pretraining benchmark evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add pretraining benchmark evidence” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (6):** <code>scripts/README.md</code><br><code>scripts/build_task2_pretraining_evidence.py</code><br><code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/pretraining_evidence.py</code><br><code>tests/task2/test_pretraining_evidence.py</code><br><code>tests/task2/test_pretraining_evidence_launcher.py</code>
- **Code cần đọc:** <code>scripts/README.md</code><br><code>scripts/build_task2_pretraining_evidence.py</code><br><code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/pretraining_evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_pretraining_evidence.py</code><br><code>tests/task2/test_pretraining_evidence_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add pretraining benchmark evidence” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +1116/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e74d0fd</code>, rồi <code>git show --name-status e74d0fd</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 187 — <code>fcbd79c</code> — test(task2): reproduce learning-title overlap
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>187</strong> — <code>fcbd79cac60df38527300e825301a5d6a16a22e9</code> — test(task2): reproduce learning-title overlap — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce learning-title overlap” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_pretraining_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_pretraining_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce learning-title overlap”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +54/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat fcbd79c</code>, rồi <code>git show --name-status fcbd79c</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 188 — <code>8f4cf4a</code> — fix(task2): prevent learning-title overlap
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>188</strong> — <code>8f4cf4a02ac09a80da4689b1fe8b6df06e08eaa7</code> — fix(task2): prevent learning-title overlap — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “prevent learning-title overlap”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/pretraining_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/pretraining_evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “prevent learning-title overlap”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +3/-3; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 8f4cf4a</code>, rồi <code>git show --name-status 8f4cf4a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 189 — <code>70f5308</code> — docs(experiment): record pretrained comparison boundary
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>189</strong> — <code>70f530810ee4b9ee50492a0c68ded53026704eed</code> — docs(experiment): record pretrained comparison boundary — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record pretrained comparison boundary” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (27):** <code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/confusion_matrix.csv</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/fold_metrics.csv</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/fold_summary.csv</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/manifest.json</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/per_class_metrics.csv</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/pooled_metrics.json</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/registry_snapshot.csv</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/confusion_matrix.csv</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/fold_metrics.csv</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/fold_summary.csv</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/manifest.json</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/per_class_metrics.csv</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/pooled_metrics.json</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/registry_snapshot.csv</code><br><code>results/evidence/task2/pretraining_benchmark/comparison.csv</code><br><code>results/evidence/task2/pretraining_benchmark/decision.json</code><br><code>results/evidence/task2/pretraining_benchmark/learning_curve_summary.csv</code><br><code>results/evidence/task2/pretraining_benchmark/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/pretraining_benchmark/manifest.json</code><br><code>results/evidence/task2/pretraining_benchmark/paired_fold_metrics.csv</code><br><code>results/evidence/task2/pretraining_benchmark/per_class_comparison.csv</code><br><code>results/evidence/task2/pretraining_benchmark/pretraining_effect.csv</code><br><code>results/evidence/task2/pretraining_benchmark/registry_snapshot.csv</code><br><code>results/figures/task2/g4_p0s_resnet18_standard_scratch.png</code><br><code>results/figures/task2/g4_pstar_resnet18_standard_pretrained.png</code><br><code>results/figures/task2/pretraining_benchmark_effect.png</code><br><code>results/figures/task2/pretraining_benchmark_learning_curves.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/manifest.json</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/pooled_metrics.json</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/manifest.json</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/pooled_metrics.json</code><br><code>results/evidence/task2/pretraining_benchmark/decision.json</code><br><code>results/evidence/task2/pretraining_benchmark/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/confusion_matrix.csv</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/fold_metrics.csv</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/fold_summary.csv</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/manifest.json</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/per_class_metrics.csv</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/pooled_metrics.json</code><br><code>results/evidence/task2/g4_p0s_resnet18_standard_scratch/registry_snapshot.csv</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/confusion_matrix.csv</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/fold_metrics.csv</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/fold_summary.csv</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/manifest.json</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/per_class_metrics.csv</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/pooled_metrics.json</code><br><code>results/evidence/task2/g4_pstar_resnet18_standard_pretrained/registry_snapshot.csv</code><br><code>results/evidence/task2/pretraining_benchmark/comparison.csv</code><br><code>results/evidence/task2/pretraining_benchmark/decision.json</code><br><code>results/evidence/task2/pretraining_benchmark/learning_curve_summary.csv</code><br><code>results/evidence/task2/pretraining_benchmark/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/pretraining_benchmark/manifest.json</code><br><code>results/evidence/task2/pretraining_benchmark/paired_fold_metrics.csv</code><br><code>results/evidence/task2/pretraining_benchmark/per_class_comparison.csv</code><br><code>results/evidence/task2/pretraining_benchmark/pretraining_effect.csv</code><br><code>results/evidence/task2/pretraining_benchmark/registry_snapshot.csv</code><br><code>results/figures/task2/g4_p0s_resnet18_standard_scratch.png</code><br><code>results/figures/task2/g4_pstar_resnet18_standard_pretrained.png</code><br><code>results/figures/task2/pretraining_benchmark_effect.png</code><br><code>results/figures/task2/pretraining_benchmark_learning_curves.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record pretrained comparison boundary”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +874/-0; 4 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 70f5308</code>, rồi <code>git show --name-status 70f5308</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 190 — <code>2a4b801</code> — docs(notebook): execute pretrained comparison boundary
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>190</strong> — <code>2a4b801a55c50147dc3e425bb99fa672b37f5421</code> — docs(notebook): execute pretrained comparison boundary — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “execute pretrained comparison boundary” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “execute pretrained comparison boundary”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +859/-15; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2a4b801</code>, rồi <code>git show --name-status 2a4b801</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 191 — <code>c05bd8d</code> — docs(task2): record pretrained benchmark judgement
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>191</strong> — <code>c05bd8d7c28a79f3a7338b5eed0cc63bdb130a21</code> — docs(task2): record pretrained benchmark judgement — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record pretrained benchmark judgement” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record pretrained benchmark judgement”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +104/-21; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat c05bd8d</code>, rồi <code>git show --name-status c05bd8d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 192 — <code>1341254</code> — chore(task2): declare finalist stability seed
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>192</strong> — <code>1341254ec8eaf1e80e2bf558e950a52f47286c79</code> — chore(task2): declare finalist stability seed — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare finalist stability seed” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (4):** <code>configs/task2/README.md</code><br><code>configs/task2/g5_c2_t0_resnet18_seed_2026.json</code><br><code>configs/task2/g5_i2_article_type_lambda_0_3_c1_seed_2026.json</code><br><code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g5_c2_t0_resnet18_seed_2026.json</code><br><code>configs/task2/g5_i2_article_type_lambda_0_3_c1_seed_2026.json</code>
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare finalist stability seed”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +135/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1341254</code>, rồi <code>git show --name-status 1341254</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 193 — <code>b6540b8</code> — feat(task2): add finalist stability runner
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>193</strong> — <code>b6540b8b20d7b73fcb5f4d1a99ab60fbc5101345</code> — feat(task2): add finalist stability runner — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add finalist stability runner” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (4):** <code>scripts/run_task2_stability.py</code><br><code>src/fashion/task2/stability.py</code><br><code>tests/task2/test_stability_launcher.py</code><br><code>tests/task2/test_stability_runner.py</code>
- **Code cần đọc:** <code>scripts/run_task2_stability.py</code><br><code>src/fashion/task2/stability.py</code>
- **Test cần đọc:** <code>tests/task2/test_stability_launcher.py</code><br><code>tests/task2/test_stability_runner.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add finalist stability runner” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +391/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat b6540b8</code>, rồi <code>git show --name-status b6540b8</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 194 — <code>99d5f90</code> — feat(task2): add seed stability evidence
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>194</strong> — <code>99d5f9083e4a10c1cf53b3bdc24579134447ea34</code> — feat(task2): add seed stability evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add seed stability evidence” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (4):** <code>scripts/build_task2_stability_evidence.py</code><br><code>src/fashion/task2/stability_evidence.py</code><br><code>tests/task2/test_stability_evidence.py</code><br><code>tests/task2/test_stability_evidence_launcher.py</code>
- **Code cần đọc:** <code>scripts/build_task2_stability_evidence.py</code><br><code>src/fashion/task2/stability_evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_stability_evidence.py</code><br><code>tests/task2/test_stability_evidence_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add seed stability evidence” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +1428/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 99d5f90</code>, rồi <code>git show --name-status 99d5f90</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 195 — <code>2da2754</code> — test(task2): reproduce stability hash bypass
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>195</strong> — <code>2da275455cd4eb6d546dc18d81dc48c9a6ef480e</code> — test(task2): reproduce stability hash bypass — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce stability hash bypass” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_stability_runner.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_stability_runner.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce stability hash bypass”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +34/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2da2754</code>, rồi <code>git show --name-status 2da2754</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 196 — <code>04ef69d</code> — fix(task2): preflight stability implementation hashes
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>196</strong> — <code>04ef69dfd72f1722638b7274f9f6e7bbac590a86</code> — fix(task2): preflight stability implementation hashes — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “preflight stability implementation hashes”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/task2/stability.py</code><br><code>tests/task2/test_stability_runner.py</code>
- **Code cần đọc:** <code>src/fashion/task2/stability.py</code>
- **Test cần đọc:** <code>tests/task2/test_stability_runner.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “preflight stability implementation hashes”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +150/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 04ef69d</code>, rồi <code>git show --name-status 04ef69d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 197 — <code>daf65c8</code> — docs(experiment): record stability and close modelling gate
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>197</strong> — <code>daf65c82b2a3dee16239b3e9fc9544fb6c1b6de0</code> — docs(experiment): record stability and close modelling gate — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record stability and close modelling gate” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (27):** <code>results/evidence/task2/g5_c2_t0_resnet18_s2026/confusion_matrix.csv</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/fold_metrics.csv</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/fold_summary.csv</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/manifest.json</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/per_class_metrics.csv</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/pooled_metrics.json</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/registry_snapshot.csv</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/confusion_matrix.csv</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/fold_metrics.csv</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/fold_summary.csv</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/manifest.json</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/per_class_metrics.csv</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/pooled_metrics.json</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/registry_snapshot.csv</code><br><code>results/evidence/task2/seed_stability/decision.json</code><br><code>results/evidence/task2/seed_stability/learning_curve_summary.csv</code><br><code>results/evidence/task2/seed_stability/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/seed_stability/manifest.json</code><br><code>results/evidence/task2/seed_stability/paired_fold_metrics.csv</code><br><code>results/evidence/task2/seed_stability/per_class_by_seed.csv</code><br><code>results/evidence/task2/seed_stability/registry_snapshot.csv</code><br><code>results/evidence/task2/seed_stability/seed_drift.csv</code><br><code>results/evidence/task2/seed_stability/seed_stability.csv</code><br><code>results/figures/task2/g5_c2_t0_resnet18_s2026.png</code><br><code>results/figures/task2/g5_i2_article_type_lambda_0_3_c1_s2026.png</code><br><code>results/figures/task2/seed_stability_comparison.png</code><br><code>results/figures/task2/seed_stability_learning_curves.png</code>
- **Code cần đọc:** <code>results/evidence/task2/g5_c2_t0_resnet18_s2026/manifest.json</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/pooled_metrics.json</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/manifest.json</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/pooled_metrics.json</code><br><code>results/evidence/task2/seed_stability/decision.json</code><br><code>results/evidence/task2/seed_stability/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/g5_c2_t0_resnet18_s2026/confusion_matrix.csv</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/fold_metrics.csv</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/fold_summary.csv</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/manifest.json</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/per_class_metrics.csv</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/pooled_metrics.json</code><br><code>results/evidence/task2/g5_c2_t0_resnet18_s2026/registry_snapshot.csv</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/confusion_matrix.csv</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/fold_metrics.csv</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/fold_summary.csv</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/manifest.json</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/per_class_metrics.csv</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/pooled_metrics.json</code><br><code>results/evidence/task2/g5_i2_article_type_lambda_0_3_c1_s2026/registry_snapshot.csv</code><br><code>results/evidence/task2/seed_stability/decision.json</code><br><code>results/evidence/task2/seed_stability/learning_curve_summary.csv</code><br><code>results/evidence/task2/seed_stability/learning_curves_by_fold.csv</code><br><code>results/evidence/task2/seed_stability/manifest.json</code><br><code>results/evidence/task2/seed_stability/paired_fold_metrics.csv</code><br><code>results/evidence/task2/seed_stability/per_class_by_seed.csv</code><br><code>results/evidence/task2/seed_stability/registry_snapshot.csv</code><br><code>results/evidence/task2/seed_stability/seed_drift.csv</code><br><code>results/evidence/task2/seed_stability/seed_stability.csv</code><br><code>results/figures/task2/g5_c2_t0_resnet18_s2026.png</code><br><code>results/figures/task2/g5_i2_article_type_lambda_0_3_c1_s2026.png</code><br><code>results/figures/task2/seed_stability_comparison.png</code><br><code>results/figures/task2/seed_stability_learning_curves.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record stability and close modelling gate”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +1219/-0; 4 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat daf65c8</code>, rồi <code>git show --name-status daf65c8</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 198 — <code>e6939c3</code> — docs(notebook): execute seed stability evidence
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>198</strong> — <code>e6939c3508a5338855123284d1eedcda16182a72</code> — docs(notebook): execute seed stability evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “execute seed stability evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “execute seed stability evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +909/-15; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e6939c3</code>, rồi <code>git show --name-status e6939c3</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 199 — <code>62e8cda</code> — fix(notebook): wrap stability drift formatting
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>199</strong> — <code>62e8cda8a0849e343dd15a4f42dd597220aadb29</code> — fix(notebook): wrap stability drift formatting — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “wrap stability drift formatting”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “wrap stability drift formatting”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +6/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 62e8cda</code>, rồi <code>git show --name-status 62e8cda</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 200 — <code>a68c89a</code> — docs(task2): record two-seed stability judgement
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>200</strong> — <code>a68c89a3fb60976071116c1aa2e36a2765410142</code> — docs(task2): record two-seed stability judgement — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record two-seed stability judgement” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record two-seed stability judgement”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +90/-23; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a68c89a</code>, rồi <code>git show --name-status a68c89a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 201 — <code>36a6fff</code> — chore(task2): declare shortcut and error slices
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>201</strong> — <code>36a6fff83712880fb7080b04e9acdc0bae913443</code> — chore(task2): declare shortcut and error slices — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare shortcut and error slices” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (2):** <code>configs/task2/README.md</code><br><code>configs/task2/g6_shortcut_error_slices.json</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g6_shortcut_error_slices.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare shortcut and error slices”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +114/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 36a6fff</code>, rồi <code>git show --name-status 36a6fff</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 202 — <code>95b11a4</code> — feat(task2): add shortcut and error slices
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>202</strong> — <code>95b11a47910e941c5f03abb96e597037f65c5cb5</code> — feat(task2): add shortcut and error slices — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add shortcut and error slices” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (7):** <code>scripts/README.md</code><br><code>scripts/build_task2_slice_evidence.py</code><br><code>src/fashion/task2/slice_evidence.py</code><br><code>src/fashion/task2/slices.py</code><br><code>tests/task2/test_slice_evidence.py</code><br><code>tests/task2/test_slice_evidence_launcher.py</code><br><code>tests/task2/test_slices.py</code>
- **Code cần đọc:** <code>scripts/README.md</code><br><code>scripts/build_task2_slice_evidence.py</code><br><code>src/fashion/task2/slice_evidence.py</code><br><code>src/fashion/task2/slices.py</code>
- **Test cần đọc:** <code>tests/task2/test_slice_evidence.py</code><br><code>tests/task2/test_slice_evidence_launcher.py</code><br><code>tests/task2/test_slices.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add shortcut and error slices” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +2024/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 95b11a4</code>, rồi <code>git show --name-status 95b11a4</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 203 — <code>1195f0a</code> — test(task2): reproduce normalized config hash regression
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>203</strong> — <code>1195f0af149014ff23cd2c4584371be32712232e</code> — test(task2): reproduce normalized config hash regression — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce normalized config hash regression” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_slice_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_slice_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce normalized config hash regression”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +21/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1195f0a</code>, rồi <code>git show --name-status 1195f0a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 204 — <code>077936a</code> — fix(task2): hash normalized slice configs
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>204</strong> — <code>077936aa60cfafe2747ce401dd11b7fc20d66cb0</code> — fix(task2): hash normalized slice configs — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “hash normalized slice configs”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/slice_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/slice_evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “hash normalized slice configs”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +33/-4; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 077936a</code>, rồi <code>git show --name-status 077936a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 205 — <code>6af8ecd</code> — test(task2): reproduce low-support slice warning gap
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>205</strong> — <code>6af8ecd3d77a66fc6c5940d9a0a25a3bffcb834b</code> — test(task2): reproduce low-support slice warning gap — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce low-support slice warning gap” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_slice_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_slice_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce low-support slice warning gap”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +7/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6af8ecd</code>, rồi <code>git show --name-status 6af8ecd</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 206 — <code>15da0ec</code> — fix(task2): flag low-support slice findings
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>206</strong> — <code>15da0ec96efff2083739785d7297aee16ce57e23</code> — fix(task2): flag low-support slice findings — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “flag low-support slice findings”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/task2/slice_evidence.py</code><br><code>src/fashion/task2/slices.py</code>
- **Code cần đọc:** <code>src/fashion/task2/slice_evidence.py</code><br><code>src/fashion/task2/slices.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “flag low-support slice findings”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +55/-5; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 15da0ec</code>, rồi <code>git show --name-status 15da0ec</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 207 — <code>7717a7b</code> — docs(experiment): record shortcut and minority evidence
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>207</strong> — <code>7717a7bc14a8c03af068d9c810c6fd55cf9d3966</code> — docs(experiment): record shortcut and minority evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record shortcut and minority evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (16):** <code>results/evidence/task2/shortcut_error_slices/article_type_fold_audit.csv</code><br><code>results/evidence/task2/shortcut_error_slices/article_type_mappings.csv</code><br><code>results/evidence/task2/shortcut_error_slices/candidate_slice_deltas.csv</code><br><code>results/evidence/task2/shortcut_error_slices/decision.json</code><br><code>results/evidence/task2/shortcut_error_slices/error_confusions.csv</code><br><code>results/evidence/task2/shortcut_error_slices/error_examples.csv</code><br><code>results/evidence/task2/shortcut_error_slices/file_size_boundaries.csv</code><br><code>results/evidence/task2/shortcut_error_slices/manifest.json</code><br><code>results/evidence/task2/shortcut_error_slices/registry_snapshot.csv</code><br><code>results/evidence/task2/shortcut_error_slices/slice_contrasts.csv</code><br><code>results/evidence/task2/shortcut_error_slices/slice_metrics.csv</code><br><code>results/evidence/task2/shortcut_error_slices/slice_support.csv</code><br><code>results/evidence/task2/shortcut_error_slices/spring_destinations.csv</code><br><code>results/evidence/task2/shortcut_error_slices/spring_metrics.csv</code><br><code>results/figures/task2/shortcut_slice_macro_f1.png</code><br><code>results/figures/task2/spring_error_destinations.png</code>
- **Code cần đọc:** <code>results/evidence/task2/shortcut_error_slices/decision.json</code><br><code>results/evidence/task2/shortcut_error_slices/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/shortcut_error_slices/article_type_fold_audit.csv</code><br><code>results/evidence/task2/shortcut_error_slices/article_type_mappings.csv</code><br><code>results/evidence/task2/shortcut_error_slices/candidate_slice_deltas.csv</code><br><code>results/evidence/task2/shortcut_error_slices/decision.json</code><br><code>results/evidence/task2/shortcut_error_slices/error_confusions.csv</code><br><code>results/evidence/task2/shortcut_error_slices/error_examples.csv</code><br><code>results/evidence/task2/shortcut_error_slices/file_size_boundaries.csv</code><br><code>results/evidence/task2/shortcut_error_slices/manifest.json</code><br><code>results/evidence/task2/shortcut_error_slices/registry_snapshot.csv</code><br><code>results/evidence/task2/shortcut_error_slices/slice_contrasts.csv</code><br><code>results/evidence/task2/shortcut_error_slices/slice_metrics.csv</code><br><code>results/evidence/task2/shortcut_error_slices/slice_support.csv</code><br><code>results/evidence/task2/shortcut_error_slices/spring_destinations.csv</code><br><code>results/evidence/task2/shortcut_error_slices/spring_metrics.csv</code><br><code>results/figures/task2/shortcut_slice_macro_f1.png</code><br><code>results/figures/task2/spring_error_destinations.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record shortcut and minority evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +1172/-0; 2 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7717a7b</code>, rồi <code>git show --name-status 7717a7b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 208 — <code>a749f02</code> — chore(task2): declare robustness and cost probes
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>208</strong> — <code>a749f025b95b6683d1baf74229ef103c83ab2351</code> — chore(task2): declare robustness and cost probes — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare robustness and cost probes” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (2):** <code>configs/task2/README.md</code><br><code>configs/task2/g6_robustness_cost.json</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g6_robustness_cost.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare robustness and cost probes”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +105/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a749f02</code>, rồi <code>git show --name-status a749f02</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 209 — <code>675397d</code> — docs(task2): defer app and report integration
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>209</strong> — <code>675397d25fb031066325914729157057d7630355</code> — docs(task2): defer app and report integration — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “defer app and report integration” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “defer app and report integration”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +5/-6; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 675397d</code>, rồi <code>git show --name-status 675397d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 210 — <code>d865ea6</code> — feat(task2): add robustness and cost probes
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>210</strong> — <code>d865ea65da48a0dd15300fc92fd403d252ada78d</code> — feat(task2): add robustness and cost probes — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add robustness and cost probes” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (7):** <code>scripts/README.md</code><br><code>scripts/build_task2_robustness_evidence.py</code><br><code>src/fashion/task2/robustness.py</code><br><code>src/fashion/task2/robustness_evidence.py</code><br><code>tests/task2/test_robustness.py</code><br><code>tests/task2/test_robustness_evidence.py</code><br><code>tests/task2/test_robustness_evidence_launcher.py</code>
- **Code cần đọc:** <code>scripts/README.md</code><br><code>scripts/build_task2_robustness_evidence.py</code><br><code>src/fashion/task2/robustness.py</code><br><code>src/fashion/task2/robustness_evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_robustness.py</code><br><code>tests/task2/test_robustness_evidence.py</code><br><code>tests/task2/test_robustness_evidence_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add robustness and cost probes” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +2957/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat d865ea6</code>, rồi <code>git show --name-status d865ea6</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 211 — <code>9e427d4</code> — test(task2): reproduce unpaired clean robustness baseline
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>211</strong> — <code>9e427d4a2a28f0c665370c3c49b8ed83410acd5e</code> — test(task2): reproduce unpaired clean robustness baseline — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce unpaired clean robustness baseline” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_robustness.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_robustness.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce unpaired clean robustness baseline”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +28/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 9e427d4</code>, rồi <code>git show --name-status 9e427d4</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 212 — <code>7d1310d</code> — fix(task2): pair clean robustness inference
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>212</strong> — <code>7d1310dbaeadd2654f6c6fb5669235cf4909e25f</code> — fix(task2): pair clean robustness inference — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “pair clean robustness inference”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (4):** <code>configs/task2/g6_robustness_cost.json</code><br><code>src/fashion/task2/robustness.py</code><br><code>src/fashion/task2/robustness_evidence.py</code><br><code>tests/task2/test_robustness.py</code>
- **Code cần đọc:** <code>configs/task2/g6_robustness_cost.json</code><br><code>src/fashion/task2/robustness.py</code><br><code>src/fashion/task2/robustness_evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_robustness.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “pair clean robustness inference”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +134/-22; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7d1310d</code>, rồi <code>git show --name-status 7d1310d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 213 — <code>cf36479</code> — test(task2): reproduce stale image probe cache
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>213</strong> — <code>cf3647942e95781402ec64d4dea434057b5d34c4</code> — test(task2): reproduce stale image probe cache — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce stale image probe cache” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_robustness.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_robustness.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce stale image probe cache”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +36/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat cf36479</code>, rồi <code>git show --name-status cf36479</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 214 — <code>41f9ada</code> — fix(task2): bind probe caches to image bytes
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>214</strong> — <code>41f9ada3bd285c9eb83262147e610407fb94b64f</code> — fix(task2): bind probe caches to image bytes — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “bind probe caches to image bytes”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (3):** <code>src/fashion/task2/robustness.py</code><br><code>src/fashion/task2/robustness_evidence.py</code><br><code>tests/task2/test_robustness.py</code>
- **Code cần đọc:** <code>src/fashion/task2/robustness.py</code><br><code>src/fashion/task2/robustness_evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_robustness.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “bind probe caches to image bytes”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +82/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 41f9ada</code>, rồi <code>git show --name-status 41f9ada</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 215 — <code>4b48594</code> — test(task2): reproduce incomplete robustness source hash
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>215</strong> — <code>4b48594fee9c63332a4f8cac61ecf4f98743cd34</code> — test(task2): reproduce incomplete robustness source hash — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce incomplete robustness source hash” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_robustness.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_robustness.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce incomplete robustness source hash”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +15/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 4b48594</code>, rồi <code>git show --name-status 4b48594</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 216 — <code>9570635</code> — fix(task2): cover robustness dependency graph
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>216</strong> — <code>957063532070cc8c28472d56c0133259bd8e5336</code> — fix(task2): cover robustness dependency graph — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “cover robustness dependency graph”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/robustness.py</code>
- **Code cần đọc:** <code>src/fashion/task2/robustness.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “cover robustness dependency graph”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +20/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 9570635</code>, rồi <code>git show --name-status 9570635</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 217 — <code>34966e8</code> — test(task2): reproduce untracked provenance gap
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>217</strong> — <code>34966e8a356f2d192918c59635744979ca46c93a</code> — test(task2): reproduce untracked provenance gap — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce untracked provenance gap” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_robustness_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_robustness_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce untracked provenance gap”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +31/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 34966e8</code>, rồi <code>git show --name-status 34966e8</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 218 — <code>bf852f0</code> — fix(task2): require committed probe sources
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>218</strong> — <code>bf852f043a378505cfd154fc17db1e6ecab4c27e</code> — fix(task2): require committed probe sources — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “require committed probe sources”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (3):** <code>src/fashion/task2/robustness_evidence.py</code><br><code>src/fashion/train/cache.py</code><br><code>tests/task2/test_robustness_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/robustness_evidence.py</code><br><code>src/fashion/train/cache.py</code>
- **Test cần đọc:** <code>tests/task2/test_robustness_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “require committed probe sources”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +49/-4; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat bf852f0</code>, rồi <code>git show --name-status bf852f0</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 219 — <code>3a88450</code> — test(task2): reproduce absolute evidence paths
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>219</strong> — <code>3a88450a3d0cb64be8dff0d652e226cc9af129d2</code> — test(task2): reproduce absolute evidence paths — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce absolute evidence paths” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_robustness_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_robustness_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce absolute evidence paths”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +23/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 3a88450</code>, rồi <code>git show --name-status 3a88450</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 220 — <code>03069a0</code> — fix(task2): make probe evidence paths portable
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>220</strong> — <code>03069a06b568135770fa7b9c4669ce444d36a4b3</code> — fix(task2): make probe evidence paths portable — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “make probe evidence paths portable”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/robustness_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/robustness_evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “make probe evidence paths portable”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +33/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 03069a0</code>, rồi <code>git show --name-status 03069a0</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 221 — <code>08155ef</code> — test(task2): reproduce run-load manifest drift
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>221</strong> — <code>08155efec42d408a98ff06d97dd9778308df72b9</code> — test(task2): reproduce run-load manifest drift — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce run-load manifest drift” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_robustness_evidence.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_robustness_evidence.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce run-load manifest drift”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +37/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 08155ef</code>, rồi <code>git show --name-status 08155ef</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 222 — <code>7c86a1f</code> — fix(task2): stabilise run-load evidence order
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>222</strong> — <code>7c86a1f5c298c7774e87fec7ca5decc9610276a3</code> — fix(task2): stabilise run-load evidence order — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “stabilise run-load evidence order”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/robustness_evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/robustness_evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “stabilise run-load evidence order”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +12/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7c86a1f</code>, rồi <code>git show --name-status 7c86a1f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 223 — <code>d19fcbe</code> — test(task2): reproduce prediction cache roundtrip drift
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>223</strong> — <code>d19fcbe77a127c947ebb06d2b8609259f4b40cb7</code> — test(task2): reproduce prediction cache roundtrip drift — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce prediction cache roundtrip drift” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_robustness.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_robustness.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce prediction cache roundtrip drift”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +5/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat d19fcbe</code>, rồi <code>git show --name-status d19fcbe</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 224 — <code>40e8e94</code> — fix(task2): canonicalise fresh probe predictions
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>224</strong> — <code>40e8e944774b451059bf4c6b4a8b58eccf0c3de2</code> — fix(task2): canonicalise fresh probe predictions — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “canonicalise fresh probe predictions”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/robustness.py</code>
- **Code cần đọc:** <code>src/fashion/task2/robustness.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “canonicalise fresh probe predictions”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +1/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 40e8e94</code>, rồi <code>git show --name-status 40e8e94</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 225 — <code>e7d5bcb</code> — docs(experiment): record robustness and deployment cost
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>225</strong> — <code>e7d5bcbaee8e4cc074fcc32af6cfa5703764326c</code> — docs(experiment): record robustness and deployment cost — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record robustness and deployment cost” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (12):** <code>results/evidence/task2/robustness_cost/candidate_comparison.csv</code><br><code>results/evidence/task2/robustness_cost/checkpoint_audit.csv</code><br><code>results/evidence/task2/robustness_cost/clean_reconciliation.csv</code><br><code>results/evidence/task2/robustness_cost/decision.json</code><br><code>results/evidence/task2/robustness_cost/deployment_cost.csv</code><br><code>results/evidence/task2/robustness_cost/fold_metrics.csv</code><br><code>results/evidence/task2/robustness_cost/manifest.json</code><br><code>results/evidence/task2/robustness_cost/pooled_metrics.csv</code><br><code>results/evidence/task2/robustness_cost/probe_registry.csv</code><br><code>results/evidence/task2/robustness_cost/runtime.json</code><br><code>results/figures/task2/deployment_cost.png</code><br><code>results/figures/task2/robustness_comparison.png</code>
- **Code cần đọc:** <code>results/evidence/task2/robustness_cost/decision.json</code><br><code>results/evidence/task2/robustness_cost/manifest.json</code><br><code>results/evidence/task2/robustness_cost/runtime.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/robustness_cost/candidate_comparison.csv</code><br><code>results/evidence/task2/robustness_cost/checkpoint_audit.csv</code><br><code>results/evidence/task2/robustness_cost/clean_reconciliation.csv</code><br><code>results/evidence/task2/robustness_cost/decision.json</code><br><code>results/evidence/task2/robustness_cost/deployment_cost.csv</code><br><code>results/evidence/task2/robustness_cost/fold_metrics.csv</code><br><code>results/evidence/task2/robustness_cost/manifest.json</code><br><code>results/evidence/task2/robustness_cost/pooled_metrics.csv</code><br><code>results/evidence/task2/robustness_cost/probe_registry.csv</code><br><code>results/evidence/task2/robustness_cost/runtime.json</code><br><code>results/figures/task2/deployment_cost.png</code><br><code>results/figures/task2/robustness_comparison.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record robustness and deployment cost”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +597/-0; 2 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e7d5bcb</code>, rồi <code>git show --name-status e7d5bcb</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 226 — <code>3567880</code> — chore(task2): declare cross-fitted calibration
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>226</strong> — <code>35678802992d59daf7d17df041a125975b475b5c</code> — chore(task2): declare cross-fitted calibration — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare cross-fitted calibration” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (2):** <code>configs/task2/README.md</code><br><code>configs/task2/g6_cross_fitted_calibration.json</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g6_cross_fitted_calibration.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare cross-fitted calibration”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +94/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 3567880</code>, rồi <code>git show --name-status 3567880</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Runtime hoặc dependency boundary phải được khai báo trước khi code có thể chạy ổn định: 227 — <code>22ce401</code> — build(deps): declare scipy calibration optimizer
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>227</strong> — <code>22ce401f98cf4cc8fc75cdfe809992c8acd5fd53</code> — build(deps): declare scipy calibration optimizer — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: dependency/runtime boundary “declare scipy calibration optimizer” chưa tái lập đủ. Hypothesis: pin/constraint đúng sẽ làm environment portable hơn.
- **Files changed (1):** <code>pyproject.toml</code>
- **Code cần đọc:** <code>pyproject.toml</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: cập nhật “declare scipy calibration optimizer”. Result là dependency boundary; không phải modelling improvement.
- **Git diff footprint:** +1/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 22ce401</code>, rồi <code>git show --name-status 22ce401</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Dependency pass trên environment ghi nhận không bảo đảm mọi CPU/GPU/OS.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 228 — <code>75f7ecf</code> — feat(train): add cross-fitted temperature scaling
- **Senior lesson:** Giữ thay đổi focused, traceable và independently verifiable.

</details>

<details>
<summary><strong>228</strong> — <code>75f7ecfc3e1c4b8b45da0831fef545f634beb3a8</code> — feat(train): add cross-fitted temperature scaling — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add cross-fitted temperature scaling” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/metrics.py</code><br><code>tests/train/test_metrics.py</code>
- **Code cần đọc:** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/metrics.py</code>
- **Test cần đọc:** <code>tests/train/test_metrics.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add cross-fitted temperature scaling” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +276/-11; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 75f7ecf</code>, rồi <code>git show --name-status 75f7ecf</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 229 — <code>eabd6a9</code> — test(train): reproduce calibration boundary failures
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>229</strong> — <code>eabd6a91bd08c0299c1c0ed651eb78ded1fb1616</code> — test(train): reproduce calibration boundary failures — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce calibration boundary failures” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/train/test_metrics.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/train/test_metrics.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce calibration boundary failures”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +69/-5; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat eabd6a9</code>, rồi <code>git show --name-status eabd6a9</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 230 — <code>d35a1c4</code> — fix(train): harden calibration numerics
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>230</strong> — <code>d35a1c4c5afdcdd485280550585c37094be9f7e2</code> — fix(train): harden calibration numerics — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “harden calibration numerics”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/train/metrics.py</code><br><code>tests/train/test_metrics.py</code>
- **Code cần đọc:** <code>src/fashion/train/metrics.py</code>
- **Test cần đọc:** <code>tests/train/test_metrics.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “harden calibration numerics”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +29/-10; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat d35a1c4</code>, rồi <code>git show --name-status d35a1c4</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 231 — <code>d0b103f</code> — fix(config): define risk coverage rounding
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>231</strong> — <code>d0b103f7c699c1ceff03b8510629e78ed9758f5f</code> — fix(config): define risk coverage rounding — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “define risk coverage rounding”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>configs/task2/g6_cross_fitted_calibration.json</code>
- **Code cần đọc:** <code>configs/task2/g6_cross_fitted_calibration.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “define risk coverage rounding”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +1/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat d0b103f</code>, rồi <code>git show --name-status d0b103f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 232 — <code>a53fb24</code> — feat(task2): add calibration analysis tables
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>232</strong> — <code>a53fb248de0ba34a768985b34f2bb26b2980ec2f</code> — feat(task2): add calibration analysis tables — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add calibration analysis tables” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/task2/calibration.py</code><br><code>tests/task2/test_calibration.py</code>
- **Code cần đọc:** <code>src/fashion/task2/calibration.py</code>
- **Test cần đọc:** <code>tests/task2/test_calibration.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add calibration analysis tables” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +1129/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a53fb24</code>, rồi <code>git show --name-status a53fb24</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 233 — <code>500e83b</code> — test(train): reproduce missing scipy provenance
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>233</strong> — <code>500e83b6c28a62346a0b9673729cdc224d5f3323</code> — test(train): reproduce missing scipy provenance — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce missing scipy provenance” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/train/test_reproducibility.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/train/test_reproducibility.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce missing scipy provenance”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +1/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 500e83b</code>, rồi <code>git show --name-status 500e83b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 234 — <code>faa0f24</code> — fix(train): capture scipy runtime provenance
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>234</strong> — <code>faa0f243ae9670cff6a4d6f018201177276df88d</code> — fix(train): capture scipy runtime provenance — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “capture scipy runtime provenance”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/train/reproducibility.py</code>
- **Code cần đọc:** <code>src/fashion/train/reproducibility.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “capture scipy runtime provenance”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +1/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat faa0f24</code>, rồi <code>git show --name-status faa0f24</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 235 — <code>ba5c310</code> — feat(task2): add calibration evidence builder
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>235</strong> — <code>ba5c31008b54e860370e6fe0245ab1528011d176</code> — feat(task2): add calibration evidence builder — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add calibration evidence builder” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (5):** <code>scripts/README.md</code><br><code>scripts/build_task2_calibration_evidence.py</code><br><code>src/fashion/task2/calibration_evidence.py</code><br><code>tests/task2/test_calibration_evidence.py</code><br><code>tests/task2/test_calibration_evidence_launcher.py</code>
- **Code cần đọc:** <code>scripts/README.md</code><br><code>scripts/build_task2_calibration_evidence.py</code><br><code>src/fashion/task2/calibration_evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_calibration_evidence.py</code><br><code>tests/task2/test_calibration_evidence_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add calibration evidence builder” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +1551/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ba5c310</code>, rồi <code>git show --name-status ba5c310</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 236 — <code>b845414</code> — docs(experiment): record calibration and risk coverage
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>236</strong> — <code>b845414fbac785763f9138506ecae608503dc819</code> — docs(experiment): record calibration and risk coverage — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record calibration and risk coverage” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (11):** <code>results/evidence/task2/calibration/calibration_summary.csv</code><br><code>results/evidence/task2/calibration/decision.json</code><br><code>results/evidence/task2/calibration/deployment_temperatures.csv</code><br><code>results/evidence/task2/calibration/fold_temperatures.csv</code><br><code>results/evidence/task2/calibration/manifest.json</code><br><code>results/evidence/task2/calibration/reliability_bins.csv</code><br><code>results/evidence/task2/calibration/review_budget_summary.csv</code><br><code>results/evidence/task2/calibration/risk_coverage.csv</code><br><code>results/evidence/task2/calibration/runtime.json</code><br><code>results/figures/task2/calibration_reliability.png</code><br><code>results/figures/task2/risk_coverage.png</code>
- **Code cần đọc:** <code>results/evidence/task2/calibration/decision.json</code><br><code>results/evidence/task2/calibration/manifest.json</code><br><code>results/evidence/task2/calibration/runtime.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/calibration/calibration_summary.csv</code><br><code>results/evidence/task2/calibration/decision.json</code><br><code>results/evidence/task2/calibration/deployment_temperatures.csv</code><br><code>results/evidence/task2/calibration/fold_temperatures.csv</code><br><code>results/evidence/task2/calibration/manifest.json</code><br><code>results/evidence/task2/calibration/reliability_bins.csv</code><br><code>results/evidence/task2/calibration/review_budget_summary.csv</code><br><code>results/evidence/task2/calibration/risk_coverage.csv</code><br><code>results/evidence/task2/calibration/runtime.json</code><br><code>results/figures/task2/calibration_reliability.png</code><br><code>results/figures/task2/risk_coverage.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record calibration and risk coverage”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +765/-0; 2 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat b845414</code>, rồi <code>git show --name-status b845414</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 237 — <code>97533b5</code> — chore(task2): declare paired grouped bootstrap
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>237</strong> — <code>97533b51a7d680a1ccf211a0ab4944530ae0ed55</code> — chore(task2): declare paired grouped bootstrap — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare paired grouped bootstrap” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (2):** <code>configs/task2/README.md</code><br><code>configs/task2/g6_paired_group_bootstrap.json</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g6_paired_group_bootstrap.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare paired grouped bootstrap”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +88/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 97533b5</code>, rồi <code>git show --name-status 97533b5</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 238 — <code>6cb0abd</code> — feat(train): add paired grouped bootstrap
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>238</strong> — <code>6cb0abdb71ff7c061e45a1ceb87631eb38cebaff</code> — feat(train): add paired grouped bootstrap — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add paired grouped bootstrap” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/metrics.py</code><br><code>tests/train/test_metrics.py</code>
- **Code cần đọc:** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/metrics.py</code>
- **Test cần đọc:** <code>tests/train/test_metrics.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add paired grouped bootstrap” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +488/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6cb0abd</code>, rồi <code>git show --name-status 6cb0abd</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 239 — <code>5443c91</code> — test(config): reproduce bootstrap stability id drift
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>239</strong> — <code>5443c912a32d93cd5b8957b564ec43b984f89221</code> — test(config): reproduce bootstrap stability id drift — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce bootstrap stability id drift” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_experiments.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_experiments.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce bootstrap stability id drift”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +20/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 5443c91</code>, rồi <code>git show --name-status 5443c91</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 240 — <code>63ddc4f</code> — fix(config): align bootstrap stability identities
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>240</strong> — <code>63ddc4fc0892716e9cd1676b08fc8ff60d582c04</code> — fix(config): align bootstrap stability identities — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “align bootstrap stability identities”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>configs/task2/g6_paired_group_bootstrap.json</code>
- **Code cần đọc:** <code>configs/task2/g6_paired_group_bootstrap.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “align bootstrap stability identities”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +2/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 63ddc4f</code>, rồi <code>git show --name-status 63ddc4f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 241 — <code>521ded1</code> — feat(task2): add paired bootstrap analysis
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>241</strong> — <code>521ded15d3ed3dfe4e0a9c1d83f6a81720708514</code> — feat(task2): add paired bootstrap analysis — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add paired bootstrap analysis” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/task2/bootstrap.py</code><br><code>tests/task2/test_bootstrap.py</code>
- **Code cần đọc:** <code>src/fashion/task2/bootstrap.py</code>
- **Test cần đọc:** <code>tests/task2/test_bootstrap.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add paired bootstrap analysis” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +1112/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 521ded1</code>, rồi <code>git show --name-status 521ded1</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 242 — <code>112014d</code> — feat(task2): add bootstrap evidence builder
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>242</strong> — <code>112014dd19191ee5ac35798f78f06005b967dbd3</code> — feat(task2): add bootstrap evidence builder — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add bootstrap evidence builder” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (5):** <code>scripts/README.md</code><br><code>scripts/build_task2_bootstrap_evidence.py</code><br><code>src/fashion/task2/bootstrap_evidence.py</code><br><code>tests/task2/test_bootstrap_evidence.py</code><br><code>tests/task2/test_bootstrap_evidence_launcher.py</code>
- **Code cần đọc:** <code>scripts/README.md</code><br><code>scripts/build_task2_bootstrap_evidence.py</code><br><code>src/fashion/task2/bootstrap_evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_bootstrap_evidence.py</code><br><code>tests/task2/test_bootstrap_evidence_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add bootstrap evidence builder” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +1084/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 112014d</code>, rồi <code>git show --name-status 112014d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 243 — <code>d81161d</code> — docs(experiment): record finalist uncertainty
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>243</strong> — <code>d81161dafae46d5776216dafbfeb9facf2fd056f</code> — docs(experiment): record finalist uncertainty — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record finalist uncertainty” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (9):** <code>docs/task2-season-execution-report.md</code><br><code>results/evidence/task2/paired_bootstrap/decision.json</code><br><code>results/evidence/task2/paired_bootstrap/group_audit.csv</code><br><code>results/evidence/task2/paired_bootstrap/interval_summary.csv</code><br><code>results/evidence/task2/paired_bootstrap/manifest.json</code><br><code>results/evidence/task2/paired_bootstrap/observed_metrics.csv</code><br><code>results/evidence/task2/paired_bootstrap/registry_snapshot.csv</code><br><code>results/evidence/task2/paired_bootstrap/runtime.json</code><br><code>results/figures/task2/paired_group_bootstrap.png</code>
- **Code cần đọc:** <code>results/evidence/task2/paired_bootstrap/decision.json</code><br><code>results/evidence/task2/paired_bootstrap/manifest.json</code><br><code>results/evidence/task2/paired_bootstrap/runtime.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code><br><code>results/evidence/task2/paired_bootstrap/decision.json</code><br><code>results/evidence/task2/paired_bootstrap/group_audit.csv</code><br><code>results/evidence/task2/paired_bootstrap/interval_summary.csv</code><br><code>results/evidence/task2/paired_bootstrap/manifest.json</code><br><code>results/evidence/task2/paired_bootstrap/observed_metrics.csv</code><br><code>results/evidence/task2/paired_bootstrap/registry_snapshot.csv</code><br><code>results/evidence/task2/paired_bootstrap/runtime.json</code><br><code>results/figures/task2/paired_group_bootstrap.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record finalist uncertainty”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +375/-38; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat d81161d</code>, rồi <code>git show --name-status d81161d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 244 — <code>fc4bb92</code> — chore(task2): declare deterministic gradcam review
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>244</strong> — <code>fc4bb9200033b640ed59dd4abe5ae34ce2d6705c</code> — chore(task2): declare deterministic gradcam review — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare deterministic gradcam review” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (2):** <code>configs/task2/README.md</code><br><code>configs/task2/g6_gradcam_failure_review.json</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g6_gradcam_failure_review.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare deterministic gradcam review”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +103/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat fc4bb92</code>, rồi <code>git show --name-status fc4bb92</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 245 — <code>8484981</code> — feat(task2): add deterministic gradcam analysis
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>245</strong> — <code>8484981f9b06f5d00a03d187a551a940e41e0250</code> — feat(task2): add deterministic gradcam analysis — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add deterministic gradcam analysis” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>src/fashion/task2/gradcam.py</code><br><code>tests/task2/test_gradcam.py</code>
- **Code cần đọc:** <code>src/fashion/task2/gradcam.py</code>
- **Test cần đọc:** <code>tests/task2/test_gradcam.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add deterministic gradcam analysis” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +1196/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 8484981</code>, rồi <code>git show --name-status 8484981</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 246 — <code>a04eb01</code> — feat(task2): add gradcam evidence builder
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>246</strong> — <code>a04eb019acbbff8b9ecdae5ecace320df5756087</code> — feat(task2): add gradcam evidence builder — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add gradcam evidence builder” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (5):** <code>scripts/README.md</code><br><code>scripts/build_task2_gradcam_evidence.py</code><br><code>src/fashion/task2/gradcam_evidence.py</code><br><code>tests/task2/test_gradcam_evidence.py</code><br><code>tests/task2/test_gradcam_evidence_launcher.py</code>
- **Code cần đọc:** <code>scripts/README.md</code><br><code>scripts/build_task2_gradcam_evidence.py</code><br><code>src/fashion/task2/gradcam_evidence.py</code>
- **Test cần đọc:** <code>tests/task2/test_gradcam_evidence.py</code><br><code>tests/task2/test_gradcam_evidence_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add gradcam evidence builder” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +1653/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a04eb01</code>, rồi <code>git show --name-status a04eb01</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 247 — <code>37cd8f7</code> — docs(experiment): record failures and literature limits
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>247</strong> — <code>37cd8f7b6e4f54153958fa4191aebb7f6e9a9325</code> — docs(experiment): record failures and literature limits — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record failures and literature limits” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (13):** <code>docs/task2-season-execution-report.md</code><br><code>results/evidence/task2/gradcam_failure_review/attention_metrics.csv</code><br><code>results/evidence/task2/gradcam_failure_review/checkpoint_audit.csv</code><br><code>results/evidence/task2/gradcam_failure_review/decision.json</code><br><code>results/evidence/task2/gradcam_failure_review/failure_taxonomy.csv</code><br><code>results/evidence/task2/gradcam_failure_review/failure_taxonomy_summary.csv</code><br><code>results/evidence/task2/gradcam_failure_review/heatmap_index.csv</code><br><code>results/evidence/task2/gradcam_failure_review/manifest.json</code><br><code>results/evidence/task2/gradcam_failure_review/registry_snapshot.csv</code><br><code>results/evidence/task2/gradcam_failure_review/runtime.json</code><br><code>results/evidence/task2/gradcam_failure_review/selected_examples.csv</code><br><code>results/figures/task2/gradcam_c2_contact_sheet.png</code><br><code>results/figures/task2/gradcam_i2_contact_sheet.png</code>
- **Code cần đọc:** <code>results/evidence/task2/gradcam_failure_review/decision.json</code><br><code>results/evidence/task2/gradcam_failure_review/manifest.json</code><br><code>results/evidence/task2/gradcam_failure_review/runtime.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code><br><code>results/evidence/task2/gradcam_failure_review/attention_metrics.csv</code><br><code>results/evidence/task2/gradcam_failure_review/checkpoint_audit.csv</code><br><code>results/evidence/task2/gradcam_failure_review/decision.json</code><br><code>results/evidence/task2/gradcam_failure_review/failure_taxonomy.csv</code><br><code>results/evidence/task2/gradcam_failure_review/failure_taxonomy_summary.csv</code><br><code>results/evidence/task2/gradcam_failure_review/heatmap_index.csv</code><br><code>results/evidence/task2/gradcam_failure_review/manifest.json</code><br><code>results/evidence/task2/gradcam_failure_review/registry_snapshot.csv</code><br><code>results/evidence/task2/gradcam_failure_review/runtime.json</code><br><code>results/evidence/task2/gradcam_failure_review/selected_examples.csv</code><br><code>results/figures/task2/gradcam_c2_contact_sheet.png</code><br><code>results/figures/task2/gradcam_i2_contact_sheet.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record failures and literature limits”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +752/-23; 2 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 37cd8f7</code>, rồi <code>git show --name-status 37cd8f7</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 248 — <code>c63f451</code> — test(notebook): define measured results evidence contract
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>248</strong> — <code>c63f451af163751469b51b201df191b9021bbbce</code> — test(notebook): define measured results evidence contract — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “define measured results evidence contract” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “define measured results evidence contract”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +55/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat c63f451</code>, rồi <code>git show --name-status c63f451</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 249 — <code>f7eb13f</code> — docs(notebook): integrate measured cross-validation results
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>249</strong> — <code>f7eb13fa8f83b22e04a39a58a62b31d61dd87a97</code> — docs(notebook): integrate measured cross-validation results — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “integrate measured cross-validation results” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “integrate measured cross-validation results”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +150/-39; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f7eb13f</code>, rồi <code>git show --name-status f7eb13f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 250 — <code>5468787</code> — test(notebook): reproduce missing article type slice
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>250</strong> — <code>5468787c3b70521da2c406d734a29b1ac8f7c065</code> — test(notebook): reproduce missing article type slice — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce missing article type slice” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce missing article type slice”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +66/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 5468787</code>, rồi <code>git show --name-status 5468787</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 251 — <code>0cab57c</code> — test(notebook): reproduce empty image mode slice
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>251</strong> — <code>0cab57cff79290dcfb118278e5fcd6afb840dc52</code> — test(notebook): reproduce empty image mode slice — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce empty image mode slice” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce empty image mode slice”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +1/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0cab57c</code>, rồi <code>git show --name-status 0cab57c</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 252 — <code>7ed8760</code> — docs(notebook): integrate measured shortcut analysis
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>252</strong> — <code>7ed876064ebd42bf52051a50b2b8b68688451f13</code> — docs(notebook): integrate measured shortcut analysis — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “integrate measured shortcut analysis” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “integrate measured shortcut analysis”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +243/-54; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7ed8760</code>, rồi <code>git show --name-status 7ed8760</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 253 — <code>35a4088</code> — docs(notebook): integrate robustness and cost evidence
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>253</strong> — <code>35a4088d3cc7afbc291fcd168df0552f1ffde1ae</code> — docs(notebook): integrate robustness and cost evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “integrate robustness and cost evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “integrate robustness and cost evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +190/-29; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 35a4088</code>, rồi <code>git show --name-status 35a4088</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 254 — <code>b72a247</code> — test(notebook): reproduce gradcam taxonomy schema mismatch
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>254</strong> — <code>b72a247533ce0399138917d6ed29f11ded201145</code> — test(notebook): reproduce gradcam taxonomy schema mismatch — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce gradcam taxonomy schema mismatch” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce gradcam taxonomy schema mismatch”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +49/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat b72a247</code>, rồi <code>git show --name-status b72a247</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 255 — <code>cdc716d</code> — docs(notebook): integrate gradcam failure review
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>255</strong> — <code>cdc716d5661d735ce7fb97ead80814dd217d1031</code> — docs(notebook): integrate gradcam failure review — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “integrate gradcam failure review” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “integrate gradcam failure review”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +114/-29; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat cdc716d</code>, rồi <code>git show --name-status cdc716d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 256 — <code>c7b748d</code> — docs(notebook): integrate uncertainty and literature evidence
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>256</strong> — <code>c7b748d53d13c2646211bb482efddeab11322d43</code> — docs(notebook): integrate uncertainty and literature evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “integrate uncertainty and literature evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “integrate uncertainty and literature evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +184/-20; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat c7b748d</code>, rồi <code>git show --name-status c7b748d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 257 — <code>f441f22</code> — chore(task2): declare ultimate judgement contract
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>257</strong> — <code>f441f2262f6dd68cc60f9a06076c693cf3a8e011</code> — chore(task2): declare ultimate judgement contract — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “declare ultimate judgement contract” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (2):** <code>configs/task2/README.md</code><br><code>configs/task2/g7_ultimate_judgement.json</code>
- **Code cần đọc:** <code>configs/task2/README.md</code><br><code>configs/task2/g7_ultimate_judgement.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “declare ultimate judgement contract”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +65/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f441f22</code>, rồi <code>git show --name-status f441f22</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 258 — <code>f5d77fb</code> — feat(task2): add immutable selection freeze
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>258</strong> — <code>f5d77fb9ec9ba6474c4473167f66e921cc353500</code> — feat(task2): add immutable selection freeze — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add immutable selection freeze” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (5):** <code>scripts/build_task2_ultimate_judgement.py</code><br><code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/ultimate_judgement.py</code><br><code>tests/task2/test_ultimate_judgement.py</code><br><code>tests/task2/test_ultimate_judgement_launcher.py</code>
- **Code cần đọc:** <code>scripts/build_task2_ultimate_judgement.py</code><br><code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/ultimate_judgement.py</code>
- **Test cần đọc:** <code>tests/task2/test_ultimate_judgement.py</code><br><code>tests/task2/test_ultimate_judgement_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add immutable selection freeze” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +2603/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f5d77fb</code>, rồi <code>git show --name-status f5d77fb</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 259 — <code>0f0a5b6</code> — docs(task2): freeze ultimate season judgement
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>259</strong> — <code>0f0a5b691c3e6c3aa542c92b355db3a230910d24</code> — docs(task2): freeze ultimate season judgement — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “freeze ultimate season judgement” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (6):** <code>results/evidence/task2/selection_freeze.json</code><br><code>results/evidence/task2/ultimate_judgement/decision.json</code><br><code>results/evidence/task2/ultimate_judgement/manifest.json</code><br><code>results/evidence/task2/ultimate_judgement/rejected_alternatives.csv</code><br><code>results/evidence/task2/ultimate_judgement/runtime.json</code><br><code>results/evidence/task2/ultimate_judgement/scorecard.csv</code>
- **Code cần đọc:** <code>results/evidence/task2/selection_freeze.json</code><br><code>results/evidence/task2/ultimate_judgement/decision.json</code><br><code>results/evidence/task2/ultimate_judgement/manifest.json</code><br><code>results/evidence/task2/ultimate_judgement/runtime.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/selection_freeze.json</code><br><code>results/evidence/task2/ultimate_judgement/decision.json</code><br><code>results/evidence/task2/ultimate_judgement/manifest.json</code><br><code>results/evidence/task2/ultimate_judgement/rejected_alternatives.csv</code><br><code>results/evidence/task2/ultimate_judgement/runtime.json</code><br><code>results/evidence/task2/ultimate_judgement/scorecard.csv</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “freeze ultimate season judgement”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +377/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0f0a5b6</code>, rồi <code>git show --name-status 0f0a5b6</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 260 — <code>d5b50af</code> — test(task2): reproduce interactive slice plotting failure
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>260</strong> — <code>d5b50afc84ea78d7a833d02da05613c71baacb1c</code> — test(task2): reproduce interactive slice plotting failure — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce interactive slice plotting failure” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_slices.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_slices.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce interactive slice plotting failure”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +22/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat d5b50af</code>, rồi <code>git show --name-status d5b50af</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 261 — <code>58afe78</code> — fix(task2): render slice figures headlessly
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>261</strong> — <code>58afe78f125a01e12858196da8a1f4b0aad73eff</code> — fix(task2): render slice figures headlessly — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “render slice figures headlessly”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/task2/slices.py</code><br><code>tests/task2/test_slices.py</code>
- **Code cần đọc:** <code>src/fashion/task2/slices.py</code>
- **Test cần đọc:** <code>tests/task2/test_slices.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “render slice figures headlessly”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +9/-7; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 58afe78</code>, rồi <code>git show --name-status 58afe78</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 262 — <code>2a80daf</code> — test(notebook): define ultimate judgement evidence contract
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>262</strong> — <code>2a80dafd3bb7bc9003012c6f593f04ef8682db31</code> — test(notebook): define ultimate judgement evidence contract — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “define ultimate judgement evidence contract” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “define ultimate judgement evidence contract”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +65/-26; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2a80daf</code>, rồi <code>git show --name-status 2a80daf</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 263 — <code>52b342e</code> — docs(notebook): integrate ultimate judgement freeze
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>263</strong> — <code>52b342eda2ad4cb796f86932effcb9afd6e62570</code> — docs(notebook): integrate ultimate judgement freeze — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “integrate ultimate judgement freeze” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “integrate ultimate judgement freeze”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +109/-21; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 52b342e</code>, rồi <code>git show --name-status 52b342e</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 264 — <code>6b2787d</code> — test(notebook): reproduce analysis boundary audit gaps
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>264</strong> — <code>6b2787dee6732b883c3a932dd73b32ef30f2a46c</code> — test(notebook): reproduce analysis boundary audit gaps — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce analysis boundary audit gaps” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce analysis boundary audit gaps”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +25/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6b2787d</code>, rồi <code>git show --name-status 6b2787d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 265 — <code>e9829a5</code> — fix(notebook): enforce analysis evidence boundaries
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>265</strong> — <code>e9829a5a9fee1660c048fd62a4e8753d74f60179</code> — fix(notebook): enforce analysis evidence boundaries — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “enforce analysis evidence boundaries”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “enforce analysis evidence boundaries”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +38/-9; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e9829a5</code>, rồi <code>git show --name-status e9829a5</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 266 — <code>1464f0d</code> — docs(task2): record frozen ultimate judgement
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>266</strong> — <code>1464f0d9c5bf144ea245bed2d4584cd37876865c</code> — docs(task2): record frozen ultimate judgement — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record frozen ultimate judgement” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record frozen ultimate judgement”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +41/-33; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1464f0d</code>, rồi <code>git show --name-status 1464f0d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 267 — <code>073082c</code> — feat(data): add development-only multitask refit loader
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>267</strong> — <code>073082cafeea07b93c9a8b72afd3df3950d800ea</code> — feat(data): add development-only multitask refit loader — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add development-only multitask refit loader” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (4):** <code>src/fashion/data/multitask.py</code><br><code>src/fashion/data/torch.py</code><br><code>tests/data/test_multitask_loaders.py</code><br><code>tests/data/test_torch_transforms.py</code>
- **Code cần đọc:** <code>src/fashion/data/multitask.py</code><br><code>src/fashion/data/torch.py</code>
- **Test cần đọc:** <code>tests/data/test_multitask_loaders.py</code><br><code>tests/data/test_torch_transforms.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add development-only multitask refit loader” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +279/-18; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 073082c</code>, rồi <code>git show --name-status 073082c</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 268 — <code>bd5ed09</code> — feat(train): add fixed-epoch multitask refit engine
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>268</strong> — <code>bd5ed0971e9baf0864a9615af5f26c907f032fca</code> — feat(train): add fixed-epoch multitask refit engine — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add fixed-epoch multitask refit engine” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/multitask.py</code><br><code>tests/train/test_multitask.py</code>
- **Code cần đọc:** <code>src/fashion/train/__init__.py</code><br><code>src/fashion/train/multitask.py</code>
- **Test cần đọc:** <code>tests/train/test_multitask.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add fixed-epoch multitask refit engine” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +297/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat bd5ed09</code>, rồi <code>git show --name-status bd5ed09</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 269 — <code>3b39f07</code> — feat(task2): add development refit bundle
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>269</strong> — <code>3b39f07acc2185526c19be85d9e074e919c0243e</code> — feat(task2): add development refit bundle — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add development refit bundle” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (5):** <code>scripts/refit_task2_season.py</code><br><code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/refit.py</code><br><code>tests/task2/test_refit.py</code><br><code>tests/task2/test_refit_launcher.py</code>
- **Code cần đọc:** <code>scripts/refit_task2_season.py</code><br><code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/refit.py</code>
- **Test cần đọc:** <code>tests/task2/test_refit.py</code><br><code>tests/task2/test_refit_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add development refit bundle” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +1314/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 3b39f07</code>, rồi <code>git show --name-status 3b39f07</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 270 — <code>51ff7e5</code> — docs(experiment): record final bundle provenance
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>270</strong> — <code>51ff7e55c4f9fc20fd6c53420308b01689fd8427</code> — docs(experiment): record final bundle provenance — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record final bundle provenance” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (3):** <code>models/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/runtime.json</code><br><code>results/evidence/task2/development_refit/training_history.csv</code>
- **Code cần đọc:** <code>models/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/runtime.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>models/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/runtime.json</code><br><code>results/evidence/task2/development_refit/training_history.csv</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record final bundle provenance”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +332/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 51ff7e5</code>, rồi <code>git show --name-status 51ff7e5</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 271 — <code>0909340</code> — docs(notebook): record development refit evidence
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>271</strong> — <code>0909340761bdd7a93b05530f4e7d93814a3b199a</code> — docs(notebook): record development refit evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record development refit evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (3):** <code>notebooks/03_task2_season.ipynb</code><br><code>results/figures/task2/development_refit_training_curve.png</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>results/figures/task2/development_refit_training_curve.png</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record development refit evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +134/-10; 1 binary file(s); đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0909340</code>, rồi <code>git show --name-status 0909340</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 272 — <code>2bd661f</code> — test(task2): reproduce refit registry integrity gaps
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>272</strong> — <code>2bd661fbc5df24f5301b3ffda41d538b1caead59</code> — test(task2): reproduce refit registry integrity gaps — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce refit registry integrity gaps” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_refit.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_refit.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce refit registry integrity gaps”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +66/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2bd661f</code>, rồi <code>git show --name-status 2bd661f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 273 — <code>c32f84a</code> — fix(task2): bind refit completion to verified registry
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>273</strong> — <code>c32f84a4b6a21456ffa800a09f4725d91865d275</code> — fix(task2): bind refit completion to verified registry — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “bind refit completion to verified registry”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/task2/refit.py</code><br><code>tests/task2/test_refit.py</code>
- **Code cần đọc:** <code>src/fashion/task2/refit.py</code>
- **Test cần đọc:** <code>tests/task2/test_refit.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “bind refit completion to verified registry”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +146/-47; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat c32f84a</code>, rồi <code>git show --name-status c32f84a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 274 — <code>0ce9c2f</code> — test(task2): reproduce parallel refit overwrite risk
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>274</strong> — <code>0ce9c2fa14771d4d9c7cf9278da7fdd948b349be</code> — test(task2): reproduce parallel refit overwrite risk — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce parallel refit overwrite risk” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_refit.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_refit.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce parallel refit overwrite risk”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +22/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0ce9c2f</code>, rồi <code>git show --name-status 0ce9c2f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 275 — <code>9228608</code> — fix(task2): serialize development refit lifecycle
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>275</strong> — <code>922860837d4afc6c292427726f76c5eed9696bc5</code> — fix(task2): serialize development refit lifecycle — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “serialize development refit lifecycle”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/refit.py</code>
- **Code cần đọc:** <code>src/fashion/task2/refit.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “serialize development refit lifecycle”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +97/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 9228608</code>, rồi <code>git show --name-status 9228608</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 276 — <code>fd2cfa2</code> — test(task2): reproduce partial refit publish residue
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>276</strong> — <code>fd2cfa2b9279baaec332adc89d1f35ec0220099a</code> — test(task2): reproduce partial refit publish residue — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce partial refit publish residue” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_refit.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_refit.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce partial refit publish residue”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +4/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat fd2cfa2</code>, rồi <code>git show --name-status fd2cfa2</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 277 — <code>0d0c6eb</code> — fix(task2): publish refit artifacts transactionally
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>277</strong> — <code>0d0c6ebcf4ed5779d1deb6e062d5784f8ceadbd5</code> — fix(task2): publish refit artifacts transactionally — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “publish refit artifacts transactionally”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/refit.py</code>
- **Code cần đọc:** <code>src/fashion/task2/refit.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “publish refit artifacts transactionally”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +81/-10; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0d0c6eb</code>, rồi <code>git show --name-status 0d0c6eb</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 278 — <code>e0d8409</code> — test(task2): expose incomplete refit implementation hash
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>278</strong> — <code>e0d84090b274593931512ce512fc968c475257b3</code> — test(task2): expose incomplete refit implementation hash — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “expose incomplete refit implementation hash” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_refit.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_refit.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “expose incomplete refit implementation hash”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +5/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e0d8409</code>, rồi <code>git show --name-status e0d8409</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 279 — <code>24e8f8f</code> — fix(task2): cover full refit implementation graph
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>279</strong> — <code>24e8f8f5499005a67e4ab8ab78e139315c3e95d8</code> — fix(task2): cover full refit implementation graph — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “cover full refit implementation graph”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/refit.py</code>
- **Code cần đọc:** <code>src/fashion/task2/refit.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “cover full refit implementation graph”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +13/-18; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 24e8f8f</code>, rồi <code>git show --name-status 24e8f8f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 280 — <code>1f2ad98</code> — test(task2): reproduce non-finite refit acceptance
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>280</strong> — <code>1f2ad98fa9c4188f4d956f4b6aae3334aedb18b5</code> — test(task2): reproduce non-finite refit acceptance — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce non-finite refit acceptance” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (2):** <code>tests/task2/test_refit.py</code><br><code>tests/train/test_multitask.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_refit.py</code><br><code>tests/train/test_multitask.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce non-finite refit acceptance”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +88/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1f2ad98</code>, rồi <code>git show --name-status 1f2ad98</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 281 — <code>88959cd</code> — fix(task2): reject non-finite refit state
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>281</strong> — <code>88959cdbe9cfb362cd33382c60f9962dbb5007af</code> — fix(task2): reject non-finite refit state — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “reject non-finite refit state”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/task2/refit.py</code><br><code>src/fashion/train/multitask.py</code>
- **Code cần đọc:** <code>src/fashion/task2/refit.py</code><br><code>src/fashion/train/multitask.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “reject non-finite refit state”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +44/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 88959cd</code>, rồi <code>git show --name-status 88959cd</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 282 — <code>815ed60</code> — test(task2): reproduce loose refit boolean boundary
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>282</strong> — <code>815ed604d02c93288320326fbaad1bf4b3aab7b5</code> — test(task2): reproduce loose refit boolean boundary — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce loose refit boolean boundary” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_refit.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_refit.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce loose refit boolean boundary”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +30/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 815ed60</code>, rồi <code>git show --name-status 815ed60</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 283 — <code>6629d78</code> — fix(task2): enforce strict refit booleans
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>283</strong> — <code>6629d7841696273c8aaf416a5b2a185b6c5d9205</code> — fix(task2): enforce strict refit booleans — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “enforce strict refit booleans”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/refit.py</code>
- **Code cần đọc:** <code>src/fashion/task2/refit.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “enforce strict refit booleans”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +9/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6629d78</code>, rồi <code>git show --name-status 6629d78</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 284 — <code>09bdc83</code> — docs(task2): record invalidated first refit package
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>284</strong> — <code>09bdc835add7511cf5d0906b26fb283b4a72b4a3</code> — docs(task2): record invalidated first refit package — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record invalidated first refit package” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record invalidated first refit package”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +73/-19; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 09bdc83</code>, rồi <code>git show --name-status 09bdc83</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trước execution cần khóa intent, config hoặc gate bằng dữ liệu machine-readable: 285 — <code>f9d7b92</code> — chore(task2): archive invalidated refit package
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>285</strong> — <code>f9d7b928244d4d750481d78021784e4209478b0e</code> — chore(task2): archive invalidated refit package — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: gate/config “archive invalidated refit package” chưa được khai báo machine-readable. Hypothesis: declaration trước execution ngăn post-hoc rule.
- **Files changed (4):** <code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-3d60bd14cc91/invalidation.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-3d60bd14cc91/runtime.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-3d60bd14cc91/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-3d60bd14cc91/training_history.csv</code>
- **Code cần đọc:** <code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-3d60bd14cc91/invalidation.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-3d60bd14cc91/runtime.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-3d60bd14cc91/task2_season.manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-3d60bd14cc91/invalidation.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-3d60bd14cc91/runtime.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-3d60bd14cc91/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-3d60bd14cc91/training_history.csv</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: khai báo “archive invalidated refit package”. Result là frozen intent/config; measured result chỉ xuất hiện ở commit evidence sau.
- **Git diff footprint:** +35/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f9d7b92</code>, rồi <code>git show --name-status f9d7b92</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Declaration chưa phải execution; không được báo measured result từ config.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 286 — <code>7c4346b</code> — test(train): reproduce transient windows artifact lock
- **Senior lesson:** Freeze intent và threshold trước khi nhìn result.

</details>

<details>
<summary><strong>286</strong> — <code>7c4346b0259edf805d580dcd68ac0185f19313bf</code> — test(train): reproduce transient windows artifact lock — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce transient windows artifact lock” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/train/test_artifacts.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/train/test_artifacts.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce transient windows artifact lock”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +28/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 7c4346b</code>, rồi <code>git show --name-status 7c4346b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 287 — <code>a37a6cf</code> — fix(train): retry transient windows registry writes
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>287</strong> — <code>a37a6cf968da391cb1a6b00a4bf6d7c05af3633e</code> — fix(train): retry transient windows registry writes — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “retry transient windows registry writes”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (3):** <code>src/fashion/train/registry.py</code><br><code>tests/train/test_artifacts.py</code><br><code>tests/train/test_registry.py</code>
- **Code cần đọc:** <code>src/fashion/train/registry.py</code>
- **Test cần đọc:** <code>tests/train/test_artifacts.py</code><br><code>tests/train/test_registry.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “retry transient windows registry writes”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +43/-30; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a37a6cf</code>, rồi <code>git show --name-status a37a6cf</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 288 — <code>4208592</code> — test(task2): reproduce canonical refit file-order mismatch
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>288</strong> — <code>4208592a36b8a20b178fd1c332ce012f6cc141c0</code> — test(task2): reproduce canonical refit file-order mismatch — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce canonical refit file-order mismatch” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_refit.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_refit.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce canonical refit file-order mismatch”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +1/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 4208592</code>, rồi <code>git show --name-status 4208592</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 289 — <code>319eeba</code> — fix(task2): canonicalize refit implementation order
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>289</strong> — <code>319eeba7f986ae70c7d926fae2cc30f3d5c2b1ad</code> — fix(task2): canonicalize refit implementation order — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “canonicalize refit implementation order”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/refit.py</code>
- **Code cần đọc:** <code>src/fashion/task2/refit.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “canonicalize refit implementation order”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +3/-3; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 319eeba</code>, rồi <code>git show --name-status 319eeba</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 290 — <code>0ceb980</code> — docs(experiment): record replacement refit provenance
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>290</strong> — <code>0ceb9806ba4a2e484641ae1141d7c152de5d378a</code> — docs(experiment): record replacement refit provenance — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record replacement refit provenance” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (3):** <code>models/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/runtime.json</code><br><code>results/evidence/task2/development_refit/training_history.csv</code>
- **Code cần đọc:** <code>models/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/runtime.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>models/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/runtime.json</code><br><code>results/evidence/task2/development_refit/training_history.csv</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record replacement refit provenance”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +336/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0ceb980</code>, rồi <code>git show --name-status 0ceb980</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 291 — <code>a204e17</code> — docs(notebook): trace replacement development refit
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>291</strong> — <code>a204e17b5deba0d8d8d20741a2ff22f7b6d6bbc3</code> — docs(notebook): trace replacement development refit — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “trace replacement development refit” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “trace replacement development refit”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +2/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a204e17</code>, rồi <code>git show --name-status a204e17</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 292 — <code>ee3c66a</code> — docs(task2): record verified replacement refit
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>292</strong> — <code>ee3c66a67323efbbee9830391954394b007f5010</code> — docs(task2): record verified replacement refit — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record verified replacement refit” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record verified replacement refit”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +38/-37; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ee3c66a</code>, rồi <code>git show --name-status ee3c66a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 293 — <code>dc79725</code> — feat(task2): add verified season inference
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>293</strong> — <code>dc79725b37b3d554ce198b4ec69973a681e819ef</code> — feat(task2): add verified season inference — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add verified season inference” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/inference.py</code><br><code>tests/task2/test_inference.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/inference.py</code>
- **Test cần đọc:** <code>tests/task2/test_inference.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add verified season inference” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +458/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat dc79725</code>, rồi <code>git show --name-status dc79725</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 294 — <code>b7b1720</code> — feat(task2): add season prediction cli
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>294</strong> — <code>b7b17207fc81f46af065f14f591bed8d60d54b8e</code> — feat(task2): add season prediction cli — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add season prediction cli” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>scripts/predict_task2_season.py</code><br><code>tests/task2/test_inference_launcher.py</code>
- **Code cần đọc:** <code>scripts/predict_task2_season.py</code>
- **Test cần đọc:** <code>tests/task2/test_inference_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add season prediction cli” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +183/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat b7b1720</code>, rồi <code>git show --name-status b7b1720</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 295 — <code>db59a06</code> — test(task2): reproduce unsafe oversized image failure
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>295</strong> — <code>db59a067672ae85cc3f6e54d836250e0beefdc54</code> — test(task2): reproduce unsafe oversized image failure — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce unsafe oversized image failure” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_inference.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_inference.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce unsafe oversized image failure”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +15/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat db59a06</code>, rồi <code>git show --name-status db59a06</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 296 — <code>e76f222</code> — fix(task2): reject unsafe oversized images
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>296</strong> — <code>e76f22211da0f19881f44cc794b856f724a83497</code> — fix(task2): reject unsafe oversized images — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “reject unsafe oversized images”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/inference.py</code>
- **Code cần đọc:** <code>src/fashion/task2/inference.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “reject unsafe oversized images”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +7/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat e76f222</code>, rồi <code>git show --name-status e76f222</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 297 — <code>c2dbcd4</code> — docs(task2): record verified inference handoff
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>297</strong> — <code>c2dbcd40f88c9c0d274b7f8cae8c3a2223318ea7</code> — docs(task2): record verified inference handoff — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record verified inference handoff” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record verified inference handoff”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +23/-5; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat c2dbcd4</code>, rồi <code>git show --name-status c2dbcd4</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 298 — <code>a51a924</code> — feat(task2): add locked component handoff
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>298</strong> — <code>a51a924f2f8fdc1a52067735a3f255796ce75c5a</code> — feat(task2): add locked component handoff — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add locked component handoff” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (3):** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/handoff.py</code><br><code>tests/task2/test_handoff.py</code>
- **Code cần đọc:** <code>src/fashion/task2/__init__.py</code><br><code>src/fashion/task2/handoff.py</code>
- **Test cần đọc:** <code>tests/task2/test_handoff.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add locked component handoff” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +713/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a51a924</code>, rồi <code>git show --name-status a51a924</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Limitation hiện tại cần một capability hoặc public interface mới trước khi pipeline đi tiếp: 299 — <code>ec7ab02</code> — feat(task2): add locked handoff launcher
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>299</strong> — <code>ec7ab0273d2de62250c24d7b88845a464857e1a4</code> — feat(task2): add locked handoff launcher — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: capability “add locked handoff launcher” chưa tồn tại trong dải. Hypothesis: interface mới này là bước nhỏ cần thiết cho producer/consumer kế tiếp.
- **Files changed (2):** <code>scripts/build_task2_handoff.py</code><br><code>tests/task2/test_handoff_launcher.py</code>
- **Code cần đọc:** <code>scripts/build_task2_handoff.py</code>
- **Test cần đọc:** <code>tests/task2/test_handoff_launcher.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm “add locked handoff launcher” cùng interfaces trong file list. Result là capability/code path mới, không tự động là measured gain.
- **Git diff footprint:** +206/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ec7ab02</code>, rồi <code>git show --name-status ec7ab02</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 300 — <code>9260069</code> — docs(experiment): record locked task2 handoff
- **Senior lesson:** Thiết kế public interface, validation, error path và consumer cùng nhau.

</details>

<details>
<summary><strong>300</strong> — <code>9260069fb6b6b6578afb6ba9a1544d8189640fd5</code> — docs(experiment): record locked task2 handoff — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record locked task2 handoff” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (3):** <code>results/evidence/task2/final_handoff/artifact_audit.csv</code><br><code>results/evidence/task2/final_handoff/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/manifest.json</code>
- **Code cần đọc:** <code>results/evidence/task2/final_handoff/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/final_handoff/artifact_audit.csv</code><br><code>results/evidence/task2/final_handoff/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/manifest.json</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record locked task2 handoff”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +95/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 9260069</code>, rồi <code>git show --name-status 9260069</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 301 — <code>91a9555</code> — docs(notebook): complete locked task2 handoff
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>301</strong> — <code>91a955534d56ea64484ff1bdc4336dabfd36e5c6</code> — docs(notebook): complete locked task2 handoff — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “complete locked task2 handoff” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “complete locked task2 handoff”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +126/-60; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 91a9555</code>, rồi <code>git show --name-status 91a9555</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 302 — <code>4372442</code> — test(task2): reproduce locked handoff regressions
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>302</strong> — <code>43724429c25b3379dc4915bc1d12e73ab06c8eac</code> — test(task2): reproduce locked handoff regressions — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce locked handoff regressions” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_handoff.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_handoff.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce locked handoff regressions”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +341/-2; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 4372442</code>, rồi <code>git show --name-status 4372442</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 303 — <code>9624d76</code> — fix(task2): harden locked handoff integrity
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>303</strong> — <code>9624d76ac5070051717b0dd71c9e784dbc778d02</code> — fix(task2): harden locked handoff integrity — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “harden locked handoff integrity”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/handoff.py</code>
- **Code cần đọc:** <code>src/fashion/task2/handoff.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “harden locked handoff integrity”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +577/-110; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 9624d76</code>, rồi <code>git show --name-status 9624d76</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 304 — <code>5a785bd</code> — docs(experiment): harden locked handoff evidence
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>304</strong> — <code>5a785bdb4d987aa3131a895f3f77fad0b7c569b6</code> — docs(experiment): harden locked handoff evidence — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “harden locked handoff evidence” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (4):** <code>results/evidence/task2/final_handoff/artifact_audit.csv</code><br><code>results/evidence/task2/final_handoff/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/manifest.json</code><br><code>results/evidence/task2/final_handoff/registry_snapshot.csv</code>
- **Code cần đọc:** <code>results/evidence/task2/final_handoff/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/final_handoff/artifact_audit.csv</code><br><code>results/evidence/task2/final_handoff/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/manifest.json</code><br><code>results/evidence/task2/final_handoff/registry_snapshot.csv</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “harden locked handoff evidence”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +16/-5; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 5a785bd</code>, rồi <code>git show --name-status 5a785bd</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 305 — <code>77d6b9b</code> — docs(task2): close sealed component checklist
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>305</strong> — <code>77d6b9b099fdc59f2df22593126b3ade91ceb5f1</code> — docs(task2): close sealed component checklist — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “close sealed component checklist” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “close sealed component checklist”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +45/-18; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 77d6b9b</code>, rồi <code>git show --name-status 77d6b9b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 306 — <code>8002d35</code> — test(task2): reproduce handoff edge regressions
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>306</strong> — <code>8002d3511d43cd271553cf0d886de001a70d9aaa</code> — test(task2): reproduce handoff edge regressions — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce handoff edge regressions” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_handoff.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_handoff.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce handoff edge regressions”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +108/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 8002d35</code>, rồi <code>git show --name-status 8002d35</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 307 — <code>0190dc5</code> — docs(task2): record independent defect audit
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>307</strong> — <code>0190dc51b830401be1f923067a03c015999602da</code> — docs(task2): record independent defect audit — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record independent defect audit” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record independent defect audit”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +33/-4; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0190dc5</code>, rồi <code>git show --name-status 0190dc5</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 308 — <code>149c111</code> — fix(task2): bind handoff registry provenance
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>308</strong> — <code>149c111d8a31dc7de39e68d306ba96e2b6c9dce6</code> — fix(task2): bind handoff registry provenance — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “bind handoff registry provenance”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (2):** <code>src/fashion/task2/handoff.py</code><br><code>tests/task2/test_handoff.py</code>
- **Code cần đọc:** <code>src/fashion/task2/handoff.py</code>
- **Test cần đọc:** <code>tests/task2/test_handoff.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “bind handoff registry provenance”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +109/-14; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 149c111</code>, rồi <code>git show --name-status 149c111</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 309 — <code>9677306</code> — test(task2): reproduce portable provenance gaps
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>309</strong> — <code>96773069dd2c4be47c7411eecda0c3797b5bfcba</code> — test(task2): reproduce portable provenance gaps — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce portable provenance gaps” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (2):** <code>tests/task2/test_handoff.py</code><br><code>tests/task2/test_refit.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_handoff.py</code><br><code>tests/task2/test_refit.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce portable provenance gaps”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +89/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 9677306</code>, rồi <code>git show --name-status 9677306</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 310 — <code>f7d1c82</code> — fix(task2): unify refit provenance validation
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>310</strong> — <code>f7d1c8253ee50088f482988a994a266be4d34536</code> — fix(task2): unify refit provenance validation — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “unify refit provenance validation”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (3):** <code>src/fashion/task2/handoff.py</code><br><code>src/fashion/task2/refit.py</code><br><code>tests/task2/test_refit.py</code>
- **Code cần đọc:** <code>src/fashion/task2/handoff.py</code><br><code>src/fashion/task2/refit.py</code>
- **Test cần đọc:** <code>tests/task2/test_refit.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “unify refit provenance validation”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +151/-89; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f7d1c82</code>, rồi <code>git show --name-status f7d1c82</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 311 — <code>6c9a3ac</code> — test(task2): reproduce file-impact font warning
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>311</strong> — <code>6c9a3acddef5904ba005f54a0e7b9af6c0855aa6</code> — test(task2): reproduce file-impact font warning — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reproduce file-impact font warning” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/task2/test_file_impact.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/task2/test_file_impact.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reproduce file-impact font warning”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +1/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6c9a3ac</code>, rồi <code>git show --name-status 6c9a3ac</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** History vừa lộ failure hoặc contract gap; commit kế sửa boundary đó và phải làm test liên quan xanh: 312 — <code>8c78085</code> — fix(task2): use supported impact-flow font
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>312</strong> — <code>8c780852dcbeec3bac9b87e28a417919eba9b360</code> — fix(task2): use supported impact-flow font — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: test/review/evidence gần đó đã lộ defect “use supported impact-flow font”. Hypothesis: sửa đúng boundary này sẽ làm regression xanh mà không đổi câu hỏi khoa học.
- **Files changed (1):** <code>src/fashion/task2/evidence.py</code>
- **Code cần đọc:** <code>src/fashion/task2/evidence.py</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: sửa “use supported impact-flow font”. Verify bằng regression liên quan và diff; model/evidence chỉ đổi nếu changed artifacts cho thấy vậy.
- **Git diff footprint:** +1/-1; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 8c78085</code>, rồi <code>git show --name-status 8c78085</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Fix chỉ bao phủ root cause và tests/evidence đã kiểm; không mở rộng claim ngoài scope.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 313 — <code>de75787</code> — test(notebook): define single-output narrative contract
- **Senior lesson:** Sửa nhỏ theo root cause; không rewrite history hoặc xóa evidence cũ.

</details>

<details>
<summary><strong>313</strong> — <code>de75787e8222d509ba83bd859d1d1d8f006aa5d6</code> — test(notebook): define single-output narrative contract — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “define single-output narrative contract” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “define single-output narrative contract”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +101/-13; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat de75787</code>, rồi <code>git show --name-status de75787</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Behavior cần được giữ nguyên trong khi cấu trúc được làm rõ cho bước tiếp theo: 314 — <code>1440ac5</code> — refactor(notebook): split task2 evidence outputs
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>314</strong> — <code>1440ac539fd7fd7fe473146e931d2b2e777d5fd1</code> — refactor(notebook): split task2 evidence outputs — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: behavior chính đã có nhưng structure/presentation “split task2 evidence outputs” chưa thỏa contract. Hypothesis: đổi structure mà giữ semantics.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế đúng theo subject “split task2 evidence outputs”; phạm vi được xác định bởi exact diff bên dưới.
- **Git diff footprint:** +4316/-9213; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 1440ac5</code>, rồi <code>git show --name-status 1440ac5</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 315 — <code>6f76fa3</code> — docs(experiment): archive superseded refit package
- **Senior lesson:** Refactor/presentation cần contract để prove behavior không drift.

</details>

<details>
<summary><strong>315</strong> — <code>6f76fa318a9938304d3fc9aefb3812de07fc6c63</code> — docs(experiment): archive superseded refit package — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “archive superseded refit package” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (4):** <code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/invalidation.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/runtime.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/training_history.csv</code>
- **Code cần đọc:** <code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/invalidation.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/runtime.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/task2_season.manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/invalidation.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/runtime.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/training_history.csv</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “archive superseded refit package”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +31/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6f76fa3</code>, rồi <code>git show --name-status 6f76fa3</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 316 — <code>ef95348</code> — docs(experiment): archive superseded task2 handoff
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>316</strong> — <code>ef95348a52536a342131253cae8612a1d1e10977</code> — docs(experiment): archive superseded task2 handoff — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “archive superseded task2 handoff” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (5):** <code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/artifact_audit.csv</code><br><code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/invalidation.json</code><br><code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/manifest.json</code><br><code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/registry_snapshot.csv</code>
- **Code cần đọc:** <code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/invalidation.json</code><br><code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/artifact_audit.csv</code><br><code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/invalidation.json</code><br><code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/manifest.json</code><br><code>results/evidence/task2/final_handoff/invalidated/task2-season-i2-refit-fall-s2753-4ab5682a30e1/registry_snapshot.csv</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “archive superseded task2 handoff”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +27/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ef95348</code>, rồi <code>git show --name-status ef95348</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 317 — <code>a7b31e7</code> — docs(experiment): record provenance-hardened refit
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>317</strong> — <code>a7b31e7c421f40a52dc524533f716f100a5b5977</code> — docs(experiment): record provenance-hardened refit — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “record provenance-hardened refit” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (3):** <code>models/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/runtime.json</code><br><code>results/evidence/task2/development_refit/training_history.csv</code>
- **Code cần đọc:** <code>models/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/runtime.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>models/task2_season.manifest.json</code><br><code>results/evidence/task2/development_refit/runtime.json</code><br><code>results/evidence/task2/development_refit/training_history.csv</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “record provenance-hardened refit”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +336/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a7b31e7</code>, rồi <code>git show --name-status a7b31e7</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Run hoặc implementation cần được materialize thành evidence có provenance trước khi tạo claim: 318 — <code>4c6642f</code> — docs(experiment): publish refreshed task2 handoff
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>318</strong> — <code>4c6642f071f41b22f41d21bd5a0a1c5362d008c8</code> — docs(experiment): publish refreshed task2 handoff — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “publish refreshed task2 handoff” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (4):** <code>results/evidence/task2/final_handoff/artifact_audit.csv</code><br><code>results/evidence/task2/final_handoff/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/manifest.json</code><br><code>results/evidence/task2/final_handoff/registry_snapshot.csv</code>
- **Code cần đọc:** <code>results/evidence/task2/final_handoff/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/manifest.json</code>
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>results/evidence/task2/final_handoff/artifact_audit.csv</code><br><code>results/evidence/task2/final_handoff/inference_smoke.json</code><br><code>results/evidence/task2/final_handoff/manifest.json</code><br><code>results/evidence/task2/final_handoff/registry_snapshot.csv</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “publish refreshed task2 handoff”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +106/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 4c6642f</code>, rồi <code>git show --name-status 4c6642f</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 319 — <code>ce0f119</code> — docs(notebook): align hardened refit trace
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>319</strong> — <code>ce0f11942b293fa03f2d00e09d98f473cbd60ad8</code> — docs(notebook): align hardened refit trace — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “align hardened refit trace” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “align hardened refit trace”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +4/-4; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat ce0f119</code>, rồi <code>git show --name-status ce0f119</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Logic đã có nhưng lint/presentation contract vẫn chưa đóng: 320 — <code>604077d</code> — style(notebook): satisfy task2 lint contract
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>320</strong> — <code>604077db8b6ea738e7a60336584586eaec8e160f</code> — style(notebook): satisfy task2 lint contract — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: behavior chính đã có nhưng structure/presentation “satisfy task2 lint contract” chưa thỏa contract. Hypothesis: đổi structure mà giữ semantics.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế đúng theo subject “satisfy task2 lint contract”; phạm vi được xác định bởi exact diff bên dưới.
- **Git diff footprint:** +8/-10; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 604077d</code>, rồi <code>git show --name-status 604077d</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Commit-level diff không tự chứng minh metric; measured claim cần run ID, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 321 — <code>0a88a51</code> — docs(task2): close hardened notebook audit
- **Senior lesson:** Refactor/presentation cần contract để prove behavior không drift.

</details>

<details>
<summary><strong>321</strong> — <code>0a88a51f6a631c8471e1c77ab1142d7153ec8224</code> — docs(task2): close hardened notebook audit — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “close hardened notebook audit” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “close hardened notebook audit”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +32/-23; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0a88a51</code>, rồi <code>git show --name-status 0a88a51</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 322 — <code>35ec7a8</code> — test(notebook): reject generic task2 interpretations
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>322</strong> — <code>35ec7a8c68815afda27688fc2ff1cffa8b9dad5f</code> — test(notebook): reject generic task2 interpretations — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “reject generic task2 interpretations” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “reject generic task2 interpretations”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +4/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 35ec7a8</code>, rồi <code>git show --name-status 35ec7a8</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 323 — <code>6a09e22</code> — docs(notebook): analyse task2 foundation outputs
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>323</strong> — <code>6a09e22a59036c0f809a9e4633e58a97825b0709</code> — docs(notebook): analyse task2 foundation outputs — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “analyse task2 foundation outputs” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “analyse task2 foundation outputs”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +1699/-153; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 6a09e22</code>, rồi <code>git show --name-status 6a09e22</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 324 — <code>afaf592</code> — test(notebook): require deep output analysis
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>324</strong> — <code>afaf59272b6c832f230a89dfd08c040d972f960b</code> — test(notebook): require deep output analysis — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “require deep output analysis” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “require deep output analysis”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +9/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat afaf592</code>, rồi <code>git show --name-status afaf592</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 325 — <code>a8a2aa9</code> — docs(notebook): deeply analyse experiment outputs
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>325</strong> — <code>a8a2aa96c933b169983d4f58a98b3fd3479bff61</code> — docs(notebook): deeply analyse experiment outputs — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “deeply analyse experiment outputs” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “deeply analyse experiment outputs”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +345/-335; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat a8a2aa9</code>, rồi <code>git show --name-status a8a2aa9</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 326 — <code>0c5742b</code> — docs(notebook): deeply analyse finalist outputs
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>326</strong> — <code>0c5742b3d2cb4732614304fcda56f6690c6d3f75</code> — docs(notebook): deeply analyse finalist outputs — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “deeply analyse finalist outputs” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “deeply analyse finalist outputs”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +92/-76; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 0c5742b</code>, rồi <code>git show --name-status 0c5742b</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 327 — <code>2524bbd</code> — docs(notebook): deeply analyse shortcut slices
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>327</strong> — <code>2524bbdc3840edb40c2580483f13087eaa76318c</code> — docs(notebook): deeply analyse shortcut slices — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “deeply analyse shortcut slices” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “deeply analyse shortcut slices”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +70/-60; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 2524bbd</code>, rồi <code>git show --name-status 2524bbd</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 328 — <code>98bfa43</code> — docs(notebook): deeply analyse diagnostic outputs
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>328</strong> — <code>98bfa43867693a7dbc0931929fa5e5d1da522d00</code> — docs(notebook): deeply analyse diagnostic outputs — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “deeply analyse diagnostic outputs” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “deeply analyse diagnostic outputs”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +101/-93; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 98bfa43</code>, rồi <code>git show --name-status 98bfa43</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 329 — <code>fe7f62a</code> — docs(notebook): complete deep output analysis
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>329</strong> — <code>fe7f62a057ae02791f27e6b90f5c57484825bad3</code> — docs(notebook): complete deep output analysis — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “complete deep output analysis” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “complete deep output analysis”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +117/-53; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat fe7f62a</code>, rồi <code>git show --name-status fe7f62a</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Trạng thái hiện tại cần một regression/contract guard chạy được; commit kế mã hóa đúng failure hoặc invariant: 330 — <code>b9cd99e</code> — test(notebook): enforce unique deep analysis
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>330</strong> — <code>b9cd99ef83b9b3c15db06b1a61a654cfdebcac0c</code> — test(notebook): enforce unique deep analysis — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: defect/contract “enforce unique deep analysis” chưa có regression guard trong history. Hypothesis: một test nhỏ có thể tái hiện hoặc chặn đúng failure.
- **Files changed (1):** <code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code>
- **Artifact/consumer bị tác động:** Không có tracked measured artifact/notebook đổi trong commit này.
- **Thay đổi thực tế / result:** Thay đổi thực tế: thêm/siết test cho “enforce unique deep analysis”. Result hợp lệ là failure được tái hiện hoặc guard được định nghĩa; commit này một mình chưa phải fix.
- **Git diff footprint:** +19/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat b9cd99e</code>, rồi <code>git show --name-status b9cd99e</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Test chứng minh contract/failure case được mã hóa; không chứng minh generalization hoặc production prevalence.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 331 — <code>4c86b11</code> — docs(task2): document deep output analysis contract
- **Senior lesson:** Red trước Green: giữ reproducer làm guard lâu dài.

</details>

<details>
<summary><strong>331</strong> — <code>4c86b114217d2446de5833f6c19e7d8ed3d0b1a1</code> — docs(task2): document deep output analysis contract — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “document deep output analysis contract” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>docs/task2-season-execution-report.md</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “document deep output analysis contract”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +16/-7; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 4c86b11</code>, rồi <code>git show --name-status 4c86b11</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified producer/evidence cần được nối vào Notebook consumer mà không tạo numeric truth mới: 332 — <code>661a5d7</code> — docs(notebook): keep task2 tables fully visible
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>332</strong> — <code>661a5d753e0e9528f1ef7cd4ceef37022f9a1018</code> — docs(notebook): keep task2 tables fully visible — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “keep task2 tables fully visible” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (1):** <code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “keep task2 tables fully visible”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +7/-0; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 661a5d7</code>, rồi <code>git show --name-status 661a5d7</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Verified state cần được ghi lại với đúng scope để reviewer có thể trace: 333 — <code>45c1d40</code> — docs(task2): clarify numeric precision and units
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>333</strong> — <code>45c1d407b4963cafed3aba3b1650d21fb6e311f3</code> — docs(task2): clarify numeric precision and units — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: code/evidence liên quan đã có hoặc vừa đổi nhưng trace “clarify numeric precision and units” chưa được ghi rõ. Hypothesis: narrative phải phản ánh verified state, không tạo claim mới.
- **Files changed (2):** <code>docs/task2-season-execution-report.md</code><br><code>notebooks/03_task2_season.ipynb</code>
- **Code cần đọc:** Không đổi implementation/config trong commit này; đọc exact diff và producer liên quan.
- **Test cần đọc:** Không có test file đổi trong commit này; regression/contract có thể nằm ở commit kề theo Red–Green story.
- **Artifact/consumer bị tác động:** <code>docs/task2-season-execution-report.md</code><br><code>notebooks/03_task2_season.ipynb</code>
- **Thay đổi thực tế / result:** Thay đổi thực tế: ghi/đồng bộ “clarify numeric precision and units”. Result là trace hoặc consumer presentation; source/run/artifact vẫn quyết định numeric truth.
- **Git diff footprint:** +21/-8; đây là byte-level change size, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 45c1d40</code>, rồi <code>git show --name-status 45c1d40</code>; đọc tests/artifacts được liệt kê. Không dùng subject thay cho diff.
- **Limitation:** Documentation là snapshot/consumer và có thể stale; phải đối chiếu source, registry, artifact và manifest.
- **Vì sao commit kế cần tồn tại:** Notebook vẫn thiếu nhiều output đã lưu; commit kế biến nó thành replay artifact-only có guard, không train lại: 334 — <code>8d8484b</code> — fix(task2): make notebook replay artifact-only
- **Senior lesson:** Narrative phải đi sau verified bytes và nói rõ timestamp/scope.

</details>

<details>
<summary><strong>334</strong> — <code>8d8484babded58e17c08f876ee47b21bec14ee69</code> — fix(task2): make notebook replay artifact-only — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Trước commit: chỉ 21/147 code cells giữ output, nên nhiều table và figure không hiện khi mở Notebook; một clean-kernel replay attempt trung gian còn lộ cell phụ thuộc thứ tự chạy qua <code>NameError</code>. Hypothesis: có thể replay toàn bộ evidence đã khóa trong clean kernel mà không chạy training, không ghi registry/cache/evidence và không đổi phân tích đã freeze.
- **Files changed (4):** <code>docs/task2-season-execution-report.md</code><br><code>notebooks/03_task2_season.ipynb</code><br><code>notebooks/README.md</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** <code>notebooks/03_task2_season.ipynb</code> — replay setup, frozen fold stats, artifact locks và từng consumer cell; không có training launcher.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code> — guard cấm training/write, buộc đủ output tuần tự, khóa replay roots và giữ analysis contract.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code><br><code>notebooks/README.md</code><br><code>docs/task2-season-execution-report.md</code>. Không file nào dưới <code>results/evidence/task2/</code>, <code>results/figures/</code> hay <code>models/</code> đổi.
- **Thay đổi thực tế / result:** Clean-kernel Run All hoàn tất 147/147 code cells với execution count 1→147, mỗi cell có output và không có error. Table/figure được đọc từ artifact đã hash-lock; fold stats được truyền frozen trực tiếp. Registry output chỉ dùng frozen snapshot. Metric, parameter, selection và report analysis giữ nguyên.
- **Git diff footprint:** +12970/-2972; phần lớn là serialized Notebook outputs, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat 8d8484b</code> và <code>git show --name-status 8d8484b</code>; chạy focused Notebook tests (36 pass), full pytest (578 pass), Ruff và <code>pip check</code>. So hash trước/sau để xác nhận registry, evidence, figures, model bundle/manifest, split và fold-stats cache không đổi.
- **Limitation:** Replay chỉ trình bày evidence đã có. Nó không tạo run mới, không tăng độ chính xác, không mở holdout và không thay thế việc verify source artifact khi bytes đổi.
- **Vì sao commit kế cần tồn tại:** Replay đã đủ output nhưng người đọc chưa có bản đồ rõ để tìm code training, chọn đúng launcher/cache mode và phân biệt lệnh chỉ tải với lệnh có thể train: 335 — <code>f800ff5</code> — docs(task2): map notebook training workflow
- **Senior lesson:** Notebook tái lập tốt có thể hiện đủ kết quả từ artifact đã khóa; không cần train lại để sửa phần trình bày.

</details>

<details>
<summary><strong>335</strong> — <code>f800ff54393a6cf71af673cd6acc783cbff32825</code> — docs(task2): map notebook training workflow — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Notebook replay đã hiện đủ 147 outputs nhưng người đọc chưa có một bản đồ ngắn nối config, launcher, orchestration, training loop và artifact; nếu dùng nhầm launcher hoặc cache mode, một lần kiểm tra có thể thành physical training. Hypothesis: thêm hướng dẫn chỉ-đọc và regression guard có thể làm rõ cách replay/load/train mà không đổi frozen result.
- **Files changed (3):** <code>docs/task2-season-execution-report.md</code><br><code>notebooks/03_task2_season.ipynb</code><br><code>tests/test_notebook_scaffolds.py</code>
- **Code cần đọc:** title cell <code>task2-title</code> trong <code>notebooks/03_task2_season.ipynb</code>; các launcher dưới <code>scripts/</code>; orchestration dưới <code>src/fashion/task2/</code>; training loops dưới <code>src/fashion/train/</code>.
- **Test cần đọc:** <code>tests/test_notebook_scaffolds.py</code> — guard yêu cầu training-code map, đúng specialized routing, sáu lệnh <code>--mode load</code>, sáu lệnh <code>--mode run</code>, và cấm trainer/producer trong executable replay cells.
- **Artifact/consumer bị tác động:** <code>notebooks/03_task2_season.ipynb</code> và <code>docs/task2-season-execution-report.md</code>. Không file nào dưới <code>configs/</code>, <code>results/</code>, <code>models/</code>, <code>data/</code>, <code>scripts/</code> hay <code>src/</code> đổi.
- **Thay đổi thực tế / result:** Notebook thêm bản đồ config → launcher → orchestration → loop → artifact, giải thích Markdown không chạy Python, tách rõ <code>load</code>/<code>run_or_load</code>/<code>run</code>, và giới hạn general launcher vào B0/B1 cùng Season-only G1–G3. Execution report dùng mô tả audit trung tính và đồng bộ verification thành 579 repository tests, gồm 37 notebook-contract tests. Frozen outputs, metric, parameter, selection và model bytes giữ nguyên.
- **Git diff footprint:** +143/-7; đây là documentation và regression-contract change, không phải model-quality evidence.
- **Cách xác minh:** chạy read-only <code>git show --stat f800ff5</code> và <code>git show --name-status f800ff5</code>; focused Notebook suite 37 pass, full pytest 579 pass, Ruff và <code>pip check</code> đều pass. Mở title cell để kiểm tra link/routing và xác nhận 147 executable replay cells vẫn không gọi trainer.
- **Limitation:** Bản đồ chỉ mô tả producer boundary hiện tại. <code>load</code> cần exact cache đã có; <code>run_or_load</code> vẫn có thể train khi cache miss; physical training vẫn tốn thời gian và không phải cách review Notebook 03 thông thường.
- **Vì sao commit kế cần tồn tại:** Task 2 đã hoàn thiện ở feature lineage nhưng lịch sử nhánh chính cần ghi nhận merge node riêng, không lẫn nội dung các commit producer với conflict-resolution diff: 336 — <code>793a995</code> — Merge pull request #4 from TrnLin/feature/task2-season
- **Senior lesson:** Luôn tách ba hành động: replay báo cáo, load cache đã xác minh, và cố ý train. Tài liệu tốt phải chỉ đúng entry point và cảnh báo side effect ngay cạnh lệnh.

</details>

<details>
<summary><strong>336</strong> — <code>793a99549c8dc9118d2ea8013f9d09e12101dab1</code> — Merge pull request #4 from TrnLin/feature/task2-season — <em>Task 2 direct</em></summary>

- **Trạng thái trước / problem / hypothesis:** Task 2 đã có lịch sử producer, test, evidence và notebook riêng nhưng nhánh chính chưa có merge node ghi nhận toàn bộ lineage đó. Hypothesis: clean merge có thể đưa lineage vào nhánh chính mà không tạo conflict-resolution bytes hoặc thay đổi kết quả đã kiểm tra.
- **Files changed (0):** Không có file trong combined merge-resolution view.
- **Code cần đọc:** Không có source implementation mới tại merge node; đọc hai parent <code>17e028e</code> và <code>45c1d40</code>, rồi trace các commit Task 2 trước đó trong ledger.
- **Test cần đọc:** Không có test file mới hoặc conflict-resolution test diff tại merge node; test contracts thuộc các commit đã được audit trước đó.
- **Artifact/consumer bị tác động:** Không có artifact mới tại merge node. Tree <code>e3baf6826dea5c2985d51971065bb4756402e6ad</code> đúng bằng tree của parent chứa Task 2 <code>45c1d40</code>.
- **Thay đổi thực tế / result:** Merge commit nối lịch sử Task 2 vào nhánh chính. Combined view có zero changed files, không có manual conflict resolution, không train model và không thay đổi metric, parameter, selection hay artifact bytes.
- **Git diff footprint:** +0/-0; đây là combined merge-resolution footprint, không phải kích thước toàn bộ feature history đã merge.
- **Cách xác minh:** chạy <code>git rev-list --parents -n 1 793a995</code>, <code>git show --cc --format= --name-only 793a995</code> và so <code>793a995^{tree}</code> với <code>45c1d40^{tree}</code>; parent list, zero-file combined view và tree hash phải khớp.
- **Limitation:** Zero merge-resolution diff không có nghĩa feature branch không đổi file. Nội dung feature nằm trong các commit 001–333 và phải được đọc/test ở đúng card của chúng.
- **Vì sao commit kế cần tồn tại:** Feature lineage tiếp tục sau điểm PR, nên nhánh feature cần hợp nhất main lineage để một HEAD chứa cả hai parent mà vẫn giữ nguyên tree đã kiểm tra: 337 — <code>0d92496</code> — merge: main into feature/task2-season
- **Senior lesson:** Với merge commit, phân biệt rõ three-way graph integration, combined conflict-resolution diff và toàn bộ diff của branch; ba khái niệm không cùng một số liệu.

</details>

<details>
<summary><strong>337</strong> — <code>0d92496a831a5557d19089fb4284cf33dd100e99</code> — merge: main into feature/task2-season — <em>shared dependency</em></summary>

- **Trạng thái trước / problem / hypothesis:** Feature HEAD <code>f800ff5</code> chứa training guide mới, còn main lineage kết thúc tại PR merge <code>793a995</code>; graph chưa hội tụ về một feature HEAD chung. Hypothesis: clean merge từ main vào feature có thể đóng graph mà giữ nguyên toàn bộ tree của <code>f800ff5</code>.
- **Files changed (0):** Không có file trong combined merge-resolution view.
- **Code cần đọc:** Không có source implementation mới; đọc parent pair <code>f800ff5</code> và <code>793a995</code>, cùng merge graph của chúng.
- **Test cần đọc:** Không có test file đổi tại merge node. Verification hợp lệ là graph/tree/combined-diff audit; kết quả 37 focused và 579 full tests vẫn thuộc commit producer <code>f800ff5</code>, không được tính lại như một test run mới.
- **Artifact/consumer bị tác động:** Không có artifact hoặc consumer byte nào đổi. HEAD tree <code>e30cca883a63445e1c226d7cfe543bbf6a75febd</code> đúng bằng tree của <code>f800ff5</code>.
- **Thay đổi thực tế / result:** Merge commit hội tụ main và feature lineages; combined view có zero changed files và tree giữ nguyên. Không có model training, evidence rebuild, metric change, parameter change, selection change hoặc holdout access.
- **Git diff footprint:** +0/-0; đây là clean merge topology, không phải model-quality evidence.
- **Cách xác minh:** chạy <code>git rev-list --parents -n 1 0d92496</code>, <code>git show --cc --format= --name-only 0d92496</code> và so <code>0d92496^{tree}</code> với <code>f800ff5^{tree}</code>; phải có đúng hai parent, zero-file combined view và tree hash giống nhau.
- **Limitation:** Merge sạch chỉ chứng minh graph hội tụ và tree không đổi. Nó không tự rerun tests, không chứng minh generalization và không tạo evidence mới.
- **Vì sao commit kế cần tồn tại:** Kết thúc exact range tại expected HEAD; không suy diễn commit tương lai.
- **Senior lesson:** Một no-op merge vẫn quan trọng cho provenance, nhưng claim hợp lệ chỉ là topology/tree continuity; không được biến nó thành modelling result mới.

</details>

Next: [Mock viva và code review](11_MOCK_VIVA_AND_CODE_REVIEW.md)
