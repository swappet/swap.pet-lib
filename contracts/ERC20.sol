// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// contracts/lib/ERC20.sol
pragma solidity ^0.7.0;

import './lib/ERC20Basic.sol'; 

/// @dev Swap.Pet ERC20 token
contract ERC20 is ERC20Basic{  
    string public override immutable name;
    string public override immutable symbol;  

    /// @dev Records number of token that account (second) will be allowed to spend on behalf of another account (first) through {transferFrom}.
    /// This is zero by default.
    /// This value changes when {approve} {increaseAllowance} {decreaseAllowance} or {transferFrom} are called.
    mapping(address => mapping (address => uint256)) public allowances;  

    /// @dev Emitted when {approve()} amount_ allowance of owner_ to spender_. 
    event Approval(address indexed owner_, address indexed spender_, uint256 amount_);   

    /// @dev immutable name_/symbol_ are only set once in constructor. 
    constructor(string memory name_, string memory symbol_, uint256 amount_) public ERC20Basic(amount_){ 
        name = name_;
        symbol = symbol_; 
    } 
    /// @dev See interface for documentation. 
    function allowance(address owner_, address spender_) public view returns (uint256) {
        return allowances[owner_][spender_];
    } 
    /// @dev See interface for documentation.
    function approve(address spender_, uint256 amount_) public noShart(2 * 32) returns (bool) {
        _approve(msg.sender, spender_, amount_);
        return true;
    } 
    /// @dev See interface for documentation.
    function increaseAllowance(address spender_, uint256 amount_) public noShart(2 * 32) returns (bool) {
        require(allowances[msg.sender][spender_] <= MAX_UINT256 - amount_, "ERC20: add over"); 
        _approve(msg.sender, spender_, allowances[msg.sender][spender_] + amount_); 
        return true;
    } 
    /// @dev See interface for documentation.
    function decreaseAllowance(address spender_, uint256 amount_) public noShart(2 * 32) returns (bool) { 
        if (allowances[msg.sender][spender_] < amount_) { 
            _approve(msg.sender, spender_, 0);
        } else {
            _approve(msg.sender, spender_, allowances[msg.sender][spender_] - amount_);
        } 
        return true;
    } 

    /// @dev See interface for documentation.
    function transferFrom(address from_, address to_, uint256 amount_) public noShart(3 * 32) returns (bool) {
        require(allowances[from_][msg.sender] >= amount_, "ERC20: exceeds allowance");
        _transfer(from_, to_, amount_);
        _approve(from_, msg.sender, allowances[from_][msg.sender] - amount_);
        return true;
    }    
    
    function _approve(address owner_, address spender_, uint256 amount_) internal {
        require(owner_ != address(0), "ERC20: approve from the zero address");
        require(spender_ != address(0), "ERC20: approve to the zero address"); 

        allowances[owner_][spender_] = amount_;
        emit Approval(owner_, spender_, amount_);
    }  
}