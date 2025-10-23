// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithError {
    function main() external pure {
        assembly {
            // revert the function with an error of type `Error(string)`
            // use "RevertRevert" as error message
            // Hint: The error type is a predefined four bytes. See https://www.rareskills.io/post/try-catch-solidity

            mstore(
                0x00,
                0x08c379a000000000000000000000000000000000000000000000000000000000
            )

            // store offset to string (32 bytes)
            mstore(0x04, 0x20)

            // store string length (12)
            mstore(0x24, 0x0c)

            // store the string "RevertRevert"
            mstore(
                0x44,
                0x5265766572745265766572740000000000000000000000000000000000000000
            )

            // revert with total length = 0x64
            revert(0x00, 0x64)
        }
    }
}
