// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// contracts/Locker.sol
pragma solidity ^0.7.0; 

/**
 * @dev helper for prevent re-enter calls.
 *      Inheriting from `Locker` to use {lock} modifier 
 *      this is a single `lock` guard which can not call one another. 
 *      Using on `external`functions which points to `private` functions. 
 */
contract Locker { 
    uint8 private _lock;
    constructor () internal {
        _lock = 0;
    } 
    modifier lock() { 
        require(_lock != 1, "Locker: locked for prevent Re-enter call"); 
        _lock = 1; // enter
        _; 
        _lock = 0; // leave
    }
}
