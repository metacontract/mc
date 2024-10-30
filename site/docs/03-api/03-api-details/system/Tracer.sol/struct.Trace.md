# Trace
[Git Source](https://github.com/metacontract/mc/blob/93e4f2d4a013f48ae1db91ed21bff3eb8a27ce1d/src/devkit/system/Tracer.sol)

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

