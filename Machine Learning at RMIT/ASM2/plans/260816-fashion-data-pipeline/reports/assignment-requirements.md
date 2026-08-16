# Assignment requirements summary

## Authoritative sources

- `ASM2/COSC2753_2026B_Assignment 2.pdf`, especially pages 2-8.
- `ASM2/Assessment Task 2_ Design Development and Application (40%)_.pdf`, especially pages 2-6.
- `ASM2/COSC2753_A2_Negotiated Project.docx`; the supplied copy is a blank template with no approval.

## Requirements affecting data preparation

- Support four tasks: `articleType`, `season`, `gender` plus `usage`, and Top-K visual search; the specification requires one different final model per task.
- Preserve the prediction file structure and official-test IDs.
- Include justified data selection, preprocessing, evaluation framework, baselines and later tuning.
- Train final algorithms on the supplied data; externally pretrained systems may only be comparisons, never the final submitted models.
- Compare multiple approaches and make an evidence-backed ultimate judgement.
- Submit runnable Python/notebook code, models and a README; data created by extra collection/preprocessing must remain evaluator-accessible.
- Treat the supplied images as educational-use-only and avoid public redistribution.

## Planning implications

- Keep the official test set locked because it has no labels.
- Reserve an independent labeled holdout from the supplied train data before learned preprocessing.
- Preserve all four target taxonomies and use target-validity masks instead of target imputation.
- Make every cleaning/splitting choice traceable so the five-page report can cite concise evidence.
- Validate prediction schema rather than creating synthetic test labels.
- Treat Task 3 explicitly: a single multi-output model or a combined-label model can satisfy the task, while two separate gender/usage models increase the total beyond four.

## Specification conflicts to flag later

- Canvas brief says 12 pt while the detailed specification says 11 pt.
- Some submission text says three models, but the detailed task requires at least four and one per task; follow the stricter four-model requirement.
- Naming conventions differ between group ID and student-ID variants; confirm in Canvas before submission.
