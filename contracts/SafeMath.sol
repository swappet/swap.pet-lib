// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// contracts/SafeMath.sol
pragma solidity ^0.7.0;

/// @dev Wrappers over arithmetic operations with overflow checks for uint256. 
library SafeMath {  
    uint256 private constant __scale = 1e18;
    function max(uint a_, uint b_) internal pure returns (uint) {
        return a_ >= b_ ? a_ : b_;
    } 
    function min(uint a_, uint b_) internal pure returns (uint) {
        return a_ < b_ ? a_ : b_;
    }
    /// @dev Returns the sort of two numbers with(small,big). 
    function twins(uint a_, uint b_) internal pure returns (uint[2] memory) {
        return a_ < b_ ? [a_,b_] : [b_,a_];
    }
    // average
    function avg(uint a_, uint b_) internal pure returns (uint) {
        return (a_ / 2) + (b_ / 2) + ((a_ % 2 + b_ % 2) / 2);
    }
    function add(uint a_, uint b_) internal pure returns (uint c_) {
        require((c_ = a_ + b_) >= a_, 'SafeMath: add overflow');
    }
    function sub(uint a_, uint b_) internal pure returns (uint) {
        return sub(a_, b_, "SafeMath: sub overflow");
    }
    function sub(uint a_, uint b_, string memory errMsg_) internal pure returns (uint c_) {
        require((c_ = a_ - b_) <= a_, errMsg_);
    } 
    function mul(uint a_, uint b_) internal pure returns (uint c_) {
        require(a_ == 0 || b_ == 0 || (c_ = a_ * b_) / b_ == a_, 'SafeMath: mul overflow');
    }
    function mulScale(uint a_, uint b_, uint256 _scale) internal pure returns (uint c_) {
        require(_scale > 0, 'SafeMath: mul overflow');
        return a_.mul(b_).div(_scale);
    }
    function mulScale(uint a_, uint b_) internal pure returns (uint) { 
        return mulScale(a, b, __scale);
    }
    
    function div(uint a_, uint b_) internal pure returns (uint) {
        return div(a_, b_, "SafeMath: div by zero");
    } 
    function div(uint a_, uint b_, string memory errMsg_) internal pure returns (uint c_) {
        require( a_ == 0 || (b_ > 0 && ( c_ = a_ / b_ ) >= 0), errMsg_);
    }
    function divScale(uint a_, uint b_, uint256 _scale) internal pure returns (uint c_) {
        require(_scale > 0, 'SafeMath: div overflow');
        return a_.mul(_scale).div(b_);
    }
    function divScale(uint a_, uint b_) internal pure returns (uint) { 
        return divScale(a, b, __scale);
    }
    function mod(uint a_, uint b_) internal pure returns (uint) {
        return mod(a_, b_, "SafeMath: mod by zero");
    }
    function mod(uint a_, uint b_, string memory errMsg_) internal pure returns (uint) {
        require(b_ != 0, errMsg_);
        return a_ % b_;
    } 
    function sqrt(uint a_) internal pure returns (uint b_) {
        if (a_ > 3) {
            b_ = a_;
            uint t = a_ / 2 + 1;
            while (t < b_) {
                b_ = t;
                t = (a_ / t + t) / 2;
            }
        } else if (a_ != 0) {
            b_ = 1;
        }
    }
}
