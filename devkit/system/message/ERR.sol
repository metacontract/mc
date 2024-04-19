// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title Error Message
library ERR {
    string constant FIND_NAME_OVER_RANGE = "Default names are automatically set up to 5. Please manually assign names beyond that.";
    string constant EMPTY_STR = "Empty String";
    string constant EMPTY_B4 = "Empty Bytes4";
    string constant NOT_CONTRACT = "Not Contract Address";
    string constant STR_ALREADY_ASSIGNED = "String Already Assigned";
    string constant B4_ALREADY_ASSIGNED = "Bytes4 Already Assigned";
    string constant ZERO_ADDRESS = "Zero Address";

    // Require
    string constant RQ_SELECTOR = "Selector is required.";
    string constant RQ_CONTRACT = "Contract is required.";
    string constant RQ_NOT_EMPTY_STRING = "String is empty.";
    string constant DICTIONARY_NOT_EXISTS = "Dictionary Not Exists";
    string constant EMPTY_DICTIONARY = "Empty Dictionary";
    string constant LOCKED_OBJECT = "Locaked Object";

    // string constant STR_EXISTS = "String Already Exist";
    string constant NOT_INIT = "Bundle has not initialized yet, please mc.init() first.";
    string constant EMPTY_CURRENT_BUNDLE = "Bundle has not initialized yet, please mc.init() first.";

}
