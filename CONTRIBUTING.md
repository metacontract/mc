# Contributing Guideline

Thank you for your interest in contributing to this project! We welcome contributions from everyone, whether it's reporting an issue, submitting a pull request, or suggesting improvements.


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

1. Fork the repository and create a new branch for your feature or bug fix.
2. Make your changes and commit them with descriptive commit messages.
3. Push your changes to your forked repository.
4. Open a new pull request against the main repository, describing your changes in detail.
</details>


### Coding Style
We adhere to the [Solidity Style Guide](https://docs.soliditylang.org/en/latest/style-guide.html) for maintaining a consistent and readable codebase. When contributing to this project, please follow the Solidity Style Guide with the exceptions and additions.

To ensure consistent formatting, we use [forge fmt](https://book.getfoundry.sh/reference/forge/forge-fmt), a built-in code formatter for Foundry projects. Please run `forge fmt` before submitting your pull request. Our CI pipeline will check the formatting of your code using `forge fmt --check`.


### Release Process
This document outlines the release process for our project, including the types of releases, planning, preparation, execution.

- **Major Release**: Includes significant new features or backward-incompatible changes.
- **Minor Release**: Includes small new features or improvements.
- **Patch Release**: Includes bug fixes and backward-compatible changes.

#### 1. Create a release branch
A new release branch is created from the main branch, using the naming convention `release/vX.Y.Z`, where `X.Y.Z` represents the version number.

- Major/Minor Release
  1. Create a "New Release" issue to clarify the release plan.
  2. Create a release branch.
  3. Review and merge related Pull Requests into the release branch.
- Patch Releases
  1. Review a related Pull Request.
  2. A maintainer creates a patch release branch.
  3. Merge into the patch release branch.
  - Individual Pull Requests can be merged on an ongoing basis.
  - Combine multiple PRs into a single _Patch Release Brabch_ if needed.
  - For critical patches, a "New Release" issue may be created, but generally, a lightweight process will be followed.

  [*] If necessary, create branch and validate a Release Candidate (RC).

#### 2. Preparation
  1. Update the [CAHNGELOG](./CHANGELOG.md).
  2. [Create release notes](https://github.com/metacontract/mc/releases/new).
  3. A new git tag is created and chosen for the release, using the naming convention `vX.Y.Z`.

#### 3. Publication
  1. Publish release notes.
  2. Announce the release to the community through our designated communication channels.
  3. For information about upcoming releases and planned features, please refer to our [GitHub Issues](https://github.com/metacontract/mc/issues).

Please note that only project maintainers have the authority to create releases and merge changes into the main branch.


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
