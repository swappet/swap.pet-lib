// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// contracts/lib/WETH9.sol
pragma solidity ^0.7.0; 

import './lib/ERC20.sol';
import './interfaces/IWETH9.sol';
import './SafeMath.sol';
 
contract WETH9 is ERC20,IWETH9{  
    using SafeMath for uint256;  
    constructor() public ERC20("Wrapped Ether","WETH"){  
    }  
    /// @dev plus function over ERC20 of OpenZeppelin  
    function deposit() public payable {
        _beforeTokenTransfer(address(0), msg.sender, msg.value);
        _totalSupply += msg.value;
        _balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value); 
        emit Transfer(address(0), msg.sender, msg.value);
    } 
    function withdraw(uint256 amount_) public {
        require(_balances[msg.sender] >= amount_);
        require(_totalSupply >= amount_);
        _beforeTokenTransfer(msg.sender, address(0), amount_); 
        _balances[msg.sender] -= amount_;
        _totalSupply -= amount_;
        msg.sender.transfer(amount_);
        emit Withdraw(msg.sender, amount_);
        emit Transfer(msg.sender, address(0), amount_);
    }  
    fallback() external payable { deposit(); }
    receive() external payable { deposit(); }
}