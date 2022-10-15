// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract TestContract1 {
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == owner, "not owner");
        owner = _owner;
    }
}

contract TestContract2 {
    address public owner = msg.sender;
    uint public value =  msg.value;
    uint public x;
    uint public y;

    constructor(uint _x, uint _y) payable {
        x = _x;
        y = _y;
    }
}

contract Proxy {
    event Deploy(address);

    // called when none of other functions match the given function signature
    // called when contract called by execute sends some ether back
    fallback() external payable {}

    // use a Proxy contract to deploy arbitary contracts with byte code
    function deploy(bytes memory _code) external payable returns (address addr) {
        // to create just one contract
        // TestContract1 t1 = new TestContract1();

        // use assembly's (Yul dialect) create
        // take note Yul uses opcode (i.e. "functions") and has a slightly different syntax
        assembly {
            // create(v, p, n)
            // v = amount of ETH to send
            // p = pointer in memory to start of code
            // n = size of code
            // first 32 bytes are size of contract
            // define and return with :=  ;  notice also no `type` here
            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }
        require(addr != address(0), "deploy failed");

        emit Deploy(addr);
    }

    // use a Proxy contract to execute on a target Contract address with some data (arguments)
    // and also probably forward some ether
    function execute(address _target, bytes memory _data) external payable {
        // msg.value is the ether received (payable)
        // (bool success, bytes memoryData)
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }
}

contract Helper {
    // can use a library like web3.js instead to compile and extract the bytecode (save money!)
    // but deploying Helper contract for demo purposes only
    function getBytecode1() external pure returns (bytes memory) {
        // get the type information creationCode
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;
    }

    function getBytecode2(uint _x, uint _y) external pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y));
    }

    // to be used with Deploy.execute for TestContract1's setOwner
    function getCalldata(address _owner) external pure returns (bytes memory) {
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}