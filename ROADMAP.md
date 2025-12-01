<!-- SPDX-FileCopyrightText: 2024 eTMA Handler Contributors -->
<!-- SPDX-License-Identifier: MIT -->

# Roadmap

This document outlines the planned development direction for eTMA Handler.

## Current Version: 2.0.0

The BEAM edition is now feature-complete for basic marking workflows.

## Short Term (v2.1 - v2.3)

### v2.1 - Enhanced UI
- [ ] Dark mode support
- [ ] Keyboard shortcuts for common actions
- [ ] Customizable marking grid
- [ ] Bulk operations (select multiple, batch grade)

### v2.2 - Integration
- [ ] WebDAV sync for cloud storage
- [ ] Export to CSV/Excel
- [ ] Grade statistics dashboard
- [ ] Assignment templates

### v2.3 - Collaboration
- [ ] Multi-tutor support (shared database)
- [ ] Audit trail for changes
- [ ] Comments and annotations

## Medium Term (v3.0)

### Major Features
- [ ] Plugin system (WASM-based)
- [ ] Custom marking schemes
- [ ] Plagiarism detection hooks
- [ ] AI-assisted feedback suggestions (local models)

### Technical
- [ ] Raft consensus for multi-node
- [ ] CRDTs for offline sync
- [ ] Event sourcing

## Long Term (v4.0+)

### Vision
- Full offline-first distributed marking
- Integration with LMS platforms
- Accessibility compliance (WCAG 2.1 AA)

### Considerations
- RISC-V native builds
- Post-quantum cryptography by default
- Federation with other marking tools

## End of Life Policy

- Major versions: Supported for 2 years
- Security patches: Provided for supported versions
- Migration guides: Provided for breaking changes

## Not Planned

Items we've decided against:

- Cloud-hosted version (privacy concerns)
- Electron wrapper (prefer native web)
- Mobile app (web responsive is sufficient)

## How to Influence

1. Open GitHub Discussions for feature ideas
2. Vote on existing proposals
3. Submit RFCs for significant changes
4. Contribute implementations

---

Last updated: 2024-12-01
