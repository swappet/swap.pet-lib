// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// contracts/lib/SafeTransfer.sol
pragma solidity ^0.7.0;  

import "../interfaces/IERC20.sol";
import "./SafeMath.sol";
import "./Address.sol";

/**
 * @title SafeTransfer
 * @dev safe helper for checking the return of ERC20/ETH transfer be true.
 *      `using SafeTransfer for IERC20;` and call `token.safeTransfer(...)`, etc.
 *      Or use as SafeTransfer.safeTransfer(token,...)
 */
library SafeTransfer {
    using SafeMath for uint256;
    using Address for address; 
    
    /// @dev use {safeIncreaseAllowance/safeDecreaseAllowance} instead. 
    function safeApprove(IERC20 token_, address spender_, uint256 amount_) internal { 
        // solhint-disable-next-line max-line-length
        require((amount_ == 0) || (token_.allowance(address(this), spender_) == 0),
            "SafeTransfer: approve from non-zero to non-zero allowance"
        );
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token_.call(abi.encodeWithSelector(0x095ea7b3, spender_, amount_));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'SafeTransfer: APPROVE_FAILED');
        // _callCheckReturn(token_, abi.encodeWithSelector(token_.approve.selector, spender_, amount_),'SafeTransfer: APPROVE_FAILED');
    }
    function safeIncreaseAllowance(IERC20 token_, address spender_, uint256 amount_) internal {
        uint256 newAllowance = token_.allowance(address(this), spender_).add(amount_);
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token_.call(abi.encodeWithSelector(0x095ea7b3, spender_, newAllowance));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'SafeTransfer: APPROVE_FAILED');
        // _callCheckReturn(token_, abi.encodeWithSelector(token_.approve.selector, spender_, newAllowance)); 
    }
    function safeDecreaseAllowance(IERC20 token_, address spender_, uint256 amount_) internal {
        uint256 newAllowance = token_.allowance(address(this), spender_).sub(amount_, "SafeTransfer: decreased allowance below zero");
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token_.call(abi.encodeWithSelector(0x095ea7b3, spender_, newAllowance));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'SafeTransfer: APPROVE_FAILED');
        // _callCheckReturn(token_, abi.encodeWithSelector(token_.approve.selector, spender_, newAllowance));
    } 
    function safeTransfer(IERC20 token_, address to_, uint256 amount_) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token_.call(abi.encodeWithSelector(0xa9059cbb, to_, amount_));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'SafeTransfer: TRANSFER_FAILED');
        // _callCheckReturn(token_, abi.encodeWithSelector(token_.transfer.selector, to_, amount_),'SafeTransfer: TRANSFER_FAILED');
    }

    function safeTransferFrom(IERC20 token_, address from_, address to_, uint256 amount_) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token_.call(abi.encodeWithSelector(0x23b872dd, from_, to_, amount_));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'SafeTransfer: TRANSFER_FROM_FAILED');
        // _callCheckReturn(token_, abi.encodeWithSelector(token_.transferFrom.selector, from_, to_, amount_),'SafeTransfer: TRANSFER_FROM_FAILED');
    } 

    /**
     * @dev the return value is optional but not be false.
     * @param token The token targeted by the call.
     * @param data The call data encoded by abi.encode or one of its variants.
     */
    function _callCheckReturn(IERC20 token_, bytes memory data_, string memory errMsg_) private { 
        bytes memory data = address(token_).safeCall(data_,errMsg_);
        if (data.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(data, (bool)), "SafeTransfer: operation failed");
        }
    }
    /**
     * @dev safe `transfer`: sends `amount` ETH(wei) to `to_`.
     *      forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {safeTransferETH} removes this limitation. 
     * 
     * Note: control transferred to `to_`, using {Locker.lock()} for safe
     */
    function safeTransferETH(address payable to_, uint256 amount_) internal {
        require(address(this).balance >= amount_, "Address: insufficient balance");
        // (bool success, )= address(to_).safeCallAtValue("",amount_); 
        (bool success,) = to_.call{value:amount_}(new bytes(0));
        require(success, "SafeTransfer: ETH_TRANSFER_FAILED, may have reverted");
    } 
}
