// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {System} from "devkit/system/System.sol";

// 💬 ABOUT
// Meta Contract's default Script based on Forge Std Script

// 📦 BOILERPLATE
import {MCScriptBase} from "./MCBase.sol";

// ⭐️ MC SCRIPT
abstract contract MCScript is MCScriptBase {
    constructor() {
        mc.loadConfig();
        if (System.Config().SETUP.STD_FUNCS) mc.setupStdFunctions();
    }
}

// ⭐️ MC SCRIPT without Setup
abstract contract MCScriptWithoutSetup is MCScriptBase {
    constructor() {
        mc.loadConfig();
    }
}
