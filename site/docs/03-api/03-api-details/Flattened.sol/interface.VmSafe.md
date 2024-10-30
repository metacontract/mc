# VmSafe
[Git Source](https://github.com/metacontract/mc/blob/93e4f2d4a013f48ae1db91ed21bff3eb8a27ce1d/src/devkit/Flattened.sol)

The `VmSafe` interface does not allow manipulation of the EVM state or other actions that may
result in Script simulations differing from on-chain execution. It is recommended to only use
these cheats in scripts.


## Functions
### createWallet

Derives a private key from the name, labels the account with that name, and returns the wallet.


```solidity
function createWallet(string calldata walletLabel) external returns (Wallet memory wallet);
```

### createWallet

Generates a wallet from the private key and returns the wallet.


```solidity
function createWallet(uint256 privateKey) external returns (Wallet memory wallet);
```

### createWallet

Generates a wallet from the private key, labels the account with that name, and returns the wallet.


```solidity
function createWallet(uint256 privateKey, string calldata walletLabel) external returns (Wallet memory wallet);
```

### deriveKey

Derive a private key from a provided mnenomic string (or mnenomic file path)
at the derivation path `m/44'/60'/0'/0/{index}`.


```solidity
function deriveKey(string calldata mnemonic, uint32 index) external pure returns (uint256 privateKey);
```

### deriveKey

Derive a private key from a provided mnenomic string (or mnenomic file path)
at `{derivationPath}{index}`.


```solidity
function deriveKey(string calldata mnemonic, string calldata derivationPath, uint32 index)
    external
    pure
    returns (uint256 privateKey);
```

### deriveKey

Derive a private key from a provided mnenomic string (or mnenomic file path) in the specified language
at the derivation path `m/44'/60'/0'/0/{index}`.


```solidity
function deriveKey(string calldata mnemonic, uint32 index, string calldata language)
    external
    pure
    returns (uint256 privateKey);
```

### deriveKey

Derive a private key from a provided mnenomic string (or mnenomic file path) in the specified language
at `{derivationPath}{index}`.


```solidity
function deriveKey(string calldata mnemonic, string calldata derivationPath, uint32 index, string calldata language)
    external
    pure
    returns (uint256 privateKey);
```

### publicKeyP256

Derives secp256r1 public key from the provided `privateKey`.


```solidity
function publicKeyP256(uint256 privateKey) external pure returns (uint256 publicKeyX, uint256 publicKeyY);
```

### rememberKey

Adds a private key to the local forge wallet and returns the address.


```solidity
function rememberKey(uint256 privateKey) external returns (address keyAddr);
```

### signCompact

Signs data with a `Wallet`.
Returns a compact signature (`r`, `vs`) as per EIP-2098, where `vs` encodes both the
signature's `s` value, and the recovery id `v` in a single bytes32.
This format reduces the signature size from 65 to 64 bytes.


```solidity
function signCompact(Wallet calldata wallet, bytes32 digest) external returns (bytes32 r, bytes32 vs);
```

### signCompact

Signs `digest` with `privateKey` using the secp256k1 curve.
Returns a compact signature (`r`, `vs`) as per EIP-2098, where `vs` encodes both the
signature's `s` value, and the recovery id `v` in a single bytes32.
This format reduces the signature size from 65 to 64 bytes.


```solidity
function signCompact(uint256 privateKey, bytes32 digest) external pure returns (bytes32 r, bytes32 vs);
```

### signCompact

Signs `digest` with signer provided to script using the secp256k1 curve.
Returns a compact signature (`r`, `vs`) as per EIP-2098, where `vs` encodes both the
signature's `s` value, and the recovery id `v` in a single bytes32.
This format reduces the signature size from 65 to 64 bytes.
If `--sender` is provided, the signer with provided address is used, otherwise,
if exactly one signer is provided to the script, that signer is used.
Raises error if signer passed through `--sender` does not match any unlocked signers or
if `--sender` is not provided and not exactly one signer is passed to the script.


```solidity
function signCompact(bytes32 digest) external pure returns (bytes32 r, bytes32 vs);
```

### signCompact

Signs `digest` with signer provided to script using the secp256k1 curve.
Returns a compact signature (`r`, `vs`) as per EIP-2098, where `vs` encodes both the
signature's `s` value, and the recovery id `v` in a single bytes32.
This format reduces the signature size from 65 to 64 bytes.
Raises error if none of the signers passed into the script have provided address.


```solidity
function signCompact(address signer, bytes32 digest) external pure returns (bytes32 r, bytes32 vs);
```

### signP256

Signs `digest` with `privateKey` using the secp256r1 curve.


```solidity
function signP256(uint256 privateKey, bytes32 digest) external pure returns (bytes32 r, bytes32 s);
```

### sign

Signs data with a `Wallet`.


```solidity
function sign(Wallet calldata wallet, bytes32 digest) external returns (uint8 v, bytes32 r, bytes32 s);
```

### sign

Signs `digest` with `privateKey` using the secp256k1 curve.


```solidity
function sign(uint256 privateKey, bytes32 digest) external pure returns (uint8 v, bytes32 r, bytes32 s);
```

### sign

Signs `digest` with signer provided to script using the secp256k1 curve.
If `--sender` is provided, the signer with provided address is used, otherwise,
if exactly one signer is provided to the script, that signer is used.
Raises error if signer passed through `--sender` does not match any unlocked signers or
if `--sender` is not provided and not exactly one signer is passed to the script.


```solidity
function sign(bytes32 digest) external pure returns (uint8 v, bytes32 r, bytes32 s);
```

### sign

Signs `digest` with signer provided to script using the secp256k1 curve.
Raises error if none of the signers passed into the script have provided address.


```solidity
function sign(address signer, bytes32 digest) external pure returns (uint8 v, bytes32 r, bytes32 s);
```

### envAddress

Gets the environment variable `name` and parses it as `address`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envAddress(string calldata name) external view returns (address value);
```

### envAddress

Gets the environment variable `name` and parses it as an array of `address`, delimited by `delim`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envAddress(string calldata name, string calldata delim) external view returns (address[] memory value);
```

### envBool

Gets the environment variable `name` and parses it as `bool`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envBool(string calldata name) external view returns (bool value);
```

### envBool

Gets the environment variable `name` and parses it as an array of `bool`, delimited by `delim`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envBool(string calldata name, string calldata delim) external view returns (bool[] memory value);
```

### envBytes32

Gets the environment variable `name` and parses it as `bytes32`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envBytes32(string calldata name) external view returns (bytes32 value);
```

### envBytes32

Gets the environment variable `name` and parses it as an array of `bytes32`, delimited by `delim`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envBytes32(string calldata name, string calldata delim) external view returns (bytes32[] memory value);
```

### envBytes

Gets the environment variable `name` and parses it as `bytes`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envBytes(string calldata name) external view returns (bytes memory value);
```

### envBytes

Gets the environment variable `name` and parses it as an array of `bytes`, delimited by `delim`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envBytes(string calldata name, string calldata delim) external view returns (bytes[] memory value);
```

### envExists

Gets the environment variable `name` and returns true if it exists, else returns false.


```solidity
function envExists(string calldata name) external view returns (bool result);
```

### envInt

Gets the environment variable `name` and parses it as `int256`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envInt(string calldata name) external view returns (int256 value);
```

### envInt

Gets the environment variable `name` and parses it as an array of `int256`, delimited by `delim`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envInt(string calldata name, string calldata delim) external view returns (int256[] memory value);
```

### envOr

Gets the environment variable `name` and parses it as `bool`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, bool defaultValue) external view returns (bool value);
```

### envOr

Gets the environment variable `name` and parses it as `uint256`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, uint256 defaultValue) external view returns (uint256 value);
```

### envOr

Gets the environment variable `name` and parses it as an array of `address`, delimited by `delim`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, string calldata delim, address[] calldata defaultValue)
    external
    view
    returns (address[] memory value);
```

### envOr

Gets the environment variable `name` and parses it as an array of `bytes32`, delimited by `delim`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, string calldata delim, bytes32[] calldata defaultValue)
    external
    view
    returns (bytes32[] memory value);
```

### envOr

Gets the environment variable `name` and parses it as an array of `string`, delimited by `delim`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, string calldata delim, string[] calldata defaultValue)
    external
    view
    returns (string[] memory value);
```

### envOr

Gets the environment variable `name` and parses it as an array of `bytes`, delimited by `delim`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, string calldata delim, bytes[] calldata defaultValue)
    external
    view
    returns (bytes[] memory value);
```

### envOr

Gets the environment variable `name` and parses it as `int256`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, int256 defaultValue) external view returns (int256 value);
```

### envOr

Gets the environment variable `name` and parses it as `address`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, address defaultValue) external view returns (address value);
```

### envOr

Gets the environment variable `name` and parses it as `bytes32`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, bytes32 defaultValue) external view returns (bytes32 value);
```

### envOr

Gets the environment variable `name` and parses it as `string`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, string calldata defaultValue) external view returns (string memory value);
```

### envOr

Gets the environment variable `name` and parses it as `bytes`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, bytes calldata defaultValue) external view returns (bytes memory value);
```

### envOr

Gets the environment variable `name` and parses it as an array of `bool`, delimited by `delim`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, string calldata delim, bool[] calldata defaultValue)
    external
    view
    returns (bool[] memory value);
```

### envOr

Gets the environment variable `name` and parses it as an array of `uint256`, delimited by `delim`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, string calldata delim, uint256[] calldata defaultValue)
    external
    view
    returns (uint256[] memory value);
```

### envOr

Gets the environment variable `name` and parses it as an array of `int256`, delimited by `delim`.
Reverts if the variable could not be parsed.
Returns `defaultValue` if the variable was not found.


```solidity
function envOr(string calldata name, string calldata delim, int256[] calldata defaultValue)
    external
    view
    returns (int256[] memory value);
```

### envString

Gets the environment variable `name` and parses it as `string`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envString(string calldata name) external view returns (string memory value);
```

### envString

Gets the environment variable `name` and parses it as an array of `string`, delimited by `delim`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envString(string calldata name, string calldata delim) external view returns (string[] memory value);
```

### envUint

Gets the environment variable `name` and parses it as `uint256`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envUint(string calldata name) external view returns (uint256 value);
```

### envUint

Gets the environment variable `name` and parses it as an array of `uint256`, delimited by `delim`.
Reverts if the variable was not found or could not be parsed.


```solidity
function envUint(string calldata name, string calldata delim) external view returns (uint256[] memory value);
```

### isContext

Returns true if `forge` command was executed in given context.


```solidity
function isContext(ForgeContext context) external view returns (bool result);
```

### setEnv

Sets environment variables.


```solidity
function setEnv(string calldata name, string calldata value) external;
```

### accesses

Gets all accessed reads and write slot from a `vm.record` session, for a given address.


```solidity
function accesses(address target) external returns (bytes32[] memory readSlots, bytes32[] memory writeSlots);
```

### addr

Gets the address for a given private key.


```solidity
function addr(uint256 privateKey) external pure returns (address keyAddr);
```

### eth_getLogs

Gets all the logs according to specified filter.


```solidity
function eth_getLogs(uint256 fromBlock, uint256 toBlock, address target, bytes32[] calldata topics)
    external
    returns (EthGetLogs[] memory logs);
```

### getBlobBaseFee

Gets the current `block.blobbasefee`.
You should use this instead of `block.blobbasefee` if you use `vm.blobBaseFee`, as `block.blobbasefee` is assumed to be constant across a transaction,
and as a result will get optimized out by the compiler.
See https://github.com/foundry-rs/foundry/issues/6180


```solidity
function getBlobBaseFee() external view returns (uint256 blobBaseFee);
```

### getBlockNumber

Gets the current `block.number`.
You should use this instead of `block.number` if you use `vm.roll`, as `block.number` is assumed to be constant across a transaction,
and as a result will get optimized out by the compiler.
See https://github.com/foundry-rs/foundry/issues/6180


```solidity
function getBlockNumber() external view returns (uint256 height);
```

### getBlockTimestamp

Gets the current `block.timestamp`.
You should use this instead of `block.timestamp` if you use `vm.warp`, as `block.timestamp` is assumed to be constant across a transaction,
and as a result will get optimized out by the compiler.
See https://github.com/foundry-rs/foundry/issues/6180


```solidity
function getBlockTimestamp() external view returns (uint256 timestamp);
```

### getMappingKeyAndParentOf

Gets the map key and parent of a mapping at a given slot, for a given address.


```solidity
function getMappingKeyAndParentOf(address target, bytes32 elementSlot)
    external
    returns (bool found, bytes32 key, bytes32 parent);
```

### getMappingLength

Gets the number of elements in the mapping at the given slot, for a given address.


```solidity
function getMappingLength(address target, bytes32 mappingSlot) external returns (uint256 length);
```

### getMappingSlotAt

Gets the elements at index idx of the mapping at the given slot, for a given address. The
index must be less than the length of the mapping (i.e. the number of keys in the mapping).


```solidity
function getMappingSlotAt(address target, bytes32 mappingSlot, uint256 idx) external returns (bytes32 value);
```

### getNonce

Gets the nonce of an account.


```solidity
function getNonce(address account) external view returns (uint64 nonce);
```

### getNonce

Get the nonce of a `Wallet`.


```solidity
function getNonce(Wallet calldata wallet) external returns (uint64 nonce);
```

### getRecordedLogs

Gets all the recorded logs.


```solidity
function getRecordedLogs() external returns (Log[] memory logs);
```

### lastCallGas

Gets the gas used in the last call.


```solidity
function lastCallGas() external view returns (Gas memory gas);
```

### load

Loads a storage slot from an address.


```solidity
function load(address target, bytes32 slot) external view returns (bytes32 data);
```

### pauseGasMetering

Pauses gas metering (i.e. gas usage is not counted). Noop if already paused.


```solidity
function pauseGasMetering() external;
```

### record

Records all storage reads and writes.


```solidity
function record() external;
```

### recordLogs

Record all the transaction logs.


```solidity
function recordLogs() external;
```

### resetGasMetering

Reset gas metering (i.e. gas usage is set to gas limit).


```solidity
function resetGasMetering() external;
```

### resumeGasMetering

Resumes gas metering (i.e. gas usage is counted again). Noop if already on.


```solidity
function resumeGasMetering() external;
```

### rpc

Performs an Ethereum JSON-RPC request to the current fork URL.


```solidity
function rpc(string calldata method, string calldata params) external returns (bytes memory data);
```

### rpc

Performs an Ethereum JSON-RPC request to the given endpoint.


```solidity
function rpc(string calldata urlOrAlias, string calldata method, string calldata params)
    external
    returns (bytes memory data);
```

### startMappingRecording

Starts recording all map SSTOREs for later retrieval.


```solidity
function startMappingRecording() external;
```

### startStateDiffRecording

Record all account accesses as part of CREATE, CALL or SELFDESTRUCT opcodes in order,
along with the context of the calls


```solidity
function startStateDiffRecording() external;
```

### stopAndReturnStateDiff

Returns an ordered array of all account accesses from a `vm.startStateDiffRecording` session.


```solidity
function stopAndReturnStateDiff() external returns (AccountAccess[] memory accountAccesses);
```

### stopMappingRecording

Stops recording all map SSTOREs for later retrieval and clears the recorded data.


```solidity
function stopMappingRecording() external;
```

### closeFile

Closes file for reading, resetting the offset and allowing to read it from beginning with readLine.
`path` is relative to the project root.


```solidity
function closeFile(string calldata path) external;
```

### copyFile

Copies the contents of one file to another. This function will **overwrite** the contents of `to`.
On success, the total number of bytes copied is returned and it is equal to the length of the `to` file as reported by `metadata`.
Both `from` and `to` are relative to the project root.


```solidity
function copyFile(string calldata from, string calldata to) external returns (uint64 copied);
```

### createDir

Creates a new, empty directory at the provided path.
This cheatcode will revert in the following situations, but is not limited to just these cases:
- User lacks permissions to modify `path`.
- A parent of the given path doesn't exist and `recursive` is false.
- `path` already exists and `recursive` is false.
`path` is relative to the project root.


```solidity
function createDir(string calldata path, bool recursive) external;
```

### deployCode

Deploys a contract from an artifact file. Takes in the relative path to the json file or the path to the
artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.


```solidity
function deployCode(string calldata artifactPath) external returns (address deployedAddress);
```

### deployCode

Deploys a contract from an artifact file. Takes in the relative path to the json file or the path to the
artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
Additionaly accepts abi-encoded constructor arguments.


```solidity
function deployCode(string calldata artifactPath, bytes calldata constructorArgs)
    external
    returns (address deployedAddress);
```

### exists

Returns true if the given path points to an existing entity, else returns false.


```solidity
function exists(string calldata path) external returns (bool result);
```

### ffi

Performs a foreign function call via the terminal.


```solidity
function ffi(string[] calldata commandInput) external returns (bytes memory result);
```

### fsMetadata

Given a path, query the file system to get information about a file, directory, etc.


```solidity
function fsMetadata(string calldata path) external view returns (FsMetadata memory metadata);
```

### getCode

Gets the creation bytecode from an artifact file. Takes in the relative path to the json file or the path to the
artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.


```solidity
function getCode(string calldata artifactPath) external view returns (bytes memory creationBytecode);
```

### getDeployedCode

Gets the deployed bytecode from an artifact file. Takes in the relative path to the json file or the path to the
artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.


```solidity
function getDeployedCode(string calldata artifactPath) external view returns (bytes memory runtimeBytecode);
```

### isDir

Returns true if the path exists on disk and is pointing at a directory, else returns false.


```solidity
function isDir(string calldata path) external returns (bool result);
```

### isFile

Returns true if the path exists on disk and is pointing at a regular file, else returns false.


```solidity
function isFile(string calldata path) external returns (bool result);
```

### projectRoot

Get the path of the current project root.


```solidity
function projectRoot() external view returns (string memory path);
```

### prompt

Prompts the user for a string value in the terminal.


```solidity
function prompt(string calldata promptText) external returns (string memory input);
```

### promptAddress

Prompts the user for an address in the terminal.


```solidity
function promptAddress(string calldata promptText) external returns (address);
```

### promptSecret

Prompts the user for a hidden string value in the terminal.


```solidity
function promptSecret(string calldata promptText) external returns (string memory input);
```

### promptSecretUint

Prompts the user for hidden uint256 in the terminal (usually pk).


```solidity
function promptSecretUint(string calldata promptText) external returns (uint256);
```

### promptUint

Prompts the user for uint256 in the terminal.


```solidity
function promptUint(string calldata promptText) external returns (uint256);
```

### readDir

Reads the directory at the given path recursively, up to `maxDepth`.
`maxDepth` defaults to 1, meaning only the direct children of the given directory will be returned.
Follows symbolic links if `followLinks` is true.


```solidity
function readDir(string calldata path) external view returns (DirEntry[] memory entries);
```

### readDir

See `readDir(string)`.


```solidity
function readDir(string calldata path, uint64 maxDepth) external view returns (DirEntry[] memory entries);
```

### readDir

See `readDir(string)`.


```solidity
function readDir(string calldata path, uint64 maxDepth, bool followLinks)
    external
    view
    returns (DirEntry[] memory entries);
```

### readFile

Reads the entire content of file to string. `path` is relative to the project root.


```solidity
function readFile(string calldata path) external view returns (string memory data);
```

### readFileBinary

Reads the entire content of file as binary. `path` is relative to the project root.


```solidity
function readFileBinary(string calldata path) external view returns (bytes memory data);
```

### readLine

Reads next line of file to string.


```solidity
function readLine(string calldata path) external view returns (string memory line);
```

### readLink

Reads a symbolic link, returning the path that the link points to.
This cheatcode will revert in the following situations, but is not limited to just these cases:
- `path` is not a symbolic link.
- `path` does not exist.


```solidity
function readLink(string calldata linkPath) external view returns (string memory targetPath);
```

### removeDir

Removes a directory at the provided path.
This cheatcode will revert in the following situations, but is not limited to just these cases:
- `path` doesn't exist.
- `path` isn't a directory.
- User lacks permissions to modify `path`.
- The directory is not empty and `recursive` is false.
`path` is relative to the project root.


```solidity
function removeDir(string calldata path, bool recursive) external;
```

### removeFile

Removes a file from the filesystem.
This cheatcode will revert in the following situations, but is not limited to just these cases:
- `path` points to a directory.
- The file doesn't exist.
- The user lacks permissions to remove the file.
`path` is relative to the project root.


```solidity
function removeFile(string calldata path) external;
```

### tryFfi

Performs a foreign function call via terminal and returns the exit code, stdout, and stderr.


```solidity
function tryFfi(string[] calldata commandInput) external returns (FfiResult memory result);
```

### unixTime

Returns the time since unix epoch in milliseconds.


```solidity
function unixTime() external returns (uint256 milliseconds);
```

### writeFile

Writes data to file, creating a file if it does not exist, and entirely replacing its contents if it does.
`path` is relative to the project root.


```solidity
function writeFile(string calldata path, string calldata data) external;
```

### writeFileBinary

Writes binary data to a file, creating a file if it does not exist, and entirely replacing its contents if it does.
`path` is relative to the project root.


```solidity
function writeFileBinary(string calldata path, bytes calldata data) external;
```

### writeLine

Writes line to file, creating a file if it does not exist.
`path` is relative to the project root.


```solidity
function writeLine(string calldata path, string calldata data) external;
```

### keyExists

Checks if `key` exists in a JSON object
`keyExists` is being deprecated in favor of `keyExistsJson`. It will be removed in future versions.


```solidity
function keyExists(string calldata json, string calldata key) external view returns (bool);
```

### keyExistsJson

Checks if `key` exists in a JSON object.


```solidity
function keyExistsJson(string calldata json, string calldata key) external view returns (bool);
```

### parseJsonAddress

Parses a string of JSON data at `key` and coerces it to `address`.


```solidity
function parseJsonAddress(string calldata json, string calldata key) external pure returns (address);
```

### parseJsonAddressArray

Parses a string of JSON data at `key` and coerces it to `address[]`.


```solidity
function parseJsonAddressArray(string calldata json, string calldata key) external pure returns (address[] memory);
```

### parseJsonBool

Parses a string of JSON data at `key` and coerces it to `bool`.


```solidity
function parseJsonBool(string calldata json, string calldata key) external pure returns (bool);
```

### parseJsonBoolArray

Parses a string of JSON data at `key` and coerces it to `bool[]`.


```solidity
function parseJsonBoolArray(string calldata json, string calldata key) external pure returns (bool[] memory);
```

### parseJsonBytes

Parses a string of JSON data at `key` and coerces it to `bytes`.


```solidity
function parseJsonBytes(string calldata json, string calldata key) external pure returns (bytes memory);
```

### parseJsonBytes32

Parses a string of JSON data at `key` and coerces it to `bytes32`.


```solidity
function parseJsonBytes32(string calldata json, string calldata key) external pure returns (bytes32);
```

### parseJsonBytes32Array

Parses a string of JSON data at `key` and coerces it to `bytes32[]`.


```solidity
function parseJsonBytes32Array(string calldata json, string calldata key) external pure returns (bytes32[] memory);
```

### parseJsonBytesArray

Parses a string of JSON data at `key` and coerces it to `bytes[]`.


```solidity
function parseJsonBytesArray(string calldata json, string calldata key) external pure returns (bytes[] memory);
```

### parseJsonInt

Parses a string of JSON data at `key` and coerces it to `int256`.


```solidity
function parseJsonInt(string calldata json, string calldata key) external pure returns (int256);
```

### parseJsonIntArray

Parses a string of JSON data at `key` and coerces it to `int256[]`.


```solidity
function parseJsonIntArray(string calldata json, string calldata key) external pure returns (int256[] memory);
```

### parseJsonKeys

Returns an array of all the keys in a JSON object.


```solidity
function parseJsonKeys(string calldata json, string calldata key) external pure returns (string[] memory keys);
```

### parseJsonString

Parses a string of JSON data at `key` and coerces it to `string`.


```solidity
function parseJsonString(string calldata json, string calldata key) external pure returns (string memory);
```

### parseJsonStringArray

Parses a string of JSON data at `key` and coerces it to `string[]`.


```solidity
function parseJsonStringArray(string calldata json, string calldata key) external pure returns (string[] memory);
```

### parseJsonTypeArray

Parses a string of JSON data at `key` and coerces it to type array corresponding to `typeDescription`.


```solidity
function parseJsonTypeArray(string calldata json, string calldata key, string calldata typeDescription)
    external
    pure
    returns (bytes memory);
```

### parseJsonType

Parses a string of JSON data and coerces it to type corresponding to `typeDescription`.


```solidity
function parseJsonType(string calldata json, string calldata typeDescription) external pure returns (bytes memory);
```

### parseJsonType

Parses a string of JSON data at `key` and coerces it to type corresponding to `typeDescription`.


```solidity
function parseJsonType(string calldata json, string calldata key, string calldata typeDescription)
    external
    pure
    returns (bytes memory);
```

### parseJsonUint

Parses a string of JSON data at `key` and coerces it to `uint256`.


```solidity
function parseJsonUint(string calldata json, string calldata key) external pure returns (uint256);
```

### parseJsonUintArray

Parses a string of JSON data at `key` and coerces it to `uint256[]`.


```solidity
function parseJsonUintArray(string calldata json, string calldata key) external pure returns (uint256[] memory);
```

### parseJson

ABI-encodes a JSON object.


```solidity
function parseJson(string calldata json) external pure returns (bytes memory abiEncodedData);
```

### parseJson

ABI-encodes a JSON object at `key`.


```solidity
function parseJson(string calldata json, string calldata key) external pure returns (bytes memory abiEncodedData);
```

### serializeAddress

See `serializeJson`.


```solidity
function serializeAddress(string calldata objectKey, string calldata valueKey, address value)
    external
    returns (string memory json);
```

### serializeAddress

See `serializeJson`.


```solidity
function serializeAddress(string calldata objectKey, string calldata valueKey, address[] calldata values)
    external
    returns (string memory json);
```

### serializeBool

See `serializeJson`.


```solidity
function serializeBool(string calldata objectKey, string calldata valueKey, bool value)
    external
    returns (string memory json);
```

### serializeBool

See `serializeJson`.


```solidity
function serializeBool(string calldata objectKey, string calldata valueKey, bool[] calldata values)
    external
    returns (string memory json);
```

### serializeBytes32

See `serializeJson`.


```solidity
function serializeBytes32(string calldata objectKey, string calldata valueKey, bytes32 value)
    external
    returns (string memory json);
```

### serializeBytes32

See `serializeJson`.


```solidity
function serializeBytes32(string calldata objectKey, string calldata valueKey, bytes32[] calldata values)
    external
    returns (string memory json);
```

### serializeBytes

See `serializeJson`.


```solidity
function serializeBytes(string calldata objectKey, string calldata valueKey, bytes calldata value)
    external
    returns (string memory json);
```

### serializeBytes

See `serializeJson`.


```solidity
function serializeBytes(string calldata objectKey, string calldata valueKey, bytes[] calldata values)
    external
    returns (string memory json);
```

### serializeInt

See `serializeJson`.


```solidity
function serializeInt(string calldata objectKey, string calldata valueKey, int256 value)
    external
    returns (string memory json);
```

### serializeInt

See `serializeJson`.


```solidity
function serializeInt(string calldata objectKey, string calldata valueKey, int256[] calldata values)
    external
    returns (string memory json);
```

### serializeJson

Serializes a key and value to a JSON object stored in-memory that can be later written to a file.
Returns the stringified version of the specific JSON file up to that moment.


```solidity
function serializeJson(string calldata objectKey, string calldata value) external returns (string memory json);
```

### serializeJsonType

See `serializeJson`.


```solidity
function serializeJsonType(string calldata typeDescription, bytes calldata value)
    external
    pure
    returns (string memory json);
```

### serializeJsonType

See `serializeJson`.


```solidity
function serializeJsonType(
    string calldata objectKey,
    string calldata valueKey,
    string calldata typeDescription,
    bytes calldata value
) external returns (string memory json);
```

### serializeString

See `serializeJson`.


```solidity
function serializeString(string calldata objectKey, string calldata valueKey, string calldata value)
    external
    returns (string memory json);
```

### serializeString

See `serializeJson`.


```solidity
function serializeString(string calldata objectKey, string calldata valueKey, string[] calldata values)
    external
    returns (string memory json);
```

### serializeUintToHex

See `serializeJson`.


```solidity
function serializeUintToHex(string calldata objectKey, string calldata valueKey, uint256 value)
    external
    returns (string memory json);
```

### serializeUint

See `serializeJson`.


```solidity
function serializeUint(string calldata objectKey, string calldata valueKey, uint256 value)
    external
    returns (string memory json);
```

### serializeUint

See `serializeJson`.


```solidity
function serializeUint(string calldata objectKey, string calldata valueKey, uint256[] calldata values)
    external
    returns (string memory json);
```

### writeJson

Write a serialized JSON object to a file. If the file exists, it will be overwritten.


```solidity
function writeJson(string calldata json, string calldata path) external;
```

### writeJson

Write a serialized JSON object to an **existing** JSON file, replacing a value with key = <value_key.>
This is useful to replace a specific value of a JSON file, without having to parse the entire thing.


```solidity
function writeJson(string calldata json, string calldata path, string calldata valueKey) external;
```

### broadcastRawTransaction

Takes a signed transaction and broadcasts it to the network.


```solidity
function broadcastRawTransaction(bytes calldata data) external;
```

### broadcast

Has the next call (at this call depth only) create transactions that can later be signed and sent onchain.
Broadcasting address is determined by checking the following in order:
1. If `--sender` argument was provided, that address is used.
2. If exactly one signer (e.g. private key, hw wallet, keystore) is set when `forge broadcast` is invoked, that signer is used.
3. Otherwise, default foundry sender (1804c8AB1F12E6bbf3894d4083f33e07309d1f38) is used.


```solidity
function broadcast() external;
```

### broadcast

Has the next call (at this call depth only) create a transaction with the address provided
as the sender that can later be signed and sent onchain.


```solidity
function broadcast(address signer) external;
```

### broadcast

Has the next call (at this call depth only) create a transaction with the private key
provided as the sender that can later be signed and sent onchain.


```solidity
function broadcast(uint256 privateKey) external;
```

### startBroadcast

Has all subsequent calls (at this call depth only) create transactions that can later be signed and sent onchain.
Broadcasting address is determined by checking the following in order:
1. If `--sender` argument was provided, that address is used.
2. If exactly one signer (e.g. private key, hw wallet, keystore) is set when `forge broadcast` is invoked, that signer is used.
3. Otherwise, default foundry sender (1804c8AB1F12E6bbf3894d4083f33e07309d1f38) is used.


```solidity
function startBroadcast() external;
```

### startBroadcast

Has all subsequent calls (at this call depth only) create transactions with the address
provided that can later be signed and sent onchain.


```solidity
function startBroadcast(address signer) external;
```

### startBroadcast

Has all subsequent calls (at this call depth only) create transactions with the private key
provided that can later be signed and sent onchain.


```solidity
function startBroadcast(uint256 privateKey) external;
```

### stopBroadcast

Stops collecting onchain transactions.


```solidity
function stopBroadcast() external;
```

### indexOf

Returns the index of the first occurrence of a `key` in an `input` string.
Returns `NOT_FOUND` (i.e. `type(uint256).max`) if the `key` is not found.
Returns 0 in case of an empty `key`.


```solidity
function indexOf(string calldata input, string calldata key) external pure returns (uint256);
```

### parseAddress

Parses the given `string` into an `address`.


```solidity
function parseAddress(string calldata stringifiedValue) external pure returns (address parsedValue);
```

### parseBool

Parses the given `string` into a `bool`.


```solidity
function parseBool(string calldata stringifiedValue) external pure returns (bool parsedValue);
```

### parseBytes

Parses the given `string` into `bytes`.


```solidity
function parseBytes(string calldata stringifiedValue) external pure returns (bytes memory parsedValue);
```

### parseBytes32

Parses the given `string` into a `bytes32`.


```solidity
function parseBytes32(string calldata stringifiedValue) external pure returns (bytes32 parsedValue);
```

### parseInt

Parses the given `string` into a `int256`.


```solidity
function parseInt(string calldata stringifiedValue) external pure returns (int256 parsedValue);
```

### parseUint

Parses the given `string` into a `uint256`.


```solidity
function parseUint(string calldata stringifiedValue) external pure returns (uint256 parsedValue);
```

### replace

Replaces occurrences of `from` in the given `string` with `to`.


```solidity
function replace(string calldata input, string calldata from, string calldata to)
    external
    pure
    returns (string memory output);
```

### split

Splits the given `string` into an array of strings divided by the `delimiter`.


```solidity
function split(string calldata input, string calldata delimiter) external pure returns (string[] memory outputs);
```

### toLowercase

Converts the given `string` value to Lowercase.


```solidity
function toLowercase(string calldata input) external pure returns (string memory output);
```

### toString

Converts the given value to a `string`.


```solidity
function toString(address value) external pure returns (string memory stringifiedValue);
```

### toString

Converts the given value to a `string`.


```solidity
function toString(bytes calldata value) external pure returns (string memory stringifiedValue);
```

### toString

Converts the given value to a `string`.


```solidity
function toString(bytes32 value) external pure returns (string memory stringifiedValue);
```

### toString

Converts the given value to a `string`.


```solidity
function toString(bool value) external pure returns (string memory stringifiedValue);
```

### toString

Converts the given value to a `string`.


```solidity
function toString(uint256 value) external pure returns (string memory stringifiedValue);
```

### toString

Converts the given value to a `string`.


```solidity
function toString(int256 value) external pure returns (string memory stringifiedValue);
```

### toUppercase

Converts the given `string` value to Uppercase.


```solidity
function toUppercase(string calldata input) external pure returns (string memory output);
```

### trim

Trims leading and trailing whitespace from the given `string` value.


```solidity
function trim(string calldata input) external pure returns (string memory output);
```

### assertApproxEqAbsDecimal

Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.
Formats values with decimals in failure message.


```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals) external pure;
```

### assertApproxEqAbsDecimal

Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertApproxEqAbsDecimal(
    uint256 left,
    uint256 right,
    uint256 maxDelta,
    uint256 decimals,
    string calldata error
) external pure;
```

### assertApproxEqAbsDecimal

Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.
Formats values with decimals in failure message.


```solidity
function assertApproxEqAbsDecimal(int256 left, int256 right, uint256 maxDelta, uint256 decimals) external pure;
```

### assertApproxEqAbsDecimal

Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertApproxEqAbsDecimal(int256 left, int256 right, uint256 maxDelta, uint256 decimals, string calldata error)
    external
    pure;
```

### assertApproxEqAbs

Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.


```solidity
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta) external pure;
```

### assertApproxEqAbs

Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.
Includes error message into revert string on failure.


```solidity
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta, string calldata error) external pure;
```

### assertApproxEqAbs

Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.


```solidity
function assertApproxEqAbs(int256 left, int256 right, uint256 maxDelta) external pure;
```

### assertApproxEqAbs

Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.
Includes error message into revert string on failure.


```solidity
function assertApproxEqAbs(int256 left, int256 right, uint256 maxDelta, string calldata error) external pure;
```

### assertApproxEqRelDecimal

Compares two `uint256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
`maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
Formats values with decimals in failure message.


```solidity
function assertApproxEqRelDecimal(uint256 left, uint256 right, uint256 maxPercentDelta, uint256 decimals)
    external
    pure;
```

### assertApproxEqRelDecimal

Compares two `uint256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
`maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertApproxEqRelDecimal(
    uint256 left,
    uint256 right,
    uint256 maxPercentDelta,
    uint256 decimals,
    string calldata error
) external pure;
```

### assertApproxEqRelDecimal

Compares two `int256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
`maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
Formats values with decimals in failure message.


```solidity
function assertApproxEqRelDecimal(int256 left, int256 right, uint256 maxPercentDelta, uint256 decimals) external pure;
```

### assertApproxEqRelDecimal

Compares two `int256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
`maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertApproxEqRelDecimal(
    int256 left,
    int256 right,
    uint256 maxPercentDelta,
    uint256 decimals,
    string calldata error
) external pure;
```

### assertApproxEqRel

Compares two `uint256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
`maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%


```solidity
function assertApproxEqRel(uint256 left, uint256 right, uint256 maxPercentDelta) external pure;
```

### assertApproxEqRel

Compares two `uint256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
`maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
Includes error message into revert string on failure.


```solidity
function assertApproxEqRel(uint256 left, uint256 right, uint256 maxPercentDelta, string calldata error) external pure;
```

### assertApproxEqRel

Compares two `int256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
`maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%


```solidity
function assertApproxEqRel(int256 left, int256 right, uint256 maxPercentDelta) external pure;
```

### assertApproxEqRel

Compares two `int256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
`maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
Includes error message into revert string on failure.


```solidity
function assertApproxEqRel(int256 left, int256 right, uint256 maxPercentDelta, string calldata error) external pure;
```

### assertEqDecimal

Asserts that two `uint256` values are equal, formatting them with decimals in failure message.


```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals) external pure;
```

### assertEqDecimal

Asserts that two `uint256` values are equal, formatting them with decimals in failure message.
Includes error message into revert string on failure.


```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;
```

### assertEqDecimal

Asserts that two `int256` values are equal, formatting them with decimals in failure message.


```solidity
function assertEqDecimal(int256 left, int256 right, uint256 decimals) external pure;
```

### assertEqDecimal

Asserts that two `int256` values are equal, formatting them with decimals in failure message.
Includes error message into revert string on failure.


```solidity
function assertEqDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;
```

### assertEq

Asserts that two `bool` values are equal.


```solidity
function assertEq(bool left, bool right) external pure;
```

### assertEq

Asserts that two `bool` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(bool left, bool right, string calldata error) external pure;
```

### assertEq

Asserts that two `string` values are equal.


```solidity
function assertEq(string calldata left, string calldata right) external pure;
```

### assertEq

Asserts that two `string` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(string calldata left, string calldata right, string calldata error) external pure;
```

### assertEq

Asserts that two `bytes` values are equal.


```solidity
function assertEq(bytes calldata left, bytes calldata right) external pure;
```

### assertEq

Asserts that two `bytes` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(bytes calldata left, bytes calldata right, string calldata error) external pure;
```

### assertEq

Asserts that two arrays of `bool` values are equal.


```solidity
function assertEq(bool[] calldata left, bool[] calldata right) external pure;
```

### assertEq

Asserts that two arrays of `bool` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(bool[] calldata left, bool[] calldata right, string calldata error) external pure;
```

### assertEq

Asserts that two arrays of `uint256 values are equal.


```solidity
function assertEq(uint256[] calldata left, uint256[] calldata right) external pure;
```

### assertEq

Asserts that two arrays of `uint256` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(uint256[] calldata left, uint256[] calldata right, string calldata error) external pure;
```

### assertEq

Asserts that two arrays of `int256` values are equal.


```solidity
function assertEq(int256[] calldata left, int256[] calldata right) external pure;
```

### assertEq

Asserts that two arrays of `int256` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(int256[] calldata left, int256[] calldata right, string calldata error) external pure;
```

### assertEq

Asserts that two `uint256` values are equal.


```solidity
function assertEq(uint256 left, uint256 right) external pure;
```

### assertEq

Asserts that two arrays of `address` values are equal.


```solidity
function assertEq(address[] calldata left, address[] calldata right) external pure;
```

### assertEq

Asserts that two arrays of `address` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(address[] calldata left, address[] calldata right, string calldata error) external pure;
```

### assertEq

Asserts that two arrays of `bytes32` values are equal.


```solidity
function assertEq(bytes32[] calldata left, bytes32[] calldata right) external pure;
```

### assertEq

Asserts that two arrays of `bytes32` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(bytes32[] calldata left, bytes32[] calldata right, string calldata error) external pure;
```

### assertEq

Asserts that two arrays of `string` values are equal.


```solidity
function assertEq(string[] calldata left, string[] calldata right) external pure;
```

### assertEq

Asserts that two arrays of `string` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(string[] calldata left, string[] calldata right, string calldata error) external pure;
```

### assertEq

Asserts that two arrays of `bytes` values are equal.


```solidity
function assertEq(bytes[] calldata left, bytes[] calldata right) external pure;
```

### assertEq

Asserts that two arrays of `bytes` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(bytes[] calldata left, bytes[] calldata right, string calldata error) external pure;
```

### assertEq

Asserts that two `uint256` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(uint256 left, uint256 right, string calldata error) external pure;
```

### assertEq

Asserts that two `int256` values are equal.


```solidity
function assertEq(int256 left, int256 right) external pure;
```

### assertEq

Asserts that two `int256` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(int256 left, int256 right, string calldata error) external pure;
```

### assertEq

Asserts that two `address` values are equal.


```solidity
function assertEq(address left, address right) external pure;
```

### assertEq

Asserts that two `address` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(address left, address right, string calldata error) external pure;
```

### assertEq

Asserts that two `bytes32` values are equal.


```solidity
function assertEq(bytes32 left, bytes32 right) external pure;
```

### assertEq

Asserts that two `bytes32` values are equal and includes error message into revert string on failure.


```solidity
function assertEq(bytes32 left, bytes32 right, string calldata error) external pure;
```

### assertFalse

Asserts that the given condition is false.


```solidity
function assertFalse(bool condition) external pure;
```

### assertFalse

Asserts that the given condition is false and includes error message into revert string on failure.


```solidity
function assertFalse(bool condition, string calldata error) external pure;
```

### assertGeDecimal

Compares two `uint256` values. Expects first value to be greater than or equal to second.
Formats values with decimals in failure message.


```solidity
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals) external pure;
```

### assertGeDecimal

Compares two `uint256` values. Expects first value to be greater than or equal to second.
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;
```

### assertGeDecimal

Compares two `int256` values. Expects first value to be greater than or equal to second.
Formats values with decimals in failure message.


```solidity
function assertGeDecimal(int256 left, int256 right, uint256 decimals) external pure;
```

### assertGeDecimal

Compares two `int256` values. Expects first value to be greater than or equal to second.
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertGeDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;
```

### assertGe

Compares two `uint256` values. Expects first value to be greater than or equal to second.


```solidity
function assertGe(uint256 left, uint256 right) external pure;
```

### assertGe

Compares two `uint256` values. Expects first value to be greater than or equal to second.
Includes error message into revert string on failure.


```solidity
function assertGe(uint256 left, uint256 right, string calldata error) external pure;
```

### assertGe

Compares two `int256` values. Expects first value to be greater than or equal to second.


```solidity
function assertGe(int256 left, int256 right) external pure;
```

### assertGe

Compares two `int256` values. Expects first value to be greater than or equal to second.
Includes error message into revert string on failure.


```solidity
function assertGe(int256 left, int256 right, string calldata error) external pure;
```

### assertGtDecimal

Compares two `uint256` values. Expects first value to be greater than second.
Formats values with decimals in failure message.


```solidity
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals) external pure;
```

### assertGtDecimal

Compares two `uint256` values. Expects first value to be greater than second.
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;
```

### assertGtDecimal

Compares two `int256` values. Expects first value to be greater than second.
Formats values with decimals in failure message.


```solidity
function assertGtDecimal(int256 left, int256 right, uint256 decimals) external pure;
```

### assertGtDecimal

Compares two `int256` values. Expects first value to be greater than second.
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertGtDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;
```

### assertGt

Compares two `uint256` values. Expects first value to be greater than second.


```solidity
function assertGt(uint256 left, uint256 right) external pure;
```

### assertGt

Compares two `uint256` values. Expects first value to be greater than second.
Includes error message into revert string on failure.


```solidity
function assertGt(uint256 left, uint256 right, string calldata error) external pure;
```

### assertGt

Compares two `int256` values. Expects first value to be greater than second.


```solidity
function assertGt(int256 left, int256 right) external pure;
```

### assertGt

Compares two `int256` values. Expects first value to be greater than second.
Includes error message into revert string on failure.


```solidity
function assertGt(int256 left, int256 right, string calldata error) external pure;
```

### assertLeDecimal

Compares two `uint256` values. Expects first value to be less than or equal to second.
Formats values with decimals in failure message.


```solidity
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals) external pure;
```

### assertLeDecimal

Compares two `uint256` values. Expects first value to be less than or equal to second.
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;
```

### assertLeDecimal

Compares two `int256` values. Expects first value to be less than or equal to second.
Formats values with decimals in failure message.


```solidity
function assertLeDecimal(int256 left, int256 right, uint256 decimals) external pure;
```

### assertLeDecimal

Compares two `int256` values. Expects first value to be less than or equal to second.
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertLeDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;
```

### assertLe

Compares two `uint256` values. Expects first value to be less than or equal to second.


```solidity
function assertLe(uint256 left, uint256 right) external pure;
```

### assertLe

Compares two `uint256` values. Expects first value to be less than or equal to second.
Includes error message into revert string on failure.


```solidity
function assertLe(uint256 left, uint256 right, string calldata error) external pure;
```

### assertLe

Compares two `int256` values. Expects first value to be less than or equal to second.


```solidity
function assertLe(int256 left, int256 right) external pure;
```

### assertLe

Compares two `int256` values. Expects first value to be less than or equal to second.
Includes error message into revert string on failure.


```solidity
function assertLe(int256 left, int256 right, string calldata error) external pure;
```

### assertLtDecimal

Compares two `uint256` values. Expects first value to be less than second.
Formats values with decimals in failure message.


```solidity
function assertLtDecimal(uint256 left, uint256 right, uint256 decimals) external pure;
```

### assertLtDecimal

Compares two `uint256` values. Expects first value to be less than second.
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertLtDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;
```

### assertLtDecimal

Compares two `int256` values. Expects first value to be less than second.
Formats values with decimals in failure message.


```solidity
function assertLtDecimal(int256 left, int256 right, uint256 decimals) external pure;
```

### assertLtDecimal

Compares two `int256` values. Expects first value to be less than second.
Formats values with decimals in failure message. Includes error message into revert string on failure.


```solidity
function assertLtDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;
```

### assertLt

Compares two `uint256` values. Expects first value to be less than second.


```solidity
function assertLt(uint256 left, uint256 right) external pure;
```

### assertLt

Compares two `uint256` values. Expects first value to be less than second.
Includes error message into revert string on failure.


```solidity
function assertLt(uint256 left, uint256 right, string calldata error) external pure;
```

### assertLt

Compares two `int256` values. Expects first value to be less than second.


```solidity
function assertLt(int256 left, int256 right) external pure;
```

### assertLt

Compares two `int256` values. Expects first value to be less than second.
Includes error message into revert string on failure.


```solidity
function assertLt(int256 left, int256 right, string calldata error) external pure;
```

### assertNotEqDecimal

Asserts that two `uint256` values are not equal, formatting them with decimals in failure message.


```solidity
function assertNotEqDecimal(uint256 left, uint256 right, uint256 decimals) external pure;
```

### assertNotEqDecimal

Asserts that two `uint256` values are not equal, formatting them with decimals in failure message.
Includes error message into revert string on failure.


```solidity
function assertNotEqDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;
```

### assertNotEqDecimal

Asserts that two `int256` values are not equal, formatting them with decimals in failure message.


```solidity
function assertNotEqDecimal(int256 left, int256 right, uint256 decimals) external pure;
```

### assertNotEqDecimal

Asserts that two `int256` values are not equal, formatting them with decimals in failure message.
Includes error message into revert string on failure.


```solidity
function assertNotEqDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;
```

### assertNotEq

Asserts that two `bool` values are not equal.


```solidity
function assertNotEq(bool left, bool right) external pure;
```

### assertNotEq

Asserts that two `bool` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(bool left, bool right, string calldata error) external pure;
```

### assertNotEq

Asserts that two `string` values are not equal.


```solidity
function assertNotEq(string calldata left, string calldata right) external pure;
```

### assertNotEq

Asserts that two `string` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(string calldata left, string calldata right, string calldata error) external pure;
```

### assertNotEq

Asserts that two `bytes` values are not equal.


```solidity
function assertNotEq(bytes calldata left, bytes calldata right) external pure;
```

### assertNotEq

Asserts that two `bytes` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(bytes calldata left, bytes calldata right, string calldata error) external pure;
```

### assertNotEq

Asserts that two arrays of `bool` values are not equal.


```solidity
function assertNotEq(bool[] calldata left, bool[] calldata right) external pure;
```

### assertNotEq

Asserts that two arrays of `bool` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(bool[] calldata left, bool[] calldata right, string calldata error) external pure;
```

### assertNotEq

Asserts that two arrays of `uint256` values are not equal.


```solidity
function assertNotEq(uint256[] calldata left, uint256[] calldata right) external pure;
```

### assertNotEq

Asserts that two arrays of `uint256` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(uint256[] calldata left, uint256[] calldata right, string calldata error) external pure;
```

### assertNotEq

Asserts that two arrays of `int256` values are not equal.


```solidity
function assertNotEq(int256[] calldata left, int256[] calldata right) external pure;
```

### assertNotEq

Asserts that two arrays of `int256` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(int256[] calldata left, int256[] calldata right, string calldata error) external pure;
```

### assertNotEq

Asserts that two `uint256` values are not equal.


```solidity
function assertNotEq(uint256 left, uint256 right) external pure;
```

### assertNotEq

Asserts that two arrays of `address` values are not equal.


```solidity
function assertNotEq(address[] calldata left, address[] calldata right) external pure;
```

### assertNotEq

Asserts that two arrays of `address` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(address[] calldata left, address[] calldata right, string calldata error) external pure;
```

### assertNotEq

Asserts that two arrays of `bytes32` values are not equal.


```solidity
function assertNotEq(bytes32[] calldata left, bytes32[] calldata right) external pure;
```

### assertNotEq

Asserts that two arrays of `bytes32` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(bytes32[] calldata left, bytes32[] calldata right, string calldata error) external pure;
```

### assertNotEq

Asserts that two arrays of `string` values are not equal.


```solidity
function assertNotEq(string[] calldata left, string[] calldata right) external pure;
```

### assertNotEq

Asserts that two arrays of `string` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(string[] calldata left, string[] calldata right, string calldata error) external pure;
```

### assertNotEq

Asserts that two arrays of `bytes` values are not equal.


```solidity
function assertNotEq(bytes[] calldata left, bytes[] calldata right) external pure;
```

### assertNotEq

Asserts that two arrays of `bytes` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(bytes[] calldata left, bytes[] calldata right, string calldata error) external pure;
```

### assertNotEq

Asserts that two `uint256` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(uint256 left, uint256 right, string calldata error) external pure;
```

### assertNotEq

Asserts that two `int256` values are not equal.


```solidity
function assertNotEq(int256 left, int256 right) external pure;
```

### assertNotEq

Asserts that two `int256` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(int256 left, int256 right, string calldata error) external pure;
```

### assertNotEq

Asserts that two `address` values are not equal.


```solidity
function assertNotEq(address left, address right) external pure;
```

### assertNotEq

Asserts that two `address` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(address left, address right, string calldata error) external pure;
```

### assertNotEq

Asserts that two `bytes32` values are not equal.


```solidity
function assertNotEq(bytes32 left, bytes32 right) external pure;
```

### assertNotEq

Asserts that two `bytes32` values are not equal and includes error message into revert string on failure.


```solidity
function assertNotEq(bytes32 left, bytes32 right, string calldata error) external pure;
```

### assertTrue

Asserts that the given condition is true.


```solidity
function assertTrue(bool condition) external pure;
```

### assertTrue

Asserts that the given condition is true and includes error message into revert string on failure.


```solidity
function assertTrue(bool condition, string calldata error) external pure;
```

### assume

If the condition is false, discard this run's fuzz inputs and generate new ones.


```solidity
function assume(bool condition) external pure;
```

### assumeNoRevert

Discard this run's fuzz inputs and generate new ones if next call reverted.


```solidity
function assumeNoRevert() external pure;
```

### breakpoint

Writes a breakpoint to jump to in the debugger.


```solidity
function breakpoint(string calldata char) external;
```

### breakpoint

Writes a conditional breakpoint to jump to in the debugger.


```solidity
function breakpoint(string calldata char, bool value) external;
```

### getFoundryVersion

Returns the Foundry version.
Format: <cargo_version>+<git_sha>+<build_timestamp>
Sample output: 0.2.0+faa94c384+202407110019
Note: Build timestamps may vary slightly across platforms due to separate CI jobs.
For reliable version comparisons, use YYYYMMDD0000 format (e.g., >= 202407110000)
to compare timestamps while ignoring minor time differences.


```solidity
function getFoundryVersion() external view returns (string memory version);
```

### rpcUrl

Returns the RPC url for the given alias.


```solidity
function rpcUrl(string calldata rpcAlias) external view returns (string memory json);
```

### rpcUrlStructs

Returns all rpc urls and their aliases as structs.


```solidity
function rpcUrlStructs() external view returns (Rpc[] memory urls);
```

### rpcUrls

Returns all rpc urls and their aliases `[alias, url][]`.


```solidity
function rpcUrls() external view returns (string[2][] memory urls);
```

### sleep

Suspends execution of the main thread for `duration` milliseconds.


```solidity
function sleep(uint256 duration) external;
```

### keyExistsToml

Checks if `key` exists in a TOML table.


```solidity
function keyExistsToml(string calldata toml, string calldata key) external view returns (bool);
```

### parseTomlAddress

Parses a string of TOML data at `key` and coerces it to `address`.


```solidity
function parseTomlAddress(string calldata toml, string calldata key) external pure returns (address);
```

### parseTomlAddressArray

Parses a string of TOML data at `key` and coerces it to `address[]`.


```solidity
function parseTomlAddressArray(string calldata toml, string calldata key) external pure returns (address[] memory);
```

### parseTomlBool

Parses a string of TOML data at `key` and coerces it to `bool`.


```solidity
function parseTomlBool(string calldata toml, string calldata key) external pure returns (bool);
```

### parseTomlBoolArray

Parses a string of TOML data at `key` and coerces it to `bool[]`.


```solidity
function parseTomlBoolArray(string calldata toml, string calldata key) external pure returns (bool[] memory);
```

### parseTomlBytes

Parses a string of TOML data at `key` and coerces it to `bytes`.


```solidity
function parseTomlBytes(string calldata toml, string calldata key) external pure returns (bytes memory);
```

### parseTomlBytes32

Parses a string of TOML data at `key` and coerces it to `bytes32`.


```solidity
function parseTomlBytes32(string calldata toml, string calldata key) external pure returns (bytes32);
```

### parseTomlBytes32Array

Parses a string of TOML data at `key` and coerces it to `bytes32[]`.


```solidity
function parseTomlBytes32Array(string calldata toml, string calldata key) external pure returns (bytes32[] memory);
```

### parseTomlBytesArray

Parses a string of TOML data at `key` and coerces it to `bytes[]`.


```solidity
function parseTomlBytesArray(string calldata toml, string calldata key) external pure returns (bytes[] memory);
```

### parseTomlInt

Parses a string of TOML data at `key` and coerces it to `int256`.


```solidity
function parseTomlInt(string calldata toml, string calldata key) external pure returns (int256);
```

### parseTomlIntArray

Parses a string of TOML data at `key` and coerces it to `int256[]`.


```solidity
function parseTomlIntArray(string calldata toml, string calldata key) external pure returns (int256[] memory);
```

### parseTomlKeys

Returns an array of all the keys in a TOML table.


```solidity
function parseTomlKeys(string calldata toml, string calldata key) external pure returns (string[] memory keys);
```

### parseTomlString

Parses a string of TOML data at `key` and coerces it to `string`.


```solidity
function parseTomlString(string calldata toml, string calldata key) external pure returns (string memory);
```

### parseTomlStringArray

Parses a string of TOML data at `key` and coerces it to `string[]`.


```solidity
function parseTomlStringArray(string calldata toml, string calldata key) external pure returns (string[] memory);
```

### parseTomlUint

Parses a string of TOML data at `key` and coerces it to `uint256`.


```solidity
function parseTomlUint(string calldata toml, string calldata key) external pure returns (uint256);
```

### parseTomlUintArray

Parses a string of TOML data at `key` and coerces it to `uint256[]`.


```solidity
function parseTomlUintArray(string calldata toml, string calldata key) external pure returns (uint256[] memory);
```

### parseToml

ABI-encodes a TOML table.


```solidity
function parseToml(string calldata toml) external pure returns (bytes memory abiEncodedData);
```

### parseToml

ABI-encodes a TOML table at `key`.


```solidity
function parseToml(string calldata toml, string calldata key) external pure returns (bytes memory abiEncodedData);
```

### writeToml

Takes serialized JSON, converts to TOML and write a serialized TOML to a file.


```solidity
function writeToml(string calldata json, string calldata path) external;
```

### writeToml

Takes serialized JSON, converts to TOML and write a serialized TOML table to an **existing** TOML file, replacing a value with key = <value_key.>
This is useful to replace a specific value of a TOML file, without having to parse the entire thing.


```solidity
function writeToml(string calldata json, string calldata path, string calldata valueKey) external;
```

### computeCreate2Address

Compute the address of a contract created with CREATE2 using the given CREATE2 deployer.


```solidity
function computeCreate2Address(bytes32 salt, bytes32 initCodeHash, address deployer) external pure returns (address);
```

### computeCreate2Address

Compute the address of a contract created with CREATE2 using the default CREATE2 deployer.


```solidity
function computeCreate2Address(bytes32 salt, bytes32 initCodeHash) external pure returns (address);
```

### computeCreateAddress

Compute the address a contract will be deployed at for a given deployer address and nonce.


```solidity
function computeCreateAddress(address deployer, uint256 nonce) external pure returns (address);
```

### copyStorage

Utility cheatcode to copy storage of `from` contract to another `to` contract.


```solidity
function copyStorage(address from, address to) external;
```

### ensNamehash

Returns ENS namehash for provided string.


```solidity
function ensNamehash(string calldata name) external pure returns (bytes32);
```

### getLabel

Gets the label for the specified address.


```solidity
function getLabel(address account) external view returns (string memory currentLabel);
```

### label

Labels an address in call traces.


```solidity
function label(address account, string calldata newLabel) external;
```

### pauseTracing

Pauses collection of call traces. Useful in cases when you want to skip tracing of
complex calls which are not useful for debugging.


```solidity
function pauseTracing() external view;
```

### randomAddress

Returns a random `address`.


```solidity
function randomAddress() external returns (address);
```

### randomUint

Returns a random uint256 value.


```solidity
function randomUint() external returns (uint256);
```

### randomUint

Returns random uin256 value between the provided range (=min..=max).


```solidity
function randomUint(uint256 min, uint256 max) external returns (uint256);
```

### resumeTracing

Unpauses collection of call traces.


```solidity
function resumeTracing() external view;
```

### setArbitraryStorage

Utility cheatcode to set arbitrary storage for given target address.


```solidity
function setArbitraryStorage(address target) external;
```

### toBase64URL

Encodes a `bytes` value to a base64url string.


```solidity
function toBase64URL(bytes calldata data) external pure returns (string memory);
```

### toBase64URL

Encodes a `string` value to a base64url string.


```solidity
function toBase64URL(string calldata data) external pure returns (string memory);
```

### toBase64

Encodes a `bytes` value to a base64 string.


```solidity
function toBase64(bytes calldata data) external pure returns (string memory);
```

### toBase64

Encodes a `string` value to a base64 string.


```solidity
function toBase64(string calldata data) external pure returns (string memory);
```

## Structs
### Log
An Ethereum log. Returned by `getRecordedLogs`.


```solidity
struct Log {
    bytes32[] topics;
    bytes data;
    address emitter;
}
```

### Rpc
An RPC URL and its alias. Returned by `rpcUrlStructs`.


```solidity
struct Rpc {
    string key;
    string url;
}
```

### EthGetLogs
An RPC log object. Returned by `eth_getLogs`.


```solidity
struct EthGetLogs {
    address emitter;
    bytes32[] topics;
    bytes data;
    bytes32 blockHash;
    uint64 blockNumber;
    bytes32 transactionHash;
    uint64 transactionIndex;
    uint256 logIndex;
    bool removed;
}
```

### DirEntry
A single entry in a directory listing. Returned by `readDir`.


```solidity
struct DirEntry {
    string errorMessage;
    string path;
    uint64 depth;
    bool isDir;
    bool isSymlink;
}
```

### FsMetadata
Metadata information about a file.
This structure is returned from the `fsMetadata` function and represents known
metadata about a file such as its permissions, size, modification
times, etc.


```solidity
struct FsMetadata {
    bool isDir;
    bool isSymlink;
    uint256 length;
    bool readOnly;
    uint256 modified;
    uint256 accessed;
    uint256 created;
}
```

### Wallet
A wallet with a public and private key.


```solidity
struct Wallet {
    address addr;
    uint256 publicKeyX;
    uint256 publicKeyY;
    uint256 privateKey;
}
```

### FfiResult
The result of a `tryFfi` call.


```solidity
struct FfiResult {
    int32 exitCode;
    bytes stdout;
    bytes stderr;
}
```

### ChainInfo
Information on the chain and fork.


```solidity
struct ChainInfo {
    uint256 forkId;
    uint256 chainId;
}
```

### AccountAccess
The result of a `stopAndReturnStateDiff` call.


```solidity
struct AccountAccess {
    ChainInfo chainInfo;
    AccountAccessKind kind;
    address account;
    address accessor;
    bool initialized;
    uint256 oldBalance;
    uint256 newBalance;
    bytes deployedCode;
    uint256 value;
    bytes data;
    bool reverted;
    StorageAccess[] storageAccesses;
    uint64 depth;
}
```

### StorageAccess
The storage accessed during an `AccountAccess`.


```solidity
struct StorageAccess {
    address account;
    bytes32 slot;
    bool isWrite;
    bytes32 previousValue;
    bytes32 newValue;
    bool reverted;
}
```

### Gas
Gas used. Returned by `lastCallGas`.


```solidity
struct Gas {
    uint64 gasLimit;
    uint64 gasTotalUsed;
    uint64 gasMemoryUsed;
    int64 gasRefunded;
    uint64 gasRemaining;
}
```

## Enums
### CallerMode
A modification applied to either `msg.sender` or `tx.origin`. Returned by `readCallers`.


```solidity
enum CallerMode {
    None,
    Broadcast,
    RecurrentBroadcast,
    Prank,
    RecurrentPrank
}
```

### AccountAccessKind
The kind of account access that occurred.


```solidity
enum AccountAccessKind {
    Call,
    DelegateCall,
    CallCode,
    StaticCall,
    Create,
    SelfDestruct,
    Resume,
    Balance,
    Extcodesize,
    Extcodehash,
    Extcodecopy
}
```

### ForgeContext
Forge execution contexts.


```solidity
enum ForgeContext {
    TestGroup,
    Test,
    Coverage,
    Snapshot,
    ScriptGroup,
    ScriptDryRun,
    ScriptBroadcast,
    ScriptResume,
    Unknown
}
```

