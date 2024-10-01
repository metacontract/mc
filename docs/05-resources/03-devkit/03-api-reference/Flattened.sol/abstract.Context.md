# Context
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/Flattened.sol)

*Provides information about the current execution context, including the
sender of the transaction and its data. While these are generally available
via msg.sender and msg.data, they should not be accessed in such a direct
manner, since when dealing with meta-transactions the account sending and
paying for execution may not be the actual sender (as far as an application
is concerned).
This contract is only required for intermediate, library-like contracts.*


## Functions
### _msgSender


```solidity
function _msgSender() internal view virtual returns (address);
```

### _msgData


```solidity
function _msgData() internal view virtual returns (bytes calldata);
```

### _contextSuffixLength


```solidity
function _contextSuffixLength() internal view virtual returns (uint256);
```

