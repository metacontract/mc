# ImmutableDictionary
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/Flattened.sol)

**Inherits:**
[DictionaryBase](/src/devkit/Flattened.sol/abstract.DictionaryBase.md)


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

