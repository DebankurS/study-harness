# /quiz

Arguments: `$ARGUMENTS` → `<track> [scope] [mode] [N]`. Defaults: scope `mixed`, mode `practice`, N `8` (practice only). In `full` mode, N is ignored: a full assessment is always **full-length** (see below).

This is the **practice doctrine**: it makes held knowledge come to mind under test conditions, and it measures. It is not a teaching session. Misconceptions get a surgical nudge. Anything bigger goes to the drill queue.

## 1. Load context (and nothing more)
- `data/<track>/state.md`, then `guidelines.md`.
- Scope slice only: `grep`/`sed` the syllabus rows and ledger rows for the chosen area (all areas for `mixed`: read the ledger table, skip notes).
- `tail -n 30 data/<track>/log.md` only if the next action refers to a prior session.
- If the ledger is empty of evidence (all `unseen`), suggest `/probe <track>` first (a full map, no teaching) and proceed only if the learner wants to. Otherwise this is a **baseline probe**: sample across areas by weight, entering near the hard end of each area, and let misses walk you down.

## 2. Select the demands
Standing question: *what is the cheapest question that most strengthens, or most reduces uncertainty about, the weakest capability not yet demonstrated?*

- **Target** (weakest first): weight × (unseen > shaky/drill > holding > solid), least-recently-tested first. Premises that feed many objectives rank higher.
- **Mode per target** (cheapest layer not yet demonstrated): Recall, then Discrimination, then Composition. If a later layer fails, test the earlier one.
  - Recall: a varied cue in a short scenario.
  - Discrimination: a near-twin pair where one feature decides, using a confusable from the ledger or "Known traps".
  - Composition: a multi-step scenario with distractor detail, the way the real assessment is written, if there is one.
- **Bank repeats (practice mode only):** before the fresh questions, re-ask up to 3 eligible items from `bank.md` for the in-scope rows, verbatim (rules in AGENTS.md "Question bank"). They count within N. Never in full mode.
- **Interleave.** Never run same-target blocks. Switching targets is what makes retrieval real.
- **Difficulty** per target from its last outcome: clean success, one notch up; needed hints, hold; miss, one notch down.
- Match the style the track will really be assessed in, from `guidelines.md` (scenario length, qualifiers, question types). If it has no external assessment, favour scenario and application questions.

## 3. Write each question (the craft)
1. **Solve it first, then try to break it.** A question solvable by a route that skips the target teaches the wrong thing, so fix or discard it. Confirm it needs nothing beyond the syllabus.
2. **Verify any fact you are not certain of** before the question exists. Use authoritative sources (official docs, standards, primary texts, or run it). A wrong key grades the learner against a lie.
3. **Never announce the target.** The scenario itself must make the concept come to mind.
4. **Option craft.** Every option is a bare claim of the same grain and register, with no reasoning inside the options. Write the correct one first, then mutate it into each distractor, where each distractor is the answer someone holding a *specific, believable* wrong model would give. Eliminable-on-sight options are wasted. No asymmetric bolding. If you can pick the key without knowing the material, regenerate.
5. **Commit the key** (answer, one-line why, the target ID, mode, and the wrong model behind each distractor) to `data/<track>/.session/key.md` before the learner sees the question. This file is deleted at the end.

## 4. Delivery

**Practice mode** (default): one question per turn.
- Present the stem and options. Ask for the **answer + confidence %** (e.g. `B 70`). Thinking aloud is welcome and is read as evidence.
- On a miss or a hint request, use the **hint ladder, one rung per request**, diagnosing the first broken link from the learner's reasoning:
  R0 attention redirect → R1 pattern re-description → R2 candidate class → R3 name the concept → R4 outline the move → R5 worked step.
  The stall may sit earlier than where the learner is looking, so a verification nudge ("check the assumption behind that move") beats a correction. Statement confusion is free to clear, since wording is logistics. Solution information is metered.
- After a correct answer, give a one-line verdict naming the load-bearing move, then the next question.
- After a wrong answer, state the verdict plainly and localise the first break without giving the correction. Wait for the next attempt. Reveal only when solved or when the learner asks to end the question.
- Reveal the key and the wrong-model reason for each distractor **after** the question concludes.

**Full mode (full-length, always)**: the question count and time are the track's real ones, from the `Full assessment length:` line in `guidelines.md`. Ignore any N the learner gives, and say so once. Area mix follows the syllabus weights, with question types and qualifiers as in the real assessment, if there is one. Full assessment questions must all be new (never reuse stems from earlier full assessments), and each must pass the solve-and-shortcut check.
- Context budget: write the whole paper to `data/<track>/.session/paper.md` (stems and options) and the keys to `data/<track>/.session/key.md`, in batches of at most 15 questions so no single generation is huge. Present the paper to the learner in blocks of about 15, one block per turn, and collect answers as a list (`1 B 70, 2 A 90, ...`; multi-select as `3 AC 60`). Record each block's answers in `.session/answers.md` as it arrives.
- Give **no feedback until every block is answered.** No hints, no verdicts, no "correct" per block.
- Tell the learner the time budget up front (you cannot time them; they should self-time) and ask them to report their finish time.
- Then grade everything, report score % overall and per area, review every miss (classify it, give the wrong-model reason, one surgical line), and record calibration (high-confidence misses and low-confidence hits).
- Append one row to `data/<track>/assessments.md`: number, date, question count, score %, weakest area with its %, calibration note, one-line note. Update ledger rows for the questions touched.
- Do not retest in the same session. A full assessment is a measurement.

## 5. Grade and classify (be honest)
Per question record: correct?, confidence, miss type (`cue` nothing came · `disc` wrong candidate won · `slip` right idea, wrong run · `care` careless · `struct` the belief itself is wrong).
- **Wrong + high confidence** (>=70) is a committed misconception. Flag it, dig into its extent, and queue `/drill`.
- **Right + low confidence** (<=50) is fragile. Re-test it later on a fresh surface.
- Never soften a wrong verdict. Never inflate a right one. Calibration is a product of honest feedback.
- Only `struct` misses need belief repair. The rest are practice information.
- Do not teach beyond one surgical line. If a miss needs real teaching, say "drill this" and queue it. For `deep`-tagged rows (see AGENTS.md, "Deep-understanding topics"), don't just queue: offer `/drill <track> <id>` immediately after the question concludes.

## 6. Close with retests
Before ending a practice session, retest every miss, hint-heavy item and surrendered question **on a fresh surface** (new scenario, same concept, never the original wording). Nothing that failed leaves the session unretested. In full mode, retest only the structural misses.

## 7. Write back
- **bank.md**: add each question from this session that was a miss, right at <=50% confidence, needed R2+ hints, or was surrendered. For re-asked items, update `asked`, `streak` and `Status` per AGENTS.md. Full mode writes nothing to the bank. (also after each block, so /clear is always safe)
- **ledger.md**: edit the rows touched. Update `status`, `layers` (only layers genuinely demonstrated this session), `cal`, `miss`, `last` (today), and the one-line misconception/confusable. Promote to `solid` only with R+D+C shown, calibration `ok`, and a passed fresh-surface retest. Queue misconceptions as `drill`.
- **state.md**: rewrite it (under 40 lines). Recompute readiness per area, refresh the drill queue (max 5, struct and over-confident misses first), set one concrete next action.
- **log.md**: append one entry of at most 4 lines.
- Delete `data/<track>/.session/`.
- Recompute the **readiness verdict** (AGENTS.md "Readiness") from `assessments.md` and the ledger, write it to `state.md`, and print it as the last line of your reply.
- Tell the learner the score, the 2–3 most important findings and the next action. Keep it short.
