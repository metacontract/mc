# Schema
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/devkit/Flattened.sol)

Storage Schema v0.1.0


## Structs
### $Admin
**Note:**
erc7201:mc.std.admin


```solidity
struct $Admin {
    address admin;
}
```

### $Clone
**Note:**
erc7201:mc.std.clone


```solidity
struct $Clone {
    address dictionary;
}
```

### $Proposal
**Note:**
erc7201:mc.std.proposal


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
**Note:**
erc7201:mc.std.member


```solidity
struct $Member {
    address[] members;
}
```

### $FeatureToggle
**Note:**
erc7201:mc.std.featureToggle


```solidity
struct $FeatureToggle {
    mapping(bytes4 selector => bool) disabledFeature;
}
```

### $Initialization
**Note:**
erc7201:mc.std.initializer


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

