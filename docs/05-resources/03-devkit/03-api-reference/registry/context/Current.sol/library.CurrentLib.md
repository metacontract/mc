# CurrentLib
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/resources/devkit/api-reference/registry/context/Current.sol)


## Functions
### update

-------------------------------
🔄 Update Current Context
---------------------------------


```solidity
function update(Current storage current, string memory name) internal;
```

### reset

------------------------------
🧹 Reset Current Context
--------------------------------


```solidity
function reset(Current storage current) internal;
```

### find

------------------
🔍 Find Name
--------------------


```solidity
function find(Current storage current) internal returns (string memory name);
```

