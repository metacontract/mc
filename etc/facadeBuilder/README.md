# how to generate facade
- `cp facade.yaml ../../`
- Write the configuration based on the following YAML Specification.
- `node ./facadeBuilder.js`

# How to build everytime you change facadeBuilder.ts
- `npm run exec`

# Solidity Bundle Configuration YAML Specification

## Overview

This YAML specification is specifically designed for Solidity smart contract bundle configurations, providing a flexible way to define contract facades and exclusion rules.

## Structure

### Bundle Properties

| Property | Type | Description | Required | Default Behavior |
|----------|------|-------------|----------|-----------------|
| `bundleName` | String | Human-readable name of the Solidity bundle | ✓ | - |
| `bundleDirName` | String | Directory name for the bundle | × | Falls back to `bundleName` |
| `facades` | List | Definitions of contract facades | ✓ | - |

### Facade Properties for Solidity

| Property | Type | Description | Required |
|----------|------|-------------|----------|
| `name` | String | Name of the contract facade | ✓ |
| `excludeFileNames` | List of Strings | Solidity contract files to exclude | × |
| `excludeFunctionNames` | List of Strings | Function names to exclude from the facade | × |

## Examples

### Solidity Contract Bundle Configuration
```yaml
- bundleName: "TextDAO"
  facades:
    - name: "TextDAOFacade"
      excludeFileNames:
        - "OnlyAdminCheats.sol"
      excludeFunctionNames:
        - "adminOnly"
        - "internalUpgrade"
```

### Multiple Facade Configuration
```yaml
- bundleName: "GovernanceContract"
  facades:
    - name: "PublicFacade"
      excludeFileNames:
        - "AdminControls.sol"
      excludeFunctionNames:
        - "emergencyStop"
    
    - name: "AdminFacade"
      excludeFileNames:
        - "PublicInteractions.sol"
```

## Solidity-Specific Considerations

### File Exclusions
- Typically used to separate administrative or sensitive contract files
- Can exclude utility contracts, test contracts, or partial implementations
- Helps in managing contract visibility and access

### Function Exclusions
- Prevents exposure of internal or administrative functions
- Useful for creating restricted interfaces
- Supports creating different levels of contract access

## Validation Rules

1. `bundleName` must be a non-empty string
2. If `bundleDirName` is not provided, use `bundleName` as the directory name
3. Each bundle must have at least one facade
4. Exclusions apply to Solidity (`.sol`) files and function names
5. Excluded elements are removed from the generated facade interface

## Best Practices

- Use clear naming conventions for contracts and functions
- Be intentional about what is included or excluded
- Consider security implications of facade design
- Align exclusions with access control and contract architecture