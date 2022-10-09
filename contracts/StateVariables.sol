// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract StateVariables {
    // state variable - saved to blockchain
    uint public myUint = 123;

    function foo() external pure {
        // local variable - only exists while function is executing
        uint localVariable = 456;
    }
}