// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// Mapping
// how to declare a mapping (simple and nested)
// set, get, delete

contract Mapping {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => bool)) public isFriend;
    address public addr;

    function examples() external {
        balances[msg.sender] = 123;
        uint bal = balances[msg.sender];
        uint bal2 = balances[address(1)]; // can access undefined key; bal2 default to 0

        balances[msg.sender] += 456; // 123 + 456 = 579

        delete balances[msg.sender]; // will default to 0

        addr = address(this); // this seems to be the contract address
        isFriend[msg.sender][address(this)] = true;
    }

    function examples2() external {
        addr = address(this);
    }
}