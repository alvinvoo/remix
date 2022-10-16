// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// Order of inheritance must be declaref from - most base-liked to derived
/*
   X
  / \
 Y   A
 |   |
 |   B
  \ / 
   Z
X, Y, A, B, Z
(Y and A same order)
*/

// Below example is in order X, Y, Z
contract X {
    function foo() public pure virtual returns (string memory) {
        return "X";
    }

    function bar() public pure virtual returns (string memory) {
        return "X";
    }

    function x() public pure returns (string memory) {
        return "X";
    }
}

contract Y is X {
    function foo() public pure virtual override returns (string memory) {
        return "Y";
    }

    function bar() public pure virtual override returns (string memory) {
        return "Y";
    }

    function y() public pure returns (string memory) {
        return "Y";
    }
}

// this must be in order of X followed by Y
contract Z is X,Y {
    function foo() public pure override(X, Y) returns (string memory) {
        return "Z";
    }

    // here override argument doesnt care about order
    function bar() public pure override(Y, X) returns (string memory) {
        return "Z";
    }
}