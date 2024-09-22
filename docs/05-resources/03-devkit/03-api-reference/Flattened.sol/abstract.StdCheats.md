# StdCheats
[Git Source](https://github.com/metacontract/mc/blob/d41f04df9ea19494be75c66f344b8104caf03cd2/resources/devkit/api-reference/Flattened.sol)

**Inherits:**
[StdCheatsSafe](/resources/devkit/api-reference/Flattened.sol/abstract.StdCheatsSafe)


## State Variables
### stdstore

```solidity
StdStorage private stdstore;
```


### vm

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));
```


### CONSOLE2_ADDRESS

```solidity
address private constant CONSOLE2_ADDRESS = 0x000000000000000000636F6e736F6c652e6c6f67;
```


## Functions
### skip


```solidity
function skip(uint256 time) internal virtual;
```

### rewind


```solidity
function rewind(uint256 time) internal virtual;
```

### hoax


```solidity
function hoax(address msgSender) internal virtual;
```

### hoax


```solidity
function hoax(address msgSender, uint256 give) internal virtual;
```

### hoax


```solidity
function hoax(address msgSender, address origin) internal virtual;
```

### hoax


```solidity
function hoax(address msgSender, address origin, uint256 give) internal virtual;
```

### startHoax


```solidity
function startHoax(address msgSender) internal virtual;
```

### startHoax


```solidity
function startHoax(address msgSender, uint256 give) internal virtual;
```

### startHoax


```solidity
function startHoax(address msgSender, address origin) internal virtual;
```

### startHoax


```solidity
function startHoax(address msgSender, address origin, uint256 give) internal virtual;
```

### changePrank


```solidity
function changePrank(address msgSender) internal virtual;
```

### changePrank


```solidity
function changePrank(address msgSender, address txOrigin) internal virtual;
```

### deal


```solidity
function deal(address to, uint256 give) internal virtual;
```

### deal


```solidity
function deal(address token, address to, uint256 give) internal virtual;
```

### dealERC1155


```solidity
function dealERC1155(address token, address to, uint256 id, uint256 give) internal virtual;
```

### deal


```solidity
function deal(address token, address to, uint256 give, bool adjust) internal virtual;
```

### dealERC1155


```solidity
function dealERC1155(address token, address to, uint256 id, uint256 give, bool adjust) internal virtual;
```

### dealERC721


```solidity
function dealERC721(address token, address to, uint256 id) internal virtual;
```

### deployCodeTo


```solidity
function deployCodeTo(string memory what, address where) internal virtual;
```

### deployCodeTo


```solidity
function deployCodeTo(string memory what, bytes memory args, address where) internal virtual;
```

### deployCodeTo


```solidity
function deployCodeTo(string memory what, bytes memory args, uint256 value, address where) internal virtual;
```

### console2_log_StdCheats


```solidity
function console2_log_StdCheats(string memory p0) private view;
```

