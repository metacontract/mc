# IBeacon
[Git Source](https://github.com/metacontract/mc/blob/93e4f2d4a013f48ae1db91ed21bff3eb8a27ce1d/src/devkit/Flattened.sol)

*This is the interface that {BeaconProxy} expects of its beacon.*


## Functions
### implementation

*Must return an address that can be used as a delegate call target.
{UpgradeableBeacon} will check that this address is a contract.*


```solidity
function implementation() external view returns (address);
```

