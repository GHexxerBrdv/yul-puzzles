// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromFixedArray {
    uint256[5] readMe;

    function setValue(uint256[5] calldata x) external {
        readMe = x;
    }

    function main(uint256 index) external view returns (uint256) {
        assembly {
            // Get the storage slot of `readMe`
            let slot := readMe.slot

            // Each element of a fixed array is stored in consecutive slots
            // So element at `index` is at `slot + index`
            let value := sload(add(slot, index))

            // Return value
            mstore(0x00, value)
            return(0x00, 0x20)
        }
    }
}
