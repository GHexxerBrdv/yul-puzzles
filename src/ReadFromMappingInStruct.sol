// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReadFromMappingInStruct {
    struct RandomValues {
        uint256 someValue1; // 1
        uint128 someValue2; // 2
        uint128 someValue3; // 2
        mapping(uint256 index => uint256) readMe; // 3
        uint256 someValue4; // 4
    }

    uint256 someValue5 = 7; // 0
    RandomValues randValues; // 1

    function setValue(uint256 i, uint256 v, uint256 s1, uint128 s2, uint128 s3, uint256 s4, uint256 s5) external {
        randValues.someValue1 = s1;
        randValues.someValue2 = s2;
        randValues.someValue3 = s3;
        randValues.someValue4 = s4;
        randValues.readMe[i] = v;
        someValue5 = s5;
    }

    function main(uint256 index) external view returns (uint256) {
        assembly {
            // your code here
            // within the struct `RandomValues`, read from the mapping `readMe` at `index`
            // and return it
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            
            let ptr := mload(0x40)
            let structSlot := randValues.slot
            let mappingBaseSlot := add(structSlot, 2)
            mstore(ptr, index)
            mstore(add(ptr, 0x20), mappingBaseSlot)
            let dataSlot := keccak256(ptr, 0x40)
            let value := sload(dataSlot)
            mstore(ptr, value)
            return(ptr, 0x20)
        }
    }
}
