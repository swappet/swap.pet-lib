// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// contracts/interfaces/IWETH9.sol
pragma solidity ^0.7.0; 
 
import './interfaces/IERC20.sol';

interface IWETH9 is IERC20{
    event Deposit(address indexed from_, uint256 amount_);
    event Withdraw(address indexed to_, uint256 amount_);

    /// @dev deposit {msg.value} ETH to WETH.
    function deposit() external payable;

    /// @dev withdraw amount_ WETH as ETH to the caller({msg.sender}) .
    function withdraw(uint256 amount_) external;
    
    /// @dev all received ETH will call deposit() as default.
    receive() external payable;

    /// @dev deal all call which do not been dealed.
    fallback() external payable;
} 