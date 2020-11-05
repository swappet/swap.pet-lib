// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// contracts/lib/ERC20Permit.sol
pragma solidity ^0.7.0;

import './lib/ERC20.sol'; 
// import './interfaces/IERC2612.sol'; 

/// @title Swap.Pet ERC20 & ERC2612 Token with permit machine.
/// @dev    Extension of {ERC20} to use tokens without sending any transactions 
///         by setting {IERC20-allowance} with a signature using the 
///         {permit} method, and then spend them via {IERC20-transferFrom}.
///         The {permit} signature mechanism conforms to the {IERC2612} interface.
abstract contract ERC20Permit is ERC20{
    // using SafeMath for uint256;

    // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"); 
    bytes32 public constant PERMIT_TYPEHASH = 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;
    
    bytes32 public immutable DOMAIN_SEPARATOR; 

    /// @dev Records current ERC2612 nonce for account. This value must be included whenever signature is generated for {permit}.
    /// Every successful call to {permit} increases account's nonce by one. This prevents signature from being used multiple times.
    mapping(address => uint256) public override nonces; 

    constructor(string memory name_, string memory symbol_, uint256 amount_) internal ERC20(name_,symbol_,amount_){
        uint256 chainId;
        assembly {chainId := chainid()} 

        // keccak256('EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)')
        bytes32 constant EIP712_TYPEHASH = 0x8b73c3c69bb8fe3d512ecc4cf759cc79239f7b179b0ffacaa9a75d522b39400f; 
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                EIP712_TYPEHASH,
                keccak256(bytes(name_)),
                keccak256(bytes('1')),
                chainId,
                address(this)
            )
        );
    }  
    /// @dev See {IERC2612-permit}
    function permit(address owner_, address spender_, uint256 amount_, uint256 deadline_, uint8 v_, bytes32 r_, bytes32 s_) external noShart(7 * 32) {
        require(block.timestamp <= deadline_ , 'ERC20Permit: deadline expired!');
        bytes32 digest = keccak256(
            abi.encodePacked(
                '\x19\x01',
                DOMAIN_SEPARATOR,
                keccak256(abi.encode(PERMIT_TYPEHASH, owner_, spender_, amount_, nonces[owner_]++, deadline_))
            )
        );
        address signer = ecrecover(digest, v_, r_, s_);
        require(signer != address(0) && signer == owner_, 'ERC20Permit: invalid signature!');
        _approve(owner_, spender_, amount_);
    }
}
