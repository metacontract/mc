# System
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/system/System.sol)

===============\
|   💻 System     |
\================


## Functions
### Config


```solidity
function Config() internal pure returns (ConfigState storage ref);
```

### Tracer


```solidity
function Tracer() internal pure returns (Trace storage ref);
```

### Exit


```solidity
function Exit(string memory errorHead, string memory errorDetail) internal view;
```

