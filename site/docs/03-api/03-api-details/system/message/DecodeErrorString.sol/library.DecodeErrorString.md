# DecodeErrorString
[Git Source](https://github.com/metacontract/mc/blob/b874bc295b567a7e9bd6d6c63dfe84df116a2f3a/src/devkit/system/message/DecodeErrorString.sol)


## Functions
### decodeRevertReason

*Decodes a revert reason from ABI-encoded data.*


```solidity
function decodeRevertReason(bytes memory data) public pure returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data`|`bytes`|ABI-encoded revert reason.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|reason The decoded revert reason as a string.|


### decodePanicCode

*Decodes a panic code from bytes.*


```solidity
function decodePanicCode(bytes memory data) internal pure returns (uint256 code);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data`|`bytes`|Bytes containing the panic code.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`code`|`uint256`|The decoded panic code as a uint256.|


### decodeRevertReasonAndPanicCode

*Attempts to decode both revert reasons and panic codes.*


```solidity
function decodeRevertReasonAndPanicCode(bytes memory data) internal pure returns (string memory result);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data`|`bytes`|Bytes containing either a revert reason or a panic code.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`result`|`string`|The decoded message as a string.|


### panicCodeToString

*Converts a panic code to a human-readable string. (These messages are not accurate and also need to be chase upstream implementation.)*


```solidity
function panicCodeToString(uint256 code) private pure returns (string memory reason);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`code`|`uint256`|The panic code as a uint256.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`reason`|`string`|The corresponding human-readable string.|


