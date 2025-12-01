<!-- SPDX-FileCopyrightText: 2024 eTMA Handler Contributors -->
<!-- SPDX-License-Identifier: MIT -->

# Innovation Ideas

Wild ideas, moonshots, and things that could make this genuinely transformative.

## Philosophy

> "The best marking tool is the one you forget you're using."

Every feature should reduce friction, not add buttons.

---

## UX Innovations

### 1. The Two-Window Dance Killer

**Problem:** Tutors constantly switch between the student's work and the feedback form.

**Solution:** Split-pane interface with synchronized scrolling.

```
┌─────────────────────────┬─────────────────────────┐
│                         │                         │
│   Student Submission    │   Feedback/PT3 Form    │
│                         │                         │
│   [Click anywhere to    │   [Comments appear     │
│    add inline comment]  │    here automatically] │
│                         │                         │
│   ← Synchronized →      │   ← Scroll Position →  │
│                         │                         │
└─────────────────────────┴─────────────────────────┘
```

### 2. "Hot Zones" for Common Feedback

**Problem:** Same mistakes appear in the same places (intro, conclusion, references).

**Solution:**
- Track where you most frequently add comments
- Pre-populate comment suggestions based on document section
- "Students often struggle here" indicator

### 3. Gesture-Based Marking (Touch/Stylus)

**Problem:** Clicking is slow, especially on tablets.

**Solution:**
- Circle = highlight issue
- Strike = delete/wrong
- Checkmark = correct
- Squiggle = unclear
- Gestures convert to typed comments automatically

### 4. "Mark Like You Talk" Voice Mode

**Problem:** Typing feedback is slow, audio files are awkward.

**Solution:**
- Hold spacebar, speak feedback
- Auto-transcribe to text (local Whisper model)
- Keep audio attached as optional playback
- Student gets text + can hear your voice

### 5. Adaptive Interface

**Problem:** Different marking sessions have different needs.

**Solution:**
- "Quick feedback" mode (minimal UI, speed focus)
- "Deep review" mode (full annotation tools)
- "Batch processing" mode (queue-focused)
- Learn preferred mode per module/time of day

---

## Workflow Innovations

### 6. "Marking Playlist"

**Problem:** Context switching between assignments is costly.

**Solution:**
- Queue assignments like a music playlist
- "Shuffle" for variety
- "Similar first" to batch similar responses
- Progress bar with ETA
- "Now playing" shows current assignment

### 7. Consistency Guardian

**Problem:** First assignment gets detailed feedback, #20 gets a tired "good work."

**Solution:**
- Track feedback length/depth per assignment
- Alert when current feedback is much shorter than average
- "You usually comment on methodology here" prompts
- Post-batch review: "These 3 got less feedback than others"

### 8. Feedback Diff

**Problem:** Did I give the same feedback to two students who made the same mistake?

**Solution:**
- Compare feedback across students
- "You said X to Student A but Y to Student B for same issue"
- Ensure consistent messaging
- Generate "common issues" summary for cohort

### 9. Deadline Awareness

**Problem:** Marking crunch at deadline, idle time before.

**Solution:**
- Import submission deadlines
- Calculate ideal marking pace
- "Mark 3 per day to finish on time"
- Notifications when falling behind
- Suggest catch-up sessions

### 10. "Return Roulette" Prevention

**Problem:** Students get marked work back at random times (anxiety-inducing).

**Solution:**
- Batch release: mark all, return all at once
- Scheduled release: "Release at 9am Monday"
- Fairness mode: fastest submission doesn't get fastest return

---

## Intelligence Innovations

### 11. Pattern Detection (Local AI)

**Problem:** Same mistakes across cohort, but tutor types same feedback 20 times.

**Solution:**
- AI scans batch for common patterns
- "15 students made this error"
- Suggest bulk feedback
- Generate "common issues" document for module forum

### 12. Feedback Quality Analysis

**Problem:** Is my feedback actually helpful?

**Solution:**
- Analyze feedback for actionability
- "This comment describes the problem but not how to fix it"
- Suggest improvements
- Track your feedback patterns over time

### 13. Student Model (Privacy-Preserving)

**Problem:** No memory of student's previous work.

**Solution:**
- Local-only student history
- "This student struggled with X last time"
- Track improvement trajectory
- Never leaves your machine

### 14. Plagiarism Awareness (Not Detection)

**Problem:** Need to spot issues without expensive Turnitin.

**Solution:**
- Local similarity check against other submissions
- Highlight unusual vocabulary shifts
- Flag suspiciously different writing styles
- "This paragraph reads differently" indicator
- No external database, no student work uploaded anywhere

### 15. Rubric Learning

**Problem:** Rubrics are static, but common issues emerge.

**Solution:**
- Track which rubric criteria get most feedback
- Suggest rubric adjustments for future
- "90% of students lost marks here - is the rubric clear?"

---

## Technical Innovations

### 16. Delta Sync

**Problem:** Exporting/importing batches is all-or-nothing.

**Solution:**
- Track changes since last export
- "3 assignments marked since last upload"
- Export only changed files
- Conflict resolution for multi-tutor scenarios

### 17. Portable Database

**Problem:** Moving between machines is painful.

**Solution:**
- Single file database (CubDB)
- Copy file = copy everything
- Encrypted backup to USB/cloud
- Open on any machine, continue marking

### 18. Time Machine

**Problem:** Accidentally overwrote feedback.

**Solution:**
- Every save creates a checkpoint
- Browse history: "2 hours ago" / "yesterday"
- Diff view: what changed
- Restore any version
- Automatic, invisible, infinite (with cleanup)

### 19. Format Agnosticism

**Problem:** Students submit in weird formats.

**Solution:**
- Accept: .docx, .doc, .odt, .pdf, .rtf, .txt, .md, .html
- Convert to common internal format
- Preview without native app
- Export to tutor's preferred format

### 20. Keyboard-First Design

**Problem:** Mouse clicking is slow.

**Solution:**
- Full keyboard navigation
- Vim-style motions (optional)
- Command palette (Ctrl+K)
- Custom shortcuts for everything
- "Type to search" everywhere

---

## Community Innovations

### 21. Comment Library Marketplace

**Problem:** Good feedback comments are hard to write.

**Solution:**
- Share comment libraries anonymously
- "Download: STEM feedback pack"
- "Download: Essay writing comments"
- Rate and improve shared libraries
- No student data, just feedback templates

### 22. Module Templates

**Problem:** Every module has different marking schemes.

**Solution:**
- Community-contributed module templates
- Import: rubric + comment bank + PT3 format
- "TM112 marking pack" one-click setup
- Versioned, with changelog

### 23. Anonymous Analytics (Opt-in)

**Problem:** No data on how tutors actually mark.

**Solution:**
- Optional, anonymous aggregate stats
- "Average marking time for similar modules"
- "Most common feedback categories"
- Privacy-first: aggregate only, no individual data
- Helps OU improve tutor support

---

## Accessibility Innovations

### 24. Screen Reader Excellence

**Problem:** Most marking tools have terrible accessibility.

**Solution:**
- ARIA landmarks throughout
- Announce: current assignment, position, grade
- Describe images in submissions
- Voice control for navigation

### 25. Dyslexia Mode

**Problem:** Long submissions are hard to read.

**Solution:**
- OpenDyslexic font option
- Increased line spacing
- Bionic reading (bold first letters)
- Text-to-speech for student submissions

### 26. One-Handed Mode

**Problem:** RSI, injury, disability.

**Solution:**
- All actions accessible from keyboard
- Foot pedal support (next/previous/submit)
- Voice control integration
- Customizable single-hand layouts

---

## Moonshots

### 27. AR Marking (Future)

**Problem:** Physical paper assignments still exist.

**Solution:**
- Point phone at paper
- Overlay digital annotations
- Capture and digitize
- Return annotated PDF

### 28. Student Collaboration View

**Problem:** Students can't see their progress.

**Solution:**
- Optional "draft feedback" sharing
- Student sees work-in-progress comments
- Can respond/clarify before final
- Reduces "I didn't understand the feedback" issues

### 29. Cross-Module Insights

**Problem:** Tutors mark in isolation.

**Solution:**
- (With consent) Aggregate patterns across modules
- "Students who struggle with X also struggle with Y"
- Inform curriculum development
- Privacy-preserving aggregation only

### 30. "The Button"

**Problem:** When you're done marking, there should be joy.

**Solution:**
- Satisfying "complete batch" animation
- Stats: "You marked 23 assignments in 6.5 hours"
- Optional: celebratory sound
- Screenshot for sharing (no student data)

---

## Implementation Notes

### What's Feasible Now (Low Effort, High Impact)
- Split-pane interface
- Keyboard shortcuts
- Comment bank
- Batch release
- Time tracking

### What Needs Research
- Local AI integration
- Gesture recognition
- Voice transcription

### What's Long-Term
- AR marking
- Community marketplace
- Cross-module insights

---

## Contribute Ideas

Have an idea?

1. Open a GitHub Discussion
2. Tag it with `idea` label
3. Community votes
4. High-voted ideas get into roadmap

---

Last updated: 2024-12-01
