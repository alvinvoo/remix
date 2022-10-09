// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract ViewAndPureFunctions {
    uint public num; // blockchain state variable

    function viewFunc() external view returns (uint) {
        return num;
    }

    function pureFunc() external pure returns (uint) {
        return 1;
    }    
    
    function addToNum(uint x) external view returns (uint) {
        return num + x;
    }

    function add(uint x, uint y) external pure returns (uint) {
        return x + y;
    }
}