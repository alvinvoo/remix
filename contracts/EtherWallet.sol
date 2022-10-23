// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        // instead of using owner.transfer (state variable) - cost more gas
        // we use a local variable msg.sender, since they are the same
        payable(msg.sender).transfer(_amount);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}