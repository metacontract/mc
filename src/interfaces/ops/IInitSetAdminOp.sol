// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

interface IInitSetAdminOp {
    event AdminSet(address admin);
    function initSetAdmin(address admin) external;
}
