# Address
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/Flattened.sol)

*Collection of functions related to the address type*


## Functions
### sendValue

*Replacement for Solidity's `transfer`: sends `amount` wei to
`recipient`, forwarding all available gas and reverting on errors.
https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
of certain opcodes, possibly making contracts go over the 2300 gas limit
imposed by `transfer`, making them unable to receive funds via
`transfer`. [sendValue](/resources/devkit/api-reference/Flattened.sol/library.Address#sendvalue) removes this limitation.
https://consensys.net/diligence/blog/2019/09/stop-using-soliditys-transfer-now/[Learn more].
IMPORTANT: because control is transferred to `recipient`, care must be
taken to not create reentrancy vulnerabilities. Consider using
{ReentrancyGuard} or the
https://solidity.readthedocs.io/en/v0.8.20/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].*


```solidity
function sendValue(address payable recipient, uint256 amount) internal;
```

### functionCall

*Performs a Solidity function call using a low level `call`. A
plain `call` is an unsafe replacement for a function call: use this
function instead.
If `target` reverts with a revert reason or custom error, it is bubbled
up by this function (like regular Solidity function calls). However, if
the call reverted with no returned reason, this function reverts with a
[FailedInnerCall](/resources/devkit/api-reference/Flattened.sol/library.Address#failedinnercall) error.
Returns the raw returned data. To convert to the expected return value,
use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
Requirements:
- `target` must be a contract.
- calling `target` with `data` must not revert.*


```solidity
function functionCall(address target, bytes memory data) internal returns (bytes memory);
```

### functionCallWithValue

*Same as [`functionCall`](/lib/ucs-contracts/lib/openzeppelin-contracts/contracts/mocks/token/ERC20Reentrant.sol/contract.ERC20Reentrant.md#functioncall),
but also transferring `value` wei to `target`.
Requirements:
- the calling contract must have an ETH balance of at least `value`.
- the called Solidity function must be `payable`.*


```solidity
function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory);
```

### functionStaticCall

*Same as [`functionCall`](/lib/ucs-contracts/lib/openzeppelin-contracts/contracts/mocks/token/ERC20Reentrant.sol/contract.ERC20Reentrant.md#functioncall),
but performing a static call.*


```solidity
function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory);
```

### functionDelegateCall

*Same as [`functionCall`](/lib/ucs-contracts/lib/openzeppelin-contracts/contracts/mocks/token/ERC20Reentrant.sol/contract.ERC20Reentrant.md#functioncall),
but performing a delegate call.*


```solidity
function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory);
```

### verifyCallResultFromTarget

*Tool to verify that a low level call to smart-contract was successful, and reverts if the target
was not a contract or bubbling up the revert reason (falling back to [FailedInnerCall](/resources/devkit/api-reference/Flattened.sol/library.Address#failedinnercall)) in case of an
unsuccessful call.*


```solidity
function verifyCallResultFromTarget(address target, bool success, bytes memory returndata)
    internal
    view
    returns (bytes memory);
```

### verifyCallResult

*Tool to verify that a low level call was successful, and reverts if it wasn't, either by bubbling the
revert reason or with a default [FailedInnerCall](/resources/devkit/api-reference/Flattened.sol/library.Address#failedinnercall) error.*


```solidity
function verifyCallResult(bool success, bytes memory returndata) internal pure returns (bytes memory);
```

### _revert

*Reverts with returndata if present. Otherwise reverts with [FailedInnerCall](/resources/devkit/api-reference/Flattened.sol/library.Address#failedinnercall).*


```solidity
function _revert(bytes memory returndata) private pure;
```

## Errors
### AddressInsufficientBalance
*The ETH balance of the account is not enough to perform the operation.*


```solidity
error AddressInsufficientBalance(address account);
```

### AddressEmptyCode
*There's no code at `target` (it is not a contract).*


```solidity
error AddressEmptyCode(address target);
```

### FailedInnerCall
*A call to an address target failed. The target may have reverted.*


```solidity
error FailedInnerCall();
```

