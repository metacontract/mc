# Trace
[Git Source](https://github.com/metacontract/mc/blob/main/src/devkit/Flattened.sol)

=================
⛓️ Process
===================

**Note:**
erc7201:mc.devkit.tracer


```solidity
struct Trace {
    Process[] processStack;
    uint256 nextPid;
    uint256 currentNest;
}
```

