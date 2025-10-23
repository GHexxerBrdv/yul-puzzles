// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithSelectorPlusArgs {
    error RevertData(uint256); // selector: 0xae412287

    function main(uint256 x) external pure {
        assembly {
            // your code here
            // revert custom error with x parameter
            // Hint: concatenate selector and x by storing them
            // adjacent to each other in memory
            // 
            // To store this error in EVM memory we need
            // 1. Error selecotr -> 0xae412287
            // 2. Abi encoded parameters 
            // 
            // uint256 is encoded in 32 bytes big-endian word
            
            let x_val := calldataload(4) // loading the value of x from calldata
            
            let ptr := mload(0x40) // free memory pointer
            
            mstore(ptr, 0xae41228700000000000000000000000000000000000000000000000000000000) // store the error selector to the free memory pointer
            
            mstore(add(ptr, 0x04), x_val) // store the value immidiatly after the selector
            
            revert(ptr, 0x24)
        }
    }
}
