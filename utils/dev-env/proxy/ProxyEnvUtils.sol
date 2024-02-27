// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {UCSProxyEnv, Proxy, Dictionary} from "dev-env/UCSDevEnv.sol";
import {ProxyUtils} from "dev-env/proxy/ProxyUtils.sol";
import {ForgeHelper} from "dev-env/common/ForgeHelper.sol";

/**********************************************
    🏠 Proxy Environment Utils
        🐣 Deploy Proxy
        🔧 Helper Methods for type Proxy
***********************************************/
library ProxyEnvUtils {

    function deployAndSetProxy(UCSProxyEnv storage proxyEnv, string memory name, Dictionary dictionary, bytes memory initData) internal returns(UCSProxyEnv storage) {
        Proxy proxy = ProxyUtils.deployProxy(name, dictionary, initData);
        proxyEnv.setProxy(name, proxy);
        return proxyEnv;
    }

    function setProxy(UCSProxyEnv storage proxyEnv, string memory name, Proxy proxy) internal returns(UCSProxyEnv storage) {
        if (!proxy.exists()) DevUtils.revertWithDevEnvError("SetProxy_EmptyProxy");
        proxyEnv.deployed[DevUtils.getHash(name)] = proxy.assignLabel(name);
        return proxyEnv;
    }

    function getProxy(UCSProxyEnv storage proxyEnv, string memory name) internal returns(Proxy) {
        Proxy proxy = proxyEnv.deployed[DevUtils.getHash(name)];
        if (!proxy.exists()) DevUtils.revertWithDevEnvError("GetProxy_NotFound");
        return proxy;
    }

    function exists(UCSProxyEnv storage proxyEnv, string memory name) internal returns(bool) {
        return proxyEnv.deployed[DevUtils.getHash(name)].exists();
    }

    function findUnusedProxyName(UCSProxyEnv storage proxyEnv) internal returns(string memory name) {
        (uint start, uint end) = DevUtils.getScanRange();
        string memory baseName = "Proxy";

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!proxyEnv.exists(name)) return name;
        }

        DevUtils.revertUnusedNameNotFound();
    }

}
