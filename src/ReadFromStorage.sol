// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromStorage {
    uint256 readMe; // slot 0

    function setValue(uint256 x) external {
        readMe = x;
    }

    function main() external view returns (uint256) {
        assembly {
            // your code here
            // read the value in the storage variable `readMe`
            // and return it
            // Hint: use sload opcode
            
            let value := sload(0x00)
            mstore(0x40, value)
            return(0x40, 0x20)
        }
    }
}
