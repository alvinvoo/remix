// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract ArrayShift {
    // state variables are in storage
    uint[] public arr;

    function example() public {
        arr = [1, 2, 3];
        // normal delete doesn't shrink the array
        delete arr[1]; // [1, 0 ,3]
    }

    // remove Array element by shifting (not gas efficient)
    // [1,2,3] -- remove(1) --> [1,3,3] --> [1,3]
    // to shift left and pop last
    // [1] -- remove(0) --> [1] --> []
    function remove(uint _index) public {
        require(_index < arr.length, "index out of bound");

        for (uint i = _index; i < arr.length - 1; i++){
            arr[i] = arr[i + 1];
        }

        arr.pop();
    }

    function test() external {
        // function variables are in memory (can be implicitly)
        arr = [1, 2, 3, 4, 5];
        remove(2);
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [0];
        remove(0);
        assert(arr.length == 0);
    }
}