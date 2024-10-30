# IStd
[Git Source](https://github.com/metacontract/mc/blob/main/src/std/interfaces/IStd.sol)

**Inherits:**
[IProxy](../../../../../../03-api/03-api-details/Flattened.sol/interface.IProxy.md)


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

