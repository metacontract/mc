# Dictionary_0
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/Flattened.sol)

**Inherits:**
[DictionaryBase](/src/devkit/Flattened.sol/abstract.DictionaryBase.md), [Ownable](/src/devkit/Flattened.sol/abstract.Ownable.md), [IDictionary](/src/devkit/Flattened.sol/interface.IDictionary.md)


## Functions
### constructor


```solidity
constructor(address owner) Ownable(owner);
```

### setImplementation


```solidity
function setImplementation(bytes4 selector, address implementation) external onlyOwner;
```

### upgradeFacade


```solidity
function upgradeFacade(address newFacade) external onlyOwner;
```

