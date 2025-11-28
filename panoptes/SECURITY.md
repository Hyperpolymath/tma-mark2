<!-- SPDX-FileCopyrightText: 2024 Panoptes Contributors -->
<!-- SPDX-License-Identifier: MIT -->

# Security Policy

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          | End of Life    |
| ------- | ------------------ | -------------- |
| 3.x.x   | :white_check_mark: | Active         |
| 2.x.x   | :white_check_mark: | 2025-06-01     |
| 1.x.x   | :x:                | 2024-01-01     |
| < 1.0   | :x:                | Not supported  |

**Note**: Only the latest patch version of each supported major/minor release receives security updates.

## Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability, please follow these steps:

### Reporting Process

1. **Do NOT** create a public GitHub issue for security vulnerabilities
2. Email security concerns to: `security@panoptes.example.com`
3. Use our PGP key for sensitive communications (see `.well-known/security.txt`)
4. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact assessment
   - Affected versions
   - Suggested fix (if any)
   - Your contact information for follow-up

### Response SLA (Service Level Agreement)

| Severity | Acknowledgement | Status Update | Resolution Target |
| -------- | --------------- | ------------- | ----------------- |
| Critical | 24 hours        | 48 hours      | 7 days            |
| High     | 24 hours        | 72 hours      | 14 days           |
| Medium   | 48 hours        | 7 days        | 30 days           |
| Low      | 72 hours        | 14 days       | 90 days           |

**Severity Definitions**:
- **Critical**: Remote code execution, authentication bypass, data breach potential
- **High**: Privilege escalation, significant data exposure, denial of service
- **Medium**: Information disclosure, cross-site scripting, CSRF
- **Low**: Minor information leakage, best practice violations

### What to Expect

1. **Acknowledgment**: Confirmation we received your report within SLA
2. **Assessment**: Security team evaluates severity and impact
3. **Coordination**: We'll work with you on timeline and disclosure
4. **Development**: Fix developed, tested, and reviewed
5. **Release**: Patch released with security advisory
6. **Credit**: Recognition in security advisory (unless you prefer anonymity)

## Security Features

### Local Processing (Privacy by Design)

Panoptes processes all files locally. No data is sent to external servers unless you explicitly configure remote Ollama endpoints. This is by design to protect your privacy.

### Memory Safety

- Written in Rust with strict memory safety guarantees
- `#![forbid(unsafe_code)]` enforced across codebase
- No direct memory manipulation

### File Permissions

- Panoptes respects file system permissions
- Operations performed with user's privileges only
- No privilege escalation mechanisms
- Files are renamed, never deleted (reversibility)

### Database Security

- SQLite database stored in user-accessible location only (`~/.local/share/panoptes/`)
- No plaintext passwords or secrets stored
- Database can be encrypted at filesystem level
- JSONL history provides audit trail

### Network Security

- Default: Localhost-only Ollama communication (no network exposure)
- Support for HTTPS when using remote endpoints
- No telemetry, analytics, or phone-home
- No external dependencies at runtime

### Code Security

- `unsafe` code forbidden: `#![forbid(unsafe_code)]`
- Dependencies audited: `cargo audit` in CI/CD
- Static analysis: `cargo clippy --deny warnings`
- SPDX headers on all source files for license compliance
- Supply chain: All dependencies pinned in `Cargo.lock`

### Container Security

- Chainguard Wolfi base images (minimal attack surface)
- Non-root user by default
- Read-only filesystem where possible
- No privileged containers
- Rootless Podman compatible

## Security Best Practices

When using Panoptes:

1. **Keep Updated**: Always use the latest patch version
2. **Secure Ollama**: If exposing Ollama externally, use authentication
3. **File Permissions**: Restrict access to config files (`chmod 600`)
4. **Database Location**: Store database in encrypted volume if handling sensitive files
5. **Watch Directories**: Only watch directories you control
6. **Network**: Keep Ollama on localhost unless necessary
7. **Containers**: Run rootless, don't mount sensitive directories

## Vulnerability Disclosure Policy

We follow coordinated vulnerability disclosure:

1. **Receipt**: Report received and acknowledged
2. **Triage**: Vulnerability verified and severity assessed
3. **Development**: Fix developed in private branch
4. **Testing**: Fix tested across supported versions
5. **Advisory**: Security advisory prepared (CVE if warranted)
6. **Release**: Fix released to all supported versions
7. **Disclosure**: Public disclosure 7 days after patch availability

### Disclosure Timeline

- **Day 0**: Report received
- **Day 1-7**: Assessment and fix development
- **Day 7-14**: Testing and advisory preparation
- **Day 14**: Coordinated release
- **Day 21**: Public disclosure

We may accelerate this timeline if the vulnerability is already public or being actively exploited.

## Security Audits

We welcome security audits and penetration testing:

- Contact us before conducting tests
- Scope: Panoptes codebase and official containers
- Out of scope: Third-party dependencies, Ollama itself
- Share findings for coordinated disclosure

## Bug Bounty

We don't currently offer a formal bug bounty program. However, we recognize and appreciate security researchers:

- Hall of Fame recognition
- Swag (stickers, t-shirts) for significant findings
- Letters of appreciation for professional portfolios

## Hall of Fame

We thank the following security researchers for responsibly disclosing vulnerabilities:

| Researcher | Date | Severity | CVE |
| ---------- | ---- | -------- | --- |
| (Your name could be here) | - | - | - |

## Contact

- **Security Email**: security@panoptes.example.com
- **PGP Key**: See `.well-known/security.txt`
- **security.txt**: `/.well-known/security.txt`

---

**Last updated**: 2024-12-01
**Policy version**: 2.0.0
