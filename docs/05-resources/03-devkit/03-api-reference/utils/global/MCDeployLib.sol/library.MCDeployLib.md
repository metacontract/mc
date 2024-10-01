# MCDeployLib
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/utils/global/MCDeployLib.sol)

🚀 Deployment
🌞 Deploy Meta Contract
- Deploy
- DeployImmutable
- DeployRestrictedUpgradeable
- DeployContractUpgradeable
🏠 Deploy Proxy
📚 Deploy Dictionary
🔂 Duplicate Dictionary
💽 Load Dictionary


## Functions
### deploy

-----------------------------
🌞 Deploy Meta Contract
-------------------------------


```solidity
function deploy(MCDevKit storage mc, Bundle storage bundle, address owner, bytes memory initData)
    internal
    returns (MCDevKit storage);
```

### deploy


```solidity
function deploy(MCDevKit storage mc) internal returns (MCDevKit storage);
```

### deploy


```solidity
function deploy(MCDevKit storage mc, Bundle storage bundle) internal returns (MCDevKit storage);
```

### deploy


```solidity
function deploy(MCDevKit storage mc, Bundle storage bundle, address owner) internal returns (MCDevKit storage);
```

### deploy


```solidity
function deploy(MCDevKit storage mc, Bundle storage bundle, bytes memory initData)
    internal
    returns (MCDevKit storage);
```

### deploy


```solidity
function deploy(MCDevKit storage mc, address owner) internal returns (MCDevKit storage);
```

### deploy


```solidity
function deploy(MCDevKit storage mc, address owner, bytes memory initData) internal returns (MCDevKit storage);
```

### deploy


```solidity
function deploy(MCDevKit storage mc, bytes memory initData) internal returns (MCDevKit storage);
```

### deployProxy

---------------------
🏠 Deploy Proxy
-----------------------


```solidity
function deployProxy(MCDevKit storage mc, Dictionary storage dictionary, bytes memory initData)
    internal
    returns (Proxy memory proxy);
```

### deployProxy

*Accepts any initData as input*


```solidity
function deployProxy(MCDevKit storage mc) internal returns (Proxy memory proxy);
```

### deployProxy


```solidity
function deployProxy(MCDevKit storage mc, Dictionary storage dictionary) internal returns (Proxy memory proxy);
```

### deployProxy


```solidity
function deployProxy(MCDevKit storage mc, bytes memory initData) internal returns (Proxy memory proxy);
```

### deployDictionary

-------------------------
📚 Deploy Dictionary
---------------------------


```solidity
function deployDictionary(MCDevKit storage mc, Bundle storage bundle, address owner)
    internal
    returns (Dictionary storage dictionary);
```

### deployDictionary


```solidity
function deployDictionary(MCDevKit storage mc) internal returns (Dictionary storage dictionary);
```

### deployDictionary


```solidity
function deployDictionary(MCDevKit storage mc, Bundle storage bundle)
    internal
    returns (Dictionary storage dictionary);
```

### deployDictionary


```solidity
function deployDictionary(MCDevKit storage mc, address owner) internal returns (Dictionary storage dictionary);
```

### duplicateDictionary

----------------------------
🔂 Duplicate Dictionary
------------------------------


```solidity
function duplicateDictionary(MCDevKit storage mc, Dictionary storage dictionary, address owner)
    internal
    returns (Dictionary storage duplicatedDictionary);
```

### duplicateDictionary


```solidity
function duplicateDictionary(MCDevKit storage mc) internal returns (Dictionary storage duplicatedDictionary);
```

### duplicateDictionary


```solidity
function duplicateDictionary(MCDevKit storage mc, Dictionary storage dictionary)
    internal
    returns (Dictionary storage duplicatedDictionary);
```

### duplicateDictionary


```solidity
function duplicateDictionary(MCDevKit storage mc, address owner)
    internal
    returns (Dictionary storage duplicatedDictionary);
```

### loadDictionary

------------------------
💽 Load Dictionary
--------------------------


```solidity
function loadDictionary(MCDevKit storage mc, string memory name, address dictionaryAddr)
    internal
    returns (Dictionary storage dictionary);
```

