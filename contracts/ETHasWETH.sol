// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// contracts/lib/ETHasWETH.sol
pragma solidity ^0.7.0; 

import "./interfaces/IWETH9.sol";
import "./interfaces/IETHasWETH.sol";

// See interface for documentation.
contract ETHasWETH is IETHasWETH {
    /// @dev the WETH contract that this ETHasWETH contract uses. 
    IWETH9 payable public override immutable WETH;

    constructor(address payable weth_) public {
        WETH = weth_;
    }

    // See interface for documentation.
    function depositETHasWETHtoCall(uint amount_, address to_, bytes calldata data_) external override payable returns (uint total_){ 
        if ( msg.value > 0 ) { depositETH(); } // msg.value ETH to WETH
        if ( amount_ > 0) { // get WETH
            WETH.transferFrom(msg.sender, address(this), amount_);
        }
        uint total_ = msg.value + amount_; // total_ of WETH
        require(total_ >= msg.value, 'ETHasWETH:OVERFLOW'); // check overflow.
        require(total_ > 0, 'ETHasWETH:ZERO_INPUTS');
        WETH.approve(to_, total_);
        (bool success,) = to_.call(data_);
        require(success, 'ETHasWETH:TO_CALL_FAILED'); 
        // withdrawETH(msg.sender);// unwrap and refund any unspent WETH.
    }

    // See interface for documentation.
    function withdrawETH(uint amount_, address payable to_) internal override { 
        require(amount_ < WETH.balanceOf(address(this)), "ETHasWETH: insufficient WETH");
        WETH.withdraw(amount_); // WETH to ETH
        (bool success,) = to_.call{value: amount_}(''); // send ETH
        // (bool success,) = to_.call{value:amount_}(new bytes(0));
        require(success, 'ETHasWETH:WITHDRAW_ETH_FAILED');
    } 
    
    /// @dev deposit ETH through send(msg.value) to WETH of this contract.
    function depositETH() internal override {  
        WETH.deposit{value: msg.value}(); 
    }

    receive() payable external { 
        /// deposit ETH to WETH directly
        depositETH(); 
        
        /// Only the WETH contract may send ETH via a call to withdraw.
        // require(msg.sender == WETH, 'ETHasWETH:WETH_ONLY'); 
    }
}
