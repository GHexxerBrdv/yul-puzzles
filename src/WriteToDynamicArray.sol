// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDynamicArray {
    uint256[] writeHere;

    function main(uint256[] memory x) external {
        assembly {
            // your code here
            // store the values in the DYNAMIC array `x` in the storage variable `writeHere`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            let ptr := mload(0x40)
            let length := mload(x)
            let slot := writeHere.slot
            sstore(slot, length)
            mstore(ptr, slot)
            
            let dataSlot := keccak256(ptr, 0x20)
            
            for {let i := 0} lt(i, length) {i := add(i, 1)} {
                let value := mload(add(add(x, 0x20), mul(i, 0x20)))
                
                sstore(add(dataSlot, i), value)
            }
        }
    }

    function getter() external view returns (uint256[] memory) {
        return writeHere;
    }
}
