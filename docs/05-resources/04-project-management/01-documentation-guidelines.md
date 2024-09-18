---
title: "Documentation Guidelines"
version: 0.1.0
lastUpdated: 2024-09-06
author: Meta Contract Development Team
scope: project
type: guide
tags: [documentation, guidelines, best-practices]
relatedDocs: [project-structure.md, glossary.md]
changeLog:
  - version: 0.1.0
    date: 2024-09-06
    description: Initial version of the documentation guidelines
changeLogLink: /CHANGELOG.md
---

# Documentation Guidelines

This guide outlines the standards and best practices for creating and maintaining documentation in the Meta Contract project.

## General Principles

1. Write clear, concise, and accurate documentation.
2. Keep documentation up-to-date with code changes.
3. Use a consistent style and format across all documentation.
4. Write for your audience, considering their technical background.

## Documentation Structure

The documentation should follow this structure:

```
docs/
├── 01-introduction
│   ├── 01-what-is-meta-contract.md
│   ├── 02-key-concepts.md
│   ├── 03-getting-started
│   │   ├── 01-installation.md
│   │   ├── 02-basic-setup.md
│   │   └── index.md
│   └── index.md
├── 02-tutorials
│   ├── 01-simple-dao.md
│   ├── 02-simple-dex.md
│   ├── 03-stable-credit.md
│   ├── 04-erc-implementations
│   │   ├── 01-erc20.md
│   │   ├── 02-erc721.md
│   │   ├── 03-erc1155.md
│   │   ├── 04-erc4337.md
│   │   └── index.md
│   └── index.md
├── 03-devops
│   ├── 01-tdd.md
│   ├── 02-deployment.md
│   ├── 03-upgrades.md
│   ├── 04-ci-cd.md
│   └── index.md
├── 04-plugin-functions
│   ├── 01-common
│   │   ├── 01-access-control
│   │   │   └── index.md
│   │   └── index.md
│   ├── 02-deliberation
│   │   └── index.md
│   ├── 03-token
│   │   └── index.md
│   ├── 04-defi
│   │   └── index.md
│   ├── 05-std
│   │   ├── functions
│   │   │   ├── Clone.sol
│   │   │   │   ├── contract.Clone.md
│   │   │   │   └── index.md
│   │   │   ├── Create.sol
│   │   │   │   ├── contract.Create.md
│   │   │   │   └── index.md
│   │   │   ├── GetFunctions.sol
│   │   │   │   ├── contract.GetFunctions.md
│   │   │   │   └── index.md
│   │   │   ├── Receive.sol
│   │   │   │   ├── contract.Receive.md
│   │   │   │   └── index.md
│   │   │   ├── index.md
│   │   │   ├── internal
│   │   │   │   ├── ProxyCreator.sol
│   │   │   │   │   ├── index.md
│   │   │   │   │   └── library.ProxyCreator.md
│   │   │   │   └── index.md
│   │   │   └── protected
│   │   │       ├── FeatureToggle.sol
│   │   │       │   ├── contract.FeatureToggle.md
│   │   │       │   └── index.md
│   │   │       ├── InitSetAdmin.sol
│   │   │       │   ├── contract.InitSetAdmin.md
│   │   │       │   └── index.md
│   │   │       ├── UpgradeDictionary.sol
│   │   │       │   ├── contract.UpgradeDictionary.md
│   │   │       │   └── index.md
│   │   │       ├── index.md
│   │   │       └── protection
│   │   │           ├── FeatureToggle.sol
│   │   │           │   ├── index.md
│   │   │           │   └── library.FeatureToggle.md
│   │   │           ├── Initialization.sol
│   │   │           │   ├── index.md
│   │   │           │   └── library.Initialization.md
│   │   │           ├── MsgSender.sol
│   │   │           │   ├── index.md
│   │   │           │   └── library.MsgSender.md
│   │   │           ├── ProtectionBase.sol
│   │   │           │   ├── abstract.ProtectionBase.md
│   │   │           │   └── index.md
│   │   │           └── index.md
│   │   ├── index.md
│   │   ├── interfaces
│   │   │   ├── IStd.sol
│   │   │   │   ├── index.md
│   │   │   │   └── interface.IStd.md
│   │   │   ├── StdFacade.sol
│   │   │   │   ├── contract.StdFacade.md
│   │   │   │   └── index.md
│   │   │   └── index.md
│   │   └── storage
│   │       ├── Schema.sol
│   │       │   ├── index.md
│   │       │   └── interface.Schema.md
│   │       ├── Storage.sol
│   │       │   ├── index.md
│   │       │   └── library.Storage.md
│   │       └── index.md
│   └── index.md
└── 05-resources
    ├── 01-general
    │   ├── 01-ethereum.md
    │   ├── 02-foundry.md
    │   ├── 03-solidity.md
    │   └── index.md
    ├── 02-meta-contract-architecture
    │   ├── 01-erc7546.md
    │   ├── 02-overview.md
    │   ├── 03-schema-based-storage.md
    │   ├── 04-interfaces.md
    │   └── index.md
    ├── 03-devkit
    │   ├── 01-overview.md
    │   ├── 02-usage.md
    │   ├── 03-api-reference
    │   │   ├── Flattened.sol
    │   │   │   ├── abstract.CommonBase.md
    │   │   │   ├── abstract.Context.md
    │   │   │   ├── abstract.DictionaryBase.md
    │   │   │   ├── abstract.MCBase.md
    │   │   │   ├── abstract.MCScript.md
    │   │   │   ├── abstract.MCScriptBase.md
    │   │   │   ├── abstract.MCTest.md
    │   │   │   ├── abstract.MCTestBase.md
    │   │   │   ├── abstract.Ownable.md
    │   │   │   ├── abstract.ProtectionBase.md
    │   │   │   ├── abstract.Proxy_0.md
    │   │   │   ├── abstract.Script.md
    │   │   │   ├── abstract.ScriptBase.md
    │   │   │   ├── abstract.StdAssertions.md
    │   │   │   ├── abstract.StdChains.md
    │   │   │   ├── abstract.StdCheats.md
    │   │   │   ├── abstract.StdCheatsSafe.md
    │   │   │   ├── abstract.StdInvariant.md
    │   │   │   ├── abstract.StdUtils.md
    │   │   │   ├── abstract.Test.md
    │   │   │   ├── abstract.TestBase.md
    │   │   │   ├── constants.Flattened.md
    │   │   │   ├── contract.BeaconDictionary.md
    │   │   │   ├── contract.Clone.md
    │   │   │   ├── contract.Dictionary_0.md
    │   │   │   ├── contract.DummyContract.md
    │   │   │   ├── contract.DummyFacade.md
    │   │   │   ├── contract.DummyFunction.md
    │   │   │   ├── contract.FeatureToggle.md
    │   │   │   ├── contract.GetFunctions.md
    │   │   │   ├── contract.ImmutableDictionary.md
    │   │   │   ├── contract.InitSetAdmin.md
    │   │   │   ├── contract.MockDictionary.md
    │   │   │   ├── contract.MockERC20.md
    │   │   │   ├── contract.MockERC721.md
    │   │   │   ├── contract.Proxy_1.md
    │   │   │   ├── contract.Receive.md
    │   │   │   ├── contract.SimpleMockProxy.md
    │   │   │   ├── contract.StdFacade.md
    │   │   │   ├── contract.UpgradeDictionary.md
    │   │   │   ├── contract.UpgradeableBeacon.md
    │   │   │   ├── enum.DictionaryKind.md
    │   │   │   ├── enum.ProxyKind.md
    │   │   │   ├── enum.TypeStatus.md
    │   │   │   ├── function.loadAddressFrom.md
    │   │   │   ├── function.param_0.md
    │   │   │   ├── function.param_1.md
    │   │   │   ├── function.param_10.md
    │   │   │   ├── function.param_11.md
    │   │   │   ├── function.param_12.md
    │   │   │   ├── function.param_13.md
    │   │   │   ├── function.param_14.md
    │   │   │   ├── function.param_15.md
    │   │   │   ├── function.param_16.md
    │   │   │   ├── function.param_17.md
    │   │   │   ├── function.param_18.md
    │   │   │   ├── function.param_19.md
    │   │   │   ├── function.param_2.md
    │   │   │   ├── function.param_20.md
    │   │   │   ├── function.param_21.md
    │   │   │   ├── function.param_22.md
    │   │   │   ├── function.param_23.md
    │   │   │   ├── function.param_24.md
    │   │   │   ├── function.param_25.md
    │   │   │   ├── function.param_26.md
    │   │   │   ├── function.param_27.md
    │   │   │   ├── function.param_3.md
    │   │   │   ├── function.param_4.md
    │   │   │   ├── function.param_5.md
    │   │   │   ├── function.param_6.md
    │   │   │   ├── function.param_7.md
    │   │   │   ├── function.param_8.md
    │   │   │   ├── function.param_9.md
    │   │   │   ├── index.md
    │   │   │   ├── interface.IBeacon.md
    │   │   │   ├── interface.IDictionary.md
    │   │   │   ├── interface.IDictionaryCore.md
    │   │   │   ├── interface.IERC165_0.md
    │   │   │   ├── interface.IERC165_1.md
    │   │   │   ├── interface.IERC20.md
    │   │   │   ├── interface.IERC721.md
    │   │   │   ├── interface.IERC721Enumerable.md
    │   │   │   ├── interface.IERC721Metadata.md
    │   │   │   ├── interface.IERC721TokenReceiver.md
    │   │   │   ├── interface.IMulticall3.md
    │   │   │   ├── interface.IProxy.md
    │   │   │   ├── interface.IStd.md
    │   │   │   ├── interface.IVerifiable.md
    │   │   │   ├── interface.Schema.md
    │   │   │   ├── interface.Vm.md
    │   │   │   ├── interface.VmSafe.md
    │   │   │   ├── library.Address.md
    │   │   │   ├── library.BundleLib.md
    │   │   │   ├── library.BundleRegistryLib.md
    │   │   │   ├── library.ConfigLib.md
    │   │   │   ├── library.CurrentLib.md
    │   │   │   ├── library.DictionaryLib.md
    │   │   │   ├── library.DictionaryRegistryLib.md
    │   │   │   ├── library.Dummy.md
    │   │   │   ├── library.ERC1967Utils.md
    │   │   │   ├── library.ForgeHelper.md
    │   │   │   ├── library.Formatter.md
    │   │   │   ├── library.FunctionLib.md
    │   │   │   ├── library.FunctionRegistryLib.md
    │   │   │   ├── library.Initialization.md
    │   │   │   ├── library.Inspector.md
    │   │   │   ├── library.Logger.md
    │   │   │   ├── library.MCDeployLib.md
    │   │   │   ├── library.MCFinderLib.md
    │   │   │   ├── library.MCHelpers.md
    │   │   │   ├── library.MCInitLib.md
    │   │   │   ├── library.MCMockLib.md
    │   │   │   ├── library.MessageBody.md
    │   │   │   ├── library.MessageHead.md
    │   │   │   ├── library.MsgSender.md
    │   │   │   ├── library.NameGenerator.md
    │   │   │   ├── library.Parser.md
    │   │   │   ├── library.ProxyCreator.md
    │   │   │   ├── library.ProxyLib.md
    │   │   │   ├── library.ProxyRegistryLib.md
    │   │   │   ├── library.ProxyUtils.md
    │   │   │   ├── library.SimpleMockProxyLib.md
    │   │   │   ├── library.StdFunctionsArgs.md
    │   │   │   ├── library.StdFunctionsLib.md
    │   │   │   ├── library.StdRegistryLib.md
    │   │   │   ├── library.StdStyle.md
    │   │   │   ├── library.Storage.md
    │   │   │   ├── library.StorageSlot.md
    │   │   │   ├── library.System.md
    │   │   │   ├── library.Tracer.md
    │   │   │   ├── library.TypeGuard.md
    │   │   │   ├── library.Validator.md
    │   │   │   ├── library.console.md
    │   │   │   ├── library.safeconsole.md
    │   │   │   ├── library.stdError.md
    │   │   │   ├── library.stdJson.md
    │   │   │   ├── library.stdMath.md
    │   │   │   ├── library.stdStorage.md
    │   │   │   ├── library.stdStorageSafe.md
    │   │   │   ├── library.stdToml.md
    │   │   │   ├── struct.Bundle.md
    │   │   │   ├── struct.BundleRegistry.md
    │   │   │   ├── struct.ConfigState.md
    │   │   │   ├── struct.Current.md
    │   │   │   ├── struct.DictionaryRegistry.md
    │   │   │   ├── struct.Dictionary_1.md
    │   │   │   ├── struct.FindData.md
    │   │   │   ├── struct.Function.md
    │   │   │   ├── struct.FunctionRegistry.md
    │   │   │   ├── struct.MCDevKit.md
    │   │   │   ├── struct.NamingConfig.md
    │   │   │   ├── struct.Process.md
    │   │   │   ├── struct.ProxyRegistry.md
    │   │   │   ├── struct.Proxy_2.md
    │   │   │   ├── struct.SetupConfig.md
    │   │   │   ├── struct.StdFunctions.md
    │   │   │   ├── struct.StdRegistry.md
    │   │   │   ├── struct.StdStorage.md
    │   │   │   ├── struct.SystemConfig.md
    │   │   │   └── struct.Trace.md
    │   │   ├── MCBase.sol
    │   │   │   ├── abstract.MCBase.md
    │   │   │   ├── abstract.MCScriptBase.md
    │   │   │   ├── abstract.MCTestBase.md
    │   │   │   └── index.md
    │   │   ├── MCDevKit.sol
    │   │   │   ├── index.md
    │   │   │   └── struct.MCDevKit.md
    │   │   ├── MCScript.sol
    │   │   │   ├── abstract.MCScript.md
    │   │   │   └── index.md
    │   │   ├── MCTest.sol
    │   │   │   ├── abstract.MCTest.md
    │   │   │   └── index.md
    │   │   ├── core
    │   │   │   ├── Bundle.sol
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.BundleLib.md
    │   │   │   │   └── struct.Bundle.md
    │   │   │   ├── Dictionary.sol
    │   │   │   │   ├── enum.DictionaryKind.md
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.DictionaryLib.md
    │   │   │   │   └── struct.Dictionary.md
    │   │   │   ├── Function.sol
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.FunctionLib.md
    │   │   │   │   └── struct.Function.md
    │   │   │   ├── Proxy.sol
    │   │   │   │   ├── enum.ProxyKind.md
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.ProxyLib.md
    │   │   │   │   └── struct.Proxy.md
    │   │   │   └── index.md
    │   │   ├── index.md
    │   │   ├── registry
    │   │   │   ├── BundleRegistry.sol
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.BundleRegistryLib.md
    │   │   │   │   └── struct.BundleRegistry.md
    │   │   │   ├── DictionaryRegistry.sol
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.DictionaryRegistryLib.md
    │   │   │   │   └── struct.DictionaryRegistry.md
    │   │   │   ├── FunctionRegistry.sol
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.FunctionRegistryLib.md
    │   │   │   │   └── struct.FunctionRegistry.md
    │   │   │   ├── ProxyRegistry.sol
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.ProxyRegistryLib.md
    │   │   │   │   └── struct.ProxyRegistry.md
    │   │   │   ├── StdFunctions.sol
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.StdFunctionsLib.md
    │   │   │   │   └── struct.StdFunctions.md
    │   │   │   ├── StdRegistry.sol
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.StdFunctionsArgs.md
    │   │   │   │   ├── library.StdRegistryLib.md
    │   │   │   │   └── struct.StdRegistry.md
    │   │   │   ├── context
    │   │   │   │   ├── Current.sol
    │   │   │   │   │   ├── index.md
    │   │   │   │   │   ├── library.CurrentLib.md
    │   │   │   │   │   └── struct.Current.md
    │   │   │   │   └── index.md
    │   │   │   └── index.md
    │   │   ├── system
    │   │   │   ├── Config.sol
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.ConfigLib.md
    │   │   │   │   ├── struct.ConfigState.md
    │   │   │   │   ├── struct.NamingConfig.md
    │   │   │   │   ├── struct.SetupConfig.md
    │   │   │   │   └── struct.SystemConfig.md
    │   │   │   ├── Logger.sol
    │   │   │   │   ├── index.md
    │   │   │   │   └── library.Logger.md
    │   │   │   ├── System.sol
    │   │   │   │   ├── index.md
    │   │   │   │   └── library.System.md
    │   │   │   ├── Tracer.sol
    │   │   │   │   ├── function.param.md
    │   │   │   │   ├── index.md
    │   │   │   │   ├── library.Tracer.md
    │   │   │   │   ├── struct.Process.md
    │   │   │   │   └── struct.Trace.md
    │   │   │   ├── Validator.sol
    │   │   │   │   ├── index.md
    │   │   │   │   └── library.Validator.md
    │   │   │   ├── index.md
    │   │   │   └── message
    │   │   │       ├── DecodeErrorString.sol
    │   │   │       │   ├── index.md
    │   │   │       │   └── library.DecodeErrorString.md
    │   │   │       ├── MessageBody.sol
    │   │   │       │   ├── index.md
    │   │   │       │   └── library.MessageBody.md
    │   │   │       ├── MessageHead.sol
    │   │   │       │   ├── index.md
    │   │   │       │   └── library.MessageHead.md
    │   │   │       └── index.md
    │   │   ├── test
    │   │   │   ├── dummy
    │   │   │   │   ├── Dummy.sol
    │   │   │   │   │   ├── index.md
    │   │   │   │   │   └── library.Dummy.md
    │   │   │   │   ├── DummyContract.sol
    │   │   │   │   │   ├── contract.DummyContract.md
    │   │   │   │   │   └── index.md
    │   │   │   │   ├── DummyFacade.sol
    │   │   │   │   │   ├── contract.DummyFacade.md
    │   │   │   │   │   └── index.md
    │   │   │   │   ├── DummyFunction.sol
    │   │   │   │   │   ├── contract.DummyFunction.md
    │   │   │   │   │   └── index.md
    │   │   │   │   └── index.md
    │   │   │   ├── index.md
    │   │   │   └── mocks
    │   │   │       ├── MockDictionary.sol
    │   │   │       │   ├── contract.MockDictionary.md
    │   │   │       │   └── index.md
    │   │   │       ├── SimpleMockProxy.sol
    │   │   │       │   ├── contract.SimpleMockProxy.md
    │   │   │       │   ├── index.md
    │   │   │       │   └── library.SimpleMockProxyLib.md
    │   │   │       └── index.md
    │   │   ├── types
    │   │   │   ├── Formatter.sol
    │   │   │   │   ├── index.md
    │   │   │   │   └── library.Formatter.md
    │   │   │   ├── Inspector.sol
    │   │   │   │   ├── index.md
    │   │   │   │   └── library.Inspector.md
    │   │   │   ├── Parser.sol
    │   │   │   │   ├── index.md
    │   │   │   │   └── library.Parser.md
    │   │   │   ├── TypeGuard.sol
    │   │   │   │   ├── enum.TypeStatus.md
    │   │   │   │   ├── index.md
    │   │   │   │   └── library.TypeGuard.md
    │   │   │   └── index.md
    │   │   └── utils
    │   │       ├── ForgeHelper.sol
    │   │       │   ├── constants.ForgeHelper.md
    │   │       │   ├── function.loadAddressFrom.md
    │   │       │   ├── index.md
    │   │       │   └── library.ForgeHelper.md
    │   │       ├── global
    │   │       │   ├── MCDeployLib.sol
    │   │       │   │   ├── index.md
    │   │       │   │   └── library.MCDeployLib.md
    │   │       │   ├── MCFinderLib.sol
    │   │       │   │   ├── index.md
    │   │       │   │   └── library.MCFinderLib.md
    │   │       │   ├── MCHelpers.sol
    │   │       │   │   ├── index.md
    │   │       │   │   └── library.MCHelpers.md
    │   │       │   ├── MCInitLib.sol
    │   │       │   │   ├── index.md
    │   │       │   │   └── library.MCInitLib.md
    │   │       │   ├── MCMockLib.sol
    │   │       │   │   ├── index.md
    │   │       │   │   └── library.MCMockLib.md
    │   │       │   └── index.md
    │   │       ├── index.md
    │   │       └── mapping
    │   │           ├── NameGenerator.sol
    │   │           │   ├── index.md
    │   │           │   └── library.NameGenerator.md
    │   │           └── index.md
    │   └── index.md
    ├── 04-project-management
    │   ├── 01-documentation-guidelines.md
    │   ├── 02-glossary.md
    │   ├── 03-versioning.md
    │   ├── 04-changelog.md
    │   └── index.md
    ├── 05-integration
    │   ├── 01-the-graph.md
    │   ├── 02-etherscan.md
    │   └── index.md
    ├── 06-best-practices
    │   ├── 01-ai-tdd.md
    │   ├── 02-using-internal-library.md
    │   └── index.md
    └── index.md
```

Each `index.md` file should contain:
1. A brief description of the contents of that directory
2. Links to the files and subdirectories within it
3. Any additional context or information relevant to that section of the documentation

## File Naming Convention

Use kebab-case for all documentation file names:

```
what-is-meta-contract.md
key-concepts.md
```

## Markdown Formatting

1. Use ATX-style headers (`#` for h1, `##` for h2, etc.).
2. Use backticks for inline code and triple backticks for code blocks.
3. Use appropriate language identifiers for code blocks (e.g., ```solidity).
4. Use unordered lists (`-`) for most lists, and ordered lists (`1.`) when sequence matters.

## Documentation Header

Each documentation file should start with a metadata block followed by the document content:

```markdown
---
title: "Full Document Title"
version: 0.1.0
lastUpdated: YYYY-MM-DD
author: [Author Names]
scope: [Scope of the document, e.g., dev, arch]
type: [Type of document, e.g., spec, guide]
tags: [tag1, tag2, tag3]
relatedDocs: ["RELATED_DOC_1.md", "RELATED_DOC_2.md"]
changeLog:
  - version: 0.1.0
    date: YYYY-MM-DD
    description: [Description of initial version]
---

# Document Title

Brief description or introduction to the document content.

[Main document content starts here]
```

## Code Documentation

### Solidity

Use NatSpec comments for all public and external functions:

```solidity
/**
 * @notice Calculates the sum of two numbers
 * @param a The first number
 * @param b The second number
 * @return The sum of a and b
 */
function calculateSum(uint256 a, uint256 b) public pure returns (uint256) {
    return a + b;
}
```

## Diagrams

Use Mermaid for creating diagrams in documentation. Include the diagram source in the Markdown file:

```mermaid
graph TD
    A[Proxy Contract] --> B{Dictionary Contract}
    B --> C[Function Contract 1]
    B --> D[Function Contract 2]
    B --> E[Function Contract 3]
```

## Versioning Documentation

1. Start all document versions at 0.1.0.
2. Increment the version number when making significant updates to a document.
3. Clearly indicate which version of the software each document applies to.

## Review Process

1. All documentation changes should go through peer review.
2. Check for technical accuracy, clarity, and adherence to these guidelines.
3. Ensure all links are working and point to the correct destinations.

By following these guidelines, we ensure consistency and quality across all Meta Contract documentation, making it easier for developers and users to understand and use our project.
