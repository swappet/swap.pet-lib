// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// contracts/mocks/SafeMathMock.sol 
pragma solidity ^0.7.0; 

import '../SafeMath.sol';

/// @dev contract using SafeMath library 
contract SafeMathMock {
    using SafeMath for uint256;
    using SafeMath for uint;
    function max(uint a_, uint b_) public pure returns (uint) {
        return SafeMath.max(a_,b_);
    } 
    function min(uint a_, uint b_) public pure returns (uint) {
        return SafeMath.min(a_,b_);
    } 
    function twins(uint a_, uint b_) public pure returns (uint[2] memory) {
        return SafeMath.twins(a_,b_);
    }
    function avg(uint a_, uint b_) public pure returns (uint) {
        return SafeMath.avg(a_,b_);
    }
    function add(uint a_, uint b_) public pure returns (uint) { 
        return SafeMath.add(a_,b_);
    }
    function sub(uint a_, uint b_) public pure returns (uint) {
        return SafeMath.sub(a_,b_);
    }
    function mul(uint a_, uint b_) public pure returns (uint) {
        return SafeMath.mul(a_,b_);
    }
    function div(uint a_, uint b_) public pure returns (uint) {
        return SafeMath.div(a_,b_);
    }  
    function mod(uint a_, uint b_) public pure returns (uint) {
        return SafeMath.mod(a_,b_);
    } 
    function sqrt(uint a_) public pure returns (uint) {
        return SafeMath.sqrt(a_);
    }
}  