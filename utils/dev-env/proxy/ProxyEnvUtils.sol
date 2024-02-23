// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {UCSProxyEnv, Proxy} from "dev-env/UCSDevEnv.sol";

library ProxyEnvUtils {

    error SetProxy_EmptyProxy();
    function setProxy(UCSProxyEnv storage env, string memory name, Proxy proxy) internal returns(UCSProxyEnv storage) {
        if (!proxy.exists()) revert SetProxy_EmptyProxy();
        bytes32 _nameHash = DevUtils.getHash(name);
        env.deployed[_nameHash] = proxy;
        return env;
    }

    error GetProxy_NotFound();
    function getProxy(UCSProxyEnv storage env, string memory name) internal returns(Proxy) {
        bytes32 _nameHash = DevUtils.getHash(name);
        Proxy proxy = env.deployed[_nameHash];
        if (!proxy.exists()) revert GetProxy_NotFound();
        return proxy;
    }

}
