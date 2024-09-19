# IBeacon
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/Flattened.sol)

*This is the interface that {BeaconProxy} expects of its beacon.*


## Functions
### implementation

*Must return an address that can be used as a delegate call target.
{UpgradeableBeacon} will check that this address is a contract.*


```solidity
function implementation() external view returns (address);
```

