// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// // import {DictionaryUpgradeableEtherscan} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscan.sol";
// // import {DictionaryUpgradeableEtherscanProxy} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscanProxy.sol";
// // import {DictionaryBase} from "@ucs-contracts/src/dictionary/DictionaryBase.sol";
// // import {IDictionary} from "@ucs-contracts/src/dictionary/IDictionary.sol";
// import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";
// import {ERC7546Proxy} from "@ucs-contracts/src/proxy/ERC7546Proxy.sol";
// import {ERC7546ProxyEtherscan} from "@ucs-contracts/src/proxy/ERC7546ProxyEtherscan.sol";

// // // Ops
// import {InitSetAdminOp} from "../../../src/ops/InitSetAdminOp.sol";

// import {StdOpsUtils} from "dev-env/ops/StdOpsUtils.sol";

import {ForgeHelper, console2} from "dev-env/common/ForgeHelper.sol";
import {DevUtils} from "dev-env/common/DevUtils.sol";
// import {DevUtils} from "dev-env/common/DevUtils.sol";
// import {Proxy, Dictionary} from "dev-env/UCSDevEnv.sol";
// import {DictionaryUtils} from "dev-env/dictionary/DictionaryUtils.sol";

import {SimpleMockProxy, SimpleMockProxyUtils} from "dev-env/test/mocks/SimpleMockProxy.sol";
import {MockProxy, Op} from "dev-env/UCSDevEnv.sol";

/**********************************************
    🤖🏠 Mock Proxy Primitive Utils
        🐣 Create Mock Proxy
        🔧 Helper Methods for type MockProxy
***********************************************/
library MockProxyUtils {
    using {DevUtils.exists} for address;
    using {asMockProxy} for address;


    /**-------------------------
        🐣 Create Mock Proxy
    ---------------------------*/
    function createSimpleMockProxy(Op[] memory ops) internal returns(MockProxy) {
        return address(new SimpleMockProxy(ops)).asMockProxy();
    }


    /**----------------------------------------
        🔧 Helper Methods for type MockProxy
    ------------------------------------------*/
    function toAddress(MockProxy proxy) internal pure returns(address) {
        return MockProxy.unwrap(proxy);
    }

    function asMockProxy(address addr) internal pure returns(MockProxy) {
        return MockProxy.wrap(addr);
    }

    function exists(MockProxy mockProxy) internal returns(bool) {
        return mockProxy.toAddress().exists();
    }

    function assignLabel(MockProxy mockProxy, string memory name) internal returns(MockProxy) {
        ForgeHelper.assignLabel(mockProxy.toAddress(), name);
        return mockProxy;
    }

}
