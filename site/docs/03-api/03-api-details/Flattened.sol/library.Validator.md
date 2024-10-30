# Validator
[Git Source](https://github.com/metacontract/mc/blob/main/src/devkit/Flattened.sol)

==================
✅ Validator
====================


## State Variables
### MUST

```solidity
Type constant MUST = Type.MUST;
```


### SHOULD

```solidity
Type constant SHOULD = Type.SHOULD;
```


### COMPLETION

```solidity
Type constant COMPLETION = Type.COMPLETION;
```


## Functions
### validate


```solidity
function validate(Type T, bool condition, string memory messageHead, string memory messageBody)
    internal
    view
    returns (bool res);
```

### noBroadcast


```solidity
modifier noBroadcast();
```

### SHOULD_FileExists

================
📝 Config
==================


```solidity
function SHOULD_FileExists(string memory path) internal returns (bool condition);
```

### MUST_FileExists


```solidity
function MUST_FileExists(string memory path) internal;
```

### MUST_NotEmptyName

===================
🧱 Primitives
=====================


```solidity
function MUST_NotEmptyName(string memory name) internal view;
```

### MUST_NotEmptyEnvKey


```solidity
function MUST_NotEmptyEnvKey(string memory envKey) internal view;
```

### SHOULD_NotEmptySelector


```solidity
function SHOULD_NotEmptySelector(bytes4 selector) internal view;
```

### MUST_AddressIsContract


```solidity
function MUST_AddressIsContract(address addr) internal view;
```

### SHOULD_FacadeIsContract


```solidity
function SHOULD_FacadeIsContract(address facade) internal view;
```

### SHOULD_OwnerIsNotZeroAddress


```solidity
function SHOULD_OwnerIsNotZeroAddress(address owner) internal view;
```

### MUST_NameFound

======================
📸 Current Context
========================


```solidity
function MUST_NameFound(Current storage current) internal view;
```

### ValidateBuilder

==================
🧩 Function
====================


```solidity
function ValidateBuilder(Function storage func) internal view returns (bool);
```

### MUST_Completed


```solidity
function MUST_Completed(Function memory func) internal view;
```

### MUST_NotLocked


```solidity
function MUST_NotLocked(Function storage func) internal view;
```

### MUST_Building


```solidity
function MUST_Building(Function storage func) internal view;
```

### MUST_Built


```solidity
function MUST_Built(Function storage func) internal view;
```

### MUST_Registered


```solidity
function MUST_Registered(FunctionRegistry storage registry, string memory name) internal view;
```

### ValidateBuilder

===============
🗂️ Bundle
=================


```solidity
function ValidateBuilder(Bundle storage bundle) internal view returns (bool);
```

### MUST_NotInitialized


```solidity
function MUST_NotInitialized(Bundle storage bundle) internal view;
```

### SHOULD_Completed


```solidity
function SHOULD_Completed(Bundle storage bundle) internal view;
```

### MUST_Completed


```solidity
function MUST_Completed(Bundle storage bundle) internal view;
```

### MUST_HaveFunction


```solidity
function MUST_HaveFunction(Bundle storage bundle) internal view;
```

### MUST_HaveUniqueSelector


```solidity
function MUST_HaveUniqueSelector(Bundle storage bundle, Function storage func) internal view;
```

### MUST_NotLocked


```solidity
function MUST_NotLocked(Bundle storage bundle) internal view;
```

### MUST_Building


```solidity
function MUST_Building(Bundle storage bundle) internal view;
```

### MUST_Built


```solidity
function MUST_Built(Bundle storage bundle) internal view;
```

### SHOULD_ExistCurrentBundle


```solidity
function SHOULD_ExistCurrentBundle(BundleRegistry storage registry) internal view returns (bool condition);
```

### MUST_ExistCurrentName


```solidity
function MUST_ExistCurrentName(BundleRegistry storage registry) internal view;
```

### ValidateBuilder

==============
🏠 Proxy
================


```solidity
function ValidateBuilder(Proxy_2 memory proxy) internal view returns (bool);
```

### MUST_Completed


```solidity
function MUST_Completed(Proxy_2 memory proxy) internal view;
```

### MUST_NotLocked


```solidity
function MUST_NotLocked(Proxy_2 memory proxy) internal view;
```

### MUST_Building


```solidity
function MUST_Building(Proxy_2 memory proxy) internal view;
```

### MUST_Built


```solidity
function MUST_Built(Proxy_2 memory proxy) internal view;
```

### MUST_Registered


```solidity
function MUST_Registered(ProxyRegistry storage registry, string memory name) internal view;
```

### MUST_NotRegistered


```solidity
function MUST_NotRegistered(ProxyRegistry storage registry, string memory name) internal view;
```

### MUST_ExistCurrentName


```solidity
function MUST_ExistCurrentName(ProxyRegistry storage registry) internal view;
```

### ValidateBuilder

====================
📚 Dictionary
======================


```solidity
function ValidateBuilder(Dictionary_1 memory dictionary) internal view returns (bool);
```

### MUST_Completed


```solidity
function MUST_Completed(Dictionary_1 memory dictionary) internal view;
```

### MUST_Verifiable


```solidity
function MUST_Verifiable(Dictionary_1 memory dictionary) internal noBroadcast;
```

### MUST_NotLocked


```solidity
function MUST_NotLocked(Dictionary_1 memory dictionary) internal view;
```

### MUST_Building


```solidity
function MUST_Building(Dictionary_1 memory dictionary) internal view;
```

### MUST_Built


```solidity
function MUST_Built(Dictionary_1 memory dictionary) internal view;
```

### MUST_Registered


```solidity
function MUST_Registered(DictionaryRegistry storage registry, string memory name) internal view;
```

### MUST_NotRegistered


```solidity
function MUST_NotRegistered(DictionaryRegistry storage registry, string memory name) internal view;
```

### MUST_ExistCurrentName


```solidity
function MUST_ExistCurrentName(DictionaryRegistry storage registry) internal view;
```

### ValidateBuilder

==========================
🏛 Standard Registry
============================


```solidity
function ValidateBuilder(StdRegistry storage registry) internal view returns (bool);
```

### MUST_Completed


```solidity
function MUST_Completed(StdRegistry storage registry) internal view;
```

### MUST_NotLocked


```solidity
function MUST_NotLocked(StdRegistry storage registry) internal view;
```

### MUST_Building


```solidity
function MUST_Building(StdRegistry storage registry) internal view;
```

### MUST_Built


```solidity
function MUST_Built(StdRegistry memory registry) internal view;
```

### ValidateBuilder

==========================
🏰 Standard Functions
============================


```solidity
function ValidateBuilder(StdFunctions storage std) internal view returns (bool);
```

### MUST_Completed


```solidity
function MUST_Completed(StdFunctions storage std) internal view;
```

### MUST_NotLocked


```solidity
function MUST_NotLocked(StdFunctions storage std) internal view;
```

### MUST_Building


```solidity
function MUST_Building(StdFunctions storage std) internal view;
```

### MUST_Built


```solidity
function MUST_Built(StdFunctions memory std) internal view;
```

### MUST_FoundInRange

=======================
🏷️ Name Generator
=========================


```solidity
function MUST_FoundInRange() internal view;
```

### MUST_UseFunctionContract

================
🧪 MCTest
==================


```solidity
function MUST_UseFunctionContract(address implementation) internal view;
```

## Enums
### Type

```solidity
enum Type {
    MUST,
    SHOULD,
    COMPLETION
}
```

