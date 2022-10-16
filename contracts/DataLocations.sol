// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// Data locations - storage, memory and calldata
// Take note that this doesn't apply to simple type like uint or address
// this applies to `reference types` like string, array, bytes and structs 
// string and bytes are special arrays
contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function examples(uint[] calldata y, string calldata s) external returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});

        // use `storage` when want to update dynamic data and save in global state
        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "foo";

        // use `memory` when want to just readonly or make local changes only
        MyStruct memory readOnly = myStructs[msg.sender];
        readOnly.foo = 456;

        _internal(y);

        // how to make array in memory with fixed length
        uint[] memory memArr = new uint[](3);
        memArr[0] = 234;
        return memArr;
    } 

    // use calldata when want to pass around arguments without copying again
    // just passing reference?
    function _internal(uint[] calldata y) private pure{
        uint x = y[0];
    }
}