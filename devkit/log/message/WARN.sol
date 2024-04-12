// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Utils
import {StdStyle} from "devkit/utils/ForgeHelper.sol";
    using StdStyle for string;

/// @title Error Message
library ERR {
    string constant HEADER = "\u2716 DevKit Error: ";
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

    function message(string memory errorBody) internal returns(string memory) {
        return StringUtils.append(HEADER, errorBody).bold();
    }
}