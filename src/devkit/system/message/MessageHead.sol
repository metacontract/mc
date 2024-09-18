// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

/// @title Message Head
library MessageHead {
    // Config
    string constant CONFIG_FILE_MISSING = "Config File Missing";
    string constant CONFIG_FILE_REQUIRED = "Config File Required";
    // Primitives
    string constant NAME_REQUIRED = "Name Required";
    string constant ENV_KEY_REQUIRED = "EnvKey Required";
    string constant SELECTOR_RECOMMENDED = "Empty Selector";
    string constant ADDRESS_NOT_CONTRACT = "Address Not Contract";
    string constant FACADE_NOT_CONTRACT = "Facade Not Contract";
    string constant OWNER_ZERO_ADDRESS_RECOMMENDED = "Owner Zero Address";
    // Current Context
    string constant CURRENT_NAME_NOT_FOUND = "Current Name Not Found";
    // Function
    string constant FUNC_NAME_UNASSIGNED = "Function Name Unassigned";
    string constant FUNC_CONTRACT_UNASSIGNED = "Implementation Contract Unassigned";
    string constant FUNC_NOT_COMPLETE = "Function Not Complete";
    string constant FUNC_LOCKED = "Function Locked";
    string constant FUNC_NOT_BUILDING = "Function Not Building";
    string constant FUNC_NOT_BUILT = "Function Not Built";
    string constant FUNC_NOT_REGISTERED = "Function Not Registered";
    // Bundle
    string constant BUNDLE_NAME_UNASSIGNED = "Bundle Name Unassigned";
    string constant NO_FUNCTIONS_IN_BUNDLE = "No Functions in Bundle";
    string constant BUNDLE_FACADE_UNASSIGNED = "Bundle Facade Unassigned";
    string constant BUNDLE_NOT_INITIALIZED = "Bundle Not Initialized";
    string constant BUNDLE_NOT_COMPLETE = "Bundle Not Complete";
    string constant BUNDLE_CONTAINS_SAME_SELECTOR = "Bundle Contains Same Selector";
    string constant BUNDLE_LOCKED = "Bundle Locked";
    string constant BUNDLE_NOT_BUILDING = "Bundle Not Building";
    string constant BUNDLE_NOT_BUILT = "Bundle Not Built";
    string constant CURRENT_BUNDLE_NOT_EXIST = "Current Bundle Not Exist";
    // Proxy
    string constant PROXY_ADDR_UNASSIGNED = "Proxy Address Unassigned";
    string constant PROXY_KIND_UNDEFINED = "Proxy Kind Undefined";
    string constant PROXY_NOT_COMPLETE = "Proxy Not Complete";
    string constant PROXY_LOCKED = "Proxy Locked";
    string constant PROXY_NOT_BUILDING = "Proxy Not Building";
    string constant PROXY_NOT_BUILT = "Proxy Not Built";
    string constant PROXY_ALREADY_REGISTERED = "Proxy Already Registered";
    string constant PROXY_NOT_REGISTERED = "Proxy Not Registered";
    string constant CURRENT_PROXY_NOT_EXIST = "Current Proxy Not Exist";
    // Dictionary
    string constant DICTIONARY_NAME_UNASSIGNED = "Dictionary Name Unassigned";
    string constant DICTIONARY_ADDR_UNASSIGNED = "Dictionary Address Unassigned";
    string constant DICTIONARY_KIND_UNDEFINED = "Dictionary Kind Undefined";
    string constant DICTIONARY_NOT_COMPLETE = "Dictionary Not Complete";
    string constant DICTIONARY_NOT_VERIFIABLE = "Dictionary Not Verifiable";
    string constant DICTIONARY_LOCKED = "Dictionary Locked";
    string constant DICTIONARY_NOT_BUILDING = "Dictionary Not Building";
    string constant DICTIONARY_NOT_BUILT = "Dictionary Not Built";
    string constant DICTIONARY_ALREADY_REGISTERED = "Dictionary Already Registered";
    string constant DICTIONARY_NOT_REGISTERED = "Dictionary Not Registered";
    string constant CURRENT_DICTIONARY_NOT_EXIST = "Current Dictionary Not Exist";
    // Std Registry
    string constant STD_REGISTRY_NOT_COMPLETE = "Std Registry Not Complete";
    string constant STD_REGISTRY_LOCKED = "Std Registry Locked";
    string constant STD_REGISTRY_NOT_BUILDING = "Std Registry Not Building";
    string constant STD_REGISTRY_NOT_BUILT = "Std Registry Not Built";
    // Std Functions
    string constant STD_FUNCTIONS_NOT_COMPLETE = "Std Functions Not Complete";
    string constant STD_FUNCTIONS_LOCKED = "Std Functions Locked";
    string constant STD_FUNCTIONS_NOT_BUILDING = "Std Functions Not Building";
    string constant STD_FUNCTIONS_NOT_BUILT = "Std Functions Not Built";
    // Name Generator
    string constant NOT_FOUND_IN_RANGE = "Not Found In Range";

}
