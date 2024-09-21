# IBeacon
[Git Source](https://github.com/metacontract/mc/blob/c3fc2b414d37afc92bb1cf2e606b4b2bede47403/resources/devkit/api-reference/Flattened.sol)

*This is the interface that {BeaconProxy} expects of its beacon.*


## Functions
### implementation

*Must return an address that can be used as a delegate call target.
{UpgradeableBeacon} will check that this address is a contract.*


```solidity
function implementation() external view returns (address);
```

