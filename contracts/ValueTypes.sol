// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// Data type - values and references

contract ValueTypes {
    // common types used in contract
    bool public b = true;
    uint public u = 123; // uint = uint256 0 to 2**256 - 1
                         //        uint8   0 to 2**8 - 1
                         //        uint16  0 to 2**16 - 1
    int public i = -123; // int = int256 -2**255 to 2**255 - 1
                         //       int128 -2**127 to 2**127 - 1
    int public minInt = type(int).min;
    int public maxInt = type(int).max;
    // address are 20 byte value
    address public addr = 0xe9Ccec234FD69dBd126EB4fdf80138BA50c7083C;
    // bytes32 are used to work with keccak256
    bytes32 public b32 = 0x2c22a571a470a65c2bb0ff784ff0ec758ed9bcd78ff8db28a0764e00747d02d8;
}
