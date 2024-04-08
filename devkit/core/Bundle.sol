// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Type
import {Function} from "devkit/core/Function.sol";
// Methods
import {BundleLib} from "devkit/method/core/BundleLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
import {Parser} from "devkit/method/debug/Parser.sol";


/**================
    🧺 Bundle
==================*/
struct Bundle {
    string name;
    Function[] functionInfos;
    address facade;
}
using BundleLib for Bundle global;
using ProcessLib for Bundle global;
using Parser for Bundle global;
