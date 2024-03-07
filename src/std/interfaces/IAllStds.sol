// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IInitSetAdmin} from "./functions/IInitSetAdmin.sol";
import {IGetDeps} from "./functions/IGetDeps.sol";
import {IClone} from "./functions/IClone.sol";
import {ISetImplementation} from "./functions/ISetImplementation.sol";
import {ERC7546ProxyEvents} from "@ucs-contracts/src/proxy/ERC7546ProxyEvents.sol";

interface IAllStds is
    IInitSetAdmin,
    IGetDeps,
    IClone,
    ISetImplementation,
    ERC7546ProxyEvents
{}
