// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// interfaces/IERC20Basic.sol
pragma solidity ^0.7.0;

/// @dev Interface of Swap.Pet ERC20Basic Tokens
interface IERC20Basic {  
    function decimals() external view returns (uint8);

    /// @dev the total amount of this ERC20 token.
    function totalSupply() external view returns (uint256);

    /// @dev the amount of tokens owned by owner_.
    function balanceOf(address owner_) external view returns (uint256);  

    /// @dev Moves amount_ tokens from the caller's account to to_.
    /// @returns a boolean value indicating whether the operation succeeded.
    function transfer(address to_, uint256 amount_) external returns (bool); 
}  