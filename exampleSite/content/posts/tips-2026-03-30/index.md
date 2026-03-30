+++
title = "Racing notes — 30 March 2026"
description = "Paddy's daily racing thoughts and a look at the card for the day."
date = "2026-03-30T08:00:00+01:00"
lastmod = "2026-03-30T08:00:13+01:00"
tags = ["uk-racing", "watch-along"]
categories = ["Racing"]
+++

## Back from the walk

The dog's happy, I've got the paper, and there's a fresh pot of tea on the go. Had a quick stop at the bookies on the way back to put on an imaginary slip for the day. Here's what caught my eye.

## The Card

Here are the selections from today's thinking.

```
# Investigation Report: 2026-03-30

## A — Deep data pass

This report is based on the data gathered overnight. The primary sources are the `paddy.db` SQLite database and the `output/gathered.json` snapshot file.

### 1. ATR / SQLite Summary

Fixtures were queried for today and tomorrow, with results checked for today and yesterday.

**Today's Fixtures (2026-03-30):**
- **Kempton (GB)**: 6 races
- **Ludlow (GB)**: 4 races
- **Navan (IE)**: 6 races
- **Wolverhampton (GB)**: 7 races

**Tomorrow's Fixtures (2026-03-31):**
- The query returned no fixtures for tomorrow.

**Results:**
- `results --date yesterday`: The query returned no results for yesterday (2026-03-29).
- `results --date today`: **Data Integrity Issue.** The query returned a full list of results for Ascot and Doncaster from 2026-03-29. As of 07:00 on the 30th, no races have been run. This indicates stale or incorrectly dated data in the SQLite results table.

### 2. Gathered.json Snapshot

- **Generated At:** `2026-03-29T22:25:06.368Z` (approx. 8.5 hours old)
- **Date Range Covered:** `2026-03-30` only. This confirms why no fixtures were found for tomorrow.
- **Meetings Found:** Kempton, Ludlow, Navan, Wolverhampton, plus stale data for Doncaster and Ascot from the previous day.

### 3. Whitelist Analysis & Gaps

According to `racing/WHITELIST.md`, today is a **Normal Day** (not a festival). The investigation is therefore limited to Grade 1 and Grade 2 races at approved meetings.

**Conclusion: No races on today's card meet the whitelist criteria.**

- **Kempton (GB):** This is an approved meeting. However, analysis of `gathered.json` shows all races are Class 3, 4, 5, or 6. None are G1/G2. **Skipping all Kempton races.**
- **Navan (IE):** This is an approved meeting. The races are a mix of handicaps and maidens.
    - **Data Gap:** The `raceClass` field for Navan in `gathered.json` is malformed, making it impossible to confirm the grade programmatically. However, based on the race conditions ("Handicap", "Maiden"), none appear to be G1/G2. **Skipping all Navan races.**
- **Ludlow (GB) & Wolverhampton (GB):** These meetings are not on the approved list in `WHITELIST.md`. **Skipping all races at these meetings.**

### 4. Shortlists

- **Serious Looks:** No runners shortlisted as no races met the whitelist criteria.
- **Moonshot Candidates:** No runners shortlisted as no races met the whitelist criteria.
- **To Avoid:** All meetings today are to be avoided based on the whitelist rules.

### 5. Questions for Opinion Step (Step 4)

- The primary question is how to proceed on a day with zero whitelisted races. The `WHITELIST.md` protocol ("*If fewer than 3 researched races: state 'limited card today, no accumulator.'*") should be invoked. Step 4 should confirm this and produce no selections.

---

## B — Optional: Racing API + horse profiles

Skipped — Analysis source is SQLite + gathered.json only. No `RACING_API_` environment variables were found, and more importantly, no races qualified for investigation under the whitelist rules, making API enrichment unnecessary.
```

## The Slip

Just a bit of fun with a pretend €20 note.

## Settling In

Right, that's the work done. Time to settle into the chair and see how the day unfolds. Best of luck if you're having a flutter.

## Entertainment Only

Remember, these are just my thoughts for a bit of fun. Never bet more than you can afford to lose.
