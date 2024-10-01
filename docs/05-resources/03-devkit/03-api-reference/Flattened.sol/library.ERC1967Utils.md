# ERC1967Utils
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/resources/devkit/api-reference/Flattened.sol)

*This abstract contract provides getters and event emitting update functions for
https://eips.ethereum.org/EIPS/eip-1967[EIP1967] slots.*


## State Variables
### IMPLEMENTATION_SLOT
*Storage slot with the address of the current implementation.
This is the keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1.*


```solidity
bytes32 internal constant IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
```


### ADMIN_SLOT
*Storage slot with the admin of the contract.
This is the keccak-256 hash of "eip1967.proxy.admin" subtracted by 1.*


```solidity
bytes32 internal constant ADMIN_SLOT = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;
```


### BEACON_SLOT
*The storage slot of the UpgradeableBeacon contract which defines the implementation for this proxy.
This is the keccak-256 hash of "eip1967.proxy.beacon" subtracted by 1.*


```solidity
bytes32 internal constant BEACON_SLOT = 0xa3f0ad74e5423aebfd80d3ef4346578335a9a72aeaee59ff6cb3582b35133d50;
```


## Functions
### getImplementation

*Returns the current implementation address.*


```solidity
function getImplementation() internal view returns (address);
```

### _setImplementation

*Stores a new address in the EIP1967 implementation slot.*


```solidity
function _setImplementation(address newImplementation) private;
```

### upgradeToAndCall

*Performs implementation upgrade with additional setup call if data is nonempty.
This function is payable only if the setup call is performed, otherwise `msg.value` is rejected
to avoid stuck value in the contract.
Emits an [IERC1967-Upgraded](/resources/devkit/api-reference/Flattened.sol/contract.UpgradeableBeacon#upgraded) event.*


```solidity
function upgradeToAndCall(address newImplementation, bytes memory data) internal;
```

### getAdmin

*Returns the current admin.
TIP: To get this value clients can read directly from the storage slot shown below (specified by EIP1967) using
the https://eth.wiki/json-rpc/API#eth_getstorageat[`eth_getStorageAt`] RPC call.
`0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103`*


```solidity
function getAdmin() internal view returns (address);
```

### _setAdmin

*Stores a new address in the EIP1967 admin slot.*


```solidity
function _setAdmin(address newAdmin) private;
```

### changeAdmin

*Changes the admin of the proxy.
Emits an [IERC1967-AdminChanged](/lib/ucs-contracts/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol/library.ERC1967Utils.md#adminchanged) event.*


```solidity
function changeAdmin(address newAdmin) internal;
```

### getBeacon

*Returns the current beacon.*


```solidity
function getBeacon() internal view returns (address);
```

### _setBeacon

*Stores a new beacon in the EIP1967 beacon slot.*


```solidity
function _setBeacon(address newBeacon) private;
```

### upgradeBeaconToAndCall

*Change the beacon and trigger a setup call if data is nonempty.
This function is payable only if the setup call is performed, otherwise `msg.value` is rejected
to avoid stuck value in the contract.
Emits an [IERC1967-BeaconUpgraded](/lib/ucs-contracts/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol/library.ERC1967Utils.md#beaconupgraded) event.
CAUTION: Invoking this function has no effect on an instance of {BeaconProxy} since v5, since
it uses an immutable beacon without looking at the value of the ERC-1967 beacon slot for
efficiency.*


```solidity
function upgradeBeaconToAndCall(address newBeacon, bytes memory data) internal;
```

### _checkNonPayable

*Reverts if `msg.value` is not zero. It can be used to avoid `msg.value` stuck in the contract
if an upgrade doesn't perform an initialization call.*


```solidity
function _checkNonPayable() private;
```

## Events
### Upgraded
*Emitted when the implementation is upgraded.*


```solidity
event Upgraded(address indexed implementation);
```

### AdminChanged
*Emitted when the admin account has changed.*


```solidity
event AdminChanged(address previousAdmin, address newAdmin);
```

### BeaconUpgraded
*Emitted when the beacon is changed.*


```solidity
event BeaconUpgraded(address indexed beacon);
```

## Errors
### ERC1967InvalidImplementation
*The `implementation` of the proxy is invalid.*


```solidity
error ERC1967InvalidImplementation(address implementation);
```

### ERC1967InvalidAdmin
*The `admin` of the proxy is invalid.*


```solidity
error ERC1967InvalidAdmin(address admin);
```

### ERC1967InvalidBeacon
*The `beacon` of the proxy is invalid.*


```solidity
error ERC1967InvalidBeacon(address beacon);
```

### ERC1967NonPayable
*An upgrade function sees `msg.value > 0` that may be lost.*


```solidity
error ERC1967NonPayable();
```

