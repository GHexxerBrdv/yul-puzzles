// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract DoubleOrNothing {
    function main(uint256 x) external pure returns (uint256) {
        assembly {
            // your code here
            // return 2 * x if the product is
            // 21 or less. If 2 * x > 21, then
            // return 0.
            // Hint: check if x ≤ 10, which is equivalent to x < 11
            
            let ptr := mload(0x40)
            let result
            if lt(x, 11) {
                result := mul(2, x)
            }
            mstore(ptr, result)
            return(ptr, 0x20)
        }
    }
}
