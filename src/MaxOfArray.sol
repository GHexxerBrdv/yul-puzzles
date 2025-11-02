// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfArray {
    function main(uint256[] memory arr) external pure returns (uint256) {
        assembly {
            // your code here
            // return the maximum value in the array
            // revert if array is empty
            
            let ptr := mload(0x40)
            let len := mload(arr)
            if iszero(len) {
                revert(0, 0)
            }
            let max := mload(add(arr, 0x20))
            for {let i := 1} lt(i, len) {i := add(i, 1)} {
                let val := mload(add(arr, add(0x20, mul(i, 0x20))))
                if gt(val, max) {
                    max := val
                }
            }
            mstore(ptr, max)
            return(ptr, 0x20)
        }
    }
}
