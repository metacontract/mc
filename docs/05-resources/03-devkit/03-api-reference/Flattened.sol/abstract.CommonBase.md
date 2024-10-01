# CommonBase
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/Flattened.sol)


## State Variables
### VM_ADDRESS

```solidity
address internal constant VM_ADDRESS = address(uint160(uint256(keccak256("hevm cheat code"))));
```


### CONSOLE

```solidity
address internal constant CONSOLE = 0x000000000000000000636F6e736F6c652e6c6f67;
```


### CREATE2_FACTORY

```solidity
address internal constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C;
```


### DEFAULT_SENDER

```solidity
address internal constant DEFAULT_SENDER = address(uint160(uint256(keccak256("foundry default caller"))));
```


### DEFAULT_TEST_CONTRACT

```solidity
address internal constant DEFAULT_TEST_CONTRACT = 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f;
```


### MULTICALL3_ADDRESS

```solidity
address internal constant MULTICALL3_ADDRESS = 0xcA11bde05977b3631167028862bE2a173976CA11;
```


### SECP256K1_ORDER

```solidity
uint256 internal constant SECP256K1_ORDER =
    115792089237316195423570985008687907852837564279074904382605163141518161494337;
```


### UINT256_MAX

```solidity
uint256 internal constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
```


### vm

```solidity
Vm internal constant vm = Vm(VM_ADDRESS);
```


### stdstore

```solidity
StdStorage internal stdstore;
```


