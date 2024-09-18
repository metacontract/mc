# IERC20
[Git Source](https://github.com/metacontract/mc/blob/0cf91165f9ec2cbeeba800a4baf4e81e2df5c3bb/src/devkit/Flattened.sol)

*Interface of the ERC20 standard as defined in the EIP.*

*This includes the optional name, symbol, and decimals metadata.*


## Functions
### totalSupply

Returns the amount of tokens in existence.


```solidity
function totalSupply() external view returns (uint256);
```

### balanceOf

Returns the amount of tokens owned by `account`.


```solidity
function balanceOf(address account) external view returns (uint256);
```

### transfer

Moves `amount` tokens from the caller's account to `to`.


```solidity
function transfer(address to, uint256 amount) external returns (bool);
```

### allowance

Returns the remaining number of tokens that `spender` is allowed
to spend on behalf of `owner`


```solidity
function allowance(address owner, address spender) external view returns (uint256);
```

### approve

Sets `amount` as the allowance of `spender` over the caller's tokens.

*Be aware of front-running risks: https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729*


```solidity
function approve(address spender, uint256 amount) external returns (bool);
```

### transferFrom

Moves `amount` tokens from `from` to `to` using the allowance mechanism.
`amount` is then deducted from the caller's allowance.


```solidity
function transferFrom(address from, address to, uint256 amount) external returns (bool);
```

### name

Returns the name of the token.


```solidity
function name() external view returns (string memory);
```

### symbol

Returns the symbol of the token.


```solidity
function symbol() external view returns (string memory);
```

### decimals

Returns the decimals places of the token.


```solidity
function decimals() external view returns (uint8);
```

## Events
### Transfer
*Emitted when `value` tokens are moved from one account (`from`) to another (`to`).*


```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval
*Emitted when the allowance of a `spender` for an `owner` is set, where `value`
is the new allowance.*


```solidity
event Approval(address indexed owner, address indexed spender, uint256 value);
```

