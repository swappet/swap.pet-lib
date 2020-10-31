// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// interfaces/IERC20.sol
pragma solidity ^0.7.0;

import './IERC20Basic.sol'; 

/// @dev Swap.Pet ERC20 Tokens
interface IERC20 is IERC20Basic{ 

    /// @dev ERC20 namer
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);   

    /// @dev the remaining number of tokens that spender_ be allowed by 
    ///         owner_ to spend through {transferFrom()}. default is zero.
    ///         {approve()} or {transferFrom()} can change the value. 
    function allowance(address owner_, address spender_) external view returns (uint256);

    /// @dev Sets amount_ as the allowance of spender_ over the caller's tokens.
    /// @returns boolean value indicating whether the operation succeeded.
    /// @dev Emits an {Approval()} event. 
    function approve(address spender_, uint256 amount_) external returns (bool); 
    function increaseAllowance(address spender_, uint256 amount_) external returns (bool);
    function decreaseAllowance(address spender_, uint256 amount_) external returns (bool); 
    /// @dev Moves amount_ tokens from from_ account to to_ using allowance.
    ///         amount_ is then deducted from the caller's allowance.    
    /// @returns a boolean value indicating whether the operation succeeded.
    /// @dev Emits an {Transfer()} event. 
    function transferFrom(address from_, address to_, uint256 amount_) external returns (bool); 
}  