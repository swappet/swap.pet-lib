// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// contracts/lib/ERC677.sol
pragma solidity ^0.7.0;

import './interfaces/IERC677Receiver.sol';  
import "./ERC20.sol";

/// @dev Swap.Pet ERC677 token
abstract contract ERC677 is ERC20{ 
    /// @notice transfer amount_ from caller to to_ with call {ERC677-onTokenTransfer}.
    /// @returns bool whether operation succeeded.
    /// @dev see https://github.com/ethereum/EIPs/issues/677.
    function transferAndCall(address to_, uint256 amount_, bytes calldata data_) external noShart(3 * 32) returns (bool) {
        _transfer(msg.sender, to_,  amount_);
        IERC677Receiver(to_).onTokenTransfer(msg.sender, amount_, data_);
        return true;
    }  
}
