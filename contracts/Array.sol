// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// Array - dynamic or fixed size
// Initialization 
// Insert (push), get, update, delete, pop, length
// Creating array in memory
// Returning array from function

contract Array {
    // dynamic
    uint[] public nums = [1, 2, 3];
    // fixed size
    uint[3] public numsFixed = [4, 5, 6];

    function examples() external {
        nums.push(100);
        uint x = nums[1];
        nums[2] = 777; //[1, 2, 777, 100]
        delete nums[1]; //[1, 0, 777, 100]
        nums.pop(); //[1,0,777]
        uint len = nums.length;
        
        // create array in memory
        uint[] memory a = new uint[](5);
        a[1] = 123;
    }

    // highly discourage to return array - will cost high gas price 
    function returnArray() external view returns (uint[] memory) {
        return nums;
    }
}