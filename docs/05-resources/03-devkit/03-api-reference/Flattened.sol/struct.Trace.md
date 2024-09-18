# Trace
[Git Source](https://github.com/metacontract/mc/blob/0cf91165f9ec2cbeeba800a4baf4e81e2df5c3bb/src/devkit/Flattened.sol)

=================
⛓️ Process
===================


```solidity
struct Trace {
    Process[] processStack;
    uint256 nextPid;
    uint256 currentNest;
}
```

