# BeaconDictionary
[Git Source](https://github.com/metacontract/mc/blob/main/src/devkit/Flattened.sol)

**Inherits:**
[UpgradeableBeacon](contract.UpgradeableBeacon.md)


## Functions
### constructor


```solidity
constructor(address implementation_, address initialOwner) UpgradeableBeacon(implementation_, initialOwner);
```

### getImplementation


```solidity
function getImplementation(bytes4 selector) external view returns (address);
```

