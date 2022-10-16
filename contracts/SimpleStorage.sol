// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract SimpleStorage {
    string public text;

    // aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    // calldata 89626 gas - use call data as it is cheaper
    // memory 90114 gas
    function set(string calldata _text) external {
        text = _text;
    }

    // more gas if using get explicitly to return
    function get() external view returns (string memory) {
        return text;
    }
}