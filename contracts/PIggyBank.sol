// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract PiggyBank {
    event Deposit(uint amount);
    event Withdraw(uint amount);

    // directly initializing owner = msg.sender (no need via constructor)
    address public owner = msg.sender;

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner);
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}