# ImmutableDictionary
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/Flattened.sol)

**Inherits:**
[DictionaryBase](/resources/devkit/api-reference/Flattened.sol/abstract.DictionaryBase)


## Functions
### constructor


```solidity
constructor(Function[] memory _functions, address _facade);
```

### __existsSameSelector


```solidity
function __existsSameSelector(bytes4 _selector) internal override returns (bool);
```

## Errors
### SelectorAlreadyExists

```solidity
error SelectorAlreadyExists(bytes4 selector);
```

## Structs
### Function

```solidity
struct Function {
    bytes4 selector;
    address implementation;
}
```

