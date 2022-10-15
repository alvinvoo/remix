// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract ArrayReplaceLast {
    uint[] public arr;

    // more gas efficient
    // simply replace the element to be removed with last element
    // 2 operations - but order not preserved
    // [1, 2, 3, 4] -- remove(1) --> [1, 4, 3]
    // [1, 4, 3] -- remove(2) --> [1, 4]
    function remove(uint _index) public {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4];

        remove(1);

        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);

        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}