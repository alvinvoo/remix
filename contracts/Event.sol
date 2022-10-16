// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Event {
    // events are states stored in blockchain as well
    event Log(string message, uint val);
    // up to 3 index in one event only
    // index allow easy searches via libraries like web3.js
    event IndexedLog(address indexed sender, uint val);

    function example() external {
        emit Log("foo", 1234);
        emit IndexedLog(msg.sender, 789);
    }

    event Message(address indexed _from, address indexed _to, string message);

    // function is transactional and cost gas
    function sendMessage(address _to, string calldata message) external {
        emit Message((msg.sender), _to, message);
    }
}