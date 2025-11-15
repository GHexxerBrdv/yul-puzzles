// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPacked64 {
    uint64 public someValue1 = 7;
    uint64 public writeHere = 1;
    uint64 public someValue2 = 7;
    uint64 public someValue3 = 7;

    function main(uint256 v) external {
        assembly {
            // your code here
            // change the value of `writeHere` storage variable to `v`
            // be careful not to alter the value of `someValue` variable
            let data := sload(writeHere.slot)
            let cleared := and(
                data,
                0xFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF
            )
            let shifted := shl(64, and(v, 0xFFFFFFFFFFFFFFFF))
            sstore(writeHere.slot, or(cleared, shifted))
            
        }
    }
}
