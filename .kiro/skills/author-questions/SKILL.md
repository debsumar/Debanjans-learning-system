---
name: author-questions
description: Author applied MCQs and per-question recall with registry objectives, distractor rationales, confusion sets, and verifier-safe IDs
---
# Author questions

Use this runbook for `$ARGUMENTS`.

## Ground truth first

Read `assets/registry.js`, especially `questionSchema`, `objectives`, `confusionSets`, and `studyPolicy`.

Read real page patterns in `topics/az-900/04-core-architecture.html`, `topics/az-900/05-compute-networking.html`, `topics/az-900/09-governance-compliance.html`, and `topics/az-900/10-management-deployment.html`.

The shipped bank has 110 MCQs and 114 recall items. Match shipped contracts; invent no schema.

## MCQ contract

Each item must have:

- `itemId` in form `cNN-qMM`.
- `objectiveIds` containing real registry objective ids.
- `bloom`: exactly one of `remember`, `understand`, `apply`, `analyze`.
- A clear `stem`.
- Exactly 4 answer options.
- `key` naming the correct option.
- `keyRationale` explaining why key is correct.
- `distractorRationales`: one rationale for EVERY wrong option.
- Optional `misconceptionTag` when a known misconception is tested.

In authored HTML, MCQ answer panels use `data-mcq="cNN-qMM"` and `data-objective="..."`. Keep IDs unique.

Per-distractor rationales matter. They turn a wrong answer into contrast learning. They are also the part almost everyone omits. Explain why each wrong option fails, not only why key wins.

## Distractor discipline

Every distractor must be a defensible near-neighbour or known misconception. Never use joke options.

For every distractor, state condition under which it WOULD be correct. Example: a private endpoint is wrong for a public internet path, but correct when a service needs a private VNet IP through Private Link.

Avoid options that differ only by grammar, unequal specificity, or accidental clues. Keep option lengths and wording comparable. Ensure one answer is best under stated constraints.

## Stem discipline

Prefer applied scenario stems over definition recall. Existing bank already does this: choose a service for a failure scope, network path, governance need, or deployment constraint.

Use definition recall only for atomic facts that still need memorizing. Raise Bloom level when scenario permits. Do not make ambiguity look like difficulty.

## Recall contract

Create exactly one recall item per question:

```html
<details class="more recall-item" data-recall="cNN-rMM">
  <summary>Question before answer</summary>
  <p>Answer in body.</p>
</details>
```

Question goes in `summary`. Answer goes in body. Use IDs `cNN-rMM`; one per MCQ, no duplicates.

Reason, bluntly: old format put all answers in one panel. Opening it revealed everything, so no retrieval attempt happened. Retrieval works only when reader commits before seeing answer.

Existing `05-compute-networking.html` shows the shipped per-question pattern: `c05-r01` through `c05-r10`, each separately expandable.

## Objective tagging

Every MCQ answer panel carries `data-objective` referencing a real registry id, for example `az900-c05-o5`.

Verifier fails on orphan objective references in either direction: HTML ids absent from registry, or registry objectives never referenced by page data. Also keep `#skills` bullet ids aligned with registry objectives.

Do not attach an objective merely because a term appears. Attach objective that item actually tests.

## Coverage target

For each objective, aim for at least:

1. One atomic recall item.
2. One discrimination or scenario item.
3. One explanation prompt.

Explanation can ask why a choice fits, why a near-neighbour fails, or what constraint changes the answer. Do not pad coverage with weak cloze items.

Map each question to one or more objectives only when evidence supports it. Per-question recall remains one item, even when MCQ has multiple objective ids.

## Avoid shipped skew

Chapter 09 has only 3 objectives but 10 MCQs; 8 map to one objective. Do not repeat this imbalance without reason.

Every existing chapter has exactly 10 questions, even though domain weights are `25-30%`, `35-40%`, and `30-35%`. Equal chapter count is not equal exam coverage.

For new topics, allocate question volume proportional to domain weight. Within a chapter, distribute items across objectives and use coverage targets before adding extras.

## Interleaving and confusion sets

If concepts are confusable, register a `confusionSets` entry in `assets/registry.js` with discriminator, objective ids, owning chapter, and hub target. Do not silently invent a local pair.

Give each registered set a `.cal.confuse` callout in owning chapter. Add a discrimination drill entry in topic `review.html`; shipped review page uses `data-recall="rev-dNN"` entries linked to owning callouts.

Interleaving helps after base comprehension and can hurt novices before it. Sequence: teach distinction first, then mix near-neighbours for retrieval.

Evidence strength varies. Retrieval practice and spacing are strongly supported. Interleaving and dual coding are moderate and context-dependent. Do not overclaim any learning effect.

## Authoring sequence

1. Resolve `$ARGUMENTS` to chapter or objective in registry.
2. Read objective text and confusion-set membership.
3. Draft scenario and intended Bloom level.
4. Draft four plausible options; mark key.
5. Write key rationale and three distractor rationales, including when each distractor would be correct.
6. Add `data-mcq`, real `data-objective`, and one `data-recall` item.
7. Check objective coverage, IDs, and recall count.
8. Add confusion callout and review drill when registry requires it.

## Finish: verifier

Run from target repo:

```powershell
pwsh -File tools\verify.ps1
```

Require `PASS` overall. At minimum inspect objective coverage, skills-bullet ids, recall and MCQ integrity, confusion set integrity, study contract, and progressive enhancement.

Verifier checks unique `cNN-qMM` and recall IDs, expected chapter counts, registry objective references, and per-page recall markup. It does not judge question quality, distractor defensibility, Bloom validity, or whether rationale truly explains the misconception. Human review remains required.
