// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// the low-level function call can be used to send Ether as well as calling functions in other contract
contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }

    function foo(string memory _message, uint _x) external payable returns (bool, uint) {
        message = _message;
        x = _x;
        return (true, 999);
    }

    function getGas() external view returns (uint) {
        return gasleft();
    }
}

contract Call {
    bytes public data;

    function callFoo(address _test) external payable {
        // call can pass ether value, gas value (if put too little and unable to call foo function, it will fail)
        // call can call functions with arguments 
        // call can return a bool, and also data bytes from called function
        (bool success, bytes memory _data) = _test.call{value: 111
            ,gas: 5000
            }(
            // function signature has no space in between
            // and also uint is a sugar syntax for uint256
            abi.encodeWithSignature(
                "foo(string,uint256)", "call fooing", 123
            )
        );
        require(success, "call failed");
        data = _data;
    }

    // example for function that does not exist - to trigger fallback function call
    function callDoesNotExist(address _test) external {
        (bool success, ) = _test.call(abi.encodeWithSignature("doesNotExist()"));
        require(success, "call failed");
    }
}