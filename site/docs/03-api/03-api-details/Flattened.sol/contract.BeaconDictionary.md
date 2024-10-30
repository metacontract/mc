# BeaconDictionary
[Git Source](https://github.com/metacontract/mc/blob/93e4f2d4a013f48ae1db91ed21bff3eb8a27ce1d/src/devkit/Flattened.sol)

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

