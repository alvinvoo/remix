// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Counter {
    // for public state, an external getter function - count() is created
    uint public count;

    // WRITE function, no need modifier
    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}