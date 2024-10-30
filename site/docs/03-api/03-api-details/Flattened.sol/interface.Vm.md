# Vm
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/devkit/Flattened.sol)

**Inherits:**
[VmSafe](interface.VmSafe.md)

The `Vm` interface does allow manipulation of the EVM state. These are all intended to be used
in tests, but it is not recommended to use these cheats in scripts.


## Functions
### activeFork

Returns the identifier of the currently active fork. Reverts if no fork is currently active.


```solidity
function activeFork() external view returns (uint256 forkId);
```

### allowCheatcodes

In forking mode, explicitly grant the given address cheatcode access.


```solidity
function allowCheatcodes(address account) external;
```

### blobBaseFee

Sets `block.blobbasefee`


```solidity
function blobBaseFee(uint256 newBlobBaseFee) external;
```

### blobhashes

Sets the blobhashes in the transaction.
Not available on EVM versions before Cancun.
If used on unsupported EVM versions it will revert.


```solidity
function blobhashes(bytes32[] calldata hashes) external;
```

### chainId

Sets `block.chainid`.


```solidity
function chainId(uint256 newChainId) external;
```

### clearMockedCalls

Clears all mocked calls.


```solidity
function clearMockedCalls() external;
```

### coinbase

Sets `block.coinbase`.


```solidity
function coinbase(address newCoinbase) external;
```

### createFork

Creates a new fork with the given endpoint and the _latest_ block and returns the identifier of the fork.


```solidity
function createFork(string calldata urlOrAlias) external returns (uint256 forkId);
```

### createFork

Creates a new fork with the given endpoint and block and returns the identifier of the fork.


```solidity
function createFork(string calldata urlOrAlias, uint256 blockNumber) external returns (uint256 forkId);
```

### createFork

Creates a new fork with the given endpoint and at the block the given transaction was mined in,
replays all transaction mined in the block before the transaction, and returns the identifier of the fork.


```solidity
function createFork(string calldata urlOrAlias, bytes32 txHash) external returns (uint256 forkId);
```

### createSelectFork

Creates and also selects a new fork with the given endpoint and the latest block and returns the identifier of the fork.


```solidity
function createSelectFork(string calldata urlOrAlias) external returns (uint256 forkId);
```

### createSelectFork

Creates and also selects a new fork with the given endpoint and block and returns the identifier of the fork.


```solidity
function createSelectFork(string calldata urlOrAlias, uint256 blockNumber) external returns (uint256 forkId);
```

### createSelectFork

Creates and also selects new fork with the given endpoint and at the block the given transaction was mined in,
replays all transaction mined in the block before the transaction, returns the identifier of the fork.


```solidity
function createSelectFork(string calldata urlOrAlias, bytes32 txHash) external returns (uint256 forkId);
```

### deal

Sets an address' balance.


```solidity
function deal(address account, uint256 newBalance) external;
```

### deleteSnapshot

Removes the snapshot with the given ID created by `snapshot`.
Takes the snapshot ID to delete.
Returns `true` if the snapshot was successfully deleted.
Returns `false` if the snapshot does not exist.


```solidity
function deleteSnapshot(uint256 snapshotId) external returns (bool success);
```

### deleteSnapshots

Removes _all_ snapshots previously created by `snapshot`.


```solidity
function deleteSnapshots() external;
```

### difficulty

Sets `block.difficulty`.
Not available on EVM versions from Paris onwards. Use `prevrandao` instead.
Reverts if used on unsupported EVM versions.


```solidity
function difficulty(uint256 newDifficulty) external;
```

### dumpState

Dump a genesis JSON file's `allocs` to disk.


```solidity
function dumpState(string calldata pathToStateJson) external;
```

### etch

Sets an address' code.


```solidity
function etch(address target, bytes calldata newRuntimeBytecode) external;
```

### fee

Sets `block.basefee`.


```solidity
function fee(uint256 newBasefee) external;
```

### getBlobhashes

Gets the blockhashes from the current transaction.
Not available on EVM versions before Cancun.
If used on unsupported EVM versions it will revert.


```solidity
function getBlobhashes() external view returns (bytes32[] memory hashes);
```

### isPersistent

Returns true if the account is marked as persistent.


```solidity
function isPersistent(address account) external view returns (bool persistent);
```

### loadAllocs

Load a genesis JSON file's `allocs` into the in-memory revm state.


```solidity
function loadAllocs(string calldata pathToAllocsJson) external;
```

### makePersistent

Marks that the account(s) should use persistent storage across fork swaps in a multifork setup
Meaning, changes made to the state of this account will be kept when switching forks.


```solidity
function makePersistent(address account) external;
```

### makePersistent

See `makePersistent(address)`.


```solidity
function makePersistent(address account0, address account1) external;
```

### makePersistent

See `makePersistent(address)`.


```solidity
function makePersistent(address account0, address account1, address account2) external;
```

### makePersistent

See `makePersistent(address)`.


```solidity
function makePersistent(address[] calldata accounts) external;
```

### mockCallRevert

Reverts a call to an address with specified revert data.


```solidity
function mockCallRevert(address callee, bytes calldata data, bytes calldata revertData) external;
```

### mockCallRevert

Reverts a call to an address with a specific `msg.value`, with specified revert data.


```solidity
function mockCallRevert(address callee, uint256 msgValue, bytes calldata data, bytes calldata revertData) external;
```

### mockCall

Mocks a call to an address, returning specified data.
Calldata can either be strict or a partial match, e.g. if you only
pass a Solidity selector to the expected calldata, then the entire Solidity
function will be mocked.


```solidity
function mockCall(address callee, bytes calldata data, bytes calldata returnData) external;
```

### mockCall

Mocks a call to an address with a specific `msg.value`, returning specified data.
Calldata match takes precedence over `msg.value` in case of ambiguity.


```solidity
function mockCall(address callee, uint256 msgValue, bytes calldata data, bytes calldata returnData) external;
```

### mockFunction

Whenever a call is made to `callee` with calldata `data`, this cheatcode instead calls
`target` with the same calldata. This functionality is similar to a delegate call made to
`target` contract from `callee`.
Can be used to substitute a call to a function with another implementation that captures
the primary logic of the original function but is easier to reason about.
If calldata is not a strict match then partial match by selector is attempted.


```solidity
function mockFunction(address callee, address target, bytes calldata data) external;
```

### prank

Sets the *next* call's `msg.sender` to be the input address.


```solidity
function prank(address msgSender) external;
```

### prank

Sets the *next* call's `msg.sender` to be the input address, and the `tx.origin` to be the second input.


```solidity
function prank(address msgSender, address txOrigin) external;
```

### prevrandao

Sets `block.prevrandao`.
Not available on EVM versions before Paris. Use `difficulty` instead.
If used on unsupported EVM versions it will revert.


```solidity
function prevrandao(bytes32 newPrevrandao) external;
```

### prevrandao

Sets `block.prevrandao`.
Not available on EVM versions before Paris. Use `difficulty` instead.
If used on unsupported EVM versions it will revert.


```solidity
function prevrandao(uint256 newPrevrandao) external;
```

### readCallers

Reads the current `msg.sender` and `tx.origin` from state and reports if there is any active caller modification.


```solidity
function readCallers() external returns (CallerMode callerMode, address msgSender, address txOrigin);
```

### resetNonce

Resets the nonce of an account to 0 for EOAs and 1 for contract accounts.


```solidity
function resetNonce(address account) external;
```

### revertTo

Revert the state of the EVM to a previous snapshot
Takes the snapshot ID to revert to.
Returns `true` if the snapshot was successfully reverted.
Returns `false` if the snapshot does not exist.
**Note:** This does not automatically delete the snapshot. To delete the snapshot use `deleteSnapshot`.


```solidity
function revertTo(uint256 snapshotId) external returns (bool success);
```

### revertToAndDelete

Revert the state of the EVM to a previous snapshot and automatically deletes the snapshots
Takes the snapshot ID to revert to.
Returns `true` if the snapshot was successfully reverted and deleted.
Returns `false` if the snapshot does not exist.


```solidity
function revertToAndDelete(uint256 snapshotId) external returns (bool success);
```

### revokePersistent

Revokes persistent status from the address, previously added via `makePersistent`.


```solidity
function revokePersistent(address account) external;
```

### revokePersistent

See `revokePersistent(address)`.


```solidity
function revokePersistent(address[] calldata accounts) external;
```

### roll

Sets `block.height`.


```solidity
function roll(uint256 newHeight) external;
```

### rollFork

Updates the currently active fork to given block number
This is similar to `roll` but for the currently active fork.


```solidity
function rollFork(uint256 blockNumber) external;
```

### rollFork

Updates the currently active fork to given transaction. This will `rollFork` with the number
of the block the transaction was mined in and replays all transaction mined before it in the block.


```solidity
function rollFork(bytes32 txHash) external;
```

### rollFork

Updates the given fork to given block number.


```solidity
function rollFork(uint256 forkId, uint256 blockNumber) external;
```

### rollFork

Updates the given fork to block number of the given transaction and replays all transaction mined before it in the block.


```solidity
function rollFork(uint256 forkId, bytes32 txHash) external;
```

### selectFork

Takes a fork identifier created by `createFork` and sets the corresponding forked state as active.


```solidity
function selectFork(uint256 forkId) external;
```

### setBlockhash

Set blockhash for the current block.
It only sets the blockhash for blocks where `block.number - 256 <= number < block.number`.


```solidity
function setBlockhash(uint256 blockNumber, bytes32 blockHash) external;
```

### setNonce

Sets the nonce of an account. Must be higher than the current nonce of the account.


```solidity
function setNonce(address account, uint64 newNonce) external;
```

### setNonceUnsafe

Sets the nonce of an account to an arbitrary value.


```solidity
function setNonceUnsafe(address account, uint64 newNonce) external;
```

### snapshot

Snapshot the current state of the evm.
Returns the ID of the snapshot that was created.
To revert a snapshot use `revertTo`.


```solidity
function snapshot() external returns (uint256 snapshotId);
```

### startPrank

Sets all subsequent calls' `msg.sender` to be the input address until `stopPrank` is called.


```solidity
function startPrank(address msgSender) external;
```

### startPrank

Sets all subsequent calls' `msg.sender` to be the input address until `stopPrank` is called, and the `tx.origin` to be the second input.


```solidity
function startPrank(address msgSender, address txOrigin) external;
```

### stopPrank

Resets subsequent calls' `msg.sender` to be `address(this)`.


```solidity
function stopPrank() external;
```

### store

Stores a value to an address' storage slot.


```solidity
function store(address target, bytes32 slot, bytes32 value) external;
```

### transact

Fetches the given transaction from the active fork and executes it on the current state.


```solidity
function transact(bytes32 txHash) external;
```

### transact

Fetches the given transaction from the given fork and executes it on the current state.


```solidity
function transact(uint256 forkId, bytes32 txHash) external;
```

### txGasPrice

Sets `tx.gasprice`.


```solidity
function txGasPrice(uint256 newGasPrice) external;
```

### warp

Sets `block.timestamp`.


```solidity
function warp(uint256 newTimestamp) external;
```

### expectCallMinGas

Expect a call to an address with the specified `msg.value` and calldata, and a *minimum* amount of gas.


```solidity
function expectCallMinGas(address callee, uint256 msgValue, uint64 minGas, bytes calldata data) external;
```

### expectCallMinGas

Expect given number of calls to an address with the specified `msg.value` and calldata, and a *minimum* amount of gas.


```solidity
function expectCallMinGas(address callee, uint256 msgValue, uint64 minGas, bytes calldata data, uint64 count)
    external;
```

### expectCall

Expects a call to an address with the specified calldata.
Calldata can either be a strict or a partial match.


```solidity
function expectCall(address callee, bytes calldata data) external;
```

### expectCall

Expects given number of calls to an address with the specified calldata.


```solidity
function expectCall(address callee, bytes calldata data, uint64 count) external;
```

### expectCall

Expects a call to an address with the specified `msg.value` and calldata.


```solidity
function expectCall(address callee, uint256 msgValue, bytes calldata data) external;
```

### expectCall

Expects given number of calls to an address with the specified `msg.value` and calldata.


```solidity
function expectCall(address callee, uint256 msgValue, bytes calldata data, uint64 count) external;
```

### expectCall

Expect a call to an address with the specified `msg.value`, gas, and calldata.


```solidity
function expectCall(address callee, uint256 msgValue, uint64 gas, bytes calldata data) external;
```

### expectCall

Expects given number of calls to an address with the specified `msg.value`, gas, and calldata.


```solidity
function expectCall(address callee, uint256 msgValue, uint64 gas, bytes calldata data, uint64 count) external;
```

### expectEmitAnonymous

Prepare an expected anonymous log with (bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData.).
Call this function, then emit an anonymous event, then call a function. Internally after the call, we check if
logs were emitted in the expected order with the expected topics and data (as specified by the booleans).


```solidity
function expectEmitAnonymous(bool checkTopic0, bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData)
    external;
```

### expectEmitAnonymous

Same as the previous method, but also checks supplied address against emitting contract.


```solidity
function expectEmitAnonymous(
    bool checkTopic0,
    bool checkTopic1,
    bool checkTopic2,
    bool checkTopic3,
    bool checkData,
    address emitter
) external;
```

### expectEmitAnonymous

Prepare an expected anonymous log with all topic and data checks enabled.
Call this function, then emit an anonymous event, then call a function. Internally after the call, we check if
logs were emitted in the expected order with the expected topics and data.


```solidity
function expectEmitAnonymous() external;
```

### expectEmitAnonymous

Same as the previous method, but also checks supplied address against emitting contract.


```solidity
function expectEmitAnonymous(address emitter) external;
```

### expectEmit

Prepare an expected log with (bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData.).
Call this function, then emit an event, then call a function. Internally after the call, we check if
logs were emitted in the expected order with the expected topics and data (as specified by the booleans).


```solidity
function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData) external;
```

### expectEmit

Same as the previous method, but also checks supplied address against emitting contract.


```solidity
function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, address emitter) external;
```

### expectEmit

Prepare an expected log with all topic and data checks enabled.
Call this function, then emit an event, then call a function. Internally after the call, we check if
logs were emitted in the expected order with the expected topics and data.


```solidity
function expectEmit() external;
```

### expectEmit

Same as the previous method, but also checks supplied address against emitting contract.


```solidity
function expectEmit(address emitter) external;
```

### expectPartialRevert

Expects an error on next call that starts with the revert data.


```solidity
function expectPartialRevert(bytes4 revertData) external;
```

### expectRevert

Expects an error on next call with any revert data.


```solidity
function expectRevert() external;
```

### expectRevert

Expects an error on next call that exactly matches the revert data.


```solidity
function expectRevert(bytes4 revertData) external;
```

### expectRevert

Expects an error on next call that exactly matches the revert data.


```solidity
function expectRevert(bytes calldata revertData) external;
```

### expectSafeMemory

Only allows memory writes to offsets [0x00, 0x60) ∪ [min, max) in the current subcontext. If any other
memory is written to, the test will fail. Can be called multiple times to add more ranges to the set.


```solidity
function expectSafeMemory(uint64 min, uint64 max) external;
```

### expectSafeMemoryCall

Only allows memory writes to offsets [0x00, 0x60) ∪ [min, max) in the next created subcontext.
If any other memory is written to, the test will fail. Can be called multiple times to add more ranges
to the set.


```solidity
function expectSafeMemoryCall(uint64 min, uint64 max) external;
```

### skip

Marks a test as skipped. Must be called at the top of the test.


```solidity
function skip(bool skipTest) external;
```

### stopExpectSafeMemory

Stops all safe memory expectation in the current subcontext.


```solidity
function stopExpectSafeMemory() external;
```

