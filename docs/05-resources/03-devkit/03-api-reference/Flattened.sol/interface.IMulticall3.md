# IMulticall3
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/Flattened.sol)


## Functions
### aggregate


```solidity
function aggregate(Call[] calldata calls) external payable returns (uint256 blockNumber, bytes[] memory returnData);
```

### aggregate3


```solidity
function aggregate3(Call3[] calldata calls) external payable returns (Result[] memory returnData);
```

### aggregate3Value


```solidity
function aggregate3Value(Call3Value[] calldata calls) external payable returns (Result[] memory returnData);
```

### blockAndAggregate


```solidity
function blockAndAggregate(Call[] calldata calls)
    external
    payable
    returns (uint256 blockNumber, bytes32 blockHash, Result[] memory returnData);
```

### getBasefee


```solidity
function getBasefee() external view returns (uint256 basefee);
```

### getBlockHash


```solidity
function getBlockHash(uint256 blockNumber) external view returns (bytes32 blockHash);
```

### getBlockNumber


```solidity
function getBlockNumber() external view returns (uint256 blockNumber);
```

### getChainId


```solidity
function getChainId() external view returns (uint256 chainid);
```

### getCurrentBlockCoinbase


```solidity
function getCurrentBlockCoinbase() external view returns (address coinbase);
```

### getCurrentBlockDifficulty


```solidity
function getCurrentBlockDifficulty() external view returns (uint256 difficulty);
```

### getCurrentBlockGasLimit


```solidity
function getCurrentBlockGasLimit() external view returns (uint256 gaslimit);
```

### getCurrentBlockTimestamp


```solidity
function getCurrentBlockTimestamp() external view returns (uint256 timestamp);
```

### getEthBalance


```solidity
function getEthBalance(address addr) external view returns (uint256 balance);
```

### getLastBlockHash


```solidity
function getLastBlockHash() external view returns (bytes32 blockHash);
```

### tryAggregate


```solidity
function tryAggregate(bool requireSuccess, Call[] calldata calls)
    external
    payable
    returns (Result[] memory returnData);
```

### tryBlockAndAggregate


```solidity
function tryBlockAndAggregate(bool requireSuccess, Call[] calldata calls)
    external
    payable
    returns (uint256 blockNumber, bytes32 blockHash, Result[] memory returnData);
```

## Structs
### Call

```solidity
struct Call {
    address target;
    bytes callData;
}
```

### Call3

```solidity
struct Call3 {
    address target;
    bool allowFailure;
    bytes callData;
}
```

### Call3Value

```solidity
struct Call3Value {
    address target;
    bool allowFailure;
    uint256 value;
    bytes callData;
}
```

### Result

```solidity
struct Result {
    bool success;
    bytes returnData;
}
```

