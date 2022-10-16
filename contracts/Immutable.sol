// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Immutable {
    // immutable modifier is like `const`
    // assigning once when contract is deployed and never change again - will save some gas when being accessed

    // 45718 gas with no immutable
    // 43585 with immutable

    // 189028 deployment gas when initializing directly
    address public immutable owner = msg.sender;

    uint public x;

    // another way of initializing is using constructor - but seems to require a bit more gas
    // 189046
    // constructor () {
    //     owner = msg.sender;
    // }

    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}