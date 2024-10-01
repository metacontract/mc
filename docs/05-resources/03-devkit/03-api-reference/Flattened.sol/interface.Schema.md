# Schema
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/resources/devkit/api-reference/Flattened.sol)

Storage Schema v0.1.0


## Structs
### $Admin

```solidity
struct $Admin {
    address admin;
}
```

### $Clone

```solidity
struct $Clone {
    address dictionary;
}
```

### $Proposal

```solidity
struct $Proposal {
    Proposal[] proposals;
}
```

### Proposal

```solidity
struct Proposal {
    ProposalHeader header;
    ProposalBody[] bodies;
}
```

### ProposalHeader

```solidity
struct ProposalHeader {
    ProposalType proposalType;
}
```

### ProposalBody

```solidity
struct ProposalBody {
    uint80 forkRefIndex;
    string overview;
    Op[] ops;
}
```

### Op

```solidity
struct Op {
    bytes data;
}
```

### $Member

```solidity
struct $Member {
    address[] members;
}
```

### $FeatureToggle

```solidity
struct $FeatureToggle {
    mapping(bytes4 selector => bool) disabledFeature;
}
```

### $Initialization

```solidity
struct $Initialization {
    uint64 initialized;
    bool initializing;
}
```

## Enums
### ProposalType

```solidity
enum ProposalType {
    Undefined,
    MEMBERSHIP_STOCK_TOKEN_RULE,
    MEMBERSHIP_REPS_MAJORITY_RULE,
    LEGISLATION
}
```

