# Trace
[Git Source](https://github.com/metacontract/mc/blob/b874bc295b567a7e9bd6d6c63dfe84df116a2f3a/src/devkit/system/Tracer.sol)

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

