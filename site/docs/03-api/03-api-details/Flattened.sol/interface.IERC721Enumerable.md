# IERC721Enumerable
[Git Source](https://github.com/metacontract/mc/blob/93e4f2d4a013f48ae1db91ed21bff3eb8a27ce1d/src/devkit/Flattened.sol)

**Inherits:**
[IERC721](interface.IERC721.md)

*See https://eips.ethereum.org/EIPS/eip-721
Note: the ERC-165 identifier for this interface is 0x780e9d63.*


## Functions
### totalSupply

Count NFTs tracked by this contract


```solidity
function totalSupply() external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|A count of valid NFTs tracked by this contract, where each one of them has an assigned and queryable owner not equal to the zero address|


### tokenByIndex

Enumerate valid NFTs

*Throws if `_index` >= `totalSupply()`.*


```solidity
function tokenByIndex(uint256 _index) external view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_index`|`uint256`|A counter less than `totalSupply()`|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The token identifier for the `_index`th NFT, (sort order not specified)|


### tokenOfOwnerByIndex

Enumerate NFTs assigned to an owner

*Throws if `_index` >= `balanceOf(_owner)` or if
`_owner` is the zero address, representing invalid NFTs.*


```solidity
function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_owner`|`address`|An address where we are interested in NFTs owned by them|
|`_index`|`uint256`|A counter less than `balanceOf(_owner)`|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The token identifier for the `_index`th NFT assigned to `_owner`, (sort order not specified)|


