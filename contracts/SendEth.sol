// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 3 ways to send ETH
// transfer - 2300 gas, reverts (if the function fails)
// send - 2300 gas, returns bool (but does it revert?)
// call - forward all gas, returns bool and data
// most people use call, followed by transfer

contract SendEther {
    constructor() payable {}

    // not fallback function, so if non-existing function is called this contract will fail
    // receive only receive ETH
    receive() external payable {}

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123); // send 123 wei to _to; only send 2300 gas for _to to execute some code
        // if function call fails, the whole tranx will fail
    }

    function sendViaSend(address payable _to) external payable {
        bool sent = _to.send(123); // will return boolean value
        require(sent, "send failed");
    }

    function sendViaCall(address payable _to) external payable {
        (bool success, ) = _to.call{value: 123}("");
        require(success, "call failed");
    }
}

contract EthReceive {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}