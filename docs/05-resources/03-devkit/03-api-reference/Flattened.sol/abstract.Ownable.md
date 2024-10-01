# Ownable
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/resources/devkit/api-reference/Flattened.sol)

**Inherits:**
[Context](/resources/devkit/api-reference/Flattened.sol/abstract.Context)

*Contract module which provides a basic access control mechanism, where
there is an account (an owner) that can be granted exclusive access to
specific functions.
The initial owner is set to the address provided by the deployer. This can
later be changed with [transferOwnership](/resources/devkit/api-reference/Flattened.sol/abstract.Ownable#transferownership).
This module is used through inheritance. It will make available the modifier
`onlyOwner`, which can be applied to your functions to restrict their use to
the owner.*


## State Variables
### _owner

```solidity
address private _owner;
```


## Functions
### constructor

*Initializes the contract setting the address provided by the deployer as the initial owner.*


```solidity
constructor(address initialOwner);
```

### onlyOwner

*Throws if called by any account other than the owner.*


```solidity
modifier onlyOwner();
```

### owner

*Returns the address of the current owner.*


```solidity
function owner() public view virtual returns (address);
```

### _checkOwner

*Throws if the sender is not the owner.*


```solidity
function _checkOwner() internal view virtual;
```

### renounceOwnership

*Leaves the contract without owner. It will not be possible to call
`onlyOwner` functions. Can only be called by the current owner.
NOTE: Renouncing ownership will leave the contract without an owner,
thereby disabling any functionality that is only available to the owner.*


```solidity
function renounceOwnership() public virtual onlyOwner;
```

### transferOwnership

*Transfers ownership of the contract to a new account (`newOwner`).
Can only be called by the current owner.*


```solidity
function transferOwnership(address newOwner) public virtual onlyOwner;
```

### _transferOwnership

*Transfers ownership of the contract to a new account (`newOwner`).
Internal function without access restriction.*


```solidity
function _transferOwnership(address newOwner) internal virtual;
```

## Events
### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

## Errors
### OwnableUnauthorizedAccount
*The caller account is not authorized to perform an operation.*


```solidity
error OwnableUnauthorizedAccount(address account);
```

### OwnableInvalidOwner
*The owner is not a valid owner account. (eg. `address(0)`)*


```solidity
error OwnableInvalidOwner(address owner);
```

