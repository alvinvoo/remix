// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// cannot know the size of mapping
// cannot iterate through a map
contract IterableMapping {
    mapping(address => uint) public balances;
    // to keep track of the balances map
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address, address _key, uint _val) external {
        balances[_key] = _val;

        if (!inserted[_key]) {
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view returns (uint) {
        return keys.length;
    }

    function first() external view returns (uint) {
        return balances[keys[0]];
    }

    function last() external view returns (uint) {
        return balances[keys[keys.length - 1]];
    }

    function get(uint _i) external view returns (uint) {
        return balances[keys[_i]];
    }
}