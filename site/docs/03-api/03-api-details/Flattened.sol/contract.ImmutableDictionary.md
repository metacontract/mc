# ImmutableDictionary
[Git Source](https://github.com/metacontract/mc/blob/main/src/devkit/Flattened.sol)

**Inherits:**
[DictionaryBase](abstract.DictionaryBase.md)


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

