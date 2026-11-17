# /status

Argument: `$ARGUMENTS` → `[track]`. With no track, give the **cross-track view**. With a track, give the **single-track view**.

**Read-only. Do not write or edit anything.**

## Cross-track view (no argument)

For each folder in `data/` (skip `shared`), in alphabetical order:
1. `state.md` (verdict line, next action) and `assessments.md` (full assessment count, last three scores).
2. From `ledger.md` by `grep`: rows per status (`unseen`, `shaky`, `drill`, `holding`, `solid`) and the weakest area by weight-adjusted gap.
3. From `bank.md`: count of active items (`grep -c 'Status: active'`).
4. Recompute each **readiness verdict** per AGENTS.md "Readiness" (do not write it).

Report one compact table:

| Track | Verdict | Full assessments | Last 3 | Held (holding+solid / total) | Weakest area | Bank | Next |
|---|---|---|---|---|---|---|---|

Then, in at most 6 lines:
- **Focus:** suggest the track the learner has worked on most recently (newest `last` date in its ledger or newest log entry) so they can continue. If nothing has been started, suggest creating one with `/track-new`. Say once that any order is fine and that they can switch freely. Never refuse or discourage a track.
- **Shared concept progress:** count of entries in `data/shared/concepts.md` (`grep -c '^- \*\*'`), and which tracks have `deep`-tagged rows still `unseen`, `shaky` or `drill`.
- **Ready now:** any track whose verdict is READY. If it has an external exam (READY TO BOOK), say to check the exam provider's page for fees and format before booking.
- **Stale:** tracks with no session in 14 days (from the newest `last` date in the ledger).

## Single-track view (`/status <track>`)

1. Read `data/<track>/state.md` and `assessments.md`.
2. Count ledger rows by status per area from `ledger.md` using `grep`. Don't read notes or the log.
3. Flag stale ledger rows (`last` older than 14 days and status not `unseen`) and any syllabus older than ~6 months. The target date is ASAP by default and needs no flag. Flag a date only if the learner set one within 21 days.
4. Report the **readiness verdict** first (NOT READY, CLOSE or READY; READY TO BOOK when the track has an external exam) with the full assessment count, last three scores, weakest area, and exactly what is blocking.
5. Then in about 10 lines: readiness per area against its weight, the drill queue, over-confident misses (cal `over`), the bank count, and **one** recommended next command.

## Recommendation logic
- No `/probe` done yet (all rows `unseen`) → `/probe <track>`
- Queued `drill` items, especially `struct` or over-confident misses → `/drill <track>`
- Drills done recently but rows not yet confirmed → `/quiz <track> mixed practice 8`
- Most rows `holding` or `solid` → `/quiz <track> mixed full assessment` (full length)
- Stale rows → `/quiz <track> <area> practice` to retest
