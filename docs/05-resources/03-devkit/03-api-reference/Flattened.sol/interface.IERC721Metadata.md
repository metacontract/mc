# IERC721Metadata
[Git Source](https://github.com/metacontract/mc/blob/0cf91165f9ec2cbeeba800a4baf4e81e2df5c3bb/src/devkit/Flattened.sol)

**Inherits:**
[IERC721](/src/devkit/Flattened.sol/interface.IERC721.md)

*See https://eips.ethereum.org/EIPS/eip-721
Note: the ERC-165 identifier for this interface is 0x5b5e139f.*


## Functions
### name

A descriptive name for a collection of NFTs in this contract


```solidity
function name() external view returns (string memory _name);
```

### symbol

An abbreviated name for NFTs in this contract


```solidity
function symbol() external view returns (string memory _symbol);
```

### tokenURI

A distinct Uniform Resource Identifier (URI) for a given asset.

*Throws if `_tokenId` is not a valid NFT. URIs are defined in RFC
3986. The URI may point to a JSON file that conforms to the "ERC721
Metadata JSON Schema".*


```solidity
function tokenURI(uint256 _tokenId) external view returns (string memory);
```

