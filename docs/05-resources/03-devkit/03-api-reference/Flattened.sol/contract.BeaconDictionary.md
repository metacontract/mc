# BeaconDictionary
[Git Source](https://github.com/metacontract/mc/blob/d41f04df9ea19494be75c66f344b8104caf03cd2/resources/devkit/api-reference/Flattened.sol)

**Inherits:**
[UpgradeableBeacon](/resources/devkit/api-reference/Flattened.sol/contract.UpgradeableBeacon)


## Functions
### constructor


```solidity
constructor(address implementation_, address initialOwner) UpgradeableBeacon(implementation_, initialOwner);
```

### getImplementation


```solidity
function getImplementation(bytes4 selector) external view returns (address);
```

