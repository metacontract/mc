# MCHelpers
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/devkit/utils/global/MCHelpers.sol)

🛠️ Helper
♻️ Reset Current Context
🤲 Set Storage Reader


## Functions
### reset

-----------------------------
♻️ Reset Current Context
-------------------------------


```solidity
function reset(MCDevKit storage mc) internal returns (MCDevKit storage);
```

### setStorageReader

--------------------------
🤲 Set Storage Reader
----------------------------


```solidity
function setStorageReader(MCDevKit storage mc, Dictionary memory dictionary, bytes4 selector, address implementation)
    internal
    returns (MCDevKit storage);
```

### setStorageReader


```solidity
function setStorageReader(MCDevKit storage mc, string memory bundleName, bytes4 selector, address implementation)
    internal
    returns (MCDevKit storage);
```

### setStorageReader


```solidity
function setStorageReader(MCDevKit storage mc, bytes4 selector, address implementation)
    internal
    returns (MCDevKit storage);
```

### loadPrivateKey

ForgeHelper Wrapper
-------------------
🔧 Env File
---------------------


```solidity
function loadPrivateKey(MCDevKit storage, string memory envKey) internal view returns (uint256);
```

### loadAddressFromEnv


```solidity
function loadAddressFromEnv(MCDevKit storage, string memory envKey) internal view returns (address);
```

### injectCode

-------------------------
📍 Address Operation
---------------------------


```solidity
function injectCode(MCDevKit storage, address target, bytes memory runtimeBytecode) internal;
```

### injectDictionary


```solidity
function injectDictionary(MCDevKit storage, address proxy, address dictionary) internal;
```

### getAddress


```solidity
function getAddress(MCDevKit storage, address target, bytes32 slot) internal view returns (address);
```

### getDictionaryAddress


```solidity
function getDictionaryAddress(MCDevKit storage, address proxy) internal view returns (address);
```

### assumeAddressIsNotReserved


```solidity
function assumeAddressIsNotReserved(MCDevKit storage, address addr) internal pure;
```

### msgSender

----------------
📓 Context
------------------


```solidity
function msgSender(MCDevKit storage) internal returns (address);
```

### assignLabel

---------------
🏷️ Label
-----------------


```solidity
function assignLabel(MCDevKit storage, address addr, string memory name) internal returns (address);
```

### getLabel


```solidity
function getLabel(MCDevKit storage, address addr) internal view returns (string memory);
```

### pauseBroadcast

------------------
📡 Broadcast
--------------------


```solidity
function pauseBroadcast(MCDevKit storage) internal;
```

### resumeBroadcast


```solidity
function resumeBroadcast(MCDevKit storage, bool isBroadcasting, address currentSender) internal;
```

### expectRevert

----------------------
🛠️ Forge Extender
------------------------


```solidity
function expectRevert(MCDevKit storage, string memory message) internal;
```

