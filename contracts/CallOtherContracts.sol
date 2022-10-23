// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract CallTestContract {
    function setX(TestContract testContract, uint _x) external {
        testContract.setX(_x);
    }

    // can also call another contract by address, its the same
    function getX(address _test) external view returns (uint x) {
        x = TestContract(_test).getX();
    }

    function setXandSendEther(address _test, uint _x) external payable {
        // forward all value paid via this function
        TestContract(_test).setXandReceiveEther{value: msg.value}(_x);
    }

    function getXandValue(address _test) external view returns (uint, uint) {
        return TestContract(_test).getXandValue();
    }
}

contract TestContract {
    uint public x;
    uint public value = 123;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function setXandReceiveEther(uint _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }
}