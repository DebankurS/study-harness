# Method: derived from LearnHarness

Source: https://github.com/amosblomqvist/learnharness (AGPL-3.0). Parts of this repo's playbooks and of this file are adapted from its `docs/teaching-methodology.md` and `src/agent/prompts/{prober,teacher,practice,shared}`, with changes (see `NOTICE`). This file restates those ideas, adapted to goal-directed learning of any subject.

## 1. What carries over, and what changes

LearnHarness separates three jobs that most study tools blur together:

| Job | LearnHarness | Here |
|---|---|---|
| Find what the learner holds | Probe: bracket each strand with a floor and a ceiling | `/quiz` in practice mode is the probe. Every miss is a coordinate, and the ledger is the bracket. |
| Install understanding | Teach: one reasoning step at a time, predict, then teach, then check | `/drill` |
| Make knowledge available under test conditions | Practice: retrieve from inactive memory, interleave, fresh surfaces, honest verdicts | `/quiz` |

A track differs from open-ended tutoring in one way: the goal is fixed up front, in the syllabus. `/track-new` settles it once, from an authoritative source or with the learner, so later sessions never re-interview them. The "goal" step collapses into reading `syllabus.md`, and the minimal tree is the dependency path from what the ledger shows to the objectives the syllabus weights.

## 2. The principles, as applied

**Understanding is a graph, and the click comes from generators.** A track is full of loose facts such as limits, defaults and names. Memorised, they rot. The target is a few base facts from which many answers follow, for example "a security group is stateful, so return traffic is implicit". `notes.md` stores these generators, not flash-fact lists.

**One reasoning step at a time, and check every step.** A drill never lectures across several steps and then checks once. A miss is localised the moment it happens, and repaired before anything is built on it.

**Foundations are unconditional truths.** If a concept needs a base fact the learner doesn't hold, state it plainly, without caveats, and confirm it landed before building on it. If the base fact needs hedging, it isn't a foundation yet, so dig down.

**"How could I have discovered this?"** Facts feel arbitrary when there is no visible reason they had to be so. Each design choice in a service is motivated by a problem. Present the problem first, then the feature.

**Predict, then teach, then check.** The prediction motivates and opens the step. The check follows the teaching. They are different jobs and aren't interchangeable.

**Retrieval needs the target to be inactive.** A question about a concept named or taught moments ago measures comprehension, not availability. Questions must demand the concept from the situation alone. Hence: never announce the target, interleave domains by default, and retest on a fresh surface.

**Three question modes, in prerequisite order.** Recall (does it come to mind from a varied cue), Discrimination (does the right one beat a live confusable), Composition (does a multi-step scenario run as a whole). Failing a later layer often means the earlier one is weaker than it looked, so drop back and test it.

**Calibrate with confidence.** Every answer carries a stated confidence. Wrong with high confidence is a committed misconception, the strongest signal there is. Right with low confidence is fragile. This matters because real assessments punish confident wrong beliefs the most.

**Honest verdicts.** Never soften a wrong answer or inflate a right one. Classify every miss: cue miss (nothing came), discrimination error (wrong candidate won), execution slip, careless, or structural (the belief itself is wrong). Only structural misses need repair of the belief.

**Hints cost information.** One rung per request, least revealing first, and diagnose the first broken link. The rung needed is a difficulty readout.

**Commit before posing.** The agent solves each question and tries to shortcut it before the learner sees it. Then it fixes the key. This keeps verdicts consistent and catches broken questions.

**The system owns the logistics.** Finding the objectives, checking facts, choosing what to ask next and scheduling retests are the agent's job. The learner's effort goes into the material.

## 3. What we deliberately do not build

- No bank of every question asked. Only missed, shaky and surrendered questions are stored (`bank.md`, capped), and they never appear in full assessments.
- No numeric "mastery score" that pretends precision. The ledger records evidence (layer demonstrated, calibration, last seen) and a coarse status.
- No lectures. If a drill starts to feel like a lecture, it has stopped drilling.

## 4. Where each rule lives

| Rule | Skill |
|---|---|
| Syllabus-weighted selection, full vs practice, honest verdicts, hint ladder, fresh-surface retests | `/quiz` |
| Bracketing probe, minimal tree, predict-teach-check, generators, closing retest | `/drill` |
| Context budget, read order, write-back | `AGENTS.md` |
