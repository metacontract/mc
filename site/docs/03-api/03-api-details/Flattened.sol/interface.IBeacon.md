# IBeacon
[Git Source](https://github.com/metacontract/mc/blob/b874bc295b567a7e9bd6d6c63dfe84df116a2f3a/src/devkit/Flattened.sol)

*This is the interface that {BeaconProxy} expects of its beacon.*


## Functions
### implementation

*Must return an address that can be used as a delegate call target.
{UpgradeableBeacon} will check that this address is a contract.*


```solidity
function implementation() external view returns (address);
```

