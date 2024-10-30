# StdFacade
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/std/interfaces/StdFacade.sol)

**Inherits:**
[IStd](../IStd.sol/interface.IStd.md)


## Functions
### clone


```solidity
function clone(bytes calldata initData) external returns (address proxy);
```

### getFunctions


```solidity
function getFunctions() external view returns (GetFunctions.Function[] memory);
```

### featureToggle


```solidity
function featureToggle(bytes4 selector) external;
```

### initSetAdmin


```solidity
function initSetAdmin(address admin) external;
```

### upgradeDictionary


```solidity
function upgradeDictionary(address newDictionary) external;
```

