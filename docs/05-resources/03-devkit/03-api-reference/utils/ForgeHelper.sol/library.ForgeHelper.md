# ForgeHelper
[Git Source](https://github.com/metacontract/mc/blob/0cf91165f9ec2cbeeba800a4baf4e81e2df5c3bb/src/devkit/utils/ForgeHelper.sol)

🛠 Helper Methods for Forge Std


## Functions
### loadPrivateKey

-------------------
🔧 Env File
---------------------


```solidity
function loadPrivateKey(string memory envKey) internal view returns (uint256);
```

### loadAddressFromEnv


```solidity
function loadAddressFromEnv(string memory envKey) internal view returns (address);
```

### getAddress

------------------
📍 Address
--------------------


```solidity
function getAddress(address target, bytes32 slot) internal view returns (address);
```

### getDictionaryAddress


```solidity
function getDictionaryAddress(address proxy) internal view returns (address);
```

### injectCode


```solidity
function injectCode(address target, bytes memory runtimeBytecode) internal;
```

### injectAddressToStorage


```solidity
function injectAddressToStorage(address target, bytes32 slot, address addr) internal;
```

### injectDictionary


```solidity
function injectDictionary(address proxy, address dictionary) internal;
```

### assumeAddressIsNotReserved


```solidity
function assumeAddressIsNotReserved(address addr) internal pure;
```

### msgSender

----------------
📓 Context
------------------


```solidity
function msgSender() internal returns (address);
```

### assignLabel

---------------
🏷️ Label
-----------------


```solidity
function assignLabel(address addr, string memory name) internal returns (address);
```

### getLabel


```solidity
function getLabel(address addr) internal view returns (string memory);
```

### readBoolOr

--------------
📂 TOML
----------------


```solidity
function readBoolOr(string memory toml, string memory key, bool or) internal view returns (bool);
```

### readStringOr


```solidity
function readStringOr(string memory toml, string memory key, string memory or) internal view returns (string memory);
```

### readUintOr


```solidity
function readUintOr(string memory toml, string memory key, uint256 or) internal view returns (uint256);
```

### readLogLevelOr


```solidity
function readLogLevelOr(string memory toml, string memory key, Logger.Level or) internal view returns (Logger.Level);
```

### pauseBroadcast

------------------
📡 Broadcast
--------------------


```solidity
function pauseBroadcast() internal returns (bool isBroadcasting, address);
```

### resumeBroadcast


```solidity
function resumeBroadcast(bool isBroadcasting, address currentSender) internal;
```

