// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// contracts/mocks/SafeNamerMock.sol 
pragma solidity ^0.7.0; 

import '../SafeNamer.sol';

contract PairNamerMock {
    function pairName(string calldata prefix, address token0, address token1, string calldata suffix) external view returns (string memory) {
        return SafeNamer.pairName(prefix, token0, token1, suffix);
    }

    function pairSymbol(string calldata prefix, address token0, address token1, string calldata suffix) external view returns (string memory) {
        return SafeNamer.pairSymbol(prefix, token0, token1, suffix);
    }
}

contract MixNamerMock {
    function mixName(string calldata prefix, address[] memory tokens, address tokenBase, string calldata suffix) external view returns (string memory) {
        return SafeNamer.mixName(prefix,tokens, tokenBase,  suffix);
    }

    function mixSymbol(string calldata prefix, address[] memory tokens, address tokenBase, string calldata suffix) external view returns (string memory) {
        return SafeNamer.mixSymbol(prefix,tokens, tokenBase, suffix);
    }
}
/// @dev test token with name()/symbol()
contract FakeTokenMock {
    string public name;
    string public symbol;
    
    constructor(string memory name_, string memory symbol_) public {
        name = name_;
        symbol = symbol_;
    }
}

