# Contributing Guideline

Thank you for your interest in contributing to meta contract! We welcome contributions from everyone, whether it's reporting an issue, submitting a pull request, or suggesting improvements.

## Reporting Issues

If you encounter a bug or have a feature request, please use the provided templates when [opening a new issue](https://github.com/metacontract/mc/issues/new/choose). This helps us address your concerns more effectively.

## Development Workflow

### Submitting Pull Requests

When submitting a Pull Request (PR), please keep in mind the following:

- PRs that contain backward-compatible bug fixes or minor changes will generally be merged directly.
- PRs that introduce new features or include backward-incompatible changes may be included in an upcoming Major or Minor release.
- The maintainer(s) will evaluate the scope of each PR and determine if it should be part of the next release cycle or if it can be merged immediately as a patch.

<details>
<summary>How to submit PR</summary>

1. Fork the repository and create a new branch from the `main` branch for your feature or bug fix.
2. Make your changes and commit them with descriptive commit messages.
3. Push your changes to your forked repository.
4. Open a new pull request against the `main` branch of the main repository, describing your changes in detail.
5. Ensure your branch is up to date with the `main` branch before requesting a review.
6. Address any review comments and make necessary changes.
7. Once approved, the PR will be merged into the `main` branch.

</details>


### Documentation Style and Format

- Follow the Markdown formatting guidelines as outlined in the [Documentation Guidelines](https://mc-book.ecdysis.xyz/guides/project-management/documentation-guidelines).
- Use kebab-case for all documentation file names.

### Coding Style

- Adhere to the [Solidity Style Guide](https://docs.soliditylang.org/en/latest/style-guide.html) with project-specific additions as outlined in the [Coding Standards](https://mc-book.ecdysis.xyz/guides/project-management/coding-standards).
- Use `forge fmt` for consistent code formatting.

### Test Strategy

- Follow the comprehensive test strategy outlined in the [Test Strategy](https://mc-book.ecdysis.xyz/guides/project-management/test-strategy).
- Write unit tests for all functions and ensure high code coverage.

### Release Process

- Follow the branching and release strategy as outlined in the [Branching and Release Strategy](https://mc-book.ecdysis.xyz/guides/project-management/branching-and-release-strategy).
- Use Semantic Versioning for all releases.


### Versioning Policy

This project follows [Semantic Versioning](https://semver.org/) and uses version numbers in the format _MAJOR.MINOR.PATCH_.
- Version number updates will be determined and applied by the assigned maintainer(s).

* For the initial v0.1.0 release, we expect to make frequent breaking changes.

### Changelog

A changelog will be maintained in [CHANGELOG.md](./CHANGELOG.md) to document all notable changes in each version.

- Changelog entries should follow the [Keep a Changelog](https://keepachangelog.com/) format.
- Each version section should include the following subsections:
  - `Added` for new features.
  - `Changed` for changes in existing functionality.
  - `Deprecated` for soon-to-be removed features.
  - `Removed` for now removed features.
  - `Fixed` for any bug fixes.
  - `Security` in case of vulnerabilities.
- Entries should be written in imperative mood, e.g., "Add feature" instead of "Added feature".
- Entries should include a reference to the related issue or pull request, e.g., "(#123)".
- Breaking changes should be clearly indicated with a "BREAKING CHANGE:" prefix.
