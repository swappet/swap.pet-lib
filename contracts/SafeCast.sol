// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// contracts/SafeCast.sol
pragma solidity ^0.7.0; 

/// @notice Downcasting uintXX/intXX in save with overflow checks. 
/// @dev combined with {SafeMath} and {SignedSafeMath} and then downcasting:
///         use SafeMath for int256;
///         use SafeCast for int256;
///         use SignedSafeMath for uint256;
///         use SafeCast for uint256; 
library SafeCast {

    /// @notice uint256 => toInt256 
    function toInt256(uint256 value) internal pure returns (int256) {
        require(value < 2**255, "SafeCast: value overflow int256");
        return int256(value);
    }

    /// @notice int256 => uint128 
    function toInt128(int256 value) internal pure returns (int128) {
        require(value >= -2**127 && value < 2**127, "SafeCast: value overflow 128 bits");
        return int128(value);
    }

    /// @notice int256 => uint64
    function toInt64(int256 value) internal pure returns (int64) {
        require(value >= -2**63 && value < 2**63, "SafeCast: value overflow 64 bits");
        return int64(value);
    }

    /// @notice int256 => uint32
    function toInt32(int256 value) internal pure returns (int32) {
        require(value >= -2**31 && value < 2**31, "SafeCast: value overflow 32 bits");
        return int32(value);
    }

    /// @notice int256 => uint16
    function toInt16(int256 value) internal pure returns (int16) {
        require(value >= -2**15 && value < 2**15, "SafeCast: value overflow 16 bits");
        return int16(value);
    }

    /// @notice int256 => uint8
    function toInt8(int256 value) internal pure returns (int8) {
        require(value >= -2**7 && value < 2**7, "SafeCast: value overflow 8 bits");
        return int8(value);
    }
    
    /// @notice int256 => uint256 
    function toUint256(int256 value) internal pure returns (uint256) {
        require(value >= 0, "SafeCast: value must be positive");
        return uint256(value);
    }
    /// @notice uint256 => uint128 
    function toUint128(uint256 value) internal pure returns (uint128) {
        require(value < 2**128, "SafeCast: value overflow 128 bits");
        return uint128(value);
    }

    /// @notice uint256 => uint64 
    function toUint64(uint256 value) internal pure returns (uint64) {
        require(value < 2**64, "SafeCast: value overflow 64 bits");
        return uint64(value);
    }

    /// @notice uint256 => uint32 
    function toUint32(uint256 value) internal pure returns (uint32) {
        require(value < 2**32, "SafeCast: value overflow 32 bits");
        return uint32(value);
    }

    /// @notice uint256 => uint16
    function toUint16(uint256 value) internal pure returns (uint16) {
        require(value < 2**16, "SafeCast: value overflow 16 bits");
        return uint16(value);
    }

    /// @notice uint256 => uint8 
    function toUint8(uint256 value) internal pure returns (uint8) {
        require(value < 2**8, "SafeCast: value overflow 8 bits");
        return uint8(value);
    }


}
