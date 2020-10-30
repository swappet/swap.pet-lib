// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// contracts/lib/SignedSafeMath.sol
pragma solidity ^0.7.0; 

/// @dev Wrappers over arithmetic operations with overflow checks for int256. 
library SignedSafeMath {
    int constant private _INT256_MIN = -2**255;
    function max(int a_, int b_) internal pure returns (int) {
        return a_ >= b_ ? a_ : b_;
    } 
    function min(int a_, int b_) internal pure returns (int) {
        return a_ < b_ ? a_ : b_;
    }
    /// @dev Returns the sort of two numbers with(small,big). 
    function twins(int a_, int b_) internal pure returns (int[2] memory) {
        return a_ < b_ ? [a_,b_] : [b_,a_];
    }
    // average
    function avg(int a_, int b_) internal pure returns (int) {
        return (a_ / 2) + (b_ / 2) + ((a_ % 2 + b_ % 2) / 2);
    }
    function mul(int a_, int b_) internal pure returns (int) { 
        if (a_ == 0 || b_ == 0) {
            return 0;
        }
        require(!(a_ == -1 && b_ == _INT256_MIN), "SignedSafeMath: mul overflow");
        int c_ = a_ * b_;
        require(c_ / a_ == b_, "SignedSafeMath: mul overflow");
        return c_;
    }
    function div(int a_, int b_) internal pure returns (int) {
        require(b_ != 0, "SignedSafeMath: div by zero");
        require(!(b_ == -1 && a_ == _INT256_MIN), "SignedSafeMath: div overflow");
        int c_ = a_ / b_;
        return c_;
    } 
    function sub(int a_, int b_) internal pure returns (int) {
        int c_ = a_ - b_;
        require((b_ >= 0 && c_ <= a_) || (b_ < 0 && c_ > a_), "SignedSafeMath: sub overflow");
        return c_;
    } 
    function add(int a_, int b_) internal pure returns (int) {
        int c_ = a_ + b_;
        require((b_ >= 0 && c_ >= a_) || (b_ < 0 && c_ < a_), "SignedSafeMath: add overflow");
        return c_;
    }
}