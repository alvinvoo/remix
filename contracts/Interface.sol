// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// interface allows to call other contracts without its code
interface ICounter {
    function count() external view returns (uint);
    function inc() external;
}

// deploy Counter.sol first before deploying this contract
contract CallInterface {
    uint public count;

    function examples(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}
