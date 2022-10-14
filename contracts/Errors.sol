// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// to throw error -> require, revert, assert
// - when an error is thrown, the gas (what's UNUSED only) is refunded, state updates are reverted
// use custom error to save gas
contract Error {
    // require is mostly use to validate inputs and access control
    function testRequire(uint _i) public pure {
        require(_i <= 10, "error i > 10");
        // code
    }

    // can use revert as well
    // revert is better option if condition is nested 
    function testRevert(uint _i) public pure {
        if (_i < 10) {
            revert("error i > 10");
        }
    }

    uint public num = 123;
    // use assert to check for condition that's always true
    function testAssert() public view {
        assert(num == 123);
    }

    function foo(uint _i) public {
        // accidentally update num
        num += 1;
        require(_i < 10);
    }

// 21735 gas without params
// 22041 gas WITH params
    error MyError(address caller, uint i);
    function testCustomError(uint _i) public view {
        if (_i > 10) {
            // custom error only can be used with revert
            revert MyError(msg.sender, _i);
        }
    }
}