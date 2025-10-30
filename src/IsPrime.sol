// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract IsPrime {
    function main(uint256 x) external pure returns (bool) {
        assembly {
            // your code here
            // return true if x is a prime number, else false
            // 1. check if the number is a multiple of 2 or 3
            // 2. loop from 5 to x / 2 to see if it is divisible
            // 3. increment the loop by 2 to skip the even numbers
            
            let ptr := mload(0x40)
            if or(lt(x, 2), eq(x, 4)) {
                mstore(ptr, 0)
                return(ptr, 0x20)
            }
            
            if or(eq(x, 2), eq(x, 3)) {
                mstore(ptr, 1)
                return(ptr, 0x20)
            }
            
            let result := or(
                eq(
                    mod(x, 2),
                    0
                ),
                eq(
                    mod(x, 3),
                    0
                )
            )
            
            if result {
                mstore(ptr, 0)
                return(ptr, 0x20)
            }
            
            let half := div(x, 2)
            
            for {let i := 5} lt(i, half) { i := add(i, 2)} {
                if iszero(mod(x, i)) {
                    mstore(ptr, 0)
                    return(ptr, 0x20)
                }
            }
            
            mstore(ptr, 1)
            return(ptr, 0x20)
        }
    }
}
