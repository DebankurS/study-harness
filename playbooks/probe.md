# /probe

Arguments: `$ARGUMENTS` → `<track> [area]`. With no area, work through the areas in order of weight, highest first.

This is the **prober doctrine**: your whole job is a precise map of what the learner already holds. The map decides what later sessions skip, so precision matters more than speed. Measure only. Never teach, hint or explain during the probe.

## 1. Load context
- `state.md`, `guidelines.md`, and the syllabus and ledger rows for the chosen area (grep the slice).
- `data/shared/concepts.md` section for any `deep`-tagged rows in scope.
- Rows already `holding` or `solid` with a recent `last` need no probing. Skip them. Resuming a half-finished probe means starting at the first `unseen` row.
- Learner context is in memory and `guidelines.md`. Enter high where the learner's background is strong, and expect thin spots elsewhere.

## 2. Reason out the strands
Each syllabus task (or tight cluster of tasks) is a **strand**. For each, note the hardest thing the objective needs. That's where you enter.

## 3. Bracket each strand, one question at a time
Ask, wait, then choose the next question from what the answer showed.

- **Enter near the top, not the bottom.** Open at roughly the hardest thing the objective needs and let a miss walk you down. A warm-up at the basics wastes the question that could have moved an edge.
- **Strands inform each other.** A strand crushed at height means its neighbours start high too. Never open below what the session has already shown.
- **Correct and confident** (>=70%): jump up sharply. The bigger the jump, the fewer questions needed.
- **Correct but hesitant** (<=50%, thin or no reasoning): the knowledge is fragile. Step up gently and characterise the shakiness.
- **Wrong:** the ceiling drops. Narrow back in to pin exactly where it sits.
- **A miss is one coordinate, not a verdict.** A slip, a gap and a misconception look identical. Probe around it. Misconceptions matter most: when a wrong answer comes with high confidence, dig into its extent before moving on.
- **"I don't know"** (no confidence needed) is a genuine gap, not a wrong answer. Record it as such.
- **A strand that never breaks isn't done.** Escalate until it does, or until you've reached the hardest the objective needs.
- **Every question must move an edge.** No filler. No re-asking what a previous answer already showed. Never descend into territory that's already bracketed.
- **Prefer questions that resolve several rows at once.** A scenario that needs three objectives, answered correctly and confidently, moves all three edges.

## 4. Writing the questions
Same craft as `/quiz`:
1. Solve it first and try to shortcut it. Fix or discard anything solvable without the target.
2. Verify any fact you aren't sure of against an authoritative source before it goes into a question or key.
3. Never announce the target. The scenario must make the concept come to mind.
4. Options are bare claims of the same grain. Each distractor is a believable wrong model. Nothing is eliminable on sight.
5. Commit the key, the target IDs and each distractor's wrong model to `data/<track>/.session/key.md` before posing.

Delivery: one question per turn, answer plus confidence (`B 70`) plus optional thinking aloud. Tell the learner only "correct" or "incorrect". No explanation, no key and no hint during the probe. If the learner asks for the answer, say it comes at the end.

## 5. Checkpoint (every ~5 questions, so /clear is always safe)
For each row touched, edit `ledger.md` in place:
- Put **floor** and **ceiling** in the last column, prefixed `F:` and `C:` (for example `F: basic pipeline construction. C: persisting a custom component. Misconception: ...`).
- Confident-correct at or near the objective's hard end: status `holding`, with `layers` set to what the questions showed (usually R and D). Mark inferred rows `(inferred)` in the note. Never mark `solid` from a probe.
- Wrong: `shaky`, or `drill` if it's a misconception, a high-confidence miss or a `deep` row.
- "I don't know": leave `unseen` and write `gap` in the note.
- Set `cal`, `miss` and `last`.

- Add each missed, shaky (<=50% confidence) or "I don't know" question to `bank.md` at the checkpoint, so it returns in later sessions.

## 6. Conclude
Stop when every strand in scope is bracketed. Then:
1. Reveal the keys for the misses and gaps only, briefly, with the wrong-model reason. This is the only teaching in a probe.
2. Report the map in a compact table: per area, what's held (skip), where it breaks, misconceptions, and rows queued.
3. Update `state.md` (under 40 lines): recompute readiness per area, put the top 5 gaps in the drill queue (misconceptions and high-weight areas first), and set one next action: usually `/drill <track>` for the top gap.
4. Append a 4-line entry to `log.md`.
5. Delete `data/<track>/.session/`.

## Prohibitions
- Never teach, hint or explain while the probe is running.
- Never re-ask in the same surface. Never ask what an earlier answer already showed.
- Never open below what the session has already demonstrated.
- Never mark anything `solid`.
- Never ask for a target date. It is ASAP by default.
