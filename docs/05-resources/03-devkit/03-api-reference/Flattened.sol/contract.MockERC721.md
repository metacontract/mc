# MockERC721
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/Flattened.sol)

**Inherits:**
[IERC721Metadata](/src/devkit/Flattened.sol/interface.IERC721Metadata.md)

This is a mock contract of the ERC721 standard for testing purposes only, it SHOULD NOT be used in production.

*Forked from: https://github.com/transmissions11/solmate/blob/0384dbaaa4fcb5715738a9254a7c0a4cb62cf458/src/tokens/ERC721.sol*


## State Variables
### _name

```solidity
string internal _name;
```


### _symbol

```solidity
string internal _symbol;
```


### _ownerOf

```solidity
mapping(uint256 => address) internal _ownerOf;
```


### _balanceOf

```solidity
mapping(address => uint256) internal _balanceOf;
```


### _getApproved

```solidity
mapping(uint256 => address) internal _getApproved;
```


### _isApprovedForAll

```solidity
mapping(address => mapping(address => bool)) internal _isApprovedForAll;
```


### initialized
*A bool to track whether the contract has been initialized.*


```solidity
bool private initialized;
```


## Functions
### name


```solidity
function name() external view override returns (string memory);
```

### symbol


```solidity
function symbol() external view override returns (string memory);
```

### tokenURI


```solidity
function tokenURI(uint256 id) public view virtual override returns (string memory);
```

### ownerOf


```solidity
function ownerOf(uint256 id) public view virtual override returns (address owner);
```

### balanceOf


```solidity
function balanceOf(address owner) public view virtual override returns (uint256);
```

### getApproved


```solidity
function getApproved(uint256 id) public view virtual override returns (address);
```

### isApprovedForAll


```solidity
function isApprovedForAll(address owner, address operator) public view virtual override returns (bool);
```

### initialize

*To hide constructor warnings across solc versions due to different constructor visibility requirements and
syntaxes, we add an initialization function that can be called only once.*


```solidity
function initialize(string memory name_, string memory symbol_) public;
```

### approve


```solidity
function approve(address spender, uint256 id) public payable virtual override;
```

### setApprovalForAll


```solidity
function setApprovalForAll(address operator, bool approved) public virtual override;
```

### transferFrom


```solidity
function transferFrom(address from, address to, uint256 id) public payable virtual override;
```

### safeTransferFrom


```solidity
function safeTransferFrom(address from, address to, uint256 id) public payable virtual override;
```

### safeTransferFrom


```solidity
function safeTransferFrom(address from, address to, uint256 id, bytes memory data) public payable virtual override;
```

### supportsInterface


```solidity
function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool);
```

### _mint


```solidity
function _mint(address to, uint256 id) internal virtual;
```

### _burn


```solidity
function _burn(uint256 id) internal virtual;
```

### _safeMint


```solidity
function _safeMint(address to, uint256 id) internal virtual;
```

### _safeMint


```solidity
function _safeMint(address to, uint256 id, bytes memory data) internal virtual;
```

### _isContract


```solidity
function _isContract(address _addr) private view returns (bool);
```

