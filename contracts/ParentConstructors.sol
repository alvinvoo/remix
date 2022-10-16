// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 2 ways of calling parent constructor
// 1. static call
contract U is S("s"), T("t") {

}

// 2. dynamic call only when child constructor is initialized
contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {

    }
}

// mixture of 1. and 2.
contract UV is S("s"), T {
    constructor(string memory _text) T(_text) {

    }
}

// order of call and execution is based on order by inheritance; NOT order by constructor call syntax
// Order of execution: S, T, VV
contract VV is S, T {
    constructor(string memory _name, string memory _text) T(_text) S(_name) {

    }
}