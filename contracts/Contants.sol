// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// constant state variables save gas
// both deployment gas and call gas
// deploy 147096 gas
contract Constants {
    // calls 21442 gas
    address public constant MY_ADDRESS = 0x8888888888777777777788888888887777777777;
    uint public constant MY_UINT = 123;
}

// deploy 149779 gas
contract Var {
    // calls 23553 gas
    address public MY_ADDRESS = 0x8888888888777777777788888888887777777777;
}