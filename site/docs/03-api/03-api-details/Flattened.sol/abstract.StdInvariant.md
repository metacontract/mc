# StdInvariant
[Git Source](https://github.com/metacontract/mc/blob/93e4f2d4a013f48ae1db91ed21bff3eb8a27ce1d/src/devkit/Flattened.sol)


## State Variables
### _excludedContracts

```solidity
address[] private _excludedContracts;
```


### _excludedSenders

```solidity
address[] private _excludedSenders;
```


### _targetedContracts

```solidity
address[] private _targetedContracts;
```


### _targetedSenders

```solidity
address[] private _targetedSenders;
```


### _excludedArtifacts

```solidity
string[] private _excludedArtifacts;
```


### _targetedArtifacts

```solidity
string[] private _targetedArtifacts;
```


### _targetedArtifactSelectors

```solidity
FuzzArtifactSelector[] private _targetedArtifactSelectors;
```


### _excludedSelectors

```solidity
FuzzSelector[] private _excludedSelectors;
```


### _targetedSelectors

```solidity
FuzzSelector[] private _targetedSelectors;
```


### _targetedInterfaces

```solidity
FuzzInterface[] private _targetedInterfaces;
```


## Functions
### excludeContract


```solidity
function excludeContract(address newExcludedContract_) internal;
```

### excludeSelector


```solidity
function excludeSelector(FuzzSelector memory newExcludedSelector_) internal;
```

### excludeSender


```solidity
function excludeSender(address newExcludedSender_) internal;
```

### excludeArtifact


```solidity
function excludeArtifact(string memory newExcludedArtifact_) internal;
```

### targetArtifact


```solidity
function targetArtifact(string memory newTargetedArtifact_) internal;
```

### targetArtifactSelector


```solidity
function targetArtifactSelector(FuzzArtifactSelector memory newTargetedArtifactSelector_) internal;
```

### targetContract


```solidity
function targetContract(address newTargetedContract_) internal;
```

### targetSelector


```solidity
function targetSelector(FuzzSelector memory newTargetedSelector_) internal;
```

### targetSender


```solidity
function targetSender(address newTargetedSender_) internal;
```

### targetInterface


```solidity
function targetInterface(FuzzInterface memory newTargetedInterface_) internal;
```

### excludeArtifacts


```solidity
function excludeArtifacts() public view returns (string[] memory excludedArtifacts_);
```

### excludeContracts


```solidity
function excludeContracts() public view returns (address[] memory excludedContracts_);
```

### excludeSelectors


```solidity
function excludeSelectors() public view returns (FuzzSelector[] memory excludedSelectors_);
```

### excludeSenders


```solidity
function excludeSenders() public view returns (address[] memory excludedSenders_);
```

### targetArtifacts


```solidity
function targetArtifacts() public view returns (string[] memory targetedArtifacts_);
```

### targetArtifactSelectors


```solidity
function targetArtifactSelectors() public view returns (FuzzArtifactSelector[] memory targetedArtifactSelectors_);
```

### targetContracts


```solidity
function targetContracts() public view returns (address[] memory targetedContracts_);
```

### targetSelectors


```solidity
function targetSelectors() public view returns (FuzzSelector[] memory targetedSelectors_);
```

### targetSenders


```solidity
function targetSenders() public view returns (address[] memory targetedSenders_);
```

### targetInterfaces


```solidity
function targetInterfaces() public view returns (FuzzInterface[] memory targetedInterfaces_);
```

## Structs
### FuzzSelector

```solidity
struct FuzzSelector {
    address addr;
    bytes4[] selectors;
}
```

### FuzzArtifactSelector

```solidity
struct FuzzArtifactSelector {
    string artifact;
    bytes4[] selectors;
}
```

### FuzzInterface

```solidity
struct FuzzInterface {
    address addr;
    string[] artifacts;
}
```

