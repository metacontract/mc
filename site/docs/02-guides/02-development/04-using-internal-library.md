---
keywords: [internal library, data management, schema, abstract data types]
tags: [internal library, data management, schema, abstract data types]
last_update:
  date: 2024-10-26
  author: Meta Contract Development Team
---

# Using Internal Library

The Meta Contract DevKit uses a Schema-based data management system, and it is recommended to use Solidity's internal library for data operations. Conceptually, this approach is akin to handling abstract data types.

## Overview

Using an internal library allows for efficient data management, enhancing consistency and reusability, and improving code maintainability.

<!-- ## Example Usage

Below is an example of managing data using an internal library.

### Defining Schema

First, define the Schema to manage data. The Schema serves as a template for defining the structure of the data.

```solidity
library ProposalLib {
    function addProposal(Proposal storage self, ProposalHeader memory header, ProposalBody[] memory bodies) internal {
        self.header = header;
        self.bodies = bodies;
    }
    function getProposalType(Proposal storage self) internal view returns (ProposalType) {
        return self.header.proposalType;
    }
}
```

### Usage

By using the internal library, data manipulation becomes straightforward. Below is an example of adding Proposal data.

```solidity
function createProposal(Proposal storage proposal, ProposalHeader memory header, ProposalBody[] memory bodies) internal {
    ProposalLib.addProposal(proposal, header, bodies);
}
```

## Conclusion

Using an internal library makes data management more efficient and enhances code reusability. The Meta Contract DevKit recommends leveraging internal libraries for data operations, given its Schema-based data management approach. -->
