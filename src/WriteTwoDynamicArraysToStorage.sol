// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteTwoDynamicArraysToStorage {
    uint256[] public writeHere1;
    uint256[] public writeHere2;

    function main(uint256[] calldata x, uint256[] calldata y) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere1` and
            // dynamic calldata array `y` to storage variable `writeHere2`
            
            let slot1 := writeHere1.slot
            let slot2 := writeHere2.slot
            
            let xOffset := calldataload(4)
            let xLen := calldataload(add(4, xOffset))
            sstore(slot1, xLen)
            
            let xData := add(add(4, xOffset), 0x20)
            
            mstore(0x00, slot1)
            let xSlot := keccak256(0x00, 0x20)
            
            for {let i := 0} lt(i, xLen) {i := add(i, 1)} {
                let val := calldataload(add(xData, mul(i, 0x20)))
                sstore(add(xSlot, i), val)
            }
            
            let yLen := calldataload(y.offset)
            sstore(slot2, yLen)
            
            let yData := add(y.offset, 0x20)
            
            mstore(0x00, slot2)
            let ySlot := keccak256(0x00, 0x20)
                
            for {let j := 0} lt(j, yLen) {j := add(j, 1)} {
                let val := calldataload(add(yData, mul(j, 0x20)))
                sstore(add(ySlot, j), val)
            }
        }
    }
}
