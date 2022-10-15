// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// a contract to claim ownership
// state variables
// global variables
// function modifier
// function
// error handling

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender; // owner
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    function setOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "invalid address");
        owner = _newOwner;
    }

    function onlyOwnerCanCall() external onlyOwner {
        // code
    }

    function anyoneCanCall() external {
        // code
    }
}