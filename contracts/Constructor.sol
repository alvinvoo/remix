// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Constructor {
    address public owner;
    uint public x;

    // only called once when we deploy the contract
    // allow to initialize state variable
    constructor(uint _x){
        owner = msg.sender;
        x = _x;
    }
}