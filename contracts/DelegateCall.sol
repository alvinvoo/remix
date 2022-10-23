// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;
// use delegatecall (another low-level like call)
// to bypass the middle caller
/*
A calls B, sends 100 wei
        B calls C, sends 50 wei
A --> B --> C
            msg.sender = B
            msg.value = 50
            execute code on C's state variables
            use ETH in C

A calls B, sends 100 wei
        B delegatecall C
A --> B --> C
            msg.sender = A
            msg.value = 100
            execute code on B's state variables
            use ETH in B

Benefit: can update the delegate callee (C) logic and state variables of the caller
(B) will be updated. This might be useful when the caller (B) is a huge contract that
we dont want to redeploy often.
*/

contract TestDelegateCall {
    // take care that the ordering of state variables have to be the same
    // bytes public test; not ok, will "push" the state variable storage area
    uint public num;
    address public sender;
    uint public value;
    // but if its something appended afterwards, its ok
    uint public somethingElse;

    function setVars(uint _num) external payable {
        num = 4 * _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    // take care that the ordering of state variables have to be the same
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _test, uint _num) external payable {
        // downside: the function argument defined in string has to be precise
        // _test.delegatecall(
        //     abi.encodeWithSignature("setVars(uint256)", _num)
        // );

        (bool success, bytes memory data) = _test.delegatecall(
            // can update setVars argument signature without having to update
            // this function again
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        require(success, "delegatecall failed");
    }
}

