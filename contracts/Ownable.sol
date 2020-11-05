// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// contracts/lib/Ownable.sol
pragma solidity ^0.7.0; 

contract Ownable {  
    address private _owner;

    event OwnershipTransferred(address indexed old_, address indexed new_);

    /// @dev Throws if called by any account other than the owner.
    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: Not the owner");
        _;
    } 
    /// @dev Initializes the contract setting the deployer as the initial owner.
    constructor () internal {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }
    /// @dev Returns the address of the current owner. 
    function owner() public view returns (address) {
        return _owner;
    }
    /// @dev Leaves contract without owner. Only be called by the current owner.
    function renounceOwnership() public virtual onlyOwner{ 
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    /// @dev Transfers ownership to owner_. Only be called by the current owner.
    function transferOwnership(address owner_) public virtual onlyOwner{ 
        require(owner_ != address(0), "Ownable: Not be zero address");
        emit OwnershipTransferred(_owner, owner_);
        _owner = owner_;
    }
}