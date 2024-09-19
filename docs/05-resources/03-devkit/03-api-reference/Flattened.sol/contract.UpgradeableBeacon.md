# UpgradeableBeacon
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/Flattened.sol)

**Inherits:**
[IBeacon](/src/devkit/Flattened.sol/interface.IBeacon.md), [Ownable](/src/devkit/Flattened.sol/abstract.Ownable.md)

*This contract is used in conjunction with one or more instances of {BeaconProxy} to determine their
implementation contract, which is where they will delegate all function calls.
An owner is able to change the implementation the beacon points to, thus upgrading the proxies that use this beacon.*


## State Variables
### _implementation

```solidity
address private _implementation;
```


## Functions
### constructor

*Sets the address of the initial implementation, and the initial owner who can upgrade the beacon.*


```solidity
constructor(address implementation_, address initialOwner) Ownable(initialOwner);
```

### implementation

*Returns the current implementation address.*


```solidity
function implementation() public view virtual returns (address);
```

### upgradeTo

*Upgrades the beacon to a new implementation.
Emits an [Upgraded](/src/devkit/Flattened.sol/contract.UpgradeableBeacon.md#upgraded) event.
Requirements:
- msg.sender must be the owner of the contract.
- `newImplementation` must be a contract.*


```solidity
function upgradeTo(address newImplementation) public virtual onlyOwner;
```

### _setImplementation

*Sets the implementation contract address for this beacon
Requirements:
- `newImplementation` must be a contract.*


```solidity
function _setImplementation(address newImplementation) private;
```

## Events
### Upgraded
*Emitted when the implementation returned by the beacon is changed.*


```solidity
event Upgraded(address indexed implementation);
```

## Errors
### BeaconInvalidImplementation
*The `implementation` of the beacon is invalid.*


```solidity
error BeaconInvalidImplementation(address implementation);
```

