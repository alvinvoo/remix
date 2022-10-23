// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// keccak256 hash function
// use cases: 
// 1. sign a signature
// 2. create an unique id
// 3. create a contract to prevent from front-running (commit review scheme)
// a little bit change in the input change the output by a lot

contract HashFunc {
    function hash(string memory text, uint num, address addr) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text, num, addr));
    }

    // abi.encode vs abi.encodePacked
    // both return bytes
    // abi.encodePacked - compress output and reduce the info from abi.encode 
    function encode(string memory text0, string memory text1) external pure returns (bytes memory) {
        return abi.encode(text0, text1);
    }  

    // 2 different inputs but same encoded output
    // for e.g. in example below: "AAAA", "BBB" vs "AAA", "ABBB" will have
    function encodePacked(string memory text0, string memory text1) external pure returns (bytes memory) {
        return abi.encodePacked(text0, text1);
    }     

    // there's a possibility of hash collision
    // same encoded packed will produce the same hash output when passed thru keccak256
    // fix to avoid hash collision: 1) use abi.encode or 2) make sure no 2 dynamic data types like string are next to each other
    function collision(string memory text0, uint x, string memory text1) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text0, x, text1));
    }
}
