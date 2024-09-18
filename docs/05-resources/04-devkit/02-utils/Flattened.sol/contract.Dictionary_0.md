# Dictionary_0
[Git Source](https://github.com/metacontract/mc/blob/0cf91165f9ec2cbeeba800a4baf4e81e2df5c3bb/src/devkit/Flattened.sol)

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

