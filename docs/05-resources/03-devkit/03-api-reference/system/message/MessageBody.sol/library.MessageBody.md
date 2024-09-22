# MessageBody
[Git Source](https://github.com/metacontract/mc/blob/d41f04df9ea19494be75c66f344b8104caf03cd2/resources/devkit/api-reference/system/message/MessageBody.sol)


## State Variables
### CONFIG_FILE_MISSING

```solidity
string constant CONFIG_FILE_MISSING =
    "Please ensure that the configuration file is present in the project root directory. If the file is missing, create a new one or restore it from the 'lib/mc/mc.toml' template.";
```


### CONFIG_FILE_REQUIRED

```solidity
string constant CONFIG_FILE_REQUIRED =
    "The configuration file is required and must be present in the project root directory. Please create a new 'mc.toml' file or restore it from the 'lib/mc/mc.toml' template.";
```


### NAME_REQUIRED

```solidity
string constant NAME_REQUIRED =
    "The provided name cannot be an empty string. Please enter a non-empty value for the name and try again.";
```


### ENV_KEY_REQUIRED

```solidity
string constant ENV_KEY_REQUIRED =
    "The provided environment key cannot be an empty string. Please enter a non-empty value for the key and try again.";
```


### SELECTOR_RECOMMENDED

```solidity
string constant SELECTOR_RECOMMENDED =
    "The provided function selector is empty (0x00000000). It is recommended to use a non-empty selector.";
```


### ADDRESS_NOT_CONTRACT

```solidity
string constant ADDRESS_NOT_CONTRACT =
    "The provided address is not a contract address. Please provide the address of a deployed contract and try again.";
```


### FACADE_NOT_CONTRACT

```solidity
string constant FACADE_NOT_CONTRACT =
    "The provided facade address is not a contract address. It is recommended to use the address of a deployed facade contract and try again.";
```


### OWNER_ZERO_ADDRESS_RECOMMENDED

```solidity
string constant OWNER_ZERO_ADDRESS_RECOMMENDED =
    "The provided owner address is the zero address (0x0). It is recommended to use a non-zero address for the owner to ensure proper access control and security.";
```


### CURRENT_NAME_NOT_FOUND

```solidity
string constant CURRENT_NAME_NOT_FOUND = "Current Name Not Found";
```


### FUNC_NAME_UNASSIGNED

```solidity
string constant FUNC_NAME_UNASSIGNED =
    "The function name is currently unassigned. It is recommended to provide a non-empty value for the name.";
```


### FUNC_CONTRACT_UNASSIGNED

```solidity
string constant FUNC_CONTRACT_UNASSIGNED =
    "The implementation contract address is currently unassigned. It is recommended to set the address of a deployed contract.";
```


### FUNC_NOT_COMPLETE

```solidity
string constant FUNC_NOT_COMPLETE =
    "The function is not marked as complete. Please ensure all requirements are met before proceeding.";
```


### FUNC_LOCKED

```solidity
string constant FUNC_LOCKED = "The function object is currently locked and cannot be modified.";
```


### FUNC_NOT_BUILDING

```solidity
string constant FUNC_NOT_BUILDING =
    "The function is not currently in the building state. Please initiate the building process before proceeding.";
```


### FUNC_NOT_BUILT

```solidity
string constant FUNC_NOT_BUILT =
    "The function has not been successfully built yet. Please complete the building process before attempting to use the function.";
```


### FUNC_NOT_REGISTERED

```solidity
string constant FUNC_NOT_REGISTERED =
    "The function name is not registered in the registry. Please register the function before proceeding.";
```


### BUNDLE_NAME_UNASSIGNED

```solidity
string constant BUNDLE_NAME_UNASSIGNED =
    "The name of the bundle is currently unassigned. It is recommended to provide a non-empty value for the bundle name.";
```


### NO_FUNCTIONS_IN_BUNDLE

```solidity
string constant NO_FUNCTIONS_IN_BUNDLE =
    "The bundle should contain at least one function. Please add functions before attempting to build the bundle.";
```


### NO_FUNCTIONS_IN_BUNDLE_REQUIRED

```solidity
string constant NO_FUNCTIONS_IN_BUNDLE_REQUIRED =
    "The bundle must contain at least one function. Please add functions before attempting to build the bundle.";
```


### BUNDLE_FACADE_UNASSIGNED

```solidity
string constant BUNDLE_FACADE_UNASSIGNED =
    "The facade contract for the bundle is currently unassigned. It is recommended to set the address of a deployed contract as the facade.";
```


### BUNDLE_NOT_INITIALIZED

```solidity
string constant BUNDLE_NOT_INITIALIZED =
    "The bundle has not been initialized. Please ensure the bundle is properly initialized before proceeding.";
```


### BUNDLE_NOT_COMPLETE

```solidity
string constant BUNDLE_NOT_COMPLETE =
    "The bundle is not marked as complete. It is recommended to ensure all requirements are met before proceeding.";
```


### BUNDLE_NOT_COMPLETE_REQUIRED

```solidity
string constant BUNDLE_NOT_COMPLETE_REQUIRED =
    "The bundle is not marked as complete. It is required to ensure all requirements are met before proceeding.";
```


### BUNDLE_CONTAINS_SAME_SELECTOR

```solidity
string constant BUNDLE_CONTAINS_SAME_SELECTOR =
    "The bundle cannot contain multiple functions with the same 4-byte selector. The function selector is already present in the bundle.";
```


### BUNDLE_LOCKED

```solidity
string constant BUNDLE_LOCKED = "The bundle object is currently locked and cannot be modified.";
```


### BUNDLE_NOT_BUILDING

```solidity
string constant BUNDLE_NOT_BUILDING =
    "The bundle is not currently in the building state. Please initiate the building process before proceeding.";
```


### BUNDLE_NOT_BUILT

```solidity
string constant BUNDLE_NOT_BUILT =
    "The bundle has not been successfully built yet. Please complete the building process before attempting to use the bundle.";
```


### CURRENT_BUNDLE_NOT_EXIST

```solidity
string constant CURRENT_BUNDLE_NOT_EXIST =
    "There is no current bundle set in the registry. It is recommended to set a bundle as the current one before proceeding.";
```


### CURRENT_BUNDLE_NOT_EXIST_REQUIRED

```solidity
string constant CURRENT_BUNDLE_NOT_EXIST_REQUIRED =
    "There is no current bundle set in the registry. It is required to set a bundle as the current one before proceeding. Please make sure to call the mc.init() method to initialize the current bundle.";
```


### PROXY_ADDR_UNASSIGNED

```solidity
string constant PROXY_ADDR_UNASSIGNED =
    "The address of the proxy contract is currently unassigned. Please set the address of a deployed contract.";
```


### PROXY_KIND_UNDEFINED

```solidity
string constant PROXY_KIND_UNDEFINED =
    "The kind of proxy is not defined. Please specify the proxy kind before proceeding.";
```


### PROXY_NOT_COMPLETE

```solidity
string constant PROXY_NOT_COMPLETE =
    "The proxy object is not marked as complete. Please ensure all requirements are met before proceeding.";
```


### PROXY_LOCKED

```solidity
string constant PROXY_LOCKED = "The proxy object is currently locked and cannot be modified.";
```


### PROXY_NOT_BUILDING

```solidity
string constant PROXY_NOT_BUILDING =
    "The proxy is not currently in the building state. Please initiate the building process before proceeding.";
```


### PROXY_NOT_BUILT

```solidity
string constant PROXY_NOT_BUILT =
    "The proxy has not been successfully built yet. Please complete the building process before attempting to use the proxy.";
```


### PROXY_ALREADY_REGISTERED

```solidity
string constant PROXY_ALREADY_REGISTERED =
    "The proxy name is already registered in the registry. Please use a different name.";
```


### PROXY_NOT_REGISTERED

```solidity
string constant PROXY_NOT_REGISTERED =
    "The proxy name is not registered in the registry. Please register the proxy name before proceeding.";
```


### CURRENT_PROXY_NOT_EXIST

```solidity
string constant CURRENT_PROXY_NOT_EXIST =
    "There is no current proxy set in the registry. It is required to set a proxy as the current one before proceeding. Please make sure to deploy the current proxy.";
```


### DICTIONARY_NAME_UNASSIGNED

```solidity
string constant DICTIONARY_NAME_UNASSIGNED =
    "The name of the dictionary contract is currently unassigned. Please set the name of a deployed contract.";
```


### DICTIONARY_ADDR_UNASSIGNED

```solidity
string constant DICTIONARY_ADDR_UNASSIGNED =
    "The address of the dictionary contract is currently unassigned. Please set the address of a deployed contract.";
```


### DICTIONARY_KIND_UNDEFINED

```solidity
string constant DICTIONARY_KIND_UNDEFINED =
    "The kind of dictionary is not defined. Please specify the dictionary kind before proceeding.";
```


### DICTIONARY_NOT_COMPLETE

```solidity
string constant DICTIONARY_NOT_COMPLETE =
    "The dictionary object is not marked as complete. Please ensure all requirements are met before proceeding.";
```


### DICTIONARY_NOT_VERIFIABLE

```solidity
string constant DICTIONARY_NOT_VERIFIABLE =
    "The dictionary is not verifiable. Please ensure all prerequisites are met for verification.";
```


### DICTIONARY_LOCKED

```solidity
string constant DICTIONARY_LOCKED = "The dictionary object is currently locked and cannot be modified.";
```


### DICTIONARY_NOT_BUILDING

```solidity
string constant DICTIONARY_NOT_BUILDING =
    "The dictionary is not currently in the building state. Please initiate the building process before proceeding.";
```


### DICTIONARY_NOT_BUILT

```solidity
string constant DICTIONARY_NOT_BUILT =
    "The dictionary has not been successfully built yet. Please complete the building process before attempting to use the dictionary.";
```


### DICTIONARY_ALREADY_REGISTERED

```solidity
string constant DICTIONARY_ALREADY_REGISTERED =
    "The dictionary name is already registered in the registry. Please use a different name.";
```


### DICTIONARY_NOT_REGISTERED

```solidity
string constant DICTIONARY_NOT_REGISTERED =
    "The dictionary name is not registered in the registry. Please register the dictionary name before proceeding.";
```


### CURRENT_DICTIONARY_NOT_EXIST

```solidity
string constant CURRENT_DICTIONARY_NOT_EXIST =
    "There is no current dictionary set in the registry. It is required to set a dictionary as the current one before proceeding. Please make sure to deploy/load/duplicate the current dictionary.";
```


### STD_REGISTRY_NOT_COMPLETE

```solidity
string constant STD_REGISTRY_NOT_COMPLETE =
    "The standard registry is not marked as complete. Please ensure all requirements are met before proceeding.";
```


### STD_REGISTRY_LOCKED

```solidity
string constant STD_REGISTRY_LOCKED = "The standard registry is currently locked and cannot be modified.";
```


### STD_REGISTRY_NOT_BUILDING

```solidity
string constant STD_REGISTRY_NOT_BUILDING =
    "The standard registry is not currently in the building state. Please initiate the building process before proceeding.";
```


### STD_REGISTRY_NOT_BUILT

```solidity
string constant STD_REGISTRY_NOT_BUILT =
    "The standard registry has not been successfully built yet. Please complete the building process before attempting to use the registry.";
```


### STD_FUNCTIONS_NOT_COMPLETE

```solidity
string constant STD_FUNCTIONS_NOT_COMPLETE =
    "The standard functions object is not marked as complete. Please ensure all requirements are met before proceeding.";
```


### STD_FUNCTIONS_LOCKED

```solidity
string constant STD_FUNCTIONS_LOCKED = "The standard functions object is currently locked and cannot be modified.";
```


### STD_FUNCTIONS_NOT_BUILDING

```solidity
string constant STD_FUNCTIONS_NOT_BUILDING =
    "The standard functions are not currently in the building state. Please initiate the building process before proceeding.";
```


### STD_FUNCTIONS_NOT_BUILT

```solidity
string constant STD_FUNCTIONS_NOT_BUILT =
    "The standard functions have not been successfully built yet. Please complete the building process before attempting to use them.";
```


### NOT_FOUND_IN_RANGE

```solidity
string constant NOT_FOUND_IN_RANGE =
    "The value was not found within the expected range. Please provide a value that falls within the specified range and try again.";
```


### TEST_MUST_USE_FUNCTION

```solidity
string constant TEST_MUST_USE_FUNCTION =
    "The function required for testing is not configured. Please set it up using '_use'.";
```


