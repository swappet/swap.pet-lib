// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// contracts/lib/ERC20Basic.sol
pragma solidity ^0.7.0;
 
/// @dev Swap.Pet ERC20Basic token
contract ERC20Basic {
    uint256 constant MAX_UINT256 = 2**256 -1 ;
    uint8 public decimals;  
    uint256 public totalSupply;  
    
    /// @dev Records amount of token owned by account.
    mapping(address => uint256) public balances;
    
    /// @dev Emitted when amount_ tokens moved from from_ account to to_.
    event Transfer(address indexed from_, address indexed to_, uint256 amount_);
    event Burn(address indexed from_, uint256 amount_);
    event Mint(address indexed to_, uint256 amount_);
 
    /// @dev Fix for the short address attack. 
    modifier noShart(uint256 size) {
        require(!(msg.data.length < size + 4));
        _;
    }
    constructor(uint256 amount_) public {  
        /// @dev    default value, so  `_X_` tokens be displayed `_X_ / 10 ** 18`.
        ///         use {_setupDecimals} change 
        decimals = 18;  
        totalSupply = amount_ * (10**uint256(decimals));
        balances[msg.sender] = totalSupply;
    }  
    function balanceOf(address account_) public view returns (uint256) {
        return balances[account_];
    }    
    function transfer(address to_, uint256 amount_) public noShart(2 * 32) returns (bool) {
        _transfer(msg.sender, to_, amount_);
        return true;
    } 
    /// @dev Moves tokens amount_ from from_ to to_ after {_beforeTokenTransfer()}.
    function _transfer(address from_, address to_, uint256 amount_) internal {
        require(from_ != address(0), "ERC20: transfer from the zero address");
        require(to_ != address(0), "ERC20: transfer to the zero address");
        require(balances[from_] >= amount_, "ERC20: sub overflow");
        require(balances[to_] + amount_ >= amount_, "ERC20: add overflow"); 

        _beforeTokenTransfer(from_, to_, amount_);

        balances[from_] = balances[from_] - amount_;
        balances[to_] = balances[to_] + amount_; 
        emit Transfer(from_, to_, amount_);
    } 
    /// @dev Creates amount_ tokens to to_, increasing the total supply. 
    function _mint(address to_, uint256 amount_) internal {
        require(to_ != address(0), "ERC20: mint to the zero address");  
        _beforeTokenTransfer(address(0), to_, amount_);
        require(totalSupply <= MAX_UINT256 - amount, "ERC20: add over");
        require(balances[to_] <= MAX_UINT256 - amount, "ERC20: add over");
        totalSupply = totalSupply + amount_;
        balances[to_] = balances[to_] + amount_;
        emit Mint(to_, amount_);
        emit Transfer(address(0), to_, amount_);
    } 
    /// @dev Destroys amount_ tokens from from_, reducing the total supply.
    function _burn(address from_, uint256 amount_) internal {
        require(from_ != address(0), "ERC20: burn from the zero address");
        require(amount_>=0 && balances[from_] >= amount_ && totalSupply >= amount_, "ERC20: amount error");
        _beforeTokenTransfer(from_, address(0), amount_); 
        balances[from_] = balances[from_] - amount_;
        totalSupply = totalSupply - amount_; 
        emit Burn(from_, amount_);
        emit Transfer(from_, address(0), amount_);
    }  
    /// @dev    Sets {decimals} to a value other than the default one of 18.
    ///         WARNING: should only be called once in the constructor.
    function _setupDecimals(uint8 decimals_) internal {
        decimals = decimals_;
    } 

    /// @dev Hook called before any transfer(mint/burn) of tokens.  
    function _beforeTokenTransfer(address from_, address to_, uint256 amount_) internal virtual { }
}
