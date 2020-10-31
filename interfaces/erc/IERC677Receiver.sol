// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// contracts/interfaces/IERC677Receiver.sol
pragma solidity ^0.7.0;

interface IERC677Receiver {
    function onTokenTransfer(address sender_, uint256 amount_, bytes calldata data_) external;
}