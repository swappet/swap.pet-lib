// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me, checked at 2020.10.21
// contracts/interfaces/IERC2612.sol
pragma solidity ^0.7.0;

/// @notice Interface of the ERC2612 standard as defined in the EIP.
/// @dev    Adds {permit} to change {IERC20-allowance} without {IERC20-approve}. 
///         This allows users to spend tokens without having to hold Ether.
///         See https://eips.ethereum.org/EIPS/eip-2612.
interface IERC2612 {
    /// @notice Sets amount_ as the allowance of spender_ over owner_'s tokens.
    /// @dev    given owner_'s signature with emit {Approval} event.
    ///         signature format, see the[relevant EIP section]:
    ///         https://eips.ethereum.org/EIPS/eip-2612#specification
    /// @param owner_       cannot be the zero address.
    /// @param spender_     cannot be the zero address.
    /// @param deadline_    must be a timestamp in the future.
    /// @param v_, r_, s_   must be a valid `secp256k1` signature from owner_ 
    ///                     over the EIP712-formatted function arguments.
    ///                     the signature must use owner_ current nonce. 
    function permit(address owner_, address spender_, uint256 amount_, uint256 deadline_, uint8 v_, bytes32 r_, bytes32 s_) external;

    /// @notice  Returns the current ERC2612 nonce of owner_. 
    /// @dev    This value must be included whenever a signature is generated for {permit}.
    ///         Every successful call to {permit} increases owner_'s nonce by one 
    ///         to prevent a signature from being used multiple times.
    function nonces(address owner_) external view returns (uint256);
    
    /// @dev EIP712Domain
    function DOMAIN_SEPARATOR() external view returns (bytes32);
    /// @dev keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    function PERMIT_TYPEHASH() external pure returns (bytes32);
} 