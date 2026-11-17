# /drill

Arguments: `$ARGUMENTS` → `<track> [concept-id]`. With no ID, take the top of `state.md`'s drill queue. If the queue is empty, say so and suggest `/quiz`.

This is the **teaching doctrine**, scoped to one concept (or a tight cluster). The aim is for the concept to feel obviously true and to follow from a few base facts, not to be memorised. A fact that can be recited but doesn't feel self-evident is not learned.

Drill can also be used **proactively** for a `deep`-tagged objective the learner has never seen (status `unseen`). Skip repair framing: probe briefly, then teach the minimal tree to the goal. Passing questions alone never make such a row `solid`. It needs a generator in `notes.md`.

## 1. Load context
- `state.md`, `guidelines.md`.
- Ledger row(s) for the target, the syllabus line for it, and the matching `notes.md` area section (existing generators are what you build from).
- Do not load other areas.

## 2. Probe, briefly (bracket, don't interview)
The ledger already says roughly where it broke. Find the exact edge with a few questions, one at a time, each chosen from the last answer.
- **Enter near the top** of what the objective needs and let a miss walk you down. Don't warm up at the basics.
- Correct + confident → jump up. Correct + hesitant → fragile, step up gently. Wrong → narrow back in. A miss is one coordinate, not a verdict (slip, gap and misconception look the same), so probe around it. A wrong + confident answer is a committed misconception, so dig into its extent first.
- Stop when you can state: **floor** (what they reliably hold), **ceiling** (where it breaks) and the **misconception** if there is one. Do not ask "what's your goal". The goal is the syllabus objective.

## 3. Plan the minimal tree (think here, then tell the learner in 2–4 sentences)
- What does this objective actually depend on? What are the **unconditional truths** underneath (facts that can be accepted as-is, with no caveats)? A universal statement ("ALL X is done through Y") or a genuine definition is the strongest form. If a candidate needs hedging, dig deeper.
- Prune everything the probe showed they hold. Don't teach anything off the path, however interesting. The tree is the shortest derivation from floor to objective.
- Stress-test each root: is it a real foundation *for them*, or a disguised theorem that derives from something simpler?
- Present the plan in prose only (no diagram, no outline) and wait for a go.

## 4. Teach: one reasoning step at a time
Per step, in this rhythm: **predict → teach → check → repair-or-continue.**
1. **Predict** (optional, skip it when there's nothing to anticipate). Point at the problem with the current state and ask what has to give. A nudge, not a test. The attempt is the point. Resolve it explicitly when you teach: what they guessed, what's true, why.
2. **Teach one step.** One fact, attached to something already held by a single motivated move. If it needs two explanations to land, it's two steps. Lead with *why this exists* (the problem the design choice solves), so it feels discovered, not decreed. Foundations are simply asserted, plainly. Keep the connective tissue inside the prose. Don't announce the method or label turns as steps.
3. **Check, every step.** One scenario question that *applies* the step (a new case, a prediction, an extension), answerable by reasoning from what was just covered. Not a recitation. Build it so a miss names the wrong model. Ask for answer + confidence %, and welcome thinking aloud.
4. **A miss means the step didn't land.** Diagnose, repair and re-check *before* building anything on it. Never build on an unchecked step. Never rush a repair into one big paragraph.
- Choose Socratic (let them attempt the discovery) when they can plausibly reason their way there, expository when it is beyond cold reasoning or they are low on energy.
- **Keep it engaging: every turn ends with a question for the learner.** Never deliver two turns of pure explanation in a row. When a step needs explaining, keep the explanation short, then ask the learner to apply it or predict the next consequence. Default to Socratic: pose the motivating problem first, let the learner attempt it (thinking aloud is welcome), then resolve it. Go expository only when the topic is beyond cold reasoning.
- Be brief. Anything that doesn't install understanding is overhead.
- Verify any fact you aren't certain of against an authoritative source *before* teaching it. If it can't be resolved, say so plainly and mark it unverified in the note.

## 5. Harden: the click and the generators
(For `deep`-tagged concepts, write the generator to `data/shared/concepts.md` under its section, listing the objective IDs in every track that tests it. Check that file first in step 1 so you don't re-teach what is already there.)
When the steps are in place, ask them to show the **collapse**: which loose facts on this objective now follow from the base fact(s)? Then write the **generators** into the `notes.md` area section: the few base facts, plus what follows from each. Each is 1–3 lines. Replace and merge existing entries rather than appending (the file must stay small). Add the objective IDs each one explains.

## 6. Retest on fresh surfaces
(First, as a warm-up in step 2, re-ask up to 2 eligible `bank.md` items for this objective verbatim, per AGENTS.md "Question bank". The retest below stays fresh variants.) (practice, not teaching)
Pose 2–3 assessment-style questions on the repaired concept, using the `/quiz` craft (solve and shortcut-hunt first, never announce the target, believable distractors, key committed to `.session/key.md`). Use **fresh scenarios**, mix in one near-twin confusable from the ledger, and interleave with one earlier item from the same area so retrieval is real. Hold to the same hint ladder (one rung per request) and the same honest verdicts.

## 7. Write back (after each concluded step, so /clear is always safe)
- **bank.md**: add questions from this session that were missed, shaky, hint-heavy or surrendered; update streaks on re-asked items.
- **ledger.md**: update the row(s). `repaired` concepts go to `holding`, not `solid`. `solid` needs R+D+C shown, calibration `ok`, and a pass on a fresh-surface retest in a *later* `/quiz` session. Update `cal`, `miss`, `last` and the one-line misconception.
- **notes.md**: generators as above.
- **state.md**: remove repaired items from the drill queue, add anything new this uncovered, set the next action (usually `/quiz <track> <area> practice` to retest in a different session).
- **log.md**: append one entry of at most 4 lines.
- Delete `data/<track>/.session/`.
- End with the current readiness verdict from `state.md` (recompute it per AGENTS.md "Readiness" if the ledger changed it).
- Tell the learner what was repaired, what is still shaky, and the next action. Keep it short.

## Prohibitions
- Never lecture across several steps before one check.
- Never reveal what the learner can still generate. Verify the assumption behind a move before correcting it.
- Never re-ask in the same surface. Never re-teach what the probe showed they hold.
- Never mark a concept `solid` from the drill alone.
