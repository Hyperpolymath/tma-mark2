<!-- SPDX-FileCopyrightText: 2024 eTMA Handler Contributors -->
<!-- SPDX-License-Identifier: MIT -->

# Roadmap

This document outlines the planned development direction for eTMA Handler.

## Vision

**Kill every pain point that makes tutors hate marking.**

Replace the clunky, Windows-only, Java-dependent, Word-mangling legacy tools with something that sparks joy (or at least doesn't spark rage).

## Current Version: 2.0.0

The BEAM edition provides basic marking workflows. Now we make it actually good.

---

## Phase 1: Foundation (v2.1 - v2.3)

### v2.1 - Cross-Platform Nirvana
*Kill: Platform lock-in, Java hell, runtime dependencies*

- [ ] Burrito builds for Linux, macOS (Intel + ARM), Windows
- [ ] Zero-dependency installer (no JRE, no runtime)
- [ ] Flatpak for Linux (Flathub submission)
- [ ] Homebrew formula for macOS
- [ ] Winget manifest for Windows
- [ ] Automatic updates (optional, privacy-respecting)

### v2.2 - Native .fhi Mastery
*Kill: File handler stupidity, format conversion nightmares*

- [ ] Bulletproof .fhi parser (handle malformed files gracefully)
- [ ] Accept any valid .fhi regardless of filename
- [ ] Preview submissions without Word
- [ ] Extract/view all embedded content
- [ ] Batch import entire marking batch
- [ ] Drag-and-drop support

### v2.3 - Built-in Annotation System
*Kill: Track changes hell, Word dependency, accessibility issues*

- [ ] Web-native annotation layer (not Word dependent)
- [ ] Inline comments with rich text
- [ ] Highlight, strikethrough, margin notes
- [ ] Drawing/sketch tools for diagrams
- [ ] Audio feedback recording (inline voice notes)
- [ ] Export to clean .docx, PDF, or HTML
- [ ] Accessible output (screen reader friendly)

---

## Phase 2: Workflow Revolution (v2.4 - v2.6)

### v2.4 - Comment Bank & Templates
*Kill: Repetitive typing, inconsistent feedback*

- [ ] Reusable comment library (like Turnitin QuickMarks)
- [ ] Searchable comment bank with tags
- [ ] Keyboard shortcuts for frequent comments
- [ ] Share comment banks between tutors
- [ ] Import/export comment libraries
- [ ] Variable interpolation (`{{student_name}}`, `{{assignment}}`)
- [ ] Module-specific comment sets

### v2.5 - Rubric Engine
*Kill: Subjective marking, inconsistent standards*

- [ ] Import rubrics from CSV/JSON/YAML
- [ ] Visual rubric builder
- [ ] Analytic rubrics (multi-criteria)
- [ ] Single-point rubrics
- [ ] Auto-calculate grades from criteria
- [ ] Rubric-linked comments (click criterion → insert feedback)
- [ ] Per-question rubrics
- [ ] Module marking guide integration

### v2.6 - PT3 Reimagined
*Kill: Manual form attachment, zip dance*

- [ ] Auto-generate feedback forms
- [ ] Customizable PT3 templates
- [ ] One-click export (script + PT3 + summary)
- [ ] Bulk export entire batch
- [ ] OU system format compliance
- [ ] Preview before export

---

## Phase 3: Intelligence Layer (v2.7 - v2.9)

### v2.7 - Batch Management
*Kill: Inconsistent return timing, student anxiety*

- [ ] Queue dashboard (see all assignments at once)
- [ ] Mark in any order, release when ready
- [ ] Batch release (return all at same time)
- [ ] Progress tracker per student
- [ ] Deadline warnings
- [ ] Status labels (received, in progress, marked, released)

### v2.8 - Time & Workload Analytics
*Kill: Rushed marking, workload blindness*

- [ ] Time tracking per assignment (non-invasive)
- [ ] Average marking time by module/question
- [ ] Workload predictions
- [ ] Pace yourself reminders
- [ ] Break suggestions (Pomodoro optional)
- [ ] Export time logs (for workload discussions)

### v2.9 - AI Assistance (Local)
*Kill: Writer's block, missed feedback opportunities*

- [ ] Local LLM integration (Ollama, llama.cpp)
- [ ] Feedback suggestions (never auto-applied)
- [ ] Grammar/clarity check for tutor comments
- [ ] Summarize student submissions
- [ ] Flag potential plagiarism patterns
- [ ] Generate draft feedback (tutor approves/edits)
- [ ] **All AI runs locally - no cloud, no data leak**

---

## Phase 4: Ecosystem (v3.0)

### v3.0 - Plugin Architecture
*Enable the community to extend*

- [ ] WASM-based plugin system
- [ ] Plugin marketplace (community contributed)
- [ ] Custom file format handlers
- [ ] Custom annotation tools
- [ ] LMS connectors (Moodle, Canvas, Blackboard)
- [ ] Export format plugins
- [ ] Theme plugins

### Integration Possibilities
- [ ] Turnitin similarity check (optional integration)
- [ ] WebDAV sync for cloud backup
- [ ] CalDAV for deadline integration
- [ ] Webhook notifications
- [ ] API for institutional systems

---

## Phase 5: Future (v4.0+)

### Distributed Marking
- [ ] Multi-tutor collaboration (shared database)
- [ ] Raft consensus for distributed sync
- [ ] CRDTs for offline-first conflict resolution
- [ ] Event sourcing for audit trail
- [ ] Federation with other marking tools

### Accessibility Excellence
- [ ] WCAG 2.1 AA compliance
- [ ] Screen reader optimized
- [ ] High contrast themes
- [ ] Keyboard-only navigation
- [ ] Voice control support

### Technical Future-Proofing
- [ ] RISC-V native builds
- [ ] ARM64 optimization
- [ ] Post-quantum cryptography option
- [ ] SBOM auto-generation
- [ ] Reproducible builds verification

---

## Feature Priority Matrix

| Feature | Pain Killed | Effort | Impact | Priority |
|---------|-------------|--------|--------|----------|
| Cross-platform binary | Platform lock-in | Medium | Critical | P0 |
| Native .fhi parsing | File handler issues | Medium | Critical | P0 |
| Built-in annotation | Word dependency | High | Critical | P1 |
| Comment bank | Repetitive typing | Low | High | P1 |
| Rubric engine | Inconsistent marking | Medium | High | P1 |
| PT3 generation | Manual workflow | Low | High | P1 |
| Batch management | Return timing | Medium | Medium | P2 |
| Time tracking | Workload issues | Low | Medium | P2 |
| Local AI assist | Feedback quality | High | Medium | P3 |
| Plugin system | Extensibility | High | Medium | P3 |

---

## Anti-Features (Not Planned)

Things we've deliberately decided against:

- **Cloud-hosted version** - Privacy is non-negotiable
- **Mandatory accounts** - Works without login
- **Telemetry** - Zero data collection
- **Electron wrapper** - Native web, not 200MB Chrome
- **Subscription model** - Free forever, MIT licensed
- **AI that auto-grades** - AI assists, human decides
- **Social features** - It's a marking tool, not LinkedIn

---

## How to Influence

1. Open GitHub Discussions for feature ideas
2. Vote on existing proposals with 👍
3. Submit RFCs for significant changes
4. Contribute implementations
5. Report pain points from your marking experience

---

## Competitor Learnings Applied

Lessons from existing tools (see COMPETITORS.md):

| Tool | Good Idea We'll Take | Bad Idea We'll Avoid |
|------|---------------------|---------------------|
| Gradescope | Question-by-question marking, similar answer grouping | Institutional pricing wall |
| Turnitin QuickMarks | Reusable comment pins | Vendor lock-in |
| Blackboard Annotate | Content library for comments | Clunky interface |
| Canvas SpeedGrader | Comment bank | Requires LMS |
| eMarking Assistant | Audio comments, plagiarism search | Word dependency |
| Moodle | Offline grading mode | Complex setup |
| OK (okpy) | Self-hosted, open source | Focused on code only |
| Submitty | Comprehensive open source | Complex deployment |

---

Last updated: 2024-12-01
