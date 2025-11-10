// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromDynamicArrayAndRevertOnFailure {
    uint256[] readMe;

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(int256 index) external view returns (uint256) {
        assembly {
            // your code here
            // read the value at the `index` in the dynamic array `readMe`
            // and return it
            // Revert with Solidity panic on failure, use error code 0x32 (out-of-bounds or negative index)
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            
            let baseSlot := readMe.slot
            let len := sload(baseSlot)
            let ptr := mload(0x40)
            if or(lt(index, 0), iszero(lt(index, len))) {
                mstore(ptr, shl(224, 0x4e487b71))
                mstore(add(ptr, 0x04), 0x32)
                revert(ptr, 0x24)
            }
            
            mstore(ptr, baseSlot)
            let dataSlot := keccak256(ptr, 0x20)
            let value := sload(add(dataSlot, index))
            mstore(ptr, value)
            return(ptr, 0x20)
        }
    }
}
