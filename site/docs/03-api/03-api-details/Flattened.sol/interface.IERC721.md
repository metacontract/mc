# IERC721
[Git Source](https://github.com/metacontract/mc/blob/b874bc295b567a7e9bd6d6c63dfe84df116a2f3a/src/devkit/Flattened.sol)

**Inherits:**
[IERC165_0](interface.IERC165_0.md)

*See https://eips.ethereum.org/EIPS/eip-721
Note: the ERC-165 identifier for this interface is 0x80ac58cd.*


## Functions
### balanceOf

Count all NFTs assigned to an owner

*NFTs assigned to the zero address are considered invalid, and this
function throws for queries about the zero address.*


```solidity
function balanceOf(address _owner) external view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_owner`|`address`|An address for whom to query the balance|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The number of NFTs owned by `_owner`, possibly zero|


### ownerOf

Find the owner of an NFT

*NFTs assigned to zero address are considered invalid, and queries
about them do throw.*


```solidity
function ownerOf(uint256 _tokenId) external view returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_tokenId`|`uint256`|The identifier for an NFT|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address of the owner of the NFT|


### safeTransferFrom

Transfers the ownership of an NFT from one address to another address

*Throws unless `msg.sender` is the current owner, an authorized
operator, or the approved address for this NFT. Throws if `_from` is
not the current owner. Throws if `_to` is the zero address. Throws if
`_tokenId` is not a valid NFT. When transfer is complete, this function
checks if `_to` is a smart contract (code size > 0). If so, it calls
`onERC721Received` on `_to` and throws if the return value is not
`bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`.*


```solidity
function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_from`|`address`|The current owner of the NFT|
|`_to`|`address`|The new owner|
|`_tokenId`|`uint256`|The NFT to transfer|
|`data`|`bytes`|Additional data with no specified format, sent in call to `_to`|


### safeTransferFrom

Transfers the ownership of an NFT from one address to another address

*This works identically to the other function with an extra data parameter,
except this function just sets data to "".*


```solidity
function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_from`|`address`|The current owner of the NFT|
|`_to`|`address`|The new owner|
|`_tokenId`|`uint256`|The NFT to transfer|


### transferFrom

Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
THEY MAY BE PERMANENTLY LOST

*Throws unless `msg.sender` is the current owner, an authorized
operator, or the approved address for this NFT. Throws if `_from` is
not the current owner. Throws if `_to` is the zero address. Throws if
`_tokenId` is not a valid NFT.*


```solidity
function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_from`|`address`|The current owner of the NFT|
|`_to`|`address`|The new owner|
|`_tokenId`|`uint256`|The NFT to transfer|


### approve

Change or reaffirm the approved address for an NFT

*The zero address indicates there is no approved address.
Throws unless `msg.sender` is the current NFT owner, or an authorized
operator of the current owner.*


```solidity
function approve(address _approved, uint256 _tokenId) external payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_approved`|`address`|The new approved NFT controller|
|`_tokenId`|`uint256`|The NFT to approve|


### setApprovalForAll

Enable or disable approval for a third party ("operator") to manage
all of `msg.sender`'s assets

*Emits the ApprovalForAll event. The contract MUST allow
multiple operators per owner.*


```solidity
function setApprovalForAll(address _operator, bool _approved) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_operator`|`address`|Address to add to the set of authorized operators|
|`_approved`|`bool`|True if the operator is approved, false to revoke approval|


### getApproved

Get the approved address for a single NFT

*Throws if `_tokenId` is not a valid NFT.*


```solidity
function getApproved(uint256 _tokenId) external view returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_tokenId`|`uint256`|The NFT to find the approved address for|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The approved address for this NFT, or the zero address if there is none|


### isApprovedForAll

Query if an address is an authorized operator for another address


```solidity
function isApprovedForAll(address _owner, address _operator) external view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_owner`|`address`|The address that owns the NFTs|
|`_operator`|`address`|The address that acts on behalf of the owner|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|True if `_operator` is an approved operator for `_owner`, false otherwise|


## Events
### Transfer
*This emits when ownership of any NFT changes by any mechanism.
This event emits when NFTs are created (`from` == 0) and destroyed
(`to` == 0). Exception: during contract creation, any number of NFTs
may be created and assigned without emitting Transfer. At the time of
any transfer, the approved address for that NFT (if any) is reset to none.*


```solidity
event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
```

### Approval
*This emits when the approved address for an NFT is changed or
reaffirmed. The zero address indicates there is no approved address.
When a Transfer event emits, this also indicates that the approved
address for that NFT (if any) is reset to none.*


```solidity
event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
```

### ApprovalForAll
*This emits when an operator is enabled or disabled for an owner.
The operator can manage all NFTs of the owner.*


```solidity
event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
```

