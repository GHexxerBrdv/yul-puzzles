// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteDynamicArrayToStorage {
    uint256[] public writeHere;

    function main(uint256[] calldata x) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere`
            
            let offset := calldataload(4)
            let dataPos := add(4, offset)
            
            let len := calldataload(dataPos)
            let elSlot := add(dataPos, 0x20)
            let slot := writeHere.slot
            sstore(slot, len)
            
            let ptr := mload(0x40)
            mstore(ptr, slot)
            let dataSlot := keccak256(ptr, 0x20)
            
            for {let i := 0} lt(i, len) {i := add(i, 1)} {
                let value := calldataload(add(elSlot, mul(i, 0x20)))
                sstore(add(dataSlot, i), value)
            }
        }
    }
}
