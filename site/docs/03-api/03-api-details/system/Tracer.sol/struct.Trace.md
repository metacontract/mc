# Trace
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/devkit/system/Tracer.sol)

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

