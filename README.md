# Study harness

A small, agent-neutral harness for learning anything through questions. It maps what you already know, teaches one reasoning step at a time, drills weak spots, and tests you with honest verdicts. It works for a certification, a language, a textbook or a skill, with or without an official syllabus. Built on ideas from [LearnHarness](https://github.com/amosblomqvist/learnharness).

Every session is **stateless**. A session learns where you stand only from the files in `data/<track>/`. You can clear the conversation at any time and resume from those files.

## Quick start

**You need:** a coding agent that can read files, run shell commands and follow written instructions (Claude Code, Codex, Cursor, Gemini CLI and similar). Claude Code also gets slash commands.

1. **Get the repo.** Clone, fork or download it, and open your agent in that folder.
2. **Load the rules.** Claude Code reads `CLAUDE.md`, which imports `AGENTS.md`. Most other agents read `AGENTS.md` automatically. If yours doesn't, start with: *"Read AGENTS.md and follow it."*
3. **Create a track,** one per learning goal:
   - Claude Code: `/track-new <slug> [source]`
   - Any other agent: *"Follow playbooks/track-new.md for `<slug>`, source: `<...>`"*
   - Examples: `/track-new rust-basics`, or `/track-new my-exam https://example.com/exam-guide.pdf`.

   It asks up to four questions about your goal. If a source exists (an exam guide, a course outline, a book, official docs) it builds the syllabus from that source only. If none exists, it derives a syllabus from your goal, cross-checks it against references, marks it **self-derived**, and asks you to approve it.
4. **Map what you know, once:** `/probe <slug>`. One question at a time, no teaching, so the ledger learns your floor and ceiling per objective.
5. **Study loop:** `/drill <slug>` to repair and teach the top gap, then `/quiz <slug> mixed practice 8` every few drills to retest on fresh questions.
6. **Check readiness:** full-length assessments with `/quiz <slug> mixed full`, and `/status <slug>` any time for the verdict and the next step.

In an agent without slash commands, name the playbook instead: *"Follow playbooks/probe.md for `<slug>`."* At the start of each session the agent runs `sh scripts/status.sh`, which lists every track's verdict and next command.

### Answering questions

Reply with the answer plus a confidence %, for example `B 70`, and optionally your reasoning. Multi-select: `AC 60`. "I don't know" is a valid answer and is recorded as a gap, not a miss. Type the option itself, not a position, so a slip is easy to tell from a gap. Confidence matters: a wrong answer at high confidence is the strongest sign of a misconception.

## Customize

All three live in `AGENTS.md`:

- **Deep-understanding topics:** list the topic areas you want taught until they feel obviously true, not just passed. Matching rows get a `deep` tag. Leave it empty if you only want the objectives covered.
- **Readiness:** the thresholds for "ready" (80% on the last three full assessments, 70% per area, and so on) are defaults. Edit them to suit you.
- **Target date:** defaults to `ASAP` (the shortest realistic path). Change it if you want date-based pacing.

## Commands

| Command | Playbook | What it does |
|---|---|---|
| `/track-new <slug> [source]` | `playbooks/track-new.md` | Creates a track and its syllabus, from a source or from your goal. |
| `/probe <track> [area]` | `playbooks/probe.md` | One question at a time. Finds the floor and ceiling of each objective. No teaching. Run once per track. |
| `/drill <track> [id]` | `playbooks/drill.md` | Probes briefly, teaches one reasoning step at a time (predict, teach, check), writes generators to notes, retests on fresh questions. Every turn ends with a question. |
| `/quiz <track> [area\|mixed] practice [N]` | `playbooks/quiz.md` | One question at a time with hints and honest verdicts. Retests misses on fresh scenarios. |
| `/quiz <track> mixed full` | `playbooks/quiz.md` | A full-length assessment. No feedback until the end. Logged in `assessments.md`. |
| `/status [track]` | `playbooks/status.md` | Read-only. Readiness verdict, drill queue, next command. With no track, a cross-track table. |

## Layout

```
AGENTS.md                  Rules every session follows (agent-neutral)
CLAUDE.md                  Imports AGENTS.md for Claude Code
playbooks/                 One markdown playbook per command
.claude/skills/            Thin Claude Code wrappers that point at the playbooks
.claude/settings.json      Runs scripts/status.sh at session start (Claude Code)
scripts/status.sh          Prints each track's verdict and next action (read-only)
templates/track/           Blank track files, copied by /track-new
templates/shared/          Blank shared-concepts file
docs/method.md             The principles behind the playbooks
data/                      Your tracks (created on first use, not committed)
  <track>/
    state.md               Hot file (<40 lines): next action, readiness verdict, drill queue
    guidelines.md          Target, full-assessment length, question style, known traps
    syllabus.md            Objectives with IDs and weights, and their source
    bank.md                Missed and shaky questions, re-asked in later sessions
    ledger.md              One row per objective: status, floor/ceiling, calibration, misconception
    notes.md               Your generators: a few base facts that explain many answers
    assessments.md         One row per full-length assessment
    log.md                 Append-only session log
  shared/concepts.md       Concepts learned once, reused by every track
```

## How "ready" is decided

At the end of every `/quiz`, `/drill` and `/status`, you get a verdict. **READY** needs: at least 5 full-length assessments; the last 3 each at 80% or higher; every area averaging 70% or higher over those; no open misconception in an area worth 15% or more; an assessment in the last 14 days; and high-confidence misses under 15% of misses. For a track with an external exam it is called **READY TO BOOK**. The numbers are defaults, editable in `AGENTS.md`. They are not official pass marks. The assessments are written by the same model that teaches, so treat READY as a strong signal, not a guarantee.

## Principles worth remembering

- A fact you can recite but doesn't feel obvious is memorised, not learned. `/drill` aims for the click: loose facts collapsing into a few base facts.
- Retrieval needs the answer to be inactive. Questions never name their target, topics interleave, and retests within a session use fresh scenarios.
- Missed and shaky questions return verbatim in later sessions (that's the spacing). A repeat hit only shows you remember the question, so it never promotes a row; after two good repeats a fresh variant has to pass. Full assessments always use new questions.
- Wrong with high confidence is a committed misconception, the strongest signal. Honest verdicts are the point.
- Rows tagged `deep` are taught to understanding, not just tested. `solid` needs a generator for them.
- Only `/quiz` in a later session can promote a row to `solid`.

## Troubleshooting

- **The status script prints no tracks:** expected on a fresh copy. Run `/track-new`.
- **A session seems to forget things:** it is stateless on purpose. Check that `data/<track>/state.md` and `ledger.md` were written at the last checkpoint.
- **A fact in a question looks wrong:** sources change. Record it in `state.md` under "Open flags", and re-check the syllabus against its source.
- **A self-derived syllabus feels off:** edit `syllabus.md` and the ledger rows directly. The IDs only need to stay stable.

## Known gaps (planned, not built)

- **Spaced review scheduling.** Not built, by choice. Repeating banked questions in later sessions stands in for it.
- **Fact flashcards** for quotas, limits and defaults, which Socratic drilling suits badly.
- **Worked examples** for topics that are brand new to you, instead of forcing Socratic questions on them.

## Licence and credits

Licensed under the **GNU Affero General Public License v3.0** (see `LICENSE`). This project adapts parts of [LearnHarness](https://github.com/amosblomqvist/learnharness), also AGPL-3.0, mainly in `playbooks/probe.md`, `playbooks/drill.md` and `docs/method.md`; see `NOTICE`. If you fork or redistribute, keep `LICENSE` and `NOTICE`, and share your changes under the same licence.
