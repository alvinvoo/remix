// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// visibility
// private - only inside contract
// internal - only inside contract and child contracts
// public - inside and outside contract
// external - only from OUTSIDE contract

/*

A
private pri()
internal inter()
public pub()          <---- outside C (only can call pub() and ext())
external ext()

B is A
inter()               <---- outside C (only can call pub() and ext() as well)
pub()

*/

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    function privateFunc() private pure returns (uint) {}

    function internalFunc() internal pure returns (uint) {}

    function publicFunc() public pure returns (uint) {}

    function externalFunc() external pure returns (uint) {}

    function examples() external view {
        x + y + z;
        privateFunc();
        internalFunc();
        publicFunc();

        // can call external function like this but its very gas inefficient
        // this.externalFunc();
    }
}

contract VisibilityChild is VisibilityBase {
    function examples2() external view {
        y + z;

        internalFunc();
        publicFunc();
    }
}