// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PopFromDynamicArray {
    uint256[] popFromMe = [23, 4, 19, 3, 44, 88];

    function main() external {
        assembly {
            // your code here
            // pop the last element from the dynamic array `popFromMe`
            // dont forget to clean the popped element's slot.
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            
            let slot := popFromMe.slot
            let len := sload(slot)
            
            let ptr := mload(0x40)
            mstore(ptr, slot)
            
            let dataSlot := keccak256(ptr, 0x20)
            let lastElement := add(dataSlot, sub(len, 1))
            
            sstore(lastElement, 0)
            sstore(slot, sub(len, 1))
        }
    }

    function getter() external view returns (uint256[] memory) {
        return popFromMe;
    }

    function lastElementSlotValue(bytes32 s) external view returns (uint256 r) {
        assembly {
            r := sload(s)
        }
    }
}
