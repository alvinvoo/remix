// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// selfdestruct
// - delete contract
// - force send remaining Ether to any address (including wallet address AND contracts with no fallback function)
// - used to hack contracts

contract Kill {
    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    // won't be able to call after contract deleted
    function testCall() external pure returns (uint) {
        return 123;
    }
}

contract Helper {
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function kill(Kill _kill) external {
        _kill.kill();
    }
}

