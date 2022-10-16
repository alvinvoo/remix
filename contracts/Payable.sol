// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Payable {
    // can transfer ether to this owner address
    address payable public owner;

    constructor() {
        // initialize this owner as payable sender
        // purpose: later can withdraw ether from (this) contract address to this owner address
        owner = payable(msg.sender);
    }

    function deposit() external payable {}

    function getBalance() external view returns (uint) {
        return address(this).balance; // return this contract's balance
    }
}