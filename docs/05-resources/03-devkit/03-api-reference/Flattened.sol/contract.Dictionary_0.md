# Dictionary_0
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/Flattened.sol)

**Inherits:**
[DictionaryBase](/resources/devkit/api-reference/Flattened.sol/abstract.DictionaryBase), [Ownable](/resources/devkit/api-reference/Flattened.sol/abstract.Ownable), [IDictionary](/resources/devkit/api-reference/Flattened.sol/interface.IDictionary)


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

