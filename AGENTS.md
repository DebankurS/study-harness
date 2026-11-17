# Study harness: rules for any coding agent

Stateless, question-driven learning of any subject. Every session starts cold and learns where the learner stands only from files in `data/<track>/`. Those files are the only memory. Chat history is not.

A **track** is one learning goal (a certification, a language, a textbook, a skill). Its **syllabus** is what must be learned, taken from an authoritative source or derived from the goal. A **full assessment** is a complete, full-length test of the track.

## Running commands (any agent)

Each command is a playbook in `playbooks/<name>.md`. Claude Code exposes them as slash commands through `.claude/skills/`. In any other agent, when the user types a command or names one ("probe my rust-basics track"), open the playbook and follow it exactly with the arguments given.

At the start of a session run `sh scripts/status.sh` and follow its reminder.

| Command | Playbook | Purpose |
|---|---|---|
| `/track-new <track> [source]` | `playbooks/track-new.md` | Create `data/<track>/` from `templates/track/` and build the syllabus from a source, or from the learner's goal when there is none |
| `/probe <track> [area]` | `playbooks/probe.md` | One-time map of what you already know: bracket each objective with a floor and a ceiling, no teaching |
| `/quiz <track> [area\|mixed] [full\|practice] [N]` | `playbooks/quiz.md` | Questions graded honestly, results written to the ledger |
| `/drill <track> [concept-id]` | `playbooks/drill.md` | Repair and harden weak concepts: probe, teach one step at a time, then retest on fresh surfaces |
| `/status [track]` | `playbooks/status.md` | Read-only readout and recommended next session |

## State layout (per track, under `data/`)

```
data/<track>/
  state.md        HOT. <= 40 lines. Read first, rewritten at session end. Next action, drill queue, readiness.
  guidelines.md   Target, full-assessment length, question styles, pacing, traps. Small and rarely changes.
  syllabus.md     Objectives with stable IDs (e.g. 2.3) and area weights, and their source. Read by area slice only.
  ledger.md       One table row per syllabus ID: status, demonstrated layer, calibration, misconceptions, confusables.
  notes.md        The learner's distilled "generators" (few base facts that explain many), sectioned by area.
  bank.md         Missed and shaky questions, kept to be re-asked in later sessions. Max 40 active. Read by area slice.
  assessments.md  One row per full-length assessment. Source of the readiness verdict. Small; read whole.
  log.md          Append-only, one short entry per session. Never read in full.
data/shared/concepts.md   Generators for deep-understanding topics, learned once and reused across tracks.
```

`templates/` holds the blank versions. `data/` is created on first use and is never committed.

## Context discipline (non-negotiable)

1. Read order: `state.md`, then `guidelines.md`, then ONLY the syllabus, ledger and notes slices for the area in play. Slice with `grep`/`sed -n`, never load whole files for a one-area session.
2. Never read `log.md` beyond `tail -n 30`. The ledger and `state.md` already hold everything decision-relevant.
3. Question text is stored only in `bank.md`, and only for questions worth seeing again (missed, shaky, hint-heavy, surrendered). Everything else is generated fresh and not stored. Full assessments never use bank items and never write to it. See "Question bank" below.
4. Keep answer keys for the live session in `data/<track>/.session/` and delete it at session end. This stops drift or leakage after context compaction.
5. Write back at checkpoints (after each assessment block, each concluded problem, each drill step), not only at the end. Then clearing the conversation is always safe and the next session resumes from files.
6. `state.md` must stay under 40 lines. If it grows, compress it. The ledger holds detail.

## Deep-understanding topics

Some objectives are worth understanding, not just passing. List here the topic areas you want taught to the "feels obviously true" standard. Edit the list; empty means none.

- (your topic areas)

Ledger rows that cover them are tagged `deep` at the start of the misconception/confusable column, so sessions can find them with `grep deep`. For these rows:

- A miss in `/quiz` means "drill it now" (offer `/drill` right after the question), not just "queue it".
- A row can only become `solid` if a generator (a base fact that explains it) exists for it. Passing questions alone isn't enough.
- Anything the learner already holds stays in probe-and-move-on mode. Don't teach what is held.
- Generators live in `data/shared/concepts.md`, once per concept, with the objective IDs in each track that tests it. `/drill` reads the matching section first (a concept learned for one track counts for the others) and writes there, not into a track's own `notes.md`. In another track, a row whose concept is already in the shared file starts from `holding` once a fresh-surface retest passes, and never needs re-teaching.

## Question bank: repeating questions across sessions

Missed questions come back in later sessions. That doubles as informal spacing, with no scheduler.

- **What goes in:** in `/quiz`, `/drill` and `/probe`, any question that was a miss, right at <=50% confidence, needed R2 or higher hints, or was surrendered. Store stem, options, key, one-line why, each distractor's wrong model, verified date, and the objective IDs.
- **When it comes back:** at the start of a later `/quiz practice` session (and as a warm-up in `/drill` for the same objective), re-ask up to 3 eligible items for the in-scope rows, verbatim. Eligible means last asked on an earlier date. Oldest first, misses before shaky ones. Do not announce that it is a repeat unless asked.
- **Interpreting a repeat:** a right answer on a repeat only shows the learner remembers the question, not the concept. So a repeat hit never promotes a row to `holding` or `solid`. It counts toward the item's `streak`. After the learner gets the same item right at >=70% confidence in 2 separate sessions, ask a **fresh-surface variant** of the same concept once. If that is also right, retire the item and let the ledger row move up. A miss resets the streak.
- **Same session:** never repeat a question within the session it was asked. Closing retests stay fresh variants.
- **Hygiene:** cap 40 active items per track; when over, retire the oldest item whose row is `holding` or better. Re-verify an item's facts against an authoritative source if its verified date is older than 6 months or the source changed, and update or drop it.
- **Full assessments stay clean:** they use only new questions, so scores aren't inflated by memory. Bank items are excluded from the score math.

## Readiness: when to tell the learner they are done

A full assessment is always the track's full length (`Full assessment length:` in `guidelines.md`). `assessments.md` records each one. After every `/quiz`, `/drill` and `/status`, state a verdict:

- **READY** only if all hold: at least 5 full-length assessments done; the last 3 each score >= 80%; the average of the last 3 in every area is >= 70%; no `drill`-status row with a `struct` miss in an area weighing 15% or more; at least one assessment in the last 14 days; calibration is sound (high-confidence misses are under 15% of misses in the last 2). If the track has an external exam to book, call it **READY TO BOOK**.
- **CLOSE:** at least 3 full-length assessments and the last one >= 75%, or READY except for one criterion. Name that criterion.
- **NOT READY:** everything else. Name the blocker (too few assessments, a weak area, or a score below target).
- After 10 full assessments without READY, say the self-written assessments may be miscalibrated or the gaps are real, and recommend an independent check if one exists (an official practice test, sample questions, a reviewer, or building the real thing).
- The 80% and 70% thresholds are defaults, not official pass marks. Providers differ (some scale scores, some publish no pass mark), so 80% on these assessments is a margin, not a promise. The learner can change the numbers here. Assessments are written by the same model that teaches, so treat READY as a strong signal, not a guarantee.
- You cannot notify between sessions. The verdict appears at the end of every `/quiz`, `/drill` and `/status` reply.

## Target date: ASAP by default

Every track's target date is `ASAP` unless the learner volunteers a date. Never ask for one. ASAP means: pace for the shortest realistic path to the goal. Rank targets by weight times gap, favour assessment blocks and the highest-weight weak objectives over breadth, and move on to the next track as soon as the current track's areas are `holding` or better with calibrated confidence. Say when a track looks ready.

## Truthfulness

- Facts must be right. If a fact feels even slightly uncertain, verify it against an authoritative source (official documentation, standards, primary texts, or run it) before it goes into a question, answer key, hint or note. A wrong key grades the learner against a lie.
- If no authoritative source exists for a fact, say so and mark it unverified. Verdicts are never softened or inflated.
- Sources change. Record the source and its version and date in `syllabus.md`, and flag staleness.

## Method

The principles behind the playbooks are in `docs/method.md`. Each playbook carries the operative rules it needs.
