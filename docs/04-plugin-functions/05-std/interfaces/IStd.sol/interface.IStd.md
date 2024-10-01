# IStd
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/plugin-functions/std/interfaces/IStd.sol)

**Inherits:**
[IProxy](/resources/devkit/api-reference/Flattened.sol/interface.IProxy)


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

