# Common Functions
<!-- Utilizing Standard Ops in your UCS projects can significantly streamline the development process. This section delves into the available Standard Ops, how to integrate them into your contracts, and best practices for combining them effectively.

- [Overview of Standard Ops](./overview)
- [Integrating Standard Ops into Your Contracts](./integrating)
- [Best Practices for Combining Standard Ops](./best-practice)

# Overview of Standard Ops
Start by exploring the range of Standard Ops provided by the UCS framework. This overview should include a brief description of each Op, its intended use case, and any key functionalities it offers. Highlighting the versatility and utility of these Ops can help developers understand how they can enhance their smart contracts. -->

<!-- description, selector, function signature, storage, version, deployed contract address by chain -->

<!-- :::danger
Most of the Ops are in the early stages of development, so their use outside of testing purposes is not recommended.
::: -->

<!-- ## DefaultOps
- ### InitSetAdmin
- ### GetDeps

## Factory
- ### Clone

## Dictionary
- ### ChangeDictionary
- ### SetImplementation
- ### TransferDictionaryOwnership
- ### FeatureToggle

## DAO Ops
- ### Propose
- ### Fork
- ### MajorityVote
- ### BordaVote
- ### Tally
- ### Execute

## DAO PassOps
- ### Swap
- ### DepositTo
- ### WithdrawFrom

## ERC-20 Ops
- ### ERC20Transfer
- ### ERC20Approve
- ### ERC20TransferFrom
- ### ERC20BalanceOf


# Integrating Standard Ops into Your Contracts
Incorporating Standard Ops into your smart contracts enhances their functionality and flexibility. This guide will walk you through the process of adding and configuring Standard Ops in your UCS projects, using clear instructions and practical examples.

## Step 1: Identify Required Standard Ops
Begin by identifying the Standard Ops that suit your project's needs. Consider the functionalities you want to implement, such as access control or token management, etc. Review the documentation for Standard Ops to understand their features and requirements.

## Step 2: Update Your Contract
Once you've selected the necessary Standard Ops, it's time to integrate them into your contract. Open your smart contract file and prepare to import and use the Ops.

### Importing Standard Ops
Import the required Standard Ops from the UCS library at the beginning of your contract file. For example, to add a token management Op, you might use:

```solidity
import "ucs-ops/src/ops/TokenManagementOp.sol";
```

### Adding Ops to Your Contract
Incorporate the Ops into your contract by extending them or calling their functions. This could be done in the constructor or specific functions, depending on your contract's design.

```solidity
contract MyContract {
    // Extend a Standard Op (if applicable)
    // or declare a variable of the Op type
    TokenManagementOp tokenManagement;

    constructor() {
        // Initialize or configure the Op
        tokenManagement = new TokenManagementOp();
    }
}
```

## Step 3: Configure the Ops
Some Ops require initial configuration to function correctly. This might involve setting permissions, initializing state variables, or defining key parameters.

```solidity
function initializeTokenManagement() public {
    // Configure the Op with necessary parameters
    tokenManagement.setTokenDetails("MyToken", "MTK", 18);
}
```

## Step 4: Testing the Integration
After integrating the Standard Ops into your contract, thoroughly test the contract to ensure the Ops function as expected. Utilize the UCS testing utilities and consider writing unit tests for each Op's functionality within your contract.

```solidity
// Example test case for token management
function testTokenManagement() public {
    // Initialize the contract and Op
    MyContract contract = new MyContract();
    contract.initializeTokenManagement();

    // Test Op functionalities
    assertTrue(contract.tokenManagement.totalSupply() == 0, "Initial supply should be 0");
}
```

## Step 5: Deployment and Verification
Once testing is complete and you're satisfied with the integration, deploy your contract to the desired network. Remember to verify your contract on platforms like Etherscan, especially if you've used Etherscan-verifiable Ops.
 -->
