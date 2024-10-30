# Dictionary_0
[Git Source](https://github.com/metacontract/mc/blob/main/src/devkit/Flattened.sol)

**Inherits:**
[DictionaryBase](abstract.DictionaryBase.md), [Ownable](abstract.Ownable.md), [IDictionary](interface.IDictionary.md)


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

