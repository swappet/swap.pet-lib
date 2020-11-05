// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// contracts/Log.sol
pragma solidity ^0.7.0; 

/// @notice log an 'anonymous' event
/// @dev    log with four indexed topics: selector, caller, arg1 and arg2
abstract contract Log {
    event NoteLog(
        bytes4   indexed  sig,              //  selector:msg.sig
        address  indexed  caller,           //  caller:msg.sender
        bytes32  indexed  arg1,
        bytes32  indexed  arg2,
        uint              value,            //  msg.value
        bytes             data              //  msg.data
    ) anonymous;

    modifier log {
        _;
        bytes32 arg1;
        bytes32 arg2;
        assembly {
            arg1 := calldataload(4)
            arg2 := calldataload(36)
        }
        NoteLog(msg.sig, msg.sender, arg1, arg2, msg.value, msg.data);
    }
}