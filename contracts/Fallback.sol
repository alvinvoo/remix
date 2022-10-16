// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

/*
Fallback executed when
- function doesn't exist
- direct sending of ETH (to contract)
*/

contract Fallback {
    event Log(string func, address sender, uint value, bytes data);

    // will be executed when msg.data is NOT empty
    // will be executed when msg.data is empty and receive function doesn't exist
    fallback() external payable{
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    // will be executed when msg.data is empty
    receive() external payable{ 
        emit Log("receive", msg.sender, msg.value, "");
    }
}