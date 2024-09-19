# IERC721TokenReceiver
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/Flattened.sol)

*Note: the ERC-165 identifier for this interface is 0x150b7a02.*


## Functions
### onERC721Received

Handle the receipt of an NFT

*The ERC721 smart contract calls this function on the recipient
after a `transfer`. This function MAY throw to revert and reject the
transfer. Return of other than the magic value MUST result in the
transaction being reverted.
Note: the contract address is always the message sender.*


```solidity
function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes calldata _data)
    external
    returns (bytes4);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_operator`|`address`|The address which called `safeTransferFrom` function|
|`_from`|`address`|The address which previously owned the token|
|`_tokenId`|`uint256`|The NFT identifier which is being transferred|
|`_data`|`bytes`|Additional data with no specified format|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes4`|`bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))` unless throwing|


