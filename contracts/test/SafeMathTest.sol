// contracts/test/SafeMathTest.sol
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0; 

import '../SafeMath.sol';

/// @dev contract using SafeMath library
contract SafeMathTest {
    using SafeMath for uint256;
    using SafeMath for uint;
    function max(uint a_, uint b_) public pure returns (uint) {
        return a_.max(b_);
    } 
    function min(uint a_, uint b_) public pure returns (uint) {
        return a_.min(b_);
    } 
    function twins(uint a_, uint b_) public pure returns (uint[2] memory) {
        return a_.twins(b_);
    }
    function avg(uint a_, uint b_) public pure returns (uint) {
        return a_.avg(b_);
    }
    function add(uint a_, uint b_) public pure returns (uint) { 
        return a_.add(b_);
    }
    function sub(uint a_, uint b_) public pure returns (uint) {
        return a_.sub(b_);
    }
    function mul(uint a_, uint b_) public pure returns (uint) {
        return a_.mul(b_);
    }
    function div(uint a_, uint b_) public pure returns (uint) {
        return a_.div(b_);
    }  
    function mod(uint a_, uint b_) public pure returns (uint) {
        return a_.mod(b_);
    } 
    function sqrt(uint a_) public pure returns (uint) {
        return a_.sqrt();
    }
}
contract SafeMathTest256 {
    using SafeMath for uint256;
    function max(uint256 a_, uint256 b_) public pure returns (uint256) {
        return a_.max(b_);
    } 
    function min(uint256 a_, uint256 b_) public pure returns (uint256) {
        return a_.min(b_);
    } 
    function twins(uint256 a_, uint256 b_) public pure returns (uint256[2] memory) {
        return a_.twins(b_);
    }
    function avg(uint256 a_, uint256 b_) public pure returns (uint256) {
        return a_.avg(b_);
    }
    function add(uint256 a_, uint256 b_) public pure returns (uint256) { 
        return a_.add(b_);
    }
    function sub(uint256 a_, uint256 b_) public pure returns (uint256) {
        return a_.sub(b_);
    }
    function mul(uint256 a_, uint256 b_) public pure returns (uint256) {
        return a_.mul(b_);
    }
    function div(uint256 a_, uint256 b_) public pure returns (uint256) {
        return a_.div(b_);
    }  
    function mod(uint256 a_, uint256 b_) public pure returns (uint256) {
        return a_.mod(b_);
    } 
    function sqrt(uint256 a_) public pure returns (uint256) {
        return a_.sqrt();
    }
}
contract SafeMathTest128 {
    using SafeMath for uint128;
    function max(uint128 a_, uint128 b_) public pure returns (uint128) {
        return a_.max(b_);
    } 
    function min(uint128 a_, uint128 b_) public pure returns (uint128) {
        return a_.min(b_);
    } 
    function twins(uint128 a_, uint128 b_) public pure returns (uint128[2] memory) {
        return a_.twins(b_);
    }
    function avg(uint128 a_, uint128 b_) public pure returns (uint128) {
        return a_.avg(b_);
    }
    function add(uint128 a_, uint128 b_) public pure returns (uint128) { 
        return a_.add(b_);
    }
    function sub(uint128 a_, uint128 b_) public pure returns (uint128) {
        return a_.sub(b_);
    }
    function mul(uint128 a_, uint128 b_) public pure returns (uint128) {
        return a_.mul(b_);
    }
    function div(uint128 a_, uint128 b_) public pure returns (uint128) {
        return a_.div(b_);
    }  
    function mod(uint128 a_, uint128 b_) public pure returns (uint128) {
        return a_.mod(b_);
    } 
    function sqrt(uint128 a_) public pure returns (uint128) {
        return a_.sqrt();
    }
}
contract SafeMathTest64 {
    using SafeMath for uint64;
    function max(uint64 a_, uint64 b_) public pure returns (uint64) {
        return a_.max(b_);
    } 
    function min(uint64 a_, uint64 b_) public pure returns (uint64) {
        return a_.min(b_);
    } 
    function twins(uint64 a_, uint64 b_) public pure returns (uint64[2] memory) {
        return a_.twins(b_);
    }
    function avg(uint64 a_, uint64 b_) public pure returns (uint64) {
        return a_.avg(b_);
    }
    function add(uint64 a_, uint64 b_) public pure returns (uint64) { 
        return a_.add(b_);
    }
    function sub(uint64 a_, uint64 b_) public pure returns (uint64) {
        return a_.sub(b_);
    }
    function mul(uint64 a_, uint64 b_) public pure returns (uint64) {
        return a_.mul(b_);
    }
    function div(uint64 a_, uint64 b_) public pure returns (uint64) {
        return a_.div(b_);
    }  
    function mod(uint64 a_, uint64 b_) public pure returns (uint64) {
        return a_.mod(b_);
    } 
    function sqrt(uint64 a_) public pure returns (uint64) {
        return a_.sqrt();
    }
}
contract SafeMathTest32 {
    using SafeMath for uint32;
    function max(uint32 a_, uint32 b_) public pure returns (uint32) {
        return a_.max(b_);
    } 
    function min(uint32 a_, uint32 b_) public pure returns (uint32) {
        return a_.min(b_);
    } 
    function twins(uint32 a_, uint32 b_) public pure returns (uint32[2] memory) {
        return a_.twins(b_);
    }
    function avg(uint32 a_, uint32 b_) public pure returns (uint32) {
        return a_.avg(b_);
    }
    function add(uint32 a_, uint32 b_) public pure returns (uint32) { 
        return a_.add(b_);
    }
    function sub(uint32 a_, uint32 b_) public pure returns (uint32) {
        return a_.sub(b_);
    }
    function mul(uint32 a_, uint32 b_) public pure returns (uint32) {
        return a_.mul(b_);
    }
    function div(uint32 a_, uint32 b_) public pure returns (uint32) {
        return a_.div(b_);
    }  
    function mod(uint32 a_, uint32 b_) public pure returns (uint32) {
        return a_.mod(b_);
    } 
    function sqrt(uint32 a_) public pure returns (uint32) {
        return a_.sqrt();
    }
}
contract SafeMathTest16 {
    using SafeMath for uint16;
    function max(uint16 a_, uint16 b_) public pure returns (uint16) {
        return a_.max(b_);
    } 
    function min(uint16 a_, uint16 b_) public pure returns (uint16) {
        return a_.min(b_);
    } 
    function twins(uint16 a_, uint16 b_) public pure returns (uint16[2] memory) {
        return a_.twins(b_);
    }
    function avg(uint16 a_, uint16 b_) public pure returns (uint16) {
        return a_.avg(b_);
    }
    function add(uint16 a_, uint16 b_) public pure returns (uint16) { 
        return a_.add(b_);
    }
    function sub(uint16 a_, uint16 b_) public pure returns (uint16) {
        return a_.sub(b_);
    }
    function mul(uint16 a_, uint16 b_) public pure returns (uint16) {
        return a_.mul(b_);
    }
    function div(uint16 a_, uint16 b_) public pure returns (uint16) {
        return a_.div(b_);
    }  
    function mod(uint16 a_, uint16 b_) public pure returns (uint16) {
        return a_.mod(b_);
    } 
    function sqrt(uint16 a_) public pure returns (uint16) {
        return a_.sqrt();
    }
}
contract SafeMathTest8 {
    using SafeMath for uint8;
    function max(uint8 a_, uint8 b_) public pure returns (uint8) {
        return a_.max(b_);
    } 
    function min(uint8 a_, uint8 b_) public pure returns (uint8) {
        return a_.min(b_);
    } 
    function twins(uint8 a_, uint8 b_) public pure returns (uint8[2] memory) {
        return a_.twins(b_);
    }
    function avg(uint8 a_, uint8 b_) public pure returns (uint8) {
        return a_.avg(b_);
    }
    function add(uint8 a_, uint8 b_) public pure returns (uint8) { 
        return a_.add(b_);
    }
    function sub(uint8 a_, uint8 b_) public pure returns (uint8) {
        return a_.sub(b_);
    }
    function mul(uint8 a_, uint8 b_) public pure returns (uint8) {
        return a_.mul(b_);
    }
    function div(uint8 a_, uint8 b_) public pure returns (uint8) {
        return a_.div(b_);
    }  
    function mod(uint8 a_, uint8 b_) public pure returns (uint8) {
        return a_.mod(b_);
    } 
    function sqrt(uint8 a_) public pure returns (uint8) {
        return a_.sqrt();
    }
}