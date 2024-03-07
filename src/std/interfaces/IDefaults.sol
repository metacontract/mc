// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IGetDeps} from "./functions/IGetDeps.sol";
import {IInitSetAdmin} from "./functions/IInitSetAdmin.sol";
import {ERC7546ProxyEvents} from "@ucs-contracts/src/proxy/ERC7546ProxyEvents.sol";

interface IDefaults is
    IGetDeps,
    IInitSetAdmin,
    ERC7546ProxyEvents
{}
