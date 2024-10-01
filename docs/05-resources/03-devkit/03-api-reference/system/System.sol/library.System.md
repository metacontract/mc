# System
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/resources/devkit/api-reference/system/System.sol)

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

