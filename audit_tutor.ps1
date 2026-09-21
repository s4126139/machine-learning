param(
    [switch]$CheckWeb
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Assert-True {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) {
        throw "FAIL: $Message"
    }
    Write-Host "PASS: $Message"
}

function Read-Utf8Text {
    param([string]$Path)
    return [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
}

function Read-Utf8Lines {
    param([string]$Path)
    return [System.IO.File]::ReadAllLines($Path, [System.Text.Encoding]::UTF8)
}

function Get-MarkdownColumnCount {
    param([string]$Line)

    $value = $Line.Trim()
    if ($value.StartsWith("|")) {
        $value = $value.Substring(1)
    }
    if ($value.EndsWith("|") -and -not $value.EndsWith("\|")) {
        $value = $value.Substring(0, $value.Length - 1)
    }
    return ([regex]::Split($value, '(?<!\\)\|')).Count
}

$repoRoot = (& git rev-parse --show-toplevel).Trim()
Assert-True ($LASTEXITCODE -eq 0) "repository root resolved"
$tutorRoot = Join-Path $repoRoot "docs/task2-tutor"

$expectedFiles = @(
    "00_START_HERE.md",
    "01_ASSIGNMENT_AND_EDA_HANDOFF.md",
    "02_REPOSITORY_AND_REPRODUCIBLE_FOUNDATION.md",
    "03_BASELINES_B0_AND_B1.md",
    "04_SCRATCH_MODELS_C1_C2_C3.md",
    "05_ABLATIONS_TUNING_AND_LEARNING_CURVES.md",
    "06_I1_I2_AND_PRETRAINED_BOUNDARY.md",
    "07_STABILITY_SLICES_ROBUSTNESS_AND_CALIBRATION.md",
    "08_BOOTSTRAP_GRADCAM_AND_ULTIMATE_JUDGEMENT.md",
    "09_FREEZE_REFIT_INFERENCE_AND_HANDOFF.md",
    "10_COMPLETE_COMMIT_TIMELINE.md",
    "11_MOCK_VIVA_AND_CODE_REVIEW.md",
    "12_FINAL_REVISION_AND_TRACE_MATRIX.md"
)

$actualFiles = @(Get-ChildItem -LiteralPath $tutorRoot -Filter "*.md" -File | Sort-Object Name | ForEach-Object Name)
Assert-True ($actualFiles.Count -eq 13) "exactly 13 Markdown files exist"
Assert-True (-not (Compare-Object $expectedFiles $actualFiles)) "Markdown filename set is exact"

$branch = (& git branch --show-current).Trim()
$head = (& git rev-parse HEAD).Trim()
$currentMergeBase = (& git merge-base HEAD linh/main).Trim()
$pinnedBase = "17e028edcd99697f425ad4bb6baf90a84a1fd43d"
Assert-True ($branch -eq "feature/task2-season") "branch is feature/task2-season"
Assert-True ($head -eq "0d92496a831a5557d19089fb4284cf33dd100e99") "HEAD is expected commit"
& git merge-base --is-ancestor $pinnedBase $head
Assert-True ($LASTEXITCODE -eq 0) "pinned preflight base is an ancestor of expected HEAD"
if ($currentMergeBase -ne $pinnedBase) {
    Write-Warning "linh/main moved after preflight; current merge-base is $currentMergeBase. Commit coverage stays pinned to the preflight range."
}

$excludeRelative = (& git rev-parse --git-path info/exclude).Trim()
$excludePath = if ([System.IO.Path]::IsPathRooted($excludeRelative)) {
    $excludeRelative
} else {
    Join-Path $repoRoot $excludeRelative
}
$excludeRules = @(Read-Utf8Lines -Path $excludePath | Where-Object { $_.Trim() -eq "/docs/task2-tutor/" })
Assert-True ($excludeRules.Count -eq 1) "local exclude contains exactly one tutor rule"
$ignoreProof = (& git check-ignore -v -- "docs/task2-tutor/00_START_HERE.md") -join "`n"
Assert-True ($LASTEXITCODE -eq 0) "00_START_HERE.md is ignored"
Assert-True ($ignoreProof -match "info/exclude") "ignore proof comes from local info/exclude"

$range = "17e028edcd99697f425ad4bb6baf90a84a1fd43d..0d92496a831a5557d19089fb4284cf33dd100e99"
$gitHashes = @(& git log --reverse --topo-order --format="%H" $range)
$timelinePath = Join-Path $tutorRoot "10_COMPLETE_COMMIT_TIMELINE.md"
$timeline = Read-Utf8Text -Path $timelinePath
$pattern = '(?m)^<summary><strong>\d{3}</strong> — <code>([0-9a-f]{40})</code>'
$docHashes = @([regex]::Matches($timeline, $pattern) | ForEach-Object { $_.Groups[1].Value })
Assert-True ($gitHashes.Count -eq 337) "Git range contains 337 commits"
Assert-True ($docHashes.Count -eq 337) "timeline documents 337 commit cards"
Assert-True ((@($docHashes | Group-Object | Where-Object Count -ne 1)).Count -eq 0) "timeline has no duplicate full hash"
Assert-True (-not (Compare-Object $gitHashes $docHashes)) "timeline has no missing or extra hash"
Assert-True (($gitHashes -join "`n") -ceq ($docHashes -join "`n")) "timeline order exactly matches git log --reverse --topo-order"
$allFullHashes = @([regex]::Matches($timeline, '(?<![0-9a-f])[0-9a-f]{40}(?![0-9a-f])') | ForEach-Object Value)
$rangeHashOccurrences = @($allFullHashes | Where-Object { $_ -in $gitHashes })
Assert-True ($rangeHashOccurrences.Count -eq 337) "each in-range full hash appears exactly once in the whole timeline file"

$cardPattern = '(?ms)<details>\s*<summary><strong>(\d{3})</strong> — <code>([0-9a-f]{40})</code> — (.*?) — <em>(.*?)</em></summary>(.*?)</details>'
$cards = @([regex]::Matches($timeline, $cardPattern))
Assert-True ($cards.Count -eq 337) "timeline contains 337 complete commit-card bodies"
$directCount = @($cards | Where-Object { $_.Groups[4].Value -eq "Task 2 direct" }).Count
$sharedCount = @($cards | Where-Object { $_.Groups[4].Value -eq "shared dependency" }).Count
Assert-True ($directCount -eq 298 -and $sharedCount -eq 39) "reviewed classifications are 298 direct and 39 shared dependencies"
$diffFootprints = @([regex]::Matches($timeline, '(?m)^- \*\*Git diff footprint:\*\* .+$'))
$nextReasons = @([regex]::Matches($timeline, '(?m)^- \*\*Vì sao commit kế cần tồn tại:\*\* .+$'))
Assert-True ($diffFootprints.Count -eq 337) "every commit card has one Git diff footprint"
Assert-True ($nextReasons.Count -eq 337) "every commit card has one next-step rationale"

$requiredCardLabels = @(
    "Trạng thái trước / problem / hypothesis",
    "Files changed",
    "Git diff footprint",
    "Code cần đọc",
    "Test cần đọc",
    "Artifact/consumer bị tác động",
    "Thay đổi thực tế / result",
    "Cách xác minh",
    "Limitation",
    "Vì sao commit kế cần tồn tại",
    "Senior lesson"
)
$cardIssues = [System.Collections.Generic.List[string]]::new()
$displaySubjectOverrides = @{
    "0190dc51b830401be1f923067a03c015999602da" = "docs(task2): record independent defect audit"
}
for ($index = 0; $index -lt $cards.Count; $index++) {
    $card = $cards[$index]
    $number = $card.Groups[1].Value
    $hash = $card.Groups[2].Value
    $subject = $card.Groups[3].Value
    $body = $card.Groups[5].Value
    $expectedNumber = "{0:D3}" -f ($index + 1)
    if ($number -ne $expectedNumber) {
        $cardIssues.Add("card number $number should be $expectedNumber")
    }
    $gitSubject = (& git show -s --format="%s" $hash).Trim()
    $expectedDisplaySubject = if ($displaySubjectOverrides.ContainsKey($hash)) {
        $displaySubjectOverrides[$hash]
    } else {
        $gitSubject
    }
    if ($subject -cne $expectedDisplaySubject) {
        $cardIssues.Add("card $number subject differs from Git")
    }
    foreach ($label in $requiredCardLabels) {
        if (-not $body.Contains("**${label}")) {
            $cardIssues.Add("card $number is missing field: $label")
        }
    }
    $filesMatch = [regex]::Match($body, '(?m)^- \*\*Files changed \((\d+)\):\*\* (.*)$')
    if (-not $filesMatch.Success) {
        $cardIssues.Add("card $number has no parseable changed-files field")
        continue
    }
    $declaredCount = [int]$filesMatch.Groups[1].Value
    $documentedFiles = @(
        [regex]::Matches($filesMatch.Groups[2].Value, '<code>(.*?)</code>') |
            ForEach-Object { [System.Net.WebUtility]::HtmlDecode($_.Groups[1].Value) }
    )
    $parentParts = @((& git rev-list --parents -n 1 $hash).Trim() -split '\s+')
    $gitFileOutput = if ($parentParts.Count -gt 2) {
        @(& git show --cc --format= --name-only $hash)
    } else {
        @(& git show --format= --name-only $hash)
    }
    $gitFiles = @(
        $gitFileOutput |
            Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
            ForEach-Object { $_.Trim() }
    )
    if ($declaredCount -ne $documentedFiles.Count) {
        $cardIssues.Add("card $number changed-files count does not match its list")
    }
    if (($documentedFiles -join "`n") -cne ($gitFiles -join "`n")) {
        $cardIssues.Add("card $number changed-files list differs from Git")
    }
}
if ($cardIssues.Count -gt 0) {
    throw "FAIL: commit-card audit found $($cardIssues.Count) issue(s):`n$($cardIssues -join "`n")"
}
Assert-True $true "all 337 card subjects, fields and merge-aware changed-file lists match Git"

for ($index = 0; $index -lt 12; $index++) {
    $path = Join-Path $tutorRoot $expectedFiles[$index]
    $text = Read-Utf8Text -Path $path
    $matches = @([regex]::Matches($text, '(?m)^Next: \[[^\]]+\]\(([^)]+\.md)\)\s*$'))
    Assert-True ($matches.Count -eq 1) "$($expectedFiles[$index]) has one mandatory Next link"
    Assert-True ($matches[0].Groups[1].Value -eq $expectedFiles[$index + 1]) "$($expectedFiles[$index]) points only to the next file"
}
$finalText = Read-Utf8Text -Path (Join-Path $tutorRoot $expectedFiles[12])
Assert-True (-not [regex]::IsMatch($finalText, '(?m)^Next: \[[^\]]+\]\(')) "final file has no backward or branching navigation link"
Assert-True ($finalText.TrimEnd().EndsWith("Next: **Kết thúc curriculum.**")) "final file explicitly ends the curriculum"

$allText = ($expectedFiles | ForEach-Object { Read-Utf8Text -Path (Join-Path $tutorRoot $_) }) -join "`n"
$startText = Read-Utf8Text -Path (Join-Path $tutorRoot $expectedFiles[0])
$minuteCells = @([regex]::Matches($startText, '(?m)^\|\s*\d{2}\s*\|.*?\|\s*(\d+) phút\s*\|') | ForEach-Object { [int]$_.Groups[1].Value })
Assert-True ($minuteCells.Count -eq 13) "00_START_HERE.md gives a time estimate for all 13 files"
Assert-True (($minuteCells | Measure-Object -Sum).Sum -eq 1270) "00_START_HERE.md reading-time table sums to 1,270 minutes"
Assert-True ($startText.Contains("21 giờ 10 phút")) "00_START_HERE.md states the correct total reading time"

# Beginner-facing documentation contract. These checks intentionally validate
# concepts and local explanations, not exact paragraphs, so wording can improve
# without making the audit fragile.
$requiredStartCodes = @(
    "B0", "B1", "C1", "C2", "C3", "P0", "P1", "A0", "A1",
    "T0", "T1", "T2", "I1", "I2", "P0S", "P*",
    "G0", "G1", "G2", "G3", "G4", "G5", "G6", "G7", "G8"
)
foreach ($code in $requiredStartCodes) {
    $escapedCode = [regex]::Escape($code)
    Assert-True ([regex]::IsMatch($startText, "(?<![A-Za-z0-9])$escapedCode(?![A-Za-z0-9])")) "00_START_HERE.md explains repository code: $code"
}
Assert-True ($startText.Contains("Phase 00–12")) "00_START_HERE.md names the Phase 00–12 lesson-number system"
Assert-True ($startText.Contains("G0–G8")) "00_START_HERE.md names the G0–G8 experiment-stage system"
Assert-True ($startText.Contains("001–337")) "00_START_HERE.md names the 001–337 commit-index system"

$tableIssues = [System.Collections.Generic.List[string]]::new()
$tableBlockCount = 0
foreach ($name in $expectedFiles) {
    $lines = @(Read-Utf8Lines -Path (Join-Path $tutorRoot $name))
    $insideFence = $false
    for ($lineIndex = 0; $lineIndex -lt $lines.Count - 1; $lineIndex++) {
        if ($lines[$lineIndex] -match '^\s*(?:```|~~~)') {
            $insideFence = -not $insideFence
            continue
        }
        if ($insideFence) { continue }
        $isHeader = $lines[$lineIndex] -match '^\s*\|.*\|\s*$'
        $isSeparatorNext = $lines[$lineIndex + 1] -match '^\s*\|(?:\s*:?-{3,}:?\s*\|)+\s*$'
        if (-not ($isHeader -and $isSeparatorNext)) { continue }

        $tableBlockCount++
        $previousIndex = $lineIndex - 1
        while ($previousIndex -ge 0 -and [string]::IsNullOrWhiteSpace($lines[$previousIndex])) {
            $previousIndex--
        }
        $guideStartIndex = $previousIndex
        while ($guideStartIndex -gt 0 -and -not [string]::IsNullOrWhiteSpace($lines[$guideStartIndex - 1])) {
            $guideStartIndex--
        }
        if ($guideStartIndex -lt 0 -or -not $lines[$guideStartIndex].StartsWith("**Cách đọc bảng:**")) {
            $tableIssues.Add("$name line $($lineIndex + 1): table needs an immediately preceding '**Cách đọc bảng:**' guide")
        }

        $expectedColumnCount = Get-MarkdownColumnCount -Line $lines[$lineIndex]
        $rowIndex = $lineIndex
        while ($rowIndex -lt $lines.Count -and $lines[$rowIndex] -match '^\s*\|.*\|\s*$') {
            $actualColumnCount = Get-MarkdownColumnCount -Line $lines[$rowIndex]
            if ($actualColumnCount -ne $expectedColumnCount) {
                $tableIssues.Add("$name line $($rowIndex + 1): expected $expectedColumnCount columns, found $actualColumnCount")
            }
            $rowIndex++
        }
    }
}
Assert-True ($tableBlockCount -gt 0) "Markdown tables were discovered for pedagogy audit"
if ($tableIssues.Count -gt 0) {
    throw "FAIL: table pedagogy audit found $($tableIssues.Count) issue(s):`n$($tableIssues -join "`n")"
}
Assert-True $true "every Markdown table has a nearby column guide and consistent row width"

$phase08Text = Read-Utf8Text -Path (Join-Path $tutorRoot $expectedFiles[8])
Assert-True ([regex]::IsMatch($phase08Text, '(?is)bootstrap.{0,180}không\s+(?:train|huấn luyện)(?:\s+lại)?\s+model')) "Phase 08 says bootstrap does not retrain the model"
Assert-True ([regex]::IsMatch($phase08Text, '(?is)bootstrap.{0,900}có\s+hoàn\s+lại')) "Phase 08 defines grouped sampling with replacement"
Assert-True ([regex]::IsMatch($phase08Text, '(?is)paired.{0,260}(?:cùng|same).{0,160}(?:nhóm|group|mẫu)')) "Phase 08 explains that both candidates use the same paired draw"
Assert-True ([regex]::IsMatch($phase08Text, '(?is)không\s+bao\s+phủ.{0,80}(?:mọi|tất cả|all).{0,40}seed')) "Phase 08 limits bootstrap claims beyond the fitted seeds"

$phase09Text = Read-Utf8Text -Path (Join-Path $tutorRoot $expectedFiles[9])
foreach ($term in @("G8", "Freeze", "Refit", "Bundle", "Manifest", "Registry", "Provenance", "Inference", "Handoff", "Holdout")) {
    Assert-True ($phase09Text.Contains("**${term}**")) "Phase 09 locally defines: $term"
}
Assert-True ($phase09Text.Contains("**Cách đọc sơ đồ:**")) "Phase 09 explains how to read its state diagram"

$timelineGuideText = Read-Utf8Text -Path (Join-Path $tutorRoot $expectedFiles[10])
Assert-True ($timelineGuideText.Contains("Đọc trang dài này theo ba lượt")) "Phase 10 gives a three-pass reading guide"
foreach ($field in $requiredCardLabels) {
    Assert-True ($timelineGuideText.Contains("- **${field}")) "Phase 10 explains commit-card field: $field"
}

$vivaGuideText = Read-Utf8Text -Path (Join-Path $tutorRoot $expectedFiles[11])
Assert-True ($vivaGuideText.Contains("Claim — điều bạn khẳng định")) "Phase 11 defines the viva claim step"
Assert-True ($vivaGuideText.Contains("Mechanism — cách nó hoạt động")) "Phase 11 defines the viva mechanism step"
Assert-True ($vivaGuideText.Contains("Evidence — bằng chứng")) "Phase 11 defines the viva evidence step"
Assert-True ($vivaGuideText.Contains("Decision — hành động")) "Phase 11 defines the viva decision step"
Assert-True ($vivaGuideText.Contains("Limitation — điều chưa được chứng minh")) "Phase 11 defines the viva limitation step"
Assert-True ($vivaGuideText.Contains("không phải tên mục điểm chính thức")) "Phase 11 marks self-scores as practice rather than RMIT grades"

$revisionGuideText = Read-Utf8Text -Path (Join-Path $tutorRoot $expectedFiles[12])
Assert-True ([regex]::IsMatch($revisionGuideText, '(?is)\*\*Trace matrix\*\*.{0,260}(?:bản đồ|truy dấu)')) "Phase 12 defines trace matrix before using it"

$forbidden = @(
    "xem lại phần trước",
    "như đã nói ở chapter 3",
    "xem glossary để hiểu",
    "chúng ta sẽ giải thích sau",
    "tham khảo appendix trước"
)
foreach ($phrase in $forbidden) {
    Assert-True (-not $allText.ToLowerInvariant().Contains($phrase)) "forbidden backward-reference phrase absent: $phrase"
}
Assert-True (-not [regex]::IsMatch($allText, '(?i)\bTODO\b|\bTBD\b|lorem ipsum')) "no unfinished marker or filler text"
Assert-True (-not $allText.Contains('**Answer checklist**')) "old English answer-checklist label is absent"
Assert-True (-not $allText.Contains('**Evidence to mention**')) "old English evidence label is absent"

foreach ($name in $expectedFiles[1..9]) {
    $text = Read-Utf8Text -Path (Join-Path $tutorRoot $name)
    $toggleCount = ([regex]::Matches($text, '<details>')).Count
    Assert-True ($toggleCount -ge 12) "$name has at least 12 toggle questions"
    $questionKinds = @(
        "Nhớ lại 1:", "Nhớ lại 2:", "Nhớ lại 3:",
        "Vì sao 4:", "Vì sao 5:", "Vì sao 6:",
        "Lần theo code 7:", "Lần theo code 8:",
        "Tìm lỗi 9:", "Tìm lỗi 10:",
        "Bảo vệ miệng 11:", "Bảo vệ miệng 12:"
    )
    foreach ($kind in $questionKinds) {
        $kindCount = ([regex]::Matches($text, '<summary><strong>' + [regex]::Escape($kind) + '</strong>')).Count
        Assert-True ($kindCount -eq 1) "$name has exactly one $kind question"
    }
    foreach ($number in 1..17) {
        Assert-True ([regex]::IsMatch($text, "(?m)^### $number\. ")) "$name contains required phase heading $number"
    }
    $sourceFieldAlternatives = @(
        @{ Label = "why now"; Values = @("Why read this now", "Vì sao đọc lúc này") },
        @{ Label = "exact section"; Values = @("Exact sections/pages", "Đọc đúng phần nào", "Phần/trang cần đọc") },
        @{ Label = "idea to extract"; Values = @("What idea to extract", "Cần lấy ý gì", "Ý chính cần lấy") },
        @{ Label = "safe to skip"; Values = @("What can be skipped for now", "Tạm bỏ qua gì", "Phần có thể bỏ qua") },
        @{ Label = "repository connection"; Values = @("Repository connection", "Nối với repository", "Liên hệ với repository") }
    )
    foreach ($sourceField in $sourceFieldAlternatives) {
        $fieldFound = $false
        foreach ($value in $sourceField.Values) {
            if ($text.Contains($value)) {
                $fieldFound = $true
                break
            }
        }
        Assert-True $fieldFound "$name includes bilingual source-reading field: $($sourceField.Label)"
    }
}

$phaseBounds = @(
    @{ File = $expectedFiles[1]; Start = 1; End = 11 },
    @{ File = $expectedFiles[2]; Start = 12; End = 24 },
    @{ File = $expectedFiles[3]; Start = 25; End = 26 },
    @{ File = $expectedFiles[4]; Start = 27; End = 85 },
    @{ File = $expectedFiles[5]; Start = 86; End = 139 },
    @{ File = $expectedFiles[6]; Start = 140; End = 191 },
    @{ File = $expectedFiles[7]; Start = 192; End = 236 },
    @{ File = $expectedFiles[8]; Start = 237; End = 266 },
    @{ File = $expectedFiles[9]; Start = 267; End = 337 }
)
foreach ($bound in $phaseBounds) {
    $text = Read-Utf8Text -Path (Join-Path $tutorRoot $bound.File)
    $startIndex = [int]$bound.Start
    $endIndex = [int]$bound.End
    $indexText = "{0:D3}–{1:D3}" -f $startIndex, $endIndex
    $startShort = $gitHashes[$startIndex - 1].Substring(0, 7)
    $endShort = $gitHashes[$endIndex - 1].Substring(0, 7)
    Assert-True ($text.Contains($indexText)) "$($bound.File) declares its continuous commit-index range $indexText"
    Assert-True ($text.Contains("<code>$startShort")) "$($bound.File) names the correct first commit $startShort"
    Assert-True ($text.Contains("<code>$endShort")) "$($bound.File) names the correct last commit $endShort"
    $expectedAnswerCommit = if ($bound.File -eq $expectedFiles[3]) {
        "Commit: $startShort... và $endShort..."
    } else {
        "Commit: dải $startShort... → $endShort..."
    }
    $answerCommitCount = ([regex]::Matches($text, [regex]::Escape($expectedAnswerCommit))).Count
    Assert-True ($answerCommitCount -eq 12) "$($bound.File) uses the correct commit reference in all 12 practice answers"
}

$vivaText = Read-Utf8Text -Path (Join-Path $tutorRoot $expectedFiles[11])
$vivaSections = @(
    "Hỏi nhanh", "Câu trả lời 2 phút", "Vẽ bảng", "Câu hỏi khi xem code",
    "Bài tìm rò rỉ dữ liệu", "Bài đọc đường học",
    "Câu hỏi bảo vệ model thắng", 'Câu hỏi “không được kết luận điều gì?”',
    "Một bài bảo vệ miệng mẫu hoàn chỉnh", "Bảng tự chấm theo rubric"
)
foreach ($section in $vivaSections) {
    Assert-True ($vivaText.Contains($section)) "$($expectedFiles[11]) includes viva section: $section"
}
Assert-True (([regex]::Matches($vivaText, '<details>')).Count -ge 30) "$($expectedFiles[11]) keeps viva answers hidden in toggles"

$revisionText = Read-Utf8Text -Path (Join-Path $tutorRoot $expectedFiles[12])
foreach ($matrixHeading in @("Claim trace matrix", "File impact matrix", "Model-selection ladder", "Final oral-defence checklist")) {
    Assert-True ($revisionText.Contains($matrixHeading)) "$($expectedFiles[12]) includes: $matrixHeading"
}

$mermaidCount = ([regex]::Matches($allText, '(?m)^~~~mermaid\s*$')).Count
Assert-True ($mermaidCount -ge 6) "at least six useful Mermaid diagrams exist"

$markdownLinkPattern = '\[[^\]]+\]\(([^)]+)\)'
foreach ($name in $expectedFiles) {
    $path = Join-Path $tutorRoot $name
    $text = Read-Utf8Text -Path $path
    foreach ($match in [regex]::Matches($text, $markdownLinkPattern)) {
        $target = $match.Groups[1].Value
        if ($target -match '^(https?://|mailto:|#)') { continue }
        $targetPath = Join-Path $tutorRoot ([uri]::UnescapeDataString(($target -split '#')[0]))
        Assert-True (Test-Path -LiteralPath $targetPath) "local link exists: $name -> $target"
    }
}

$repositoryPathPattern = '^(?:src|tests|notebooks|results|models|data|docs|rubrics|configs|scripts)/|^pyproject\.toml$'
$exactRepositoryPaths = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
foreach ($match in [regex]::Matches($allText, '<code>(.*?)</code>')) {
    $candidate = [System.Net.WebUtility]::HtmlDecode($match.Groups[1].Value).Trim()
    if ($candidate -notmatch $repositoryPathPattern) { continue }
    if ($candidate -match '[*{},;|]|\.\.\.|…|→|\s--') { continue }
    $candidate = $candidate -replace ':[0-9]+(?:[–-][0-9]+)?$', ''
    if ($candidate -match '\s' -and $candidate -ne 'docs/COSC2753_2026B_Assignment 2.pdf') { continue }
    [void]$exactRepositoryPaths.Add($candidate)
}
$missingRepositoryPaths = @(
    $exactRepositoryPaths |
        Where-Object {
            $nativePath = $_ -replace '/', [System.IO.Path]::DirectorySeparatorChar
            -not (Test-Path -LiteralPath (Join-Path $repoRoot $nativePath))
        } |
        Sort-Object
)
Assert-True ($missingRepositoryPaths.Count -eq 0) "all exact repository paths named in code tags exist"

$webUrls = @([regex]::Matches($allText, 'https?://[^)\s]+') | ForEach-Object { $_.Value.TrimEnd('.', ',') } | Sort-Object -Unique)
Assert-True ($webUrls.Count -ge 15) "academic/official citation set is present"
foreach ($url in $webUrls) {
    $uri = $null
    $valid = [uri]::TryCreate($url, [System.UriKind]::Absolute, [ref]$uri) -and $uri.Scheme -in @("http", "https")
    Assert-True $valid "citation URL syntax is valid: $url"
    if ($CheckWeb) {
        $webOkay = $false
        $webDetail = ""
        try {
            $response = Invoke-WebRequest `
                -Uri $url `
                -Method Get `
                -MaximumRedirection 8 `
                -TimeoutSec 25 `
                -Headers @{ "User-Agent" = "MLA2-private-tutor-citation-audit/1.0" }
            $webOkay = $response.StatusCode -ge 200 -and $response.StatusCode -lt 400
            $webDetail = "direct HTTP $($response.StatusCode)"
        } catch {
            # Some publishers reject automated requests even when a DOI is valid.
            # In that case, verify the DOI against Crossref's metadata API instead
            # of treating an anti-bot response as a broken academic citation.
            if ($uri.Host -eq "doi.org") {
                try {
                    $doi = [uri]::UnescapeDataString($uri.AbsolutePath.TrimStart("/"))
                    $encodedDoi = [uri]::EscapeDataString($doi)
                    $record = Invoke-RestMethod `
                        -Uri "https://api.crossref.org/works/$encodedDoi" `
                        -TimeoutSec 25 `
                        -Headers @{ "User-Agent" = "MLA2-private-tutor-citation-audit/1.0" }
                    $title = [string]$record.message.title[0]
                    $webOkay = $record.status -eq "ok" -and -not [string]::IsNullOrWhiteSpace($title)
                    $webDetail = "DOI metadata verified: $title"
                } catch {
                    $webDetail = "direct request and DOI metadata lookup failed: $($_.Exception.Message)"
                }
            } else {
                $webDetail = "direct request failed: $($_.Exception.Message)"
            }
        }
        Assert-True $webOkay "citation opens or has valid DOI metadata: $url ($webDetail)"
    }
}

& git diff --quiet -- .gitignore
Assert-True ($LASTEXITCODE -eq 0) ".gitignore is unchanged"
$status = (& git status --short) -join "`n"
Assert-True ([string]::IsNullOrWhiteSpace($status)) "Git status is clean; ignored tutor files are not tracked"

Write-Host "AUDIT COMPLETE: 13 Markdown files; 337/337 commits; navigation, toggles, links, citations, ignore and Git status passed."
