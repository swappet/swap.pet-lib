// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Swap.Pet@pm.me
// contracts/lib/Address.sol
pragma solidity ^0.7.0;   

/**
 * @dev helper of safe call instead the low level `call`.
 */
library Address {
    function nonZero(address address_) pure public {
        require(address_ != address(0), "Address: Not be empty"); 
    }
    // converts address to uppercase hex string(len bytes,up to 20, multiple of 2)
    function toString(address addr, uint len) pure public returns (string memory) {
        require(len % 2 == 0 && len > 0 && len <= 40, "Address: INVALID_LEN");

        bytes memory s = new bytes(len);
        uint addrNum = uint(addr);
        for (uint i = 0; i < len / 2; i++) {
            // shift right and truncate all but the least significant byte to extract the byte at position 19-i
            uint8 b = uint8(addrNum >> (8 * (19 - i)));
            // first hex character is the most significant 4 bits
            uint8 hi = b >> 4;
            // second hex character is the least significant 4 bits
            uint8 lo = b - (hi << 4);
            s[2 * i] = char(hi);
            s[2 * i + 1] = char(lo);
        }
        return string(s);
    }

    // converts values to the unicode/ascii code point for hex representation
    // uses upper case for the characters
    // hi and lo are only 4 bits and between 0 and 16
    function char(uint8 b) pure public returns (byte c) {
        return b < 10 ? byte(b + 0x30) : byte(b + 0x37);
    }

    /**
     * @dev Returns true for contract and false for the following: 
     *  - an externally-owned account (EOA) 
     *  - a contract in construction(attack in construct)
     *  - address where contract will be created (attack with create2)
     *  - an address where a contract lived, but was destroyed 
     */
    function isContract(address account_) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution. 
        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account_) }

        // EIP-1052, 0x0 is returned for not-yet created accounts, 
        // 0xc5d...470 is returned for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account_) } 
        return size > 0 || (codehash != 0x0 && codehash != accountHash);
    }  

    /**
     * @dev safe call instead the low level `call`. A 
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value .
     *
     * Requirements: 
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert. 
     */
    function safeCall(address target_, bytes memory data_) internal returns (bytes memory) {
      return safeCall(target_, data_, "Address: low-level call failed");
    } 
    function safeCall(address target_, bytes memory data_, string memory errMsg_) internal returns (bytes memory) {
        return _safeCallAtValue(target_, data_, 0, errMsg_);
    } 
    function safeCallAtValue(address target_, bytes memory data_, uint256 amount_) internal returns (bytes memory) {
        return safeCallAtValue(target_, data_, amount_, "Address: low-level call with value failed");
    } 
    function safeCallAtValue(address target_, bytes memory data_, uint256 amount_, string memory errMsg_) internal returns (bytes memory) {
        require(address(this).balance >= amount_, "Address: insufficient balance for call");
        return _safeCallAtValue(target_, data_, amount_, errMsg_);
    }
    function _safeCallAtValue(address target_, bytes memory data_, uint256 amount_, string memory errMsg_) private returns (bytes memory data) {
        require(isContract(target_), "Address: call to non-contract"); 
        (bool success, data)= _valueCall(target_, data_,amount_);  
        if (!success) {
            if (data.length > 0) {
                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let data_size := mload(data)
                    revert(add(32, data), data_size)
                }
            } else {
                revert(errMsg_);
            }
        }
    } 
    function _valueCall(address payable token_, bytes memory data_, uint256 amount_) private returns (bool success, bytes memory data){ 
        if ( !amount_ ) {
            (success, data) = token_.call(data_);
        } else {
            // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
            (success, data) = token_.call{value : amount_}(data_);
        }
    }

}
