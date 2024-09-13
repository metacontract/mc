---
title: "Documentation Guidelines"
version: 0.1.0
lastUpdated: 2024-09-06
author: Meta Contract Development Team
scope: project
type: guide
tags: [documentation, guidelines, best-practices]
relatedDocs: [project-structure.md, glossary.md]
changeLog:
  - version: 0.1.0
    date: 2024-09-06
    description: Initial version of the documentation guidelines
changeLogLink: /CHANGELOG.md
---

# Documentation Guidelines

This guide outlines the standards and best practices for creating and maintaining documentation in the Meta Contract project.

## General Principles

1. Write clear, concise, and accurate documentation.
2. Keep documentation up-to-date with code changes.
3. Use a consistent style and format across all documentation.
4. Write for your audience, considering their technical background.

## Documentation Structure

The documentation should follow this structure:

```
docs/
├── index.md (Overview of all documentation sections)
├── 01-introduction/
│   ├── index.md (Introduction to Meta Contract and its key concepts)
│   ├── 01-what-is-meta-contract.md
│   ├── 02-key-concepts.md
│   ├── 03-getting-started/
│   │   ├── index.md (Guide to getting started with Meta Contract)
│   │   ├── 01-installation.md
│   │   └── 02-basic-setup.md
├── 02-tutorials/
│   ├── index.md (Overview of available tutorials)
│   ├── 01-simple-dao.md
│   ├── 02-simple-dex.md
│   ├── 03-stable-credit.md
│   ├── 04-erc-implementations/
│   │   ├── index.md (Guide to ERC implementation tutorials)
│   │   ├── 01-erc20.md
│   │   ├── 02-erc721.md
│   │   ├── 03-erc1155.md
│   │   └── 04-erc4337.md
├── 03-devops/
│   ├── index.md (Overview of DevOps processes and tools)
│   ├── 01-deployment.md
│   ├── 02-testing.md
│   ├── 03-upgrades.md
│   └── 04-ci-cd.md
├── 04-plugins/
│   ├── index.md (Overview of available plugins and their categories)
│   ├── 01-common/
│   │   ├── index.md (Guide to common plugins)
│   │   ├── 01-access-control/
│   │   │   ├── index.md (Overview of access control plugins)
│   │   │   ├── 01-grant-role.md
│   │   │   ├── 02-revoke-role.md
│   │   │   └── 03-renounce-role.md
│   │   ├── 02-clone.md
│   │   ├── 03-create.md
│   │   └── 04-receive.md
│   ├── 02-deliberation/
│   │   ├── index.md (Guide to deliberation plugins)
│   │   ├── 01-propose.md
│   │   ├── 02-fork.md
│   │   ├── 03-vote.md
│   │   └── 04-tally.md
│   ├── 03-token/
│   │   ├── index.md (Overview of token-related plugins)
│   │   ├── 01-erc20s.md
│   │   └── 02-erc721s.md
│   ├── 04-defi/
│   │   ├── index.md (Guide to DeFi plugins)
│   │   ├── 01-deposit.md
│   │   ├── 02-withdraw.md
│   │   ├── 03-claim.md
│   │   └── 04-transfer.md
└── 05-resources/
    ├── index.md (Overview of additional resources and reference materials)
    ├── 01-library-overview/
    │   ├── index.md (Guide to library documentation)
    │   ├── 01-documentation-guidelines.md
    │   ├── 02-glossary.md
    │   └── 03-versioning.md
    ├── 02-architecture/
    │   ├── index.md (Overview of Meta Contract architecture)
    │   ├── 01-erc7546.md
    │   ├── 02-schema-based-storage.md
    │   └── 03-interfaces.md
    ├── 03-devkit/
    │   ├── index.md (Guide to using the Meta Contract DevKit)
    │   ├── 01-usage.md
    │   ├── 02-utils/
    │   │   ├── index.md (Overview of DevKit utilities)
    │   │   ├── 01-deployment.md
    │   │   ├── 02-init.md
    │   │   ├── 03-finder.md
    │   │   ├── 04-mock.md
    │   │   └── 05-helper.md
    │   └── 03-object-lifecycle.md
    ├── 04-integration/
    │   ├── index.md (Guide to integrating Meta Contract with external services)
    │   ├── 01-the-graph.md
    │   └── 02-etherscan.md
    ├── 05-best-practices/
    │   ├── index.md (Overview of best practices for Meta Contract development)
    │   ├── 01-ai-tdd.md
    │   └── 02-using-internal-library.md
```

Each `index.md` file should contain:
1. A brief description of the contents of that directory
2. Links to the files and subdirectories within it
3. Any additional context or information relevant to that section of the documentation

## File Naming Convention

Use kebab-case for all documentation file names:

```
what-is-meta-contract.md
key-concepts.md
```

## Markdown Formatting

1. Use ATX-style headers (`#` for h1, `##` for h2, etc.).
2. Use backticks for inline code and triple backticks for code blocks.
3. Use appropriate language identifiers for code blocks (e.g., ```solidity).
4. Use unordered lists (`-`) for most lists, and ordered lists (`1.`) when sequence matters.

## Documentation Header

Each documentation file should start with a metadata block followed by the document content:

```markdown
---
title: "Full Document Title"
version: 0.1.0
lastUpdated: YYYY-MM-DD
author: [Author Names]
scope: [Scope of the document, e.g., dev, arch]
type: [Type of document, e.g., spec, guide]
tags: [tag1, tag2, tag3]
relatedDocs: ["RELATED_DOC_1.md", "RELATED_DOC_2.md"]
changeLog:
  - version: 0.1.0
    date: YYYY-MM-DD
    description: [Description of initial version]
---

# Document Title

Brief description or introduction to the document content.

[Main document content starts here]
```

## Code Documentation

### Solidity

Use NatSpec comments for all public and external functions:

```solidity
/**
 * @notice Calculates the sum of two numbers
 * @param a The first number
 * @param b The second number
 * @return The sum of a and b
 */
function calculateSum(uint256 a, uint256 b) public pure returns (uint256) {
    return a + b;
}
```

## Diagrams

Use Mermaid for creating diagrams in documentation. Include the diagram source in the Markdown file:

```mermaid
graph TD
    A[Proxy Contract] --> B{Dictionary Contract}
    B --> C[Function Contract 1]
    B --> D[Function Contract 2]
    B --> E[Function Contract 3]
```

## Versioning Documentation

1. Start all document versions at 0.1.0.
2. Increment the version number when making significant updates to a document.
3. Clearly indicate which version of the software each document applies to.

## Review Process

1. All documentation changes should go through peer review.
2. Check for technical accuracy, clarity, and adherence to these guidelines.
3. Ensure all links are working and point to the correct destinations.

By following these guidelines, we ensure consistency and quality across all Meta Contract documentation, making it easier for developers and users to understand and use our project.
