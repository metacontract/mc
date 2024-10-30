# MCInitLib
[Git Source](https://github.com/metacontract/mc/blob/main/src/devkit/Flattened.sol)

🎁 MC Initial Configuration
🌱 Init Bundle
🔗 Use Function
🪟 Use Facade
🏰 Setup Standard Functions


## Functions
### init

--------------------
🌱 Init Bundle
----------------------


```solidity
function init(MCDevKit storage mc, string memory name) internal returns (MCDevKit storage);
```

### init


```solidity
function init(MCDevKit storage mc) internal returns (MCDevKit storage);
```

### use

---------------------
🔗 Use Function
-----------------------


```solidity
function use(MCDevKit storage mc, string memory name, bytes4 selector, address implementation)
    internal
    returns (MCDevKit storage);
```

### use


```solidity
function use(MCDevKit storage mc, bytes4 selector, address implementation) internal returns (MCDevKit storage);
```

### use


```solidity
function use(MCDevKit storage mc, Function storage func) internal returns (MCDevKit storage);
```

### use


```solidity
function use(MCDevKit storage mc, string memory functionName) internal returns (MCDevKit storage);
```

### useFacade

------------------
🪟 Use Facade
--------------------

Assign facade address to current bundle


```solidity
function useFacade(MCDevKit storage mc, address facade) internal returns (MCDevKit storage);
```

### setupStdFunctions

--------------------------------
🏰 Setup Standard Functions
----------------------------------


```solidity
function setupStdFunctions(MCDevKit storage mc) internal returns (MCDevKit storage);
```

