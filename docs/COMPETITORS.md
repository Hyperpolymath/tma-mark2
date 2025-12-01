<!-- SPDX-FileCopyrightText: 2024 eTMA Handler Contributors -->
<!-- SPDX-License-Identifier: MIT -->

# Competitor Analysis

Understanding the landscape to build something better.

## TL;DR

| Tool | Model | Strength | Weakness | Our Advantage |
|------|-------|----------|----------|---------------|
| OU eTMA Handler | Proprietary | OU integration | Windows-only, Java, clunky | Cross-platform, no deps |
| Gradescope | SaaS ($$$) | AI grouping | Institutional pricing | Free, local, privacy |
| Turnitin | SaaS ($$$) | Plagiarism DB | Expensive, vendor lock-in | Open source, local |
| Moodle | Self-hosted | Full LMS | Complex, overkill for marking | Focused, simple |
| Canvas | SaaS/hosted | SpeedGrader UX | Requires LMS adoption | Standalone tool |
| Blackboard | SaaS | Bb Annotate | Enterprise complexity | Lightweight |
| OK (okpy) | Open source | Code grading | Dev-focused | General assignments |
| Submitty | Open source | Comprehensive | Complex setup | Single binary |

---

## Commercial Platforms

### Gradescope (by Turnitin)

**Website:** [gradescope.com](https://www.gradescope.com/)

**What they do well:**
- AI-assisted answer grouping (similar answers clustered)
- Question-by-question marking (faster than student-by-student)
- Handwriting recognition for scanned assignments
- Rubric-based grading with point allocation
- Regrade request workflow

**What they do poorly:**
- Institutional licensing only (no individual tutors)
- Expensive (contact sales = $$$)
- Cloud-only (privacy concerns for student data)
- Requires uploading all student work to their servers

**Steal these ideas:**
- [ ] Group similar answers for efficient marking
- [ ] Question-by-question view option
- [ ] Student regrade request workflow

---

### Turnitin (Feedback Studio)

**Website:** [turnitin.com](https://www.turnitin.com/)

**What they do well:**
- QuickMarks: Reusable comment pins (drag & drop)
- Massive plagiarism database
- Voice comments
- PeerMark for peer review
- Downloadable/shareable QuickMark sets

**What they do poorly:**
- Extremely expensive
- Vendor lock-in nightmare
- Requires institutional contract
- Students hate having their work added to the database
- Similarity scores cause false positives/anxiety

**Steal these ideas:**
- [ ] QuickMarks-style reusable comments
- [ ] Shareable comment libraries
- [ ] Voice/audio feedback inline
- [ ] Drag-and-drop comment placement

---

### Blackboard (Bb Annotate)

**Website:** [blackboard.com](https://www.blackboard.com/)

**What they do well:**
- Content Library: Bank of reusable comments
- Drawing tools for annotation
- Inline grading in browser
- Multiple annotation colors
- Sidebar summary view

**What they do poorly:**
- Enterprise complexity
- Requires full Blackboard LMS
- Interface is dated
- Student experience often confusing

**Steal these ideas:**
- [ ] Content library with search
- [ ] Sidebar summary of all comments
- [ ] Color-coded annotation categories

---

### Canvas (SpeedGrader)

**Website:** [instructure.com/canvas](https://www.instructure.com/canvas)

**What they do well:**
- Clean, fast grading interface
- Comment bank (save comments for reuse)
- Rubric integration
- Anonymous grading option
- Media comments (video/audio)

**What they do poorly:**
- Requires Canvas LMS
- Institutional licensing
- Can't use standalone

**Steal these ideas:**
- [ ] Anonymous grading mode
- [ ] Media comments (video feedback)
- [ ] Clean, minimal interface design

---

## Open Source Alternatives

### Submitty

**Website:** [submitty.org](https://submitty.org/) | [GitHub](https://github.com/Submitty/Submitty)

**What they do well:**
- Fully open source
- Autograding for code
- TA grading interface
- Plagiarism detection
- Docker deployment

**What they do poorly:**
- Complex installation (Docker, multiple services)
- Focused on CS courses
- Requires server infrastructure
- Not designed for document marking

**Learn from them:**
- [ ] Their TA grading UX patterns
- [ ] Plagiarism detection approach
- [ ] Grade release workflow

---

### OK (okpy)

**Website:** [okpy.org](https://okpy.org/) | [GitHub](https://github.com/okpy/ok)

**What they do well:**
- Self-hostable
- Language-agnostic autograder
- View solutions and leave comments
- Open source (Apache 2.0)

**What they do poorly:**
- Focused on programming assignments
- Not suitable for essay/document marking
- Dated interface

**Learn from them:**
- [ ] Self-hosting simplicity
- [ ] Inline comment system

---

### Open Grades

**Website:** [GitHub](https://github.com/RaFaTEOLI/open-grades)

**What they do well:**
- Laravel-based (familiar stack for many)
- Grade management
- Class calendars
- MIT licensed

**What they do poorly:**
- Still in development (v1 ETA mid-2025)
- Grade tracking, not marking/feedback
- No annotation features

---

### OpenGrade

**Website:** [lightandmatter.com/ogr](https://www.lightandmatter.com/ogr/ogr.html)

**What they do well:**
- Simple grade tracking
- Can post grades online
- GPL licensed
- Runs on Linux

**What they do poorly:**
- Gradebook only (no marking interface)
- Very basic functionality
- Dated UI

---

### Gradeer

**Website:** [GitHub](https://github.com/ben-clegg/gradeer)

**What they do well:**
- Modular hybrid grading
- Research-backed design
- Supports tutors with data on performance

**What they do poorly:**
- Academic research project
- Limited real-world adoption
- Focused on code grading

---

## Annotation & Markup Tools

### eMarking Assistant

**Website:** [emarkingassistant.com](http://emarkingassistant.com/)

**What they do well:**
- Reusable feedback comment banks
- Audio comments in Word
- Rubric-O-Matic for automated rubrics
- Plagiarism search integration
- Works with Microsoft Word

**What they do poorly:**
- Windows/Word dependent
- Not cross-platform
- Tied to Office ecosystem

**Steal these ideas:**
- [ ] Audio comment insertion
- [ ] One-click plagiarism search
- [ ] Automated rubric generation

---

### PDF Annotation Tools

**General tools:** iLovePDF, Xodo, Drawboard PDF, Adobe Acrobat

**What they do well:**
- Universal PDF markup
- Drawing, highlighting, commenting
- Work offline
- Cross-platform (mostly)

**What they do poorly:**
- Not education-focused
- No rubric integration
- No comment banking
- No grade calculation
- No batch processing

**Learn from them:**
- [ ] Smooth annotation UX
- [ ] Touch/stylus support
- [ ] PDF rendering quality

---

### Markup Hero

**Website:** [markuphero.com](https://markuphero.com/)

**What they do well:**
- Simple screenshot/document annotation
- Shareable markup
- Works in browser

**What they do poorly:**
- Not designed for grading
- No rubrics or grades
- Limited organization

---

## LMS Platforms (For Context)

### Moodle

**What they do well:**
- Open source
- Offline grading mode
- Annotate PDF built-in
- Massive plugin ecosystem
- Self-hostable

**What they do poorly:**
- Complex to set up
- Overkill for just marking
- UI can be confusing
- Plugin quality varies

**Moodle's grading UX research:** [Assignment Grading UX](https://docs.moodle.org/dev/Assignment_Grading_UX)

Key UX insights from Moodle:
- Action buttons should be static/accessible
- Resizable columns for annotation vs. marking form
- "The most common thing a teacher will want to do is grade"

---

## AI-Powered Tools (Emerging)

### CoGrader

- Rubric-based essay grading
- State standards alignment
- Fast and affordable
- Focus: Essays only

### Edcafe AI

- Rubric support
- Customizable feedback
- Downloadable reports

### FeedbackFruits

- AI-generated feedback suggestions
- Pre-written feedback for common mistakes
- Import criteria from other assignments

### Cognii

- Chatbot-style AI tutor
- Real-time feedback
- Enterprise focused

**Our approach to AI:**
- Local models only (Ollama, llama.cpp)
- AI suggests, human decides
- No student data leaves the machine
- Optional, not required

---

## The OU's Current Stack

### OU eTMA File Handler

**Problems we're solving:**
1. Windows-only (Mac users need VMs)
2. Requires Java 6 (ancient)
3. "The file handler software is very stupid"
4. Very particular about filenames
5. Limited context menu options
6. No native Mac/Linux support

### PT3 Form System

**Problems we're solving:**
1. Manual template attachment
2. Zip/unzip workflow
3. Inconsistent return timing
4. No batch release option

### Word Compatibility Issues

**Problems we're solving:**
1. .doc vs .docx conversion destroys layout
2. Track changes incompatible across versions
3. Custom styles "cause more problems than they're worth"
4. LibreOffice/OpenOffice users get garbled feedback

---

## Competitive Positioning

```
                    ┌─────────────────────────────────────┐
                    │           CLOUD/SaaS                │
                    │  (Gradescope, Turnitin, Canvas)     │
        ┌───────────┼─────────────────────────────────────┼───────────┐
        │           │                                     │           │
        │ COMPLEX   │                                     │  SIMPLE   │
        │           │                                     │           │
        │  Moodle   │                                     │  eTMA     │
        │  Submitty │                                     │  Handler  │
        │           │                                     │  ★ US ★   │
        │           │                                     │           │
        ├───────────┼─────────────────────────────────────┼───────────┤
        │           │          LOCAL/OFFLINE              │           │
        │           │                                     │           │
        └───────────┴─────────────────────────────────────┴───────────┘
```

**Our niche:** Simple, local, offline-first, cross-platform, privacy-respecting.

---

## Feature Gap Analysis

Features competitors have that we need:

| Feature | Gradescope | Turnitin | Canvas | Us |
|---------|------------|----------|--------|-----|
| Reusable comments | ✓ | ✓ (QuickMarks) | ✓ | Planned |
| Audio feedback | ✓ | ✓ | ✓ | Planned |
| Rubric grading | ✓ | ✓ | ✓ | Planned |
| Offline mode | ✗ | ✗ | ✗ | ✓ |
| Self-hosted | ✗ | ✗ | ✗ | ✓ |
| Free for individuals | Limited | ✗ | ✗ | ✓ |
| Cross-platform native | Web | Web | Web | ✓ |
| No account required | ✗ | ✗ | ✗ | ✓ |
| Open source | ✗ | ✗ | ✗ | ✓ |

---

## Sources

- [Gradescope](https://www.gradescope.com/)
- [Turnitin](https://www.turnitin.com/)
- [Best AI Marking Tools 2025](https://cloudassess.com/blog/best-ai-marking-tools/)
- [Best Automated Grading Systems](https://tutorai.me/blog/best-automated-grading-systems/)
- [Submitty GitHub](https://github.com/Submitty/Submitty)
- [OK GitHub](https://github.com/okpy/ok)
- [Moodle Grading UX](https://docs.moodle.org/dev/Assignment_Grading_UX)
- [eMarking Assistant](http://emarkingassistant.com/)
- [OU eTMA Guidance](http://www.pcurtis.com/etutor.htm)

---

Last updated: 2024-12-01
