# Inspector
[Git Source](https://github.com/metacontract/mc/blob/main/src/devkit/types/Inspector.sol)

===================
🕵️‍♀️ Inspector
=====================


## Functions
### hasNotContract

==================
🧩 Function
====================


```solidity
function hasNotContract(Function storage func) internal view returns (bool);
```

### isEqual


```solidity
function isEqual(Function memory a, Function memory b) internal pure returns (bool);
```

### isComplete


```solidity
function isComplete(Function memory func) internal pure returns (bool);
```

### isUninitialized


```solidity
function isUninitialized(Function storage func) internal view returns (bool);
```

### hasSameSelector

===============
🗂️ Bundle
=================


```solidity
function hasSameSelector(Bundle storage bundle, Function storage func) internal view returns (bool flag);
```

### hasNotSameSelector


```solidity
function hasNotSameSelector(Bundle storage bundle, Function storage func) internal view returns (bool);
```

### isComplete


```solidity
function isComplete(Bundle storage bundle) internal view returns (bool);
```

### isUninitialized


```solidity
function isUninitialized(Bundle storage bundle) internal view returns (bool);
```

### hasCurrentBundle

=======================
📙 Bundle Registry
=========================


```solidity
function hasCurrentBundle(BundleRegistry storage bundle) internal view returns (bool);
```

### hasNotCurrentBundle


```solidity
function hasNotCurrentBundle(BundleRegistry storage bundle) internal view returns (bool);
```

### isComplete

==============
🏠 Proxy
================


```solidity
function isComplete(Proxy memory proxy) internal pure returns (bool);
```

### isInitialized


```solidity
function isInitialized(Proxy storage proxy) internal view returns (bool);
```

### isUninitialized


```solidity
function isUninitialized(Proxy storage proxy) internal view returns (bool);
```

### isNotUndefined

~~~~~~~~~~~~~~~~~~~
🏠 Proxy Kind
~~~~~~~~~~~~~~~~~~~~~


```solidity
function isNotUndefined(ProxyKind kind) internal pure returns (bool);
```

### isSupported

====================
📚 Dictionary
======================


```solidity
function isSupported(Dictionary memory dictionary, bytes4 selector) internal view returns (bool);
```

### isVerifiable


```solidity
function isVerifiable(Dictionary memory dictionary) internal returns (bool);
```

### isComplete


```solidity
function isComplete(Dictionary memory dictionary) internal pure returns (bool);
```

### isUninitialized


```solidity
function isUninitialized(Dictionary storage dictionary) internal view returns (bool);
```

### isNotUndefined

------------------------
📚 Dictionary Kind
--------------------------


```solidity
function isNotUndefined(DictionaryKind kind) internal pure returns (bool);
```

### isAssigned

===================
🧱 Primitives
=====================
📝 String


```solidity
function isAssigned(string storage str) internal pure returns (bool);
```

### isEmpty


```solidity
function isEmpty(string memory str) internal pure returns (bool);
```

### isNotEmpty


```solidity
function isNotEmpty(string memory str) internal pure returns (bool);
```

### isEqual


```solidity
function isEqual(string memory a, string memory b) internal pure returns (bool);
```

### isNotEqual


```solidity
function isNotEqual(string memory a, string memory b) internal pure returns (bool);
```

### isAssigned

💾 Bytes4


```solidity
function isAssigned(bytes4 selector) internal pure returns (bool);
```

### isEmpty


```solidity
function isEmpty(bytes4 selector) internal pure returns (bool);
```

### isNotEmpty


```solidity
function isNotEmpty(bytes4 selector) internal pure returns (bool);
```

### isEqual


```solidity
function isEqual(bytes4 a, bytes4 b) internal pure returns (bool);
```

### isNotEqual


```solidity
function isNotEqual(bytes4 a, bytes4 b) internal pure returns (bool);
```

### isZero

📌 Address


```solidity
function isZero(address addr) internal pure returns (bool);
```

### isNotZero


```solidity
function isNotZero(address addr) internal pure returns (bool);
```

### hasCode


```solidity
function hasCode(address addr) internal view returns (bool);
```

### hasNotCode


```solidity
function hasNotCode(address addr) internal view returns (bool);
```

### isContract


```solidity
function isContract(address addr) internal view returns (bool);
```

### isNotContract


```solidity
function isNotContract(address addr) internal view returns (bool);
```

### isNot

✅ Bool


```solidity
function isNot(bool flag) internal pure returns (bool);
```

### isFalse


```solidity
function isFalse(bool flag) internal pure returns (bool);
```

### isNotZero

#️⃣ Uint


```solidity
function isNotZero(uint256 num) internal pure returns (bool);
```

### isUninitialized

===================
🔒 Type Guard
=====================


```solidity
function isUninitialized(TypeStatus status) internal pure returns (bool);
```

### isInitialized


```solidity
function isInitialized(TypeStatus status) internal pure returns (bool);
```

### isBuilding


```solidity
function isBuilding(TypeStatus status) internal pure returns (bool);
```

### isBuilt


```solidity
function isBuilt(TypeStatus status) internal pure returns (bool);
```

### isLocked


```solidity
function isLocked(TypeStatus status) internal pure returns (bool);
```

### isNotLocked


```solidity
function isNotLocked(TypeStatus status) internal pure returns (bool);
```

### isComplete


```solidity
function isComplete(TypeStatus status) internal pure returns (bool);
```

