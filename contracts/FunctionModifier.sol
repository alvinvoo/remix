// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// Function modifier - resuse code before and / or after function
// Basic, inputs, sandwich

contract FunctionModifier {
    bool public paused;
    uint public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }
    // basic
    modifier whenNotPaused() {
        require(!paused, "paused");
        _; // continue on the function which is wrapped
    }

    function inc() external whenNotPaused {
        count += 1;
    }

    function dec() external whenNotPaused {
        count -= 1;
    }

    // takes an input
    modifier cap(uint _x) {
        require(_x < 100, "x >= 100");
        _;
    }

    function incBy(uint _x) external whenNotPaused cap(_x) {
        count += _x;
    }

    // sandwich the actual function in between some code in modifier
    modifier sandwich() {
        // code here
        count += 10;
        _;
        count *= 2;
    }

    function foo() external sandwich {
        count += 1;
    }
}