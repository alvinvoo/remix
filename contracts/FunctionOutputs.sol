// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// Solidity function can:
// Return multiple outputs
// Named outputs
// Destructuring Assignment

contract FunctionOutputs {
    // declared `public` so that it can be imported in another contract
    // multiple outputs
    function returnMany() public pure returns (uint, bool) {
        return (1, true);
    }

    // named outputs
    function returnManyNamed() public pure returns (uint x, bool b) {
        return (1, true);
    }

    // assigned named outputs (can save a little bit of gas)
    function returnManyNamedAssigned() public pure returns (uint x, bool b) {
        x = 1;
        b = true;
    }

    function destructuringAssignments() public pure {
        (uint x, bool b) = returnMany();
        (, bool _b) = returnMany();
    }
}