// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Config} from "devkit/config/Config.sol";

// 💬 ABOUT
// Meta Contract's default Script based on Forge Std Script

// 📦 BOILERPLATE
import {MCScriptBase} from "./MCBase.sol";

// ⭐️ MC SCRIPT
abstract contract MCScript is MCScriptBase {
    constructor() {
        Config().load();
        if (Config().DEBUG_MODE) mc.startDebug();
        if (Config().SETUP_STD_FUNCS) mc.setupStdFuncs();
    }
}
