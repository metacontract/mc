---
name: New Release
about: Create a pull request for new release
title: "[Release] vX.X.X"
labels: 'type: release, status: in-progress'
assignees: ''

---

## Overview

This pull request is to propose the new release of the `mc` project, including features and bug fixes. Please review the changes and provide feedback.
- [Release discussion]()

## Release Checklist

### Review and merge all related Pull Requests:

Ensure all tests pass and code is merged into `release` branch.

#### Breaking changes:

- [ ] [link to breaking change issue] or [short description]

#### Features:

- [ ] [link to feature request issue] or [short description]

#### Bug fixes:

- [ ] [link to bug report issue] or [short description]

### Update documentations:

- [ ] Update version number in relevant files
    - [ ] [CHANGELOG.md](../CHANGELOG.md)
    - [ ] [README.md](../README.md)
    - [ ] [package.json](../package.json)
    - [ ] [docs](../docs)

### Announces the release:

- [ ] Create Git tag and release notes
- [ ] Announce the release
    - [ ] [X](https://x.com/ecdysis_xyz)

### Merge and register the release
- [ ] Merge release branch into `main`
- [ ] Register the release on Soldeer

## Release Managers

- @username1
- @username2

Please review the changes, add any missing items, and follow the checklist to complete the release process. Ping the release managers with any questions or concerns.
