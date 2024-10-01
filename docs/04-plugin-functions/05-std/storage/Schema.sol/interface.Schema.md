# Schema
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/plugin-functions/std/storage/Schema.sol)

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

