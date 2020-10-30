// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// contracts/mocks/SignedSafeMathMock.sol 
pragma solidity ^0.7.0; 

import '../SignedSafeMath.sol';

/// @dev contract using SignedSafeMath library 
contract SignedSafeMathMock { 
    function max(int256 a_, int256 b_) public pure returns (int256) {
        return SignedSafeMath.max(a_,b_);
    } 
    function min(int256 a_, int256 b_) public pure returns (int256) {
        return SignedSafeMath.min(a_,b_);
    } 
    function twins(int256 a_, int256 b_) public pure returns (int256[2] memory) {
        return SignedSafeMath.twins(a_,b_);
    }
    function avg(int256 a_, int256 b_) public pure returns (int256) {
        return SignedSafeMath.avg(a_,b_);
    }
    function add(int256 a_, int256 b_) public pure returns (int256) { 
        return SignedSafeMath.add(a_,b_);
    }
    function sub(int256 a_, int256 b_) public pure returns (int256) {
        return SignedSafeMath.sub(a_,b_);
    }
    function mul(int256 a_, int256 b_) public pure returns (int256) {
        return SignedSafeMath.mul(a_,b_);
    }
    function div(int256 a_, int256 b_) public pure returns (int256) {
        return SignedSafeMath.div(a_,b_);
    }   
}  