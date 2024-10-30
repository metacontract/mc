# BundleLib
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/devkit/core/Bundle.sol)


## Functions
### assignName

--------------------
📛 Assign Name
----------------------


```solidity
function assignName(Bundle storage bundle, string memory name) internal returns (Bundle storage);
```

### pushFunction

-------------------------
🧩 Push Function(s)
---------------------------


```solidity
function pushFunction(Bundle storage bundle, Function storage func) internal returns (Bundle storage);
```

### pushFunctions


```solidity
function pushFunctions(Bundle storage bundle, Function[] storage functions) internal returns (Bundle storage);
```

### assignFacade

----------------------
🪟 Assign Facade
------------------------


```solidity
function assignFacade(Bundle storage bundle, address facade) internal returns (Bundle storage);
```

