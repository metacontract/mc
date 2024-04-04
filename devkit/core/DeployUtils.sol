// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "devkit/utils/GlobalMethods.sol";
// // Config
import {Config} from "devkit/Config.sol";
// // Utils
// import {ForgeHelper} from "./utils/ForgeHelper.sol";
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
// import {BoolUtils} from "./utils/BoolUtils.sol";
//     using BoolUtils for bool;
// import {Bytes4Utils} from "./utils/Bytes4Utils.sol";
//     using Bytes4Utils for bytes4;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
// // Debug
// import {Debug} from "./debug/Debug.sol";
// import {Logger} from "./debug/Logger.sol";
// // Core
// //  dictionary
// import {DictRegistry} from "./core/dictionary/DictRegistry.sol";
import {Dictionary, DictionaryUtils} from "devkit/core/dictionary/Dictionary.sol";
// //  functions
// import {FuncRegistry} from "./core/functions/FuncRegistry.sol";
import {BundleInfo} from "devkit/core/functions/BundleInfo.sol";
import {FuncInfo} from "devkit/core/functions/FuncInfo.sol";
import {MCStdFuncsArgs} from "devkit/core/functions/MCStdFuncs.sol";
    using MCStdFuncsArgs for address;
// //  proxy
// import {ProxyRegistry} from "./core/proxy/ProxyRegistry.sol";
import {Proxy, ProxyUtils} from "devkit/core/proxy/Proxy.sol";
import {MCDevKit} from "../MCDevKit.sol";


using DeployUtils for MCDevKit;
library DeployUtils {
    string constant LIB_NAME = "MCDeploy";

/***********************************************
    🚀 Deployment
        🌱 Init Custom Bundle
        🔗 Use Function
            ✨ Add Custom Function
            🧺 Add Custom Function to Bundle
        🪟 Set Facade
        🌞 Deploy Meta Contract
        ♻️ Reset Current Context
************************************************/
    /**---------------------------
        🌱 Init Custom Bundle
    -----------------------------*/
    function init(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("init", PARAMS.append(name));
        mc.functions.safeInit(name);
        return mc.recordExecFinish(pid);
    }
    function init(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.init(mc.functions.genUniqueBundleName());
    }

    //
    function ensureInit(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("ensureInit");
        if (mc.functions.findCurrentBundle().hasNotName()) mc.init();
        return mc.recordExecFinish(pid);
    }


    /**---------------------
        🔗 Use Function
    -----------------------*/
    function use(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("use", PARAMS.append(name).comma().append(selector).comma().append(implementation));
        return mc   .ensureInit()
                    .addFunction(name, selector, implementation)
                    .addCurrentToBundle()
                    .recordExecFinish(pid);
    }
    function use(MCDevKit storage mc, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc.use(implementation.getLabel(), selector, implementation);
    }
    function use(MCDevKit storage mc, FuncInfo storage functionInfo) internal returns(MCDevKit storage) {
        return mc.use(functionInfo.name, functionInfo.selector, functionInfo.implementation);
    }
    // function use(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
    //     return mc;
    // } TODO
    function use(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        check(mc.functions.findFunction(name).isComplete(), "Invalid Function Name");
        return mc.use(mc.findFunction(name));
    }
        /**---------------------------
            ✨ Add Custom Function
        -----------------------------*/
        function addFunction(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
            uint pid = mc.recordExecStart("addFunction");
            mc.functions.safeAddFunction(name, selector, implementation);
            return mc.recordExecFinish(pid);
        }
        /**-------------------------------------
            🧺 Add Custom Function to Bundle
        ---------------------------------------*/
        function addToBundle(MCDevKit storage mc, FuncInfo storage functionInfo) internal returns(MCDevKit storage) {
            uint pid = mc.recordExecStart("addToBundle");
            mc.functions.addToBundle(functionInfo);
            return mc.recordExecFinish(pid);
        }
        function addCurrentToBundle(MCDevKit storage mc) internal returns(MCDevKit storage) {
            mc.functions.addToBundle(mc.findCurrentFunction());
            return mc;
        }


    /**------------------
        🪟 Set Facade
    --------------------*/
    function set(MCDevKit storage mc, string memory name, address facade) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("set");
        mc.functions.set(name, facade);
        return mc.recordExecFinish(pid);
    }
    function set(MCDevKit storage mc, address facade) internal returns(MCDevKit storage) {
        return mc.set(mc.functions.findCurrentBundleName(), facade);
    }


    /**-----------------------------
        🌞 Deploy Meta Contract
    -------------------------------*/
    function deploy(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo, address owner, bytes memory initData) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("deploy");
        // uint pid = mc.recordExecStart("deploy", PARAMS.append(name).comma().append(bundleInfo.name).comma().append(facade).comma().append(owner).comma().append(string(initData)));
        Dictionary memory dictionary = mc.deployDictionary(name, bundleInfo, owner);
        mc.deployProxy(name, dictionary, initData);
        return mc.recordExecFinish(pid);
        // TODO gen and set facade
    }

    function deploy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.deploy(mc.findCurrentBundleName(), mc.functions.findCurrentBundle(), Config.defaultOwner(), Config.defaultInitData());
    }
    // function deploy(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo, address facade, address owner) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, bundleInfo, facade, owner, Config.defaultInitData());
    // }
    // function deploy(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, bundleInfo, Config.defaultInitData(), );
    // }
    // function deploy(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
    //     return mc.deploy(Config.defaultName(), bundleInfo, Config.defaultInitData());
    // }
    // function deploy(MCDevKit storage mc, string memory name, bytes memory initData) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, mc.functions.findBundle(name), initData);
    // }
    // function deploy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, mc.functions.findBundle(name), Config.defaultInitData());
    // }
    function deploy(MCDevKit storage mc, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deploy(mc.findCurrentBundleName(), mc.functions.findCurrentBundle(), Config.defaultOwner(), initData);
    }



    /**-----------------------------
        ♻️ Reset Current Context
    -------------------------------*/
    function reset(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("reset");
        mc.dictionary.reset();
        mc.functions.reset();
        mc.proxy.reset();
        return mc.recordExecFinish(pid);
    }


// /************************************************
//     📚 Dictionary Global Utils
//         🐣 Deploy Dictionary
//         🔂 Duplicate Dictionary
//         🧩 Set Function
//         🖼 Upgrade Facade
//         🔧 Helper Methods for type Dictionary
// *************************************************/
//     /**---------------------
//         🧩 Set Function
//     -----------------------*/
//     function set(MCDevKit storage mc, Dictionary memory dictionary, FuncInfo memory functionInfo) internal returns(MCDevKit storage) {
//         uint pid = mc.recordExecStart("set", PARAMS.append(dictionary.addr).comma().append(functionInfo.name));
//         dictionary.set(functionInfo);
//         return mc.recordExecFinish(pid);
//     }
//     function set(MCDevKit storage mc, FuncInfo memory functionInfo) internal returns(MCDevKit storage) {
//         return mc.set(mc.findCurrentDictionary(), functionInfo);
//     }


//     /**------------------
//         🧺 Set Bundle
//     --------------------*/
//     function set(MCDevKit storage mc, Dictionary memory dictionary, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
//         uint pid = mc.recordExecStart("set", PARAMS.append(dictionary.addr).comma().append(bundleInfo.name));
//         dictionary.set(bundleInfo);
//         return mc.recordExecFinish(pid);
//     }
//     function set(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
//         return mc.set(mc.findCurrentDictionary(), bundleInfo);
//     }


//     /**----------------------
//         🖼 Upgrade Facade
//     ------------------------*/
//     function upgradeFacade(MCDevKit storage mc, Dictionary memory dictionary, address newFacade) internal returns(MCDevKit storage) {
//         uint pid = mc.recordExecStart("upgradeFacade", PARAMS.append(dictionary.addr).comma().append(newFacade));
//         dictionary.upgradeFacade(newFacade);
//         return mc.recordExecFinish(pid);

//     }
//     function upgradeFacade(MCDevKit storage mc, address newFacade) internal returns(MCDevKit storage) {
//         return mc.upgradeFacade(mc.findCurrentDictionary(), newFacade);
//     }
//     function upgradeFacade(MCDevKit storage mc) internal returns(MCDevKit storage) {
//         return mc.upgradeFacade(mc.findCurrentDictionary(), mc.functions.findCurrentBundle().facade);
//     }



/********************************************
    🏠 Proxy Global Utils
        🐣 Deploy Proxy
        🔧 Helper Methods for type Proxy
*********************************************/


/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    🏠 Deploy Proxy
    📚 Deploy Dictionary
    🔂 Duplicate Dictionary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**---------------------
        🏠 Deploy Proxy
    -----------------------*/
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary memory dictionary, bytes memory initData) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("deployProxy", PARAMS.append(dictionary.addr).comma().append(string(initData)));
        Proxy memory proxy = ProxyUtils.deploy(dictionary, initData);
        mc.proxy.safeAdd(name, proxy)
                .safeUpdate(proxy);
        return mc.recordExecFinish(pid);
    }
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary storage dictionary, address owner) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, dictionary, owner.initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary storage dictionary) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, dictionary, Config.defaultOwner().initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, mc.findCurrentDictionary(), Config.defaultOwner().initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, mc.findCurrentDictionary(), initData);
    }
    function deployProxy(MCDevKit storage mc, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deployProxy(mc.proxy.genUniqueName(), mc.findCurrentDictionary(), initData);
    }
    function deployProxy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.deployProxy(mc.proxy.genUniqueName(), mc.findCurrentDictionary(), Config.defaultOwner().initSetAdminBytes());
    }


    /**-------------------------
        📚 Deploy Dictionary
    ---------------------------*/
    function deployDictionary(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo, address owner) internal returns(Dictionary memory) {
        uint pid = mc.recordExecStart("deployDictionary", PARAMS.append(name).append(bundleInfo.name).comma().append(owner));
        Dictionary memory dictionary = DictionaryUtils  .deploy(owner)
                                                        .set(bundleInfo)
                                                        .upgradeFacade(bundleInfo.facade);
        mc.dictionary   .safeAdd(name, dictionary)
                        .safeUpdate(dictionary);
        return dictionary.recordExecFinish(pid);
    }

    function deployDictionary(MCDevKit storage mc) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.dictionary.genUniqueName(), mc.functions.findCurrentBundle(), Config.defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, string memory name) internal returns(Dictionary memory) {
        return mc.deployDictionary(name, mc.functions.findCurrentBundle(), Config.defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.dictionary.genUniqueName(), bundleInfo, Config.defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, address owner) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.dictionary.genUniqueName(), mc.functions.findCurrentBundle(), owner);
    }
    function deployDictionary(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo) internal returns(Dictionary memory) {
        return mc.deployDictionary(name, bundleInfo, Config.defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, string memory name, address owner) internal returns(Dictionary memory) {
        return mc.deployDictionary(name, mc.functions.findCurrentBundle(), owner);
    }
    function deployDictionary(MCDevKit storage mc, BundleInfo storage bundleInfo, address owner) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.dictionary.genUniqueName(), bundleInfo, owner);
    }


    // /**----------------------------
    //     🔂 Duplicate Dictionary
    // ------------------------------*/
    // function duplicateDictionary(MCDevKit storage mc, string memory name, Dictionary storage targetDictionary) internal returns(MCDevKit storage) {
    //     uint pid = mc.recordExecStart("duplicateDictionary", PARAMS.append(name).comma().append(targetDictionary.addr));
    //     Dictionary memory newDictionary = targetDictionary.duplicate();
    //     mc.dictionary   .safeAdd(name, newDictionary)
    //                     .safeUpdate(newDictionary);
    //     return mc.recordExecFinish(pid);
    // }
    // function duplicateDictionary(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
    //     return mc.duplicateDictionary(name, mc.findCurrentDictionary());
    // }
    // function duplicateDictionary(MCDevKit storage mc, Dictionary storage targetDictionary) internal returns(MCDevKit storage) {
    //     return mc.duplicateDictionary(Config.defaultDuplicatedDictionaryName(), targetDictionary);
    // }
    // function duplicateDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
    //     return mc.duplicateDictionary(Config.defaultDuplicatedDictionaryName(), mc.findCurrentDictionary());
    // }

}
