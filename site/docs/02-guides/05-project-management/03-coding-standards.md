---
keywords: [smart-contracts, coding-standards, solidity, best-practices]
tags: [smart-contracts, coding-standards, solidity, best-practices]
last_update:
  date: 2024-10-28
  author: Meta Contract Development Team
---

# Coding Standards

This guide outlines the coding standards and best practices for developing smart contracts in the Meta Contract project. Adhering to these standards ensures consistency, readability, and maintainability across the codebase.

## General Guidelines

1. Use Solidity version 0.8.24 or later.
2. Follow the official [Solidity Style Guide](https://docs.soliditylang.org/en/latest/style-guide.html) as a baseline.
3. Use `pragma solidity ^0.8.24;` at the beginning of each file. See [solidity versioning](https://docs.soliditylang.org/en/latest/installing-solidity.html#versioning) for more details.
   - For production deployments, it is recommended to lock the version to avoid unexpected compatibility issues.
   - For library development, using a loose version specification (e.g., `^0.8.24`) is acceptable to ensure compatibility across different projects. Ensure to define and test the compatible version range clearly.

## Naming Conventions

### Contracts and Libraries
- Use ***PascalCase***
  - Example: `MyContract`, `TextDAOLibrary`

### Interfaces
- Prefix with `I` and use ***PascalCase***
  - Example: `IMyInterface`, `ITextDAO`

### Functions
- Use ***camelCase***
  - Examples: `myFunction`, `calculateTotal`
- Prefix internal or private functions in contracts with an underscore (_).
  - Examples: `_internalFunction`
- Do not prefix internal functions in libraries with an underscore.
  - Examples: `Math.add`

### Modifiers
- Use ***mixedCase***
  - Examples: `onlyOwner`, `nonReentrant`

### Variables
- Use ***camelCase*** for function parameters, return variables, and local variables
  - Prefix storage variables with `$` (Note: This is a project-specific standard to clearly distinguish storage variables.)
  - Prefix local stack or memory variables with `_`
  - No prefix for function parameters and return variables
  - Examples: `uint256 $totalAmount`, `uint256 _localVariable`, `function myFunction(uint256 param) public returns (uint256 ret)`

### Constants and Immutable Variables
- Use ***UPPER_CASE*** for constants and immutable variables
  - Examples: `uint256 public constant MAX_SUPPLY = 1000000`, `uint256 public immutable QUORUM_PERCENTAGE = 50`

### Errors
- Prefer custom errors over revert strings for gas efficiency and clarity.
- Use ***PascalCase*** for error names and ***camelCase*** for error parameters
  - Examples: `InsufficientBalance`, `InvalidInput(uint256 value)`

### Events
- Use ***PascalCase*** for event names and ***camelCase*** for event parameters
  - Use past tense for event names to indicate that the event has occurred.
  - Examples: `ProposalCreated(uint256 proposalId, address proposer)`

### Enums
- Use ***PascalCase*** for enum name, and ***ALL_CAPS*** for values
  - Example:
    ```solidity
    enum Color { RED, GREEN, BLUE }
    ```

### Struct
- Use ***PascalCase***
  - Example: `struct UserInfo { ... }`

## Code Layout

- Use 4 spaces for indentation (not tabs).
- Maximum line length is 120 characters.
- Use double quotes for strings.
- Place the opening brace on the same line as the declaration.
- Place the closing brace on a new line.

Example:

```solidity
contract MyContract {
    uint256 private constant MAX_VALUE = 100;

    function calculateSum(uint256 a, uint256 b) public pure returns (uint256) {
        if (a >= MAX_VALUE || b >= MAX_VALUE) revert InvalidInput(a, b);
        emit SumCalculated(a, b, a + b);
        return a + b;
    }
}
```

## Documentation

- Use [NatSpec](https://docs.soliditylang.org/en/latest/natspec-format.html) comments for all public and external functions and state variables.
- Write clear and concise comments explaining complex logic.
- Keep comments up-to-date when changing code.

Example:

```solidity
/// @notice Calculates the sum of two numbers
/// @param a The first number
/// @param b The second number
/// @return The sum of a and b
/// @dev This function will revert if the inputs are too large
/// @dev This function emits a `SumCalculated` event with the sum of a and b
function calculateSum(uint256 a, uint256 b) public pure returns (uint256) {
    // Ensure inputs are within acceptable range
    if (a >= MAX_VALUE || b >= MAX_VALUE) revert InvalidInput(a, b);
    emit SumCalculated(a, b, a + b);
    return a + b;
}
```

## Security Considerations

- Use the `Checks-Effects-Interactions` pattern to prevent reentrancy attacks. This pattern ensures that all checks are performed before any state changes, and external calls are made only after state changes are completed.
- Be cautious with `delegatecall` as it executes code in the context of the calling contract, which can lead to unexpected behavior if not properly managed.
- Use `transfer()` or `call{value: amount}()` for ETH transfers. Prefer the "withdraw" pattern over "send" to avoid issues with call stack depth and gas limits.
  - **`send`**: Uses 2300 gas and returns `true` or `false`. Requires manual error handling and is generally not recommended due to its limitations.
  - **`transfer`**: Also uses 2300 gas and throws an exception on failure, rolling back the transaction. It was previously recommended for its simplicity and safety, but recent gas limit changes may restrict its use.
  - **`call`**: Allows using all remaining gas and returns `true` or `false`. It requires checking the return value for error handling. Due to recent gas limit changes, `call` is increasingly recommended, especially when the recipient may perform complex operations.
- Avoid using `tx.origin` for authentication as it can be manipulated by malicious contracts. Use `msg.sender` instead for reliable authentication.
- For Solidity versions < 0.8.0, use SafeMath to prevent integer overflows and underflows. For versions 0.8.0 and later, Solidity includes built-in overflow checks, making SafeMath unnecessary.
- Consider implementing a fail-safe mode to handle unexpected contract behavior, allowing for emergency stops or controlled shutdowns.
- Regularly review and test your contracts, and consider peer reviews to identify potential security vulnerabilities.

See [Solidity Security Considerations](https://docs.soliditylang.org/en/latest/security-considerations.html) for more details.

## Gas Optimization

- Avoid loops with unbounded length.
- Use `memory` for read-only arrays, `storage` for modifiable state.
- Use events to store data that doesn't need to be accessed by smart contracts.
- Use custom errors instead of `revert("...")` strings for gas efficiency.

## Testing

- Write comprehensive unit tests for all functions.
- Use the MC DevKit for enhanced testing capabilities.
- Implement fuzzing tests for critical functions with foundry.
- Test for edge cases and boundary conditions.

See [Test Strategy](./04-test-strategy.md) for more details.

## Meta Contract (MC) Specific Guidelines

- Use the `MC DevKit` for testing and scripting.
- Import the DevKit contracts (like `MCTest` or `MCScript`) from the flattened file `@mc-devkit/Flattened.sol` in order to reduce the resolution time of the compiler.
- Use the `_use` function to set up contracts and selectors for testing.
- Use proper storage management techniques to prevent storage conflicts.
  - [Research on the Collisions issues between EVM Storage Layout and Upgrade Proxy Pattern](https://mirror.xyz/zer0luck.eth/-7_tRRhql4TOQp-y9GQS1jVf-ev_QmId9vTKEdbF2Hw)

Example of MC DevKit usage in tests:

```solidity
import {MCTest} from "@mc-devkit/Flattened.sol";

contract MyContractTest is MCTest {
    function setUp() public {
        _use(MyContract.someFunction.selector, address(new MyContract()));
    }

    function test_someFunction_success() public {
        // Test implementation
        (bool success, ) = target.call(abi.encodeWithSelector(MyContract.someFunction.selector, arg1, arg2));
        assertTrue(success);
    }
}
```

## Continuous Integration

- Integrate automated testing into the CI/CD pipeline.
- Ensure all tests pass before merging changes into the main branch.
- Use static analysis tools (e.g., Slither, Mythril) as part of the CI process.

## Conclusion

By adhering to these coding standards, we ensure consistency, readability, and maintainability across the Meta Contract smart contracts. These standards should be followed by all contributors to the project. Regular code reviews and automated linting tools should be used to enforce these standards.

Remember that while these guidelines are important, they should not impede productivity or innovation. Use your judgment and discuss with the team if you believe a deviation from these standards is warranted in a specific case.
